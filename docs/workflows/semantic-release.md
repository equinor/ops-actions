# ♻ semantic-release

```yaml
TODO: put usage example here.
```

## Inputs

key | type | required | default | description
--- | --- | --- | --- | ---
branches | string | False | main | A newline-separated string of branches to release on.
preset | string | False | conventionalcommits | Which preset to use for semantic-release.
plugins | string | False | @semantic-release/commit-analyzer
@semantic-release/release-notes-generator
@semantic-release/github | A newline-separated string of default plugins to use.
additional_plugins | string | False | conventional-changelog-conventionalcommits | A newline-separated string of additional plugins to install.
node_version | string | False | lts/* | Specify specific version of Node.js, with default set to latest version.
semantic_version | string | False | latest | Specify specific version of semantic-release, with default set to latest version.

## Secrets

key | required | description
--- | --- | ---

## Outputs

key | description
--- | ---