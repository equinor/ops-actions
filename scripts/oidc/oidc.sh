#!/bin/bash

set -eu

CONFIG_FILE=${1:?"CONFIG_FILE is unset or null"}

################################################################################
# Verify OIDC configuration
################################################################################

if [[ -f "$CONFIG_FILE" ]]
then
  echo "Using config file '$CONFIG_FILE'."
else
  echo "Config file '$CONFIG_FILE' does not exist."
  exit 1
fi

################################################################################
# Verify target Azure subscription
################################################################################

ACCOUNT=$(az account show --output json)
ACCOUNT_NAME=$(jq -r .name <<< "$ACCOUNT")
SUBSCRIPTION_ID=$(jq -r .id <<< "$ACCOUNT")
TENANT_ID=$(jq -r .tenantId <<< "$ACCOUNT")

read -r -p "Configure OIDC to Azure subscription '$ACCOUNT_NAME'? (y/N) " resp

case $resp in
  [yY][eE][sS]|[yY])
    ;;
  *)
    exit 0
    ;;
esac

################################################################################
# Read OIDC configuration
################################################################################

export SUBSCRIPTION_ID

config=$(envsubst < "$CONFIG_FILE")

################################################################################
# Create Azure AD application
################################################################################

app_name=$(jq -r .appName <<< "$config")

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

federated_credentials=$(jq -c .federatedCredentials[] <<< "$config")

declare -A secret_scopes # Associative array of scopes to set GitHub secrets at.

while read -r fic
do
  fic_name=$(jq -r .name <<< "$fic")

  fic_id=$(az ad app federated-credential list \
    --id "$app_id" \
    --query "[?name == '$fic_name'].id" \
    --output tsv)

  parameters=$(jq '{
    "name": .name,
    "issuer": "https://token.actions.githubusercontent.com",
    "subject": .subject,
    "description": .description,
    "audiences": ["api://AzureADTokenExchange"]
  }' <<< "$fic")

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

  subject=$(jq -r .subject <<< "$fic")
  repo=$(cut -d : -f 2 <<< "$subject")
  entity_type=$(cut -d : -f 3 <<< "$subject")
  env=""

  if [[ "$entity_type" == "environment" ]]
  then
    env=$(cut -d : -f 4 <<< "$subject")
  fi

  secret_scope="$repo:$env"
  secret_scopes[$secret_scope]=true
done <<< "$federated_credentials"

################################################################################
# Create Azure role assignments
################################################################################

role_assignments=$(jq -c .roleAssignments[] <<< "$config")

while read -r role_assignment
do
  role=$(jq -r .role <<< "$role_assignment")
  scope=$(jq -r .scope <<< "$role_assignment")

  echo "Assigning role '$role' at scope '$scope'..."

  az role assignment create \
    --role "$role" \
    --assignee-object-id "$sp_id" \
    --assignee-principal-type ServicePrincipal \
    --scope "$scope" \
    --output none
done <<< "$role_assignments"

################################################################################
# Set GitHub secrets
################################################################################

for scope in "${!secret_scopes[@]}"
do
  repo=$(cut -d : -f 1 <<< "$scope")
  env=$(cut -d : -f 2 <<< "$scope")

  gh secret set "AZURE_CLIENT_ID" \
    --repo "$repo" \
    --env "$env" \
    --body "$app_id"

  gh secret set "AZURE_SUBSCRIPTION_ID" \
    --repo "$repo" \
    --env "$env" \
    --body "$SUBSCRIPTION_ID"

  gh secret set "AZURE_TENANT_ID" \
    --repo "$repo" \
    --env "$env" \
    --body "$TENANT_ID"
done
