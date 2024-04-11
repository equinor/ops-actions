# Contributing guidelines

## Make changes

1. If you're making a change to the current major version, create a new branch from `main`. If you're making a change to a previous major version, create a new branch from the relevant `release/*` branch.

1. Make your changes.

   Follow our [best practices](./docs/best-practices.md) for creating reusable workflows.

1. Commit your changes.

    Use the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification for semantic commit messages, where scope is the name of the updated workflow file.

    For example, if you've updated the `terraform.yml` workflow file:

    ```plaintext
    feat(terraform): skip Apply if no changes present
    ```

    If you've updated multiple or no workflow files, don't specify a scope:

    ```plaintext
    refactor: update workflow input descriptions
    ```

    If you've updated no workflow files, use the `chore` type:

    ```plaintext
    chore: update OIDC script
    ```

1. Create a pull request to merge your changes into the `main` branch (or the relevant `release/*` branch if you're making a change to a previous major version).

    Use the Conventional Commits specification for semantic pull request titles.
