#!/bin/bash

set -eu

APP_NAME="$1"
export SUBSCRIPTION_ID="$2"
export REPO="$3"
export ENVIRONMENT="$4"
CONFIG_FILE="$5"

echo "SUBSCRIPTION_ID: $SUBSCRIPTION_ID"

tenant_id=$(az account show --subscription "$SUBSCRIPTION_ID" --query tenantId --output tsv)
echo "TENANT_ID: $tenant_id"

echo 'Logging into GitHub...'
gh auth login

echo 'Reading config...'
config=$(envsubst < "$CONFIG_FILE")

echo 'Checking if application already exists...'
app_id=$(az ad app list --filter "displayName eq '$APP_NAME'" --query [].appId --output tsv)
if [[ -z "$app_id" ]]
then
  echo 'Creating application...'
  app_id=$(az ad app create --display-name "$APP_NAME" --query appId --output tsv)
else
  echo 'Using existing application.'
fi
echo "CLIENT_ID: $app_id"

echo 'Checking if federated identity credential already exists...'
fic=$(echo "$config" | jq '.federatedCredential')
fic_name=$(echo "$fic" | jq -r '.name')
fic_id=$(az ad app federated-credential list --id "$app_id" --query "[?name == '$fic_name'].id" --output tsv)
if [[ -z "$fic_id" ]]
then
  echo 'Creating federated identity credential...'
  az ad app federated-credential create --id "$app_id" --parameters "$fic" --output none
else
  echo 'Updating existing federated identity credential.'
  az ad app federated-credential update --id "$app_id" --federated-credential-id "$fic_id" --parameters "$fic" \
    --output none
fi

echo 'Checking if service principal already exists...'
sp_id=$(az ad sp list --filter "appId eq '$app_id'" --query [].id --output tsv)
if [[ -z "$sp_id" ]]
then
  echo 'Creating service principal...'
  sp_id=$(az ad sp create --id "$app_id" --query id --output tsv)
else
  echo 'Using existing service principal.'
fi
echo "OBJECT_ID: $sp_id"

echo 'Creating role assignments...'
ras=$(echo "$config" | jq -c '.roleAssignments[]')
echo "$ras" | while read -r ra; do
  role=$(echo "$ra" | jq -r '.role')
  scope=$(echo "$ra" | jq -r '.scope')
  echo "Assigning role '$role' at scope '$scope'..."
  az role assignment create --role "$role" --subscription "$SUBSCRIPTION_ID" --assignee-object-id "$sp_id" \
    --assignee-principal-type ServicePrincipal --scope "$scope" --output none
done

echo 'Creating GitHub environment...'
gh api --method PUT "repos/$REPO/environments/$ENVIRONMENT"
# GitHub CLI does not natively support creating environments (cli/cli#5149).
# Create using GitHub API request instead.

echo 'Updating GitHub secrets...'
gh secret set 'AZURE_CLIENT_ID' --body "$app_id" --repo "$REPO" --env "$ENVIRONMENT"
gh secret set 'AZURE_SUBSCRIPTION_ID' --body "$SUBSCRIPTION_ID" --repo "$REPO" --env "$ENVIRONMENT"
gh secret set 'AZURE_TENANT_ID' --body "$tenant_id" --repo "$REPO" --env "$ENVIRONMENT"
