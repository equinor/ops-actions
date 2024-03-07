# How to manage releases

## Create release

We use [Release Please](https://github.com/googleapis/release-please) to automatically create GitHub releases based on [Conventional Commit messages](https://www.conventionalcommits.org/en/v1.0.0/).

Release PRs created by Release Please must be **squash merged**.

## Push changes to old release

### Create release branch

> [!NOTE]
> You only need to do this the first time you push changes to an old release.

1. Checkout the latest [tag](https://github.com/equinor/ops-actions/tags) for the minor release you want to push your changes to (for example `v9.3.1`):

    ```console
    git checkout <tag>
    ```

1. Create a release branch for the corresponding major release (for example `v9`):

    ```console
    git switch -c release/<release>
    ```

1. Push the release branch to GitHub:

    ```console
    git push
    ```

### Make your changes

1. Create a new branch from the release branch:

    ```console
    git switch -c <branch_name> release/<release>
    ```

1. Commit and push your changes.
1. Create a pull request into the release branch.
1. Request a review.
1. Once approved, **squash and merge**.
1. Once merged, a release PR should be created by Release Please. **Squash merge** that PR as well.

### Merge release branch into main

Once you've pushed your changes to the release branch, those changes should be merged into main as well.

1. Switch to the release branch:

    ```console
    git switch release/<release>
    ```

1. Ensure release branch is up-to-date:

   ```console
   git pull
   ```

1. Switch to main:

    ```console
    git switch main
    ```

1. Ensure main is up-to-date:

   ```console
   git pull
   ```

1. Create a merge branch:

    ```console
    git switch -c chore-merge-release-<release>-into-main
    ```

1. Merge changes from the release branch into your branch:

    ```console
    git merge release/<release>
    ```

1. Push the merge branch to GitHub:

   ```console
   git push
   ```

1. Create a pull request into main.
1. Request a review.
1. Once approved, **create merge commit**.
1. Once merged, a release PR should be created by Release Please. **Squash merge** that PR.
