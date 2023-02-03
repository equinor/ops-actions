#!/bin/bash

set -eu

APP_NAME=$1
export REPO=$2
export ENVIRONMENT=$3
CONFIG_FILE=$4

subscription=$(az account show --output json)
SUBSCRIPTION_ID=$(jq -r .id <<< "$subscription")
export SUBSCRIPTION_ID

if [[ -f "$CONFIG_FILE" ]]; then
  jsonschema -i "$CONFIG_FILE" oidc.schema.json
  config=$(envsubst < "$CONFIG_FILE")
else
  echo "File '$CONFIG_FILE' does not exist."
  exit 1
fi

# TODO: use "gh repo list" to check existence of repo without redirecting errors to null (if possible)
repo_name=$(gh repo view "$REPO" --json name --jq .name 2>/dev/null || true)
if [[ -z "$repo_name" ]]; then
  echo "Repo '$REPO' does not exist."
  exit 1
fi

subscription_name=$(jq -r .name <<< "$subscription")

read -r -p "Configure OIDC from GitHub repo '$repo_name' to Azure subscription '$subscription_name'? (y/N) " response
case $response in
  [yY][eE][sS]|[yY])
    ;;
  *)
    exit 0
    ;;
esac

echo "Checking if application already exists..."
app_id=$(az ad app list --filter "displayName eq '$APP_NAME'" --query [].appId --output tsv)
if [[ -z "$app_id" ]]; then
  echo "Creating application..."
  app_id=$(az ad app create --display-name "$APP_NAME" --query appId --output tsv)
else
  echo "Using existing application."
fi
echo "CLIENT_ID: $app_id"

echo "Checking if federated identity credential already exists..."
fic=$(jq '.federatedCredential + {"issuer": "https://token.actions.githubusercontent.com", "audiences": ["api://AzureADTokenExchange"]}' <<< "$config")
fic_name=$(jq -r .name <<< "$fic")
fic_id=$(az ad app federated-credential list --id "$app_id" --query "[?name == '$fic_name'].id" --output tsv)
if [[ -z "$fic_id" ]]; then
  echo "Creating federated identity credential..."
  az ad app federated-credential create --id "$app_id" --parameters "$fic" --output none
else
  echo "Updating existing federated identity credential."
  az ad app federated-credential update --id "$app_id" --federated-credential-id "$fic_id" --parameters "$fic" --output none
fi

echo "Checking if service principal already exists..."
sp_id=$(az ad sp list --filter "appId eq '$app_id'" --query [].id --output tsv)
if [[ -z "$sp_id" ]]; then
  echo "Creating service principal..."
  sp_id=$(az ad sp create --id "$app_id" --query id --output tsv)
else
  echo "Using existing service principal."
fi
echo "OBJECT_ID: $sp_id"

echo "Creating role assignments..."
ras=$(jq -c .roleAssignments[] <<< "$config")
while read -r ra; do
  role=$(jq -r .role <<< "$ra")
  scope=$(jq -r .scope <<< "$ra")
  echo "Assigning role '$role' at scope '$scope'..."
  az role assignment create --role "$role" --assignee-object-id "$sp_id" --assignee-principal-type ServicePrincipal --scope "$scope" --output none
done <<< "$ras"

tenant_id=$(jq -r .tenantId <<< "$subscription")

if [[ -n "$ENVIRONMENT" ]]; then
  echo "Creating GitHub environment..."
  gh api --method PUT "repos/$REPO/environments/$ENVIRONMENT" --silent
  # GitHub CLI does not natively support creating environments (cli/cli#5149).
  # Create using GitHub API request instead.
fi

echo "Updating GitHub secrets..."
gh secret set "AZURE_CLIENT_ID" --body "$app_id" --repo "$REPO" --env "$ENVIRONMENT"
gh secret set "AZURE_SUBSCRIPTION_ID" --body "$SUBSCRIPTION_ID" --repo "$REPO" --env "$ENVIRONMENT"
gh secret set "AZURE_TENANT_ID" --body "$tenant_id" --repo "$REPO" --env "$ENVIRONMENT"
