# Contributing guidelines

## Make changes

1. Create a new branch and make your changes.
   Follow our [best practices](./docs/best-practices.md)  for creating reusable workflows.
1. Commit your changes.

   Use the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification for semantic commit messages,
   where scope is the name of the updated workflow file.

    For example, if you've updated the `terraform.yml` workflow file:

    ```plaintext
    feat(terraform): skip Apply if no changes present
    ```

    If you've updated multiple or no workflow files, don't specify a scope:

    ```plaintext
    refactor: update workflow input descriptions
    ```

    If you haven't updated any workflow files, use the `chore` type:

    ```plaintext
    chore: update OIDC script
    ```

1. Create a pull request to merge your changes into the `main` branch.
