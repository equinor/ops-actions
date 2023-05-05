#!/bin/bash

set -eu

APP_NAME=${1:?"APP_NAME is unset or null"}
REPO=${2:?"REPO is unset or null"}
CONFIG_FILE=${3:?"CONFIG_FILE is unset or null"}

if [[ -f "$CONFIG_FILE" ]]
then
  jsonschema -i "$CONFIG_FILE" oidc.schema.json
else
  echo "File '$CONFIG_FILE' does not exist."
  exit 1
fi

# TODO: use "gh repo list" to check existence of repo without redirecting errors to null (if possible)
repo_name=$(gh repo view "$REPO" --json name --jq .name 2>/dev/null || true)
if [[ -z "$repo_name" ]]
then
  echo "Repo '$REPO' does not exist."
  exit 1
fi

subscription=$(az account show --output json)
subscription_name=$(jq -r .name <<< "$subscription")

read -r -p "Configure OIDC from GitHub repo '$repo_name' to Azure subscription '$subscription_name'? (y/N) " response
case $response in
  [yY][eE][sS]|[yY])
    ;;
  *)
    exit 0
    ;;
esac

SUBSCRIPTION_ID=$(jq -r .id <<< "$subscription")
export SUBSCRIPTION_ID
export REPO
config=$(envsubst < "$CONFIG_FILE")

# ============================================================================ #
# Create Azure AD application
# ============================================================================ #

app_id=$(az ad app list --filter "displayName eq '$APP_NAME'" --query [].appId --output tsv)

if [[ -z "$app_id" ]]
then
  echo "Creating application..."
  app_id=$(az ad app create --display-name "$APP_NAME" --sign-in-audience AzureADMyOrg --query appId --output tsv)
else
  echo "Using existing application."
fi

# ============================================================================ #
# Create Azure AD application federated credentials
# ============================================================================ #

fics=$(jq -c .federatedCredentials[] <<< "$config")

repo_level=false # Should OIDC be configured at the repository level?
declare -A env_level # Associative array of environments to configure OIDC for.

while read -r fic
do
  fic_name=$(jq -r .name <<< "$fic")
  fic_id=$(az ad app federated-credential list --id "$app_id" --query "[?name == '$fic_name'].id" --output tsv)

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
    az ad app federated-credential create --id "$app_id" --parameters "$parameters" --output none
  else
    echo "Updating existing federated identity credential '$fic_name'..."
    az ad app federated-credential update --id "$app_id" --federated-credential-id "$fic_id" --parameters "$parameters" --output none
  fi

  subject=$(jq -r .subject <<< "$fic")
  entity_type=$(cut -d : -f 3 <<< "$subject")

  if [[ "$entity_type" == "environment" ]]
  then
    env=$(cut -d : -f 4 <<< "$subject")
    env_level[$env]=true
  else
    repo_level=true
  fi
done <<< "$fics"

# ============================================================================ #
# Create Azure AD service principal
# ============================================================================ #

sp_id=$(az ad sp list --filter "appId eq '$app_id'" --query [].id --output tsv)

if [[ -z "$sp_id" ]]
then
  echo "Creating service principal..."
  sp_id=$(az ad sp create --id "$app_id" --query id --output tsv)
else
  echo "Using existing service principal."
fi

# ============================================================================ #
# Create Azure role assignments
# ============================================================================ #

ras=$(jq -c .roleAssignments[] <<< "$config")

while read -r ra
do
  role=$(jq -r .role <<< "$ra")
  scope=$(jq -r .scope <<< "$ra")

  echo "Assigning role '$role' at scope '$scope'..."
  az role assignment create --role "$role" --assignee-object-id "$sp_id" --assignee-principal-type ServicePrincipal --scope "$scope" --output none
done <<< "$ras"

# ============================================================================ #
# Create GitHub repository secrets
# ============================================================================ #

tenant_id=$(jq -r .tenantId <<< "$subscription")

if [[ "$repo_level" == true ]]
then
  echo "Creating GitHub repository secrets..."
  gh secret set "AZURE_CLIENT_ID" --repo "$REPO" --body "$app_id"
  gh secret set "AZURE_SUBSCRIPTION_ID" --repo "$REPO" --body "$SUBSCRIPTION_ID"
  gh secret set "AZURE_TENANT_ID" --repo "$REPO" --body "$tenant_id"
fi

# ============================================================================ #
# Create GitHub environment secrets
# ============================================================================ #

for env in "${!env_level[@]}"
do
  # GitHub CLI does not natively support creating environments (cli/cli#5149).
  # Create using GitHub API request instead.
  echo "Creating GitHub environment '$env'..."
  gh api --method PUT "repos/$REPO/environments/$env" --silent

  echo "Creating GitHub environment secrets for environment '$env'..."
  gh secret set "AZURE_CLIENT_ID" --repo "$REPO" --env "$env" --body "$app_id"
  gh secret set "AZURE_SUBSCRIPTION_ID" --repo "$REPO" --env "$env" --body "$SUBSCRIPTION_ID"
  gh secret set "AZURE_TENANT_ID" --repo "$REPO" --env "$env" --body "$tenant_id"
done
