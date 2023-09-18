#!/bin/bash

set -eu

CONFIG_FILE=${1:?"CONFIG_FILE is unset or null"}

################################################################################
# Verify target GitHub repository and Azure subscription
################################################################################

REPO=$(gh repo view --json nameWithOwner --jq .nameWithOwner)

SUBSCRIPTION=$(az account show --output json)
SUBSCRIPTION_NAME=$(echo "$SUBSCRIPTION" | jq -r .name)
SUBSCRIPTION_ID=$(echo "$SUBSCRIPTION" | jq -r .id)
TENANT_ID=$(echo "$SUBSCRIPTION" | jq -r .tenantId)

read -r -p "Configure OIDC from GitHub repository '$REPO' to \
Azure subscription '$SUBSCRIPTION_NAME'? (y/N) " response

case $response in
  [yY][eE][sS]|[yY])
    ;;
  *)
    exit 0
    ;;
esac

export REPO
export SUBSCRIPTION_ID

################################################################################
# Read OIDC configuration
################################################################################

if [[ -f "$CONFIG_FILE" ]]
then
  echo "Using config file '$CONFIG_FILE'."
else
  echo "Config file '$CONFIG_FILE' does not exist."
  exit 1
fi

config=$(envsubst < "$CONFIG_FILE")

################################################################################
# Create Azure AD application
################################################################################

app_name=$(echo "$config" | jq -r .appName)

app_id=$(az ad app list \
  --filter "displayName eq '$app_name'" \
  --query "[0].appId" \
  --output tsv)

if [[ -z "$app_id" ]]
then
  echo "Creating application..."

  app_id=$(az ad app create \
    --display-name "$app_name" \
    --sign-in-audience AzureADMyOrg \
    --query appId \
    --output tsv)
else
  echo "Using existing application."
fi

################################################################################
# Create Azure AD service principal
################################################################################

sp_id=$(az ad sp list \
  --filter "appId eq '$app_id'" \
  --query "[0].id" \
  --output tsv)

if [[ -z "$sp_id" ]]
then
  echo "Creating service principal..."

  sp_id=$(az ad sp create \
    --id "$app_id" \
    --query id \
    --output tsv)
else
  echo "Using existing service principal."
fi

################################################################################
# Create Azure AD application federated credentials
################################################################################

readarray -t fics <<< "$(echo "$config" | jq -c .federatedCredentials[])"

repo_level=false # Should OIDC be configured at the repository level?
declare -A environments # Environments to configure OIDC for.

for fic in "${fics[@]}"
do
  fic_name=$(echo "$fic" | jq -r .name)

  fic_id=$(az ad app federated-credential list \
    --id "$app_id" \
    --query "[?name == '$fic_name'].id" \
    --output tsv)

  parameters=$(echo "$fic" | jq '{
    "name": .name,
    "issuer": "https://token.actions.githubusercontent.com",
    "subject": .subject,
    "description": .description,
    "audiences": ["api://AzureADTokenExchange"]
  }')

  if [[ -z "$fic_id" ]]
  then
    echo "Creating federated identity credential '$fic_name'..."

    az ad app federated-credential create \
      --id "$app_id" \
      --parameters "$parameters" \
      --output none
  else
    echo "Updating existing federated identity credential '$fic_name'..."

    az ad app federated-credential update \
      --id "$app_id" \
      --federated-credential-id "$fic_id" \
      --parameters "$parameters" \
      --output none
  fi

  subject=$(echo "$fic" | jq -r .subject)
  entity_type=$(echo "$subject" | cut -d : -f 3)

  if [[ "$entity_type" == "environment" ]]
  then
    env=$(echo "$subject" | cut -d : -f 4)
    environments[$env]=true
  else
    repo_level=true
  fi
done

################################################################################
# Create Azure role assignments
################################################################################

readarray -t role_assignments <<< "$(echo "$config" | jq -c .roleAssignments[])"

for role_assignment in "${role_assignments[@]}"
do
  role=$(echo "$role_assignment" | jq -r .role)
  scope=$(echo "$role_assignment" | jq -r .scope)

  echo "Assigning role '$role' at scope '$scope'..."

  az role assignment create \
    --role "$role" \
    --assignee-object-id "$sp_id" \
    --assignee-principal-type ServicePrincipal \
    --scope "$scope" \
    --output none
done

################################################################################
# Set GitHub repository secrets
################################################################################

if [[ "$repo_level" == true ]]
then
  echo "Setting GitHub repository secrets..."

  gh secret set "AZURE_CLIENT_ID" \
    --body "$app_id"

  gh secret set "AZURE_SUBSCRIPTION_ID" \
    --body "$SUBSCRIPTION_ID"

  gh secret set "AZURE_TENANT_ID" \
    --body "$TENANT_ID"
fi

################################################################################
# Set GitHub environment secrets
################################################################################

for env in "${!environments[@]}"
do
  echo "Setting GitHub environment secrets for environment '$env'..."

  gh secret set "AZURE_CLIENT_ID" \
    --env "$env" \
    --body "$app_id"

  gh secret set "AZURE_SUBSCRIPTION_ID" \
    --env "$env" \
    --body "$SUBSCRIPTION_ID"

  gh secret set "AZURE_TENANT_ID" \
    --env "$env" \
    --body "$TENANT_ID"
done
