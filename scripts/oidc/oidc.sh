#!/bin/bash

set -eu

CONFIG_FILE=${1:?"CONFIG_FILE is unset or null"}

if [[ -f "$CONFIG_FILE" ]]
then
  echo "Using config file '$CONFIG_FILE'."
else
  echo "Config file '$CONFIG_FILE' does not exist."
  exit 1
fi

cd "$(dirname "$CONFIG_FILE")"

################################################################################
# Verify installation of necessary software components
################################################################################

hash az 2>/dev/null || {
  echo -e "\nERROR: Azure-CLI not found in PATH. Exiting... " >&2
  exit 1
}

hash gh 2>/dev/null || {
  echo -e "\nERROR: Github-CLI not found in PATH. Exiting... " >&2
  exit 1
}

hash jq 2>/dev/null || {
  echo -e "\nERROR: jq not found in PATH. Exiting... " >&2
  exit 1
}

################################################################################
# Verify target GitHub repository and Azure subscription
################################################################################

REPO=$(gh repo view --json nameWithOwner --jq .nameWithOwner)

SUBSCRIPTION=$(az account show --output json)
SUBSCRIPTION_NAME=$(echo "${SUBSCRIPTION}" | jq -j .name)
SUBSCRIPTION_ID=$(echo "${SUBSCRIPTION}" | jq -j .id)
TENANT_ID=$(echo "${SUBSCRIPTION}" | jq -j .tenantId)

while true; do
  read -r -p "Configure OIDC from GitHub repository '${REPO}' to Azure subscription '${SUBSCRIPTION_NAME}'? (y/N) " RESPONSE
  case ${RESPONSE} in
  [yY][eE][sS] | [yY])
    echo "Proceeding with configuration..."
    break
    ;;
  [nN][oO] | [nN])
    echo "Exiting without configuring..."
    exit 0
    ;;
  *)
    echo "Invalid input, please type 'y' or 'n'."
    ;;
  esac
done

################################################################################
# Read OIDC configuration
################################################################################

export REPO
export SUBSCRIPTION_ID

CONFIG=$(envsubst <"${CONFIG_FILE}")

################################################################################
# Create Azure AD application
################################################################################

APP_NAME=$(echo "${CONFIG}" | jq -j .appName)

APP_ID=$(az ad app list \
  --filter "displayName eq '${APP_NAME}'" \
  --query "[0].appId" \
  --output tsv)

if [[ -z "${APP_ID}" ]]; then
  echo "Creating application..."

  APP_ID=$(az ad app create \
    --display-name "${APP_NAME}" \
    --sign-in-audience AzureADMyOrg \
    --query appId \
    --output tsv)
else
  echo "Using existing application."
fi

################################################################################
# Create Azure AD service principal
################################################################################

SP_ID=$(az ad sp list \
  --filter "appId eq '${APP_ID}'" \
  --query "[0].id" \
  --output tsv)

if [[ -z "${SP_ID}" ]]; then
  echo "Creating service principal..."

  SP_ID=$(az ad sp create \
    --id "${APP_ID}" \
    --query id \
    --output tsv)
else
  echo "Using existing service principal."
fi

################################################################################
# Create Azure AD application federated credentials
################################################################################

readarray -t fics <<<"$(echo "${CONFIG}" | jq -c .federatedCredentials[])"

REPO_LEVEL=false        # Should OIDC be configured at the repository level?
declare -A ENVIRONMENTS # Environments to configure OIDC for.

for FIC in "${fics[@]}"; do
  FIC_NAME=$(echo "${FIC}" | jq -j .name)

  FIC_ID=$(az ad app federated-credential list \
    --id "${APP_ID}" \
    --query "[?name == '${FIC_NAME}'].id" \
    --output tsv)

  PARAMETERS=$(echo "${FIC}" | jq '{
    "name": .name,
    "issuer": "https://token.actions.githubusercontent.com",
    "subject": .subject,
    "description": .description,
    "audiences": ["api://AzureADTokenExchange"]
  }')

  if [[ -z "${FIC_ID}" ]]; then
    echo "Creating federated identity credential '${FIC_NAME}'..."

    az ad app federated-credential create \
      --id "${APP_ID}" \
      --parameters "${PARAMETERS}" \
      --output none
  else
    echo "Updating existing federated identity credential '${FIC_NAME}'..."

    az ad app federated-credential update \
      --id "${APP_ID}" \
      --federated-credential-id "${FIC_ID}" \
      --parameters "${PARAMETERS}" \
      --output none
  fi

  SUBJECT=$(echo "${FIC}" | jq -j .subject)
  ENTITY_TYPE=$(echo "${SUBJECT}" | cut -d : -f 3)

  if [[ "${ENTITY_TYPE}" == "environment" ]]; then
    ENV=$(echo "${SUBJECT}" | cut -d : -f 4)
    ENVIRONMENTS[${ENV}]=true
  else
    REPO_LEVEL=true
  fi
done

################################################################################
# Create Azure role assignments
################################################################################

readarray -t ROLE_ASSIGNMENTS <<<"$(echo "${CONFIG}" | jq -c .roleAssignments[])"

for ROLE_ASSIGNMENT in "${ROLE_ASSIGNMENTS[@]}"; do
  ROLE=$(echo "${ROLE_ASSIGNMENT}" | jq -j .role)
  SCOPE=$(echo "${ROLE_ASSIGNMENT}" | jq -j .scope)
  CONDITION=$(echo "${ROLE_ASSIGNMENT}" | jq -j .condition)

  OPTIONAL_ARGS=()
  if [[ "$CONDITION" != "null" ]]; then
    OPTIONAL_ARGS+=(--condition "${CONDITION}" --condition-version 2.0)
  fi

  echo "Assigning role '${ROLE}' at scope '${SCOPE}'..."

  az role assignment create \
    --role "${ROLE}" \
    --assignee-object-id "${SP_ID}" \
    --assignee-principal-type ServicePrincipal \
    --scope "${SCOPE}" \
    --output none \
    "${OPTIONAL_ARGS[@]}"
done

################################################################################
# Set GitHub repository secrets
################################################################################

if [[ "${REPO_LEVEL}" == true ]]; then
  echo "Setting GitHub repository secrets..."

  gh secret set "AZURE_CLIENT_ID" \
    --body "${APP_ID}"

  gh secret set "AZURE_SUBSCRIPTION_ID" \
    --body "${SUBSCRIPTION_ID}"

  gh secret set "AZURE_TENANT_ID" \
    --body "${TENANT_ID}"
fi

################################################################################
# Set GitHub environment secrets
################################################################################

for ENV in "${!ENVIRONMENTS[@]}"; do
  echo "Setting GitHub environment secrets for environment '${ENV}'..."

  gh secret set "AZURE_CLIENT_ID" \
    --env "${ENV}" \
    --body "${APP_ID}"

  gh secret set "AZURE_SUBSCRIPTION_ID" \
    --env "${ENV}" \
    --body "${SUBSCRIPTION_ID}"

  gh secret set "AZURE_TENANT_ID" \
    --env "${ENV}" \
    --body "${TENANT_ID}"
done
