#!/bin/bash

set -eu

CONFIG_FILE=${1:?"CONFIG_FILE is unset or null"}
readonly CONFIG_FILE

error() {
  echo -e "\033[0;31mERROR: $*\033[0;37m" >&2
}

if [[ -f "$CONFIG_FILE" ]]; then
  echo "Using config file '$CONFIG_FILE'."
else
  error "Config file '$CONFIG_FILE' does not exist."
  exit 1
fi
cd "$(dirname "$CONFIG_FILE")"

################################################################################
# Verify installation of necessary software components
################################################################################

hash az 2>/dev/null || {
  error "Azure CLI not found in PATH."
  exit 1
}

hash gh 2>/dev/null || {
  error "GitHub CLI not found in PATH."
  exit 1
}

hash jq 2>/dev/null || {
  error "jq not found in PATH."
  exit 1
}

################################################################################
# Verify target GitHub repository and Azure subscription
################################################################################

REPO=$(gh repo view --json nameWithOwner --jq .nameWithOwner)
readonly REPO
export REPO

ACCOUNT=$(az account show --output json)
readonly ACCOUNT

SUBSCRIPTION_NAME=$(echo "$ACCOUNT" | jq -j .name)
readonly SUBSCRIPTION_NAME

SUBSCRIPTION_ID=$(echo "$ACCOUNT" | jq -j .id)
readonly SUBSCRIPTION_ID
export SUBSCRIPTION_ID

TENANT_ID=$(echo "$ACCOUNT" | jq -j .tenantId)
readonly TENANT_ID

read -r -p "Configure OIDC from GitHub repository '$REPO' to \
Azure subscription '$SUBSCRIPTION_NAME'? (y/N) " response
case "$response" in
[yY][eE][sS] | [yY])
  echo "Proceeding with configuration..."
  ;;
*)
  echo "Exiting without configuring..."
  exit 0
  ;;
esac

################################################################################
# Read OIDC configuration
################################################################################

CONFIG=$(envsubst <"$CONFIG_FILE")
readonly CONFIG

################################################################################
# Create Azure AD application
################################################################################

APP_NAME=$(echo "$CONFIG" | jq -j .appName)
readonly APP_NAME

APP_ID=$(az ad app list \
  --filter "displayName eq '$APP_NAME'" \
  --query "[0].appId" \
  --output tsv)

if [[ -z "$APP_ID" ]]; then
  echo "Creating application..."
  APP_ID=$(az ad app create \
    --display-name "$APP_NAME" \
    --sign-in-audience AzureADMyOrg \
    --query appId \
    --output tsv)
else
  echo "Using existing application."
fi
readonly APP_ID

################################################################################
# Create Azure AD service principal
################################################################################

SP_ID=$(az ad sp list \
  --filter "appId eq '$APP_ID'" \
  --query "[0].id" \
  --output tsv)

if [[ -z "$SP_ID" ]]; then
  echo "Creating service principal..."
  SP_ID=$(az ad sp create \
    --id "$APP_ID" \
    --query id \
    --output tsv)
else
  echo "Using existing service principal."
fi
readonly SP_ID

################################################################################
# Create Azure AD application federated credentials
################################################################################

readarray -t FICS <<<"$(echo "$CONFIG" | jq -c .federatedCredentials[])"
readonly FICS

repo_level=false        # Should OIDC be configured at the repository level?
declare -A environments # Environments to configure OIDC for.

for fic in "${FICS[@]}"; do
  fic_name=$(echo "$fic" | jq -j .name)
  fic_id=$(az ad app federated-credential list \
    --id "$APP_ID" \
    --query "[?name == '$fic_name'].id" \
    --output tsv)

  parameters=$(echo "$fic" | jq '{
    "name": .name,
    "issuer": "https://token.actions.githubusercontent.com",
    "subject": .subject,
    "description": .description,
    "audiences": ["api://AzureADTokenExchange"]
  }')

  if [[ -z "$fic_id" ]]; then
    echo "Creating federated identity credential '$fic_name'..."
    az ad app federated-credential create \
      --id "$APP_ID" \
      --parameters "$parameters" \
      --output none
  else
    echo "Updating existing federated identity credential '$fic_name'..."
    az ad app federated-credential update \
      --id "$APP_ID" \
      --federated-credential-id "$fic_id" \
      --parameters "$parameters" \
      --output none
  fi

  subject=$(echo "$fic" | jq -j .subject)
  entity_type=$(echo "$subject" | cut -d : -f 3)
  if [[ "$entity_type" == "environment" ]]; then
    env=$(echo "$subject" | cut -d : -f 4)
    environments[$env]=true
  else
    repo_level=true
  fi
done

################################################################################
# Create Azure role assignments
################################################################################

readarray -t ROLE_ASSIGNMENTS <<<"$(echo "$CONFIG" | jq -c .roleAssignments[])"
readonly ROLE_ASSIGNMENTS

for role_assignment in "${ROLE_ASSIGNMENTS[@]}"; do
  role=$(echo "$role_assignment" | jq -j .role)
  scope=$(echo "$role_assignment" | jq -j .scope)
  condition=$(echo "$role_assignment" | jq -j .condition)

  optional_args=()
  if [[ "$condition" != "null" ]]; then
    optional_args+=(--condition "$condition" --condition-version 2.0)
  fi

  echo "Assigning role '$role' at scope '$scope'..."
  az role assignment create \
    --role "$role" \
    --assignee-object-id "$SP_ID" \
    --assignee-principal-type ServicePrincipal \
    --scope "$scope" \
    --output none \
    "${optional_args[@]}"
done

################################################################################
# Set GitHub repository secrets
################################################################################

if [[ "$repo_level" == true ]]; then
  echo "Setting GitHub repository secrets..."
  gh secret set "AZURE_CLIENT_ID" \
    --body "$APP_ID"
  gh secret set "AZURE_SUBSCRIPTION_ID" \
    --body "$SUBSCRIPTION_ID"
  gh secret set "AZURE_TENANT_ID" \
    --body "$TENANT_ID"
fi

################################################################################
# Set GitHub environment secrets
################################################################################

for env in "${!environments[@]}"; do
  echo "Setting GitHub environment secrets for environment '$env'..."
  gh secret set "AZURE_CLIENT_ID" \
    --env "$env" \
    --body "$APP_ID"
  gh secret set "AZURE_SUBSCRIPTION_ID" \
    --env "$env" \
    --body "$SUBSCRIPTION_ID"
  gh secret set "AZURE_TENANT_ID" \
    --env "$env" \
    --body "$TENANT_ID"
done
