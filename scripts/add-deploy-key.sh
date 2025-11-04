#! /bin/bash

# TODO: write description
#
# Arguments:
#   OWNER
#   REPO
#   PRIVATE_REPO
#
# Usage:
#   ./add-deploy-key <OWNER> <REPO> <PRIVATE_REPO>

set -eu

OWNER=${1:?"OWNER is unset or null"}
readonly OWNER

REPO=${2:?"REPO is unset or null"}
readonly REPO

PRIVATE_REPO=${3:?"PRIVATE_REPO is unset or null"}
readonly PRIVATE_REPO

SSH_DIR="$HOME/.ssh"
readonly SSH_DIR

if [[ ! -d "$SSH_DIR" ]]; then
  mkdir -p "$SSH_DIR"
fi
cd "$SSH_DIR"

KEY_NAME="${PRIVATE_REPO}_deploy_key"
readonly KEY_NAME

PUBLIC_KEY_NAME="$KEY_NAME.pub"
readonly PUBLIC_KEY_NAME

# Generate a passwordless SSH key
ssh-keygen -t ed25519 -C "$KEY_NAME" -N "" -f "$KEY_NAME"

# Add the key as a secret in your repository
gh secret set SSH_PRIVATE_KEY --repo "$OWNER/$REPO" < "$KEY_NAME"

# Add the corresponding public key as a deploy key in the private repository
gh repo deploy-key add "$PUBLIC_KEY_NAME" --repo "$OWNER/$PRIVATE_REPO" \
  --title "$KEY_NAME"
