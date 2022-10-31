# ops-actions

![release workflow status badge](https://github.com/equinor/ops-actions/actions/workflows/release.yml/badge.svg?event=push&branch=main)

[Reusable workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows) for GitHub Actions, maintained by the [Ops team](https://github.com/orgs/equinor/teams/ops).

## Prerequisites

### OpenID Connect

For reusable workflows that require authentication to Azure:

1. Run [this script](./scripts/oidc/) to configure OpenID Connect for the repository containing the caller workflow.

1. Set permissions granted to `GITHUB_TOKEN` in the caller workflow:

    ```yaml
    permissions:
      id-token: write # Required for requesting JSON web token (JWT)
      contents: read  # Required for actions/checkout
    ```

    Permissions can be set at the workflow or job scope.
