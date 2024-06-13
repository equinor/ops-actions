# Contributing guidelines

This document provides guidelines for contributing to the Ops Actions project.

## 💡 Requesting changes

[Open a new issue](https://github.com/equinor/ops-actions/issues/new/choose).

## 📝 Making changes

1. Create a new branch. For external contributors, create a fork.

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

1. Create a pull request to merge your changes into the `main` branch.

    Use the Conventional Commits specification for semantic pull request titles.

## 🤝 Roles and responsibilities

This section describes the various roles and responsibilities in the Ops Actions project.

### 🦸‍♀️ External contributors

An external contributor should:

- Create forks of this repository.
- Create issues and pull requests in this repository.

### 👨‍🎓 Contributors

A contributor must:

- Be a member of the [@equinor/ops-actions](https://github.com/orgs/equinor/teams/ops-actions) team.
- Actively contribute to this repository.

A contributor should:

- Have basic understanding of GitHub Actions.
- Have basic understanding of our best practices.

### 👷‍♀️ Maintainers

A maintainer must:

- Be a member of the [@equinor/ops-actions-maintainers](https://github.com/orgs/equinor/teams/ops-actions-maintainers) team.
- Review and approve pull requests in this repository.
- Discuss and update our best practices when needed.

A maintainer should:

- Have complete understanding of GitHub Actions.
- Have complete understanding of our best practices.
- Communicate and share with other maintainers.

### 👮‍♂️ Administrators

An administrator must:

- Be a member of the [@equinor/ops-actions-admins](https://github.com/orgs/equinor/teams/ops-actions-admins) team.

An administrator should:

- Configure this repository.
- Recruit people to the above roles 🤗
