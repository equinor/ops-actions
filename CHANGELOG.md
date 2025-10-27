# Changelog

## [9.29.0](https://github.com/equinor/ops-actions/compare/v9.28.0...v9.29.0) (2025-10-27)


### Features

* add severity input to trivy workflow and rename workflow ([#841](https://github.com/equinor/ops-actions/issues/841)) ([89c3e02](https://github.com/equinor/ops-actions/commit/89c3e02cc1bf23654057eaaa081ffeacfc452f20))
* add trivy reusable workflow ([#832](https://github.com/equinor/ops-actions/issues/832)) ([14e795d](https://github.com/equinor/ops-actions/commit/14e795dacee614fbd65db85b9860256b6f17969e))
* add zizmor reusable workflow ([#826](https://github.com/equinor/ops-actions/issues/826)) ([98550ee](https://github.com/equinor/ops-actions/commit/98550eee60c0f246e28f528436b8ed6611654ecd))
* rename zizmor workflow ([#838](https://github.com/equinor/ops-actions/issues/838)) ([ebec794](https://github.com/equinor/ops-actions/commit/ebec794e0f8a41f8169903bc80aa809f4246d138))


### Bug Fixes

* **docker-acr:** login to Azure fails with data plane-only access ([#842](https://github.com/equinor/ops-actions/issues/842)) ([f5c5cd7](https://github.com/equinor/ops-actions/commit/f5c5cd76cd73a6c05af2694db873e494354de854))
* remove output_file parameter and change config_file parameter ([#836](https://github.com/equinor/ops-actions/issues/836)) ([dd822d6](https://github.com/equinor/ops-actions/commit/dd822d65d8106f32316acb1a23d67d7959fa2f89))

## [9.28.0](https://github.com/equinor/ops-actions/compare/v9.27.0...v9.28.0) (2025-10-21)


### Features

* **python-package:** toggle whether build artifact should be uploaded ([#819](https://github.com/equinor/ops-actions/issues/819)) ([3e6aa76](https://github.com/equinor/ops-actions/commit/3e6aa7652940db0420cfe0ed1e39136b5dcb12ed))


### Bug Fixes

* **deps:** bump actions/setup-node from 5.0.0 to 6.0.0 ([#830](https://github.com/equinor/ops-actions/issues/830)) ([17b6824](https://github.com/equinor/ops-actions/commit/17b68249826f6298bf9bbde1cfca9eeb85528049))
* **deps:** bump databricks/setup-cli from 0.272.0 to 0.273.0 ([#827](https://github.com/equinor/ops-actions/issues/827)) ([8fd7f2a](https://github.com/equinor/ops-actions/commit/8fd7f2ab3ef929ced00d7fd67e15a47958f3370a))
* **deps:** bump github/codeql-action from 4.30.8 to 4.30.9 ([#829](https://github.com/equinor/ops-actions/issues/829)) ([b2c15da](https://github.com/equinor/ops-actions/commit/b2c15da5f253c56714d2f31ab91858be106169f6))
* **deps:** bump super-linter/super-linter from 8.2.0 to 8.2.1 ([#828](https://github.com/equinor/ops-actions/issues/828)) ([c54b836](https://github.com/equinor/ops-actions/commit/c54b8368c0e4e36ca7eb57084467a5dcea5c1572))

## [9.27.0](https://github.com/equinor/ops-actions/compare/v9.26.1...v9.27.0) (2025-10-15)


### Features

* add workflow `release-please-manifest.yml` ([#814](https://github.com/equinor/ops-actions/issues/814)) ([6f234d7](https://github.com/equinor/ops-actions/commit/6f234d71d5d842b5c0f1ab40b91a9fe0112dd1a4))
* **python-package:** add output `artifact_name` ([#818](https://github.com/equinor/ops-actions/issues/818)) ([5be59af](https://github.com/equinor/ops-actions/commit/5be59af74dd895e735bf372346411bbf924e96f4))


### Bug Fixes

* **deps:** bump github/codeql-action from 4.30.7 to 4.30.8 ([#812](https://github.com/equinor/ops-actions/issues/812)) ([0254ecc](https://github.com/equinor/ops-actions/commit/0254eccdc3a46e2649fba2f5c177c49a767ed7a7))
* **release-please:** add missing permission `issues: write` ([#815](https://github.com/equinor/ops-actions/issues/815)) ([ff41fd3](https://github.com/equinor/ops-actions/commit/ff41fd31d389a6fdd785484e755838497eafb74b))

## [9.26.1](https://github.com/equinor/ops-actions/compare/v9.26.0...v9.26.1) (2025-10-10)


### Bug Fixes

* **deps:** bump astral-sh/setup-uv from 6.8.0 to 7.0.0 ([#807](https://github.com/equinor/ops-actions/issues/807)) ([90a0433](https://github.com/equinor/ops-actions/commit/90a043361f744d62a0968d79d192cc3e96ac9955))
* **deps:** bump databricks/setup-cli from 0.271.0 to 0.272.0 ([#806](https://github.com/equinor/ops-actions/issues/806)) ([93f0c9d](https://github.com/equinor/ops-actions/commit/93f0c9da5a17ce94191cac9da852e134e6bbe463))
* **deps:** bump github/codeql-action from 3.30.6 to 4.30.7 ([#808](https://github.com/equinor/ops-actions/issues/808)) ([07f737d](https://github.com/equinor/ops-actions/commit/07f737d6f0b5e59ca38967db331dba80284444ae))
* **super-linter:** disable Biome linter ([#804](https://github.com/equinor/ops-actions/issues/804)) ([cc53259](https://github.com/equinor/ops-actions/commit/cc53259f13569a639b9d0b7f71c1e06cb7720ca1))

## [9.26.0](https://github.com/equinor/ops-actions/compare/v9.25.0...v9.26.0) (2025-10-09)


### Features

* **mkdocs:** add input `git_fetch_depth` ([#798](https://github.com/equinor/ops-actions/issues/798)) ([3e8d7c9](https://github.com/equinor/ops-actions/commit/3e8d7c9406fdb2e4f30d50ac59fc4ff0b73fa6bd))
* **mkdocs:** add input `upload_artifact` ([#800](https://github.com/equinor/ops-actions/issues/800)) ([87d19c9](https://github.com/equinor/ops-actions/commit/87d19c9f20c813322b91e5c7bddc9a625eeecfe7))
* **mkdocs:** install Python version specified in `.python-version` file ([#799](https://github.com/equinor/ops-actions/issues/799)) ([dbde976](https://github.com/equinor/ops-actions/commit/dbde976f3756281d12fab95369032512e1224035))
* **python-release:** publish to PyPI ([#785](https://github.com/equinor/ops-actions/issues/785)) ([445c03f](https://github.com/equinor/ops-actions/commit/445c03fc6b19382cf8782b8c33abe0cc068b591f))

## [9.25.0](https://github.com/equinor/ops-actions/compare/v9.24.6...v9.25.0) (2025-09-30)


### Features

* **release-please:** output release properties ([#780](https://github.com/equinor/ops-actions/issues/780)) ([37b402b](https://github.com/equinor/ops-actions/commit/37b402b3d8a0b5d9e9d0d18f9f033c644a59d1ec))

## [9.24.6](https://github.com/equinor/ops-actions/compare/v9.24.5...v9.24.6) (2025-09-22)


### Bug Fixes

* **docker:** prevent code injection via template expression ([#781](https://github.com/equinor/ops-actions/issues/781)) ([a61cfd1](https://github.com/equinor/ops-actions/commit/a61cfd1bd9d1cd8e82700c7801c99877f2fc450f))

## [9.24.5](https://github.com/equinor/ops-actions/compare/v9.24.4...v9.24.5) (2025-09-15)


### Bug Fixes

* **python-release:** add required workflow permission ([#771](https://github.com/equinor/ops-actions/issues/771)) ([4d04d46](https://github.com/equinor/ops-actions/commit/4d04d464cb01fa5fb60e76c5b6d86f08eca7d894))


### Code Refactoring

* **python-release:** uppercase job name ([6333c92](https://github.com/equinor/ops-actions/commit/6333c92c8b8d21da2ecf26e6daccd78f663a39e2))

## [9.24.4](https://github.com/equinor/ops-actions/compare/v9.24.3...v9.24.4) (2025-09-15)


### Code Refactoring

* **python-release:** correct job name ([e2715f9](https://github.com/equinor/ops-actions/commit/e2715f9c75567d19f9bfca544e95bff9dde50130))

## [9.24.3](https://github.com/equinor/ops-actions/compare/v9.24.2...v9.24.3) (2025-09-15)


### Bug Fixes

* **python-release:** don't use uv ([26f809a](https://github.com/equinor/ops-actions/commit/26f809aea1b52ddfa59f9d4c9022c3c2cf73fde1))

## [9.24.2](https://github.com/equinor/ops-actions/compare/v9.24.1...v9.24.2) (2025-09-12)


### Bug Fixes

* **docker-acr:** fix context input ([#768](https://github.com/equinor/ops-actions/issues/768)) ([48b3843](https://github.com/equinor/ops-actions/commit/48b38430072ab9dbacc1129996d094168a1d62ec))

## [9.24.1](https://github.com/equinor/ops-actions/compare/v9.24.0...v9.24.1) (2025-09-12)


### Code Refactoring

* rename workflow `uv-release-please.yml` to `python-release.yml` ([#766](https://github.com/equinor/ops-actions/issues/766)) ([1d0cbe8](https://github.com/equinor/ops-actions/commit/1d0cbe8ec03901e7c9f61fa1b617859245a29a2e))

## [9.24.0](https://github.com/equinor/ops-actions/compare/v9.23.1...v9.24.0) (2025-09-11)


### Features

* add workflow `uv-release-please.yml` ([#757](https://github.com/equinor/ops-actions/issues/757)) ([9ffddf9](https://github.com/equinor/ops-actions/commit/9ffddf9b1ad0b47391834e0fc9da137dc0a2a2fb))

## [9.23.1](https://github.com/equinor/ops-actions/compare/v9.23.0...v9.23.1) (2025-09-09)


### Bug Fixes

* **release-please:** remove default release type ([#758](https://github.com/equinor/ops-actions/issues/758)) ([516bc9a](https://github.com/equinor/ops-actions/commit/516bc9a93645ac706c49c0d7b65eb4ba620246b6))


### Reverts

* **release-please:** remove default release type ([fc57633](https://github.com/equinor/ops-actions/commit/fc5763331cc731edb3dc80e55356285aca9beea8))

## [9.23.0](https://github.com/equinor/ops-actions/compare/v9.22.0...v9.23.0) (2025-09-04)


### Features

* disable Git credential persistance ([#751](https://github.com/equinor/ops-actions/issues/751)) ([cd950fc](https://github.com/equinor/ops-actions/commit/cd950fcdd0debd387bf1f95cda66254da4ac6766))


### Bug Fixes

* **docker:** pin `docker/setup-buildx-action` action to commit SHA ([#752](https://github.com/equinor/ops-actions/issues/752)) ([d3c9e73](https://github.com/equinor/ops-actions/commit/d3c9e73c5a11d767b007099e282dd5d6c570e53f))
* **docker:** prevent code injection via template expression ([#755](https://github.com/equinor/ops-actions/issues/755)) ([ded635d](https://github.com/equinor/ops-actions/commit/ded635d87dfb4aaac5845c460e9f8aec47c4da3c)), closes [#753](https://github.com/equinor/ops-actions/issues/753)

## [9.22.0](https://github.com/equinor/ops-actions/compare/v9.21.0...v9.22.0) (2025-07-24)


### Features

* **terraform:** validate configuration if triggered by Dependabot ([#734](https://github.com/equinor/ops-actions/issues/734)) ([f4040ad](https://github.com/equinor/ops-actions/commit/f4040ad62dfeaff29af1ec0868a876856756cd3a))

## [9.21.0](https://github.com/equinor/ops-actions/compare/v9.20.0...v9.21.0) (2025-07-07)


### Features

* **terraform:** authenticate Grafana provider ([#731](https://github.com/equinor/ops-actions/issues/731)) ([256e5e6](https://github.com/equinor/ops-actions/commit/256e5e6e2383933a9b28a549aea55c27e019ea71))

## [9.20.0](https://github.com/equinor/ops-actions/compare/v9.19.4...v9.20.0) (2025-06-27)


### Features

* **docker:** pass build arguments ([#729](https://github.com/equinor/ops-actions/issues/729)) ([60a3994](https://github.com/equinor/ops-actions/commit/60a399464b58f0db0d5ec9d316ff09e0cdf0107f))

## [9.19.4](https://github.com/equinor/ops-actions/compare/v9.19.3...v9.19.4) (2025-06-11)


### Bug Fixes

* **databricks:** update concurrency group to allow simultaneous runs ([#727](https://github.com/equinor/ops-actions/issues/727)) ([4ebf933](https://github.com/equinor/ops-actions/commit/4ebf933250380a267d7db82b0e7afcf975f79e19))

## [9.19.3](https://github.com/equinor/ops-actions/compare/v9.19.2...v9.19.3) (2025-05-13)


### Bug Fixes

* **terraform:** jobs that target different state files run in same concurrency group ([#718](https://github.com/equinor/ops-actions/issues/718)) ([bd21256](https://github.com/equinor/ops-actions/commit/bd212560893603826093aed8204a40325d9ff952)), closes [#717](https://github.com/equinor/ops-actions/issues/717)

## [9.19.2](https://github.com/equinor/ops-actions/compare/v9.19.1...v9.19.2) (2025-04-11)


### Bug Fixes

* `databricks-repos.yml` and `databricks-bundle.yml` use same concurrency queue ([#707](https://github.com/equinor/ops-actions/issues/707)) ([ae4c084](https://github.com/equinor/ops-actions/commit/ae4c084d767744518da355f08e85f7ba44ed78e0))

## [9.19.1](https://github.com/equinor/ops-actions/compare/v9.19.0...v9.19.1) (2025-04-09)


### Documentation

* **databricks-bundle:** clarify bundle target ([5643731](https://github.com/equinor/ops-actions/commit/564373157cec3fbcc41676a7d569f310eba72f97))

## [9.19.0](https://github.com/equinor/ops-actions/compare/v9.18.0...v9.19.0) (2025-04-08)


### Features

* add workflow `databricks-bundle.yml` ([#697](https://github.com/equinor/ops-actions/issues/697)) ([1a65214](https://github.com/equinor/ops-actions/commit/1a65214d44dd9c9d259647c7dd75089ce39ef8d2))
* **databricks-bundle:** validate before deploy ([#704](https://github.com/equinor/ops-actions/issues/704)) ([00986b7](https://github.com/equinor/ops-actions/commit/00986b75821e7480231be766a4cc03cc5c8996cc))

## [9.18.0](https://github.com/equinor/ops-actions/compare/v9.17.0...v9.18.0) (2025-04-07)


### Features

* **super-linter:** create job summary instead of status checks ([#695](https://github.com/equinor/ops-actions/issues/695)) ([b20735e](https://github.com/equinor/ops-actions/commit/b20735ebe801f72c3583d4905a91591a4ae39b80))

## [9.17.0](https://github.com/equinor/ops-actions/compare/v9.16.0...v9.17.0) (2025-04-04)


### Features

* add workflow `release-please.yml` ([#691](https://github.com/equinor/ops-actions/issues/691)) ([0b1964d](https://github.com/equinor/ops-actions/commit/0b1964dfe2920cf7f61237536e05e6780a9b6416))
* **databricks-repos:** set default repo path ([#692](https://github.com/equinor/ops-actions/issues/692)) ([6e7eecb](https://github.com/equinor/ops-actions/commit/6e7eecb8a26d0d1021d326f2432f755e8eb8a17a))
* **super-linter:** prefer Ruff over Flake8 and isort ([#694](https://github.com/equinor/ops-actions/issues/694)) ([5ee1a1e](https://github.com/equinor/ops-actions/commit/5ee1a1eeac7de5cb924b5a07c61825defe754b7b))

## [9.16.0](https://github.com/equinor/ops-actions/compare/v9.15.3...v9.16.0) (2025-04-02)


### Features

* **python:** add input `requirements` ([#602](https://github.com/equinor/ops-actions/issues/602)) ([f0be28c](https://github.com/equinor/ops-actions/commit/f0be28cc6bd763d06628cd2bceeffd88c0a4528f))

## [9.15.3](https://github.com/equinor/ops-actions/compare/v9.15.2...v9.15.3) (2025-03-31)


### Bug Fixes

* **azure-webapp:** unable to get access token from Azure CLI ([#684](https://github.com/equinor/ops-actions/issues/684)) ([4117bb2](https://github.com/equinor/ops-actions/commit/4117bb23581afc3f845629fd1a34ae05eb946693))

## [9.15.2](https://github.com/equinor/ops-actions/compare/v9.15.1...v9.15.2) (2025-03-31)


### Bug Fixes

* **azure-webapp:** typo in `tar` command option ([#682](https://github.com/equinor/ops-actions/issues/682)) ([81924ff](https://github.com/equinor/ops-actions/commit/81924ffaf3e88783dffa05cc28c5888bf11d22d3))

## [9.15.1](https://github.com/equinor/ops-actions/compare/v9.15.0...v9.15.1) (2025-03-31)


### Bug Fixes

* **azure-function:** unable to get access token from Azure CLI ([#679](https://github.com/equinor/ops-actions/issues/679)) ([385569c](https://github.com/equinor/ops-actions/commit/385569cb9a26e5530705354ff6c4fb0bb57ef8fa)), closes [#674](https://github.com/equinor/ops-actions/issues/674)

## [9.15.0](https://github.com/equinor/ops-actions/compare/v9.14.0...v9.15.0) (2025-03-27)


### Features

* add workflow `databricks-repos.yml` ([#675](https://github.com/equinor/ops-actions/issues/675)) ([9117bdb](https://github.com/equinor/ops-actions/commit/9117bdbcd9f981276be19227ed313c8d15e223da))

## [9.14.0](https://github.com/equinor/ops-actions/compare/v9.13.3...v9.14.0) (2025-03-11)


### Features

* disable Azure CLI output by default ([#671](https://github.com/equinor/ops-actions/issues/671)) ([25da2fd](https://github.com/equinor/ops-actions/commit/25da2fdab5ad1b407abf990dc38a112691f2352c))

## [9.13.3](https://github.com/equinor/ops-actions/compare/v9.13.2...v9.13.3) (2025-02-21)


### Code Refactoring

* update descriptions for Azure secrets ([#650](https://github.com/equinor/ops-actions/issues/650)) ([fa8f08c](https://github.com/equinor/ops-actions/commit/fa8f08cbf89b0e3987297296c6a314280b61b059))

## [9.13.2](https://github.com/equinor/ops-actions/compare/v9.13.1...v9.13.2) (2025-02-03)


### Code Refactoring

* **terraform:** create summary at end of job ([#641](https://github.com/equinor/ops-actions/issues/641)) ([e4d6674](https://github.com/equinor/ops-actions/commit/e4d6674ca81f3c5588c76cc2182a590b7e75a733))

## [9.13.1](https://github.com/equinor/ops-actions/compare/v9.13.0...v9.13.1) (2025-01-16)


### Reverts

* **terraform:** validate configuration if triggered by Dependabot ([1ef1222](https://github.com/equinor/ops-actions/commit/1ef1222411f03b3a8b74949e1d461b72b5f29012))

## [9.13.0](https://github.com/equinor/ops-actions/compare/v9.12.4...v9.13.0) (2025-01-16)


### Features

* **terraform:** validate configuration if triggered by Dependabot ([#623](https://github.com/equinor/ops-actions/issues/623)) ([9d552d9](https://github.com/equinor/ops-actions/commit/9d552d9811de33b0ce670c4bddbd39fc083ddc0e))

## [9.12.4](https://github.com/equinor/ops-actions/compare/v9.12.3...v9.12.4) (2025-01-09)


### Bug Fixes

* **terraform:** no log output when plugin cache enabled ([#630](https://github.com/equinor/ops-actions/issues/630)) ([306a079](https://github.com/equinor/ops-actions/commit/306a0793c5cf5b38b1de5168dfa59650e9aeec0b))

## [9.12.3](https://github.com/equinor/ops-actions/compare/v9.12.2...v9.12.3) (2025-01-07)


### Bug Fixes

* **terraform:** cache not restored in Apply job ([#627](https://github.com/equinor/ops-actions/issues/627)) ([a6ffd90](https://github.com/equinor/ops-actions/commit/a6ffd90eeff58a5571f6435edca7818645b2b0cf))

## [9.12.2](https://github.com/equinor/ops-actions/compare/v9.12.1...v9.12.2) (2024-12-16)


### Bug Fixes

* **terraform:** apply job fails if lock file has not been commited ([#617](https://github.com/equinor/ops-actions/issues/617)) ([c6292ea](https://github.com/equinor/ops-actions/commit/c6292eafd9a56831ec00f03decb4c5296265896d))

## [9.12.1](https://github.com/equinor/ops-actions/compare/v9.12.0...v9.12.1) (2024-12-13)


### Bug Fixes

* **terraform:** apply job should fail if unable to restore cache ([#614](https://github.com/equinor/ops-actions/issues/614)) ([3aebc3d](https://github.com/equinor/ops-actions/commit/3aebc3dd67a93b43dc0d54f17a32cbfe72f5406b))

## [9.12.0](https://github.com/equinor/ops-actions/compare/v9.11.0...v9.12.0) (2024-12-13)


### Features

* update jobs to run on latest OS version ([#611](https://github.com/equinor/ops-actions/issues/611)) ([8b1544e](https://github.com/equinor/ops-actions/commit/8b1544e8c0b6c821974c2d802c9ee46d566fa818))

## [9.11.0](https://github.com/equinor/ops-actions/compare/v9.10.4...v9.11.0) (2024-12-06)


### Features

* set explicit OS version for runners ([#606](https://github.com/equinor/ops-actions/issues/606)) ([853c4a3](https://github.com/equinor/ops-actions/commit/853c4a3611965649aeaa8bbe20b19703d055504e))

## [9.10.4](https://github.com/equinor/ops-actions/compare/v9.10.3...v9.10.4) (2024-11-19)


### Code Refactoring

* **terraform:** reorder steps ([8298e7b](https://github.com/equinor/ops-actions/commit/8298e7bb40e2b88edf0cf3ad3417362d92dc61c1))

## [9.10.3](https://github.com/equinor/ops-actions/compare/v9.10.2...v9.10.3) (2024-11-19)


### Bug Fixes

* **terraform:** duplicate caches created ([#596](https://github.com/equinor/ops-actions/issues/596)) ([5392dfc](https://github.com/equinor/ops-actions/commit/5392dfcd1425c5f1b7e828705a0044553cd41057))

## [9.10.2](https://github.com/equinor/ops-actions/compare/v9.10.1...v9.10.2) (2024-11-18)


### Bug Fixes

* **terraform:** no plugins uploaded to cache ([#593](https://github.com/equinor/ops-actions/issues/593)) ([7033d8d](https://github.com/equinor/ops-actions/commit/7033d8d425496abcbfe81056943120dc889ed380))

## [9.10.1](https://github.com/equinor/ops-actions/compare/v9.10.0...v9.10.1) (2024-11-18)


### Bug Fixes

* **terraform:** include plugins downloaded from cache in artifact ([#591](https://github.com/equinor/ops-actions/issues/591)) ([eaa211a](https://github.com/equinor/ops-actions/commit/eaa211a621866916d14ede701f0072a467af1dd2))

## [9.10.0](https://github.com/equinor/ops-actions/compare/v9.9.2...v9.10.0) (2024-11-14)


### Features

* **terraform:** store plugins in cache ([#396](https://github.com/equinor/ops-actions/issues/396)) ([744058b](https://github.com/equinor/ops-actions/commit/744058bac03a7dcbd2ecd2a4996f7c100523e86b))

## [9.9.2](https://github.com/equinor/ops-actions/compare/v9.9.1...v9.9.2) (2024-11-11)


### Bug Fixes

* **super-linter:** linter `TERRAFORM_TERRASCAN` throws redundant errors ([#588](https://github.com/equinor/ops-actions/issues/588)) ([b42a49b](https://github.com/equinor/ops-actions/commit/b42a49b6d4a3d7c7a258a6e8047f83bb548e9dae))

## [9.9.1](https://github.com/equinor/ops-actions/compare/v9.9.0...v9.9.1) (2024-11-08)


### Bug Fixes

* **azure-function:** no artifact download ([#586](https://github.com/equinor/ops-actions/issues/586)) ([13e9dd2](https://github.com/equinor/ops-actions/commit/13e9dd2f87fecf29288249fc95b9ba5340a52d97))
* **azure-webapp:** no artifact download ([#587](https://github.com/equinor/ops-actions/issues/587)) ([3635d54](https://github.com/equinor/ops-actions/commit/3635d545b1a04bb20e07779564d562174a725324))
* **dotnet:** no artifact uploaded ([#584](https://github.com/equinor/ops-actions/issues/584)) ([2cd5ccf](https://github.com/equinor/ops-actions/commit/2cd5ccff5ae326a1c99ee95633fcc55f5d2de409))

## [9.9.0](https://github.com/equinor/ops-actions/compare/v9.8.1...v9.9.0) (2024-11-06)


### Features

* **terraform:** add option to run Apply on condition ([#582](https://github.com/equinor/ops-actions/issues/582)) ([4e290ad](https://github.com/equinor/ops-actions/commit/4e290adfc7e5bf1eb65c352a62e97819f0c3b998))

## [9.8.1](https://github.com/equinor/ops-actions/compare/v9.8.0...v9.8.1) (2024-10-23)


### Bug Fixes

* **terraform:** formatting errors prevent job from running ([#575](https://github.com/equinor/ops-actions/issues/575)) ([45e610c](https://github.com/equinor/ops-actions/commit/45e610c8096145fc617f571d587578b01713334f))

## [9.8.0](https://github.com/equinor/ops-actions/compare/v9.7.3...v9.8.0) (2024-10-09)


### Features

* **terraform:** add input variable file for greater customization options ([#559](https://github.com/equinor/ops-actions/issues/559)) ([242f621](https://github.com/equinor/ops-actions/commit/242f621b9c2c76f8c415195c79cc8b2d41bb942c))

## [9.7.3](https://github.com/equinor/ops-actions/compare/v9.7.2...v9.7.3) (2024-10-08)


### Bug Fixes

* **terraform:** skip formatting check ([#568](https://github.com/equinor/ops-actions/issues/568)) ([7c84771](https://github.com/equinor/ops-actions/commit/7c8477122ea8334355a7757177413e18f013fe63))

## [9.7.2](https://github.com/equinor/ops-actions/compare/v9.7.1...v9.7.2) (2024-09-12)


### Code Refactoring

* **docker:** replace deprecated environment variable ([#549](https://github.com/equinor/ops-actions/issues/549)) ([24214a3](https://github.com/equinor/ops-actions/commit/24214a3df127b02f512f85ac69aa4760686a0a2a))

## [9.7.1](https://github.com/equinor/ops-actions/compare/v9.7.0...v9.7.1) (2024-09-11)


### Bug Fixes

* **super-linter:** disable Checkov and JSCPD linters ([#547](https://github.com/equinor/ops-actions/issues/547)) ([9b3e0e9](https://github.com/equinor/ops-actions/commit/9b3e0e9bc1f9102aff8930016e00cedc0be2edcf))

## [9.7.0](https://github.com/equinor/ops-actions/compare/v9.6.3...v9.7.0) (2024-09-05)


### Features

* **super-linter:** read configuration file ([#544](https://github.com/equinor/ops-actions/issues/544)) ([5ce8e1a](https://github.com/equinor/ops-actions/commit/5ce8e1aed8bcced8dab4ac786aef0e1cb5a150bb))

## [9.6.3](https://github.com/equinor/ops-actions/compare/v9.6.2...v9.6.3) (2024-08-26)


### Bug Fixes

* **super-linter:** unable to report status checks ([#539](https://github.com/equinor/ops-actions/issues/539)) ([66c21bf](https://github.com/equinor/ops-actions/commit/66c21bfb35dc2a93e5019253f78c41bd194b1230))

## [9.6.2](https://github.com/equinor/ops-actions/compare/v9.6.1...v9.6.2) (2024-07-15)


### Code Refactoring

* pin actions to commit SHA ([#522](https://github.com/equinor/ops-actions/issues/522)) ([078a21b](https://github.com/equinor/ops-actions/commit/078a21b58157f85d49d56ca9dd4a0e5082968320))

## [9.6.1](https://github.com/equinor/ops-actions/compare/v9.6.0...v9.6.1) (2024-07-02)


### Bug Fixes

* skip jobs that access privileged secrets if triggered by Dependabot ([#515](https://github.com/equinor/ops-actions/issues/515)) ([44c1d51](https://github.com/equinor/ops-actions/commit/44c1d5192bae0fca79ceeca7923e0d1732be6c47))

## [9.6.0](https://github.com/equinor/ops-actions/compare/v9.5.0...v9.6.0) (2024-06-27)


### Features

* **azure-function:** disable top level GitHub token permissions ([#501](https://github.com/equinor/ops-actions/issues/501)) ([059fd22](https://github.com/equinor/ops-actions/commit/059fd2228943db71bd5ba65668b3d40592427f99))
* **azure-webapp:** disable top level GitHub token permissions ([#502](https://github.com/equinor/ops-actions/issues/502)) ([34059eb](https://github.com/equinor/ops-actions/commit/34059eba6cfd347dc549ef2525c5d79668dc7da0))
* **commitlint:** disable top level GitHub token permissions ([#510](https://github.com/equinor/ops-actions/issues/510)) ([5560a8c](https://github.com/equinor/ops-actions/commit/5560a8c4823e53ef05aebb784f5fa9a42e4af63b))
* **docker:** disable top level GitHub token permissions ([#504](https://github.com/equinor/ops-actions/issues/504)) ([cad838b](https://github.com/equinor/ops-actions/commit/cad838b8fbf54d135c62f65b7d7720b91237d411))
* **docker:** generate job summary ([#499](https://github.com/equinor/ops-actions/issues/499)) ([a82fa9b](https://github.com/equinor/ops-actions/commit/a82fa9ba519853cbc2442ea7d7f101c8ea781863))
* **dotnet:** disable top level GitHub token permissions ([#503](https://github.com/equinor/ops-actions/issues/503)) ([1683671](https://github.com/equinor/ops-actions/commit/16836715e1ea0453affc25151138f79d04c6182a))
* **github-pages:** disable top level GitHub token permissions ([#507](https://github.com/equinor/ops-actions/issues/507)) ([a2dc9c4](https://github.com/equinor/ops-actions/commit/a2dc9c459eb0370ee4ca6d9ff85bb3cdb6fbddd7))
* **mkdocs:** disable top level GitHub token permissions ([#506](https://github.com/equinor/ops-actions/issues/506)) ([1405479](https://github.com/equinor/ops-actions/commit/1405479f148010abe5cfc82c446266cb838620b5))
* **python:** disable top level GitHub token permissions ([#508](https://github.com/equinor/ops-actions/issues/508)) ([da69b2d](https://github.com/equinor/ops-actions/commit/da69b2dc7594c8f853998a170b6461e0cece6998))
* **semantic-release:** disable top level GitHub token permissions ([#509](https://github.com/equinor/ops-actions/issues/509)) ([111f38d](https://github.com/equinor/ops-actions/commit/111f38d878757da118e8df7d11402419c6dd0b5d))
* **super-linter:** disable top level GitHub token permissions ([#511](https://github.com/equinor/ops-actions/issues/511)) ([95ca4b5](https://github.com/equinor/ops-actions/commit/95ca4b5768931b1ae506cc8fab7e27d569c7179a))
* **terraform:** disable top level GitHub token permissions ([#505](https://github.com/equinor/ops-actions/issues/505)) ([a1852e8](https://github.com/equinor/ops-actions/commit/a1852e8965f62c98e3389806a0ad63779696b021))
* **terraform:** skip job summary generation on empty plan ([#513](https://github.com/equinor/ops-actions/issues/513)) ([f73b3f5](https://github.com/equinor/ops-actions/commit/f73b3f5fbe2a3a0829801eb8e5153db63ca6dcaa))

## [9.5.0](https://github.com/equinor/ops-actions/compare/v9.4.1...v9.5.0) (2024-05-06)


### Features

* add filter_regex_include parameter to super-linter ([#480](https://github.com/equinor/ops-actions/issues/480)) ([5fb8787](https://github.com/equinor/ops-actions/commit/5fb87870a430b0b298e7c3ee16d323890c1b62bd))

## [9.4.1](https://github.com/equinor/ops-actions/compare/v9.4.0...v9.4.1) (2024-04-22)


### Bug Fixes

* **mkdocs:** unable to deploy artifact to GitHub Pages ([#465](https://github.com/equinor/ops-actions/issues/465)) ([b7980ac](https://github.com/equinor/ops-actions/commit/b7980ac00775b6a55bb1544f00ba94249c9cd528))

## [9.4.0](https://github.com/equinor/ops-actions/compare/v9.3.5...v9.4.0) (2024-04-19)


### Features

* **azure-function:** set slot-specific settings ([#456](https://github.com/equinor/ops-actions/issues/456)) ([6a59426](https://github.com/equinor/ops-actions/commit/6a59426339ccd1a64b8264bb9b26b1110d125045))
* **azure-webapp:** set slot-specific settings ([#453](https://github.com/equinor/ops-actions/issues/453)) ([278789c](https://github.com/equinor/ops-actions/commit/278789c338d3652c14e3921c852dad0b651c2b6f))
* **github-pages:** deploy to GitHub Pages ([#438](https://github.com/equinor/ops-actions/issues/438)) ([dd10f1e](https://github.com/equinor/ops-actions/commit/dd10f1e19e2a882b5a922cd3e0221fdce25f28b3))
* **mkdocs:** build MkDocs static site ([#437](https://github.com/equinor/ops-actions/issues/437)) ([9d5bb6b](https://github.com/equinor/ops-actions/commit/9d5bb6bc4ec0c60fbb8a2ff5bea86de521031a13))


### Bug Fixes

* suppress Azure Web App and Azure Function App settings output ([#462](https://github.com/equinor/ops-actions/issues/462)) ([93251d7](https://github.com/equinor/ops-actions/commit/93251d760ce5487f7035e60bc145bd2b0755bc70))

## [9.3.5](https://github.com/equinor/ops-actions/compare/v9.3.4...v9.3.5) (2024-04-12)


### Bug Fixes

* **dotnet:** unable to update NPM on latest GitHub runner ([#445](https://github.com/equinor/ops-actions/issues/445)) ([b889206](https://github.com/equinor/ops-actions/commit/b88920610bc597d206fb92da05a3e2814d39d491))

## [9.3.4](https://github.com/equinor/ops-actions/compare/v9.3.3...v9.3.4) (2024-04-10)


### Reverts

* **dotnet:** disable CI mode ([#439](https://github.com/equinor/ops-actions/issues/439)) ([4904824](https://github.com/equinor/ops-actions/commit/49048242acc3d13156512f9f1c0d179f7cb414c6))

## [9.3.3](https://github.com/equinor/ops-actions/compare/v9.3.2...v9.3.3) (2024-03-22)


### Code Refactoring

* **terraform:** remove dependency on third-party action ([#432](https://github.com/equinor/ops-actions/issues/432)) ([4d1600d](https://github.com/equinor/ops-actions/commit/4d1600de060929f2bde0b0eb960b589b7c6b4cb4))

## [9.3.2](https://github.com/equinor/ops-actions/compare/v9.3.1...v9.3.2) (2024-03-07)


### Bug Fixes

* **terraform:** run Apply job on same runner as Plan job ([716baf5](https://github.com/equinor/ops-actions/commit/716baf59bcb6045b5523804deeeb3338d16dd249))

## [9.3.1](https://github.com/equinor/ops-actions/compare/v9.3.0...v9.3.1) (2024-02-09)


### Bug Fixes

* **terraform:** artifact already exists ([#392](https://github.com/equinor/ops-actions/issues/392)) ([315ba0f](https://github.com/equinor/ops-actions/commit/315ba0f95f218c7a6845a61e08e83337e48e4849))

## [9.3.0](https://github.com/equinor/ops-actions/compare/v9.2.1...v9.3.0) (2024-02-09)


### Features

* **terraform:** set environment-specific artifact name by default ([#389](https://github.com/equinor/ops-actions/issues/389)) ([06ce89a](https://github.com/equinor/ops-actions/commit/06ce89a91ce980bde7e20578f86df08b09300a59))


### Bug Fixes

* **terraform:** unable to delete artifact ([#391](https://github.com/equinor/ops-actions/issues/391)) ([9848dc4](https://github.com/equinor/ops-actions/commit/9848dc4522b0171cb9338b260e84d4d491258885))

## [9.2.1](https://github.com/equinor/ops-actions/compare/v9.2.0...v9.2.1) (2024-02-09)


### Bug Fixes

* **terraform:** downgrade GeekyEggo/delete-artifact from 4.1.0 to 2.0.0 ([#387](https://github.com/equinor/ops-actions/issues/387)) ([ad0fab3](https://github.com/equinor/ops-actions/commit/ad0fab33d1445f233441b7e42a83b89c5cdd3cbd))

## [9.2.0](https://github.com/equinor/ops-actions/compare/v9.1.3...v9.2.0) (2024-02-08)


### Features

* **terraform:** add option to send runner type as parameter ([#383](https://github.com/equinor/ops-actions/issues/383)) ([3560f76](https://github.com/equinor/ops-actions/commit/3560f76979055ee86b7bf00b6f8ed25d3ab96563))

## [9.1.3](https://github.com/equinor/ops-actions/compare/v9.1.2...v9.1.3) (2024-01-30)


### Bug Fixes

* bump actions/setup-dotnet from 2 to 4 ([#375](https://github.com/equinor/ops-actions/issues/375)) ([e545362](https://github.com/equinor/ops-actions/commit/e54536215e0c5ed472119c77965a83cd1e5ae7f1))
* bump azure/webapps-deploy from 2 to 3 ([#376](https://github.com/equinor/ops-actions/issues/376)) ([ed49dc7](https://github.com/equinor/ops-actions/commit/ed49dc766764ce7441e8b000f3a7c2cbcad5fcd3))
* bump docker/build-push-action from 3 to 5 ([#374](https://github.com/equinor/ops-actions/issues/374)) ([6311824](https://github.com/equinor/ops-actions/commit/631182404f245373feae63a723ab030a6a678ebc))
* **docker:** bump docker/login-action from 2 to 3 ([#377](https://github.com/equinor/ops-actions/issues/377)) ([998c428](https://github.com/equinor/ops-actions/commit/998c428fae7ed20cc5b22b76244cafc55d874204))

## [9.1.2](https://github.com/equinor/ops-actions/compare/v9.1.1...v9.1.2) (2024-01-30)


### Bug Fixes

* bump actions/setup-python from 4 to 5 ([#367](https://github.com/equinor/ops-actions/issues/367)) ([a76c0eb](https://github.com/equinor/ops-actions/commit/a76c0eb912cd5f88494ba616f091786bdefe3672))
* bump docker/setup-buildx-action from 2 to 3 ([#370](https://github.com/equinor/ops-actions/issues/370)) ([cfd58de](https://github.com/equinor/ops-actions/commit/cfd58de0b2009aaf2ec41e63cad713bc3881135d))
* **semantic-release:** bump actions/setup-node from 3 to 4 ([#368](https://github.com/equinor/ops-actions/issues/368)) ([12fa565](https://github.com/equinor/ops-actions/commit/12fa5653e7bcdf7fe51463ca10b97e9af18b8756))
* **terraform:** bump GeekyEggo/delete-artifact from 2.0.0 to 4.1.0 ([#369](https://github.com/equinor/ops-actions/issues/369)) ([a023f14](https://github.com/equinor/ops-actions/commit/a023f14b3bc7db9958b0bc67902167fd612225c1))

## [9.1.1](https://github.com/equinor/ops-actions/compare/v9.1.0...v9.1.1) (2024-01-29)


### Bug Fixes

* upgrade action versions ([#362](https://github.com/equinor/ops-actions/issues/362)) ([ad05797](https://github.com/equinor/ops-actions/commit/ad05797edb3adade15b5e4df29daabfa06deb193))

## [9.1.0](https://github.com/equinor/ops-actions/compare/v9.0.1...v9.1.0) (2024-01-26)


### Features

* **terraform:** use BSL releases ([#358](https://github.com/equinor/ops-actions/issues/358)) ([ef822fd](https://github.com/equinor/ops-actions/commit/ef822fdb5bfb2dd8fc8b7124a672804700d4ddfb))


### Bug Fixes

* upgrade action versions ([#359](https://github.com/equinor/ops-actions/issues/359)) ([43e2559](https://github.com/equinor/ops-actions/commit/43e2559744413ea6130ff29b1d6349bda2c12201))

## [9.0.1](https://github.com/equinor/ops-actions/compare/v9.0.0...v9.0.1) (2024-01-25)


### Bug Fixes

* **terraform:** upgrade action versions ([#356](https://github.com/equinor/ops-actions/issues/356)) ([b7f0f24](https://github.com/equinor/ops-actions/commit/b7f0f24e0216d57630141d7da2952cf7a592ea5a))

## [9.0.0](https://github.com/equinor/ops-actions/compare/v8.13.0...v9.0.0) (2024-01-25)


### ⚠ BREAKING CHANGES

* remove Azure SQL DB restore workflow ([#349](https://github.com/equinor/ops-actions/issues/349))

### Features

* remove Azure SQL DB restore workflow ([#349](https://github.com/equinor/ops-actions/issues/349)) ([41d734d](https://github.com/equinor/ops-actions/commit/41d734dd372904ff02a42506b7c21bcb481d828c)), closes [#339](https://github.com/equinor/ops-actions/issues/339)

## [8.13.0](https://github.com/equinor/ops-actions/compare/v8.12.0...v8.13.0) (2024-01-25)


### Features

* **commitlint:** lint latest commit message by default ([#350](https://github.com/equinor/ops-actions/issues/350)) ([9971f51](https://github.com/equinor/ops-actions/commit/9971f51ba23cb1b47b8da219a332a2b976c1c9f0))


### Bug Fixes

* **commitlint:** upgrade  action version ([#353](https://github.com/equinor/ops-actions/issues/353)) ([431fe13](https://github.com/equinor/ops-actions/commit/431fe135c00acf8e4523d56c74c5e229c9c059a1))
* **super-linter:** upgrade  action version ([#352](https://github.com/equinor/ops-actions/issues/352)) ([31b007f](https://github.com/equinor/ops-actions/commit/31b007f610475d4b047ceaa0d42736c0d79b0eb0))

## [8.12.0](https://github.com/equinor/ops-actions/compare/v8.11.0...v8.12.0) (2023-11-22)


### Features

* **terraform:** speed up archiving of config ([#335](https://github.com/equinor/ops-actions/issues/335)) ([20bf45e](https://github.com/equinor/ops-actions/commit/20bf45e47c86b70e74e51c971bbe708d56cf844a))

## [8.11.0](https://github.com/equinor/ops-actions/compare/v8.10.2...v8.11.0) (2023-11-06)


### Features

* add Azure SQL DB restore workflow ([#322](https://github.com/equinor/ops-actions/issues/322)) ([9447486](https://github.com/equinor/ops-actions/commit/94474867d82889809de1d9bb8cf5a3f197953d88))

## [8.10.2](https://github.com/equinor/ops-actions/compare/v8.10.1...v8.10.2) (2023-11-03)


### Bug Fixes

* **dotnet:** support self-contained publish ([#323](https://github.com/equinor/ops-actions/issues/323)) ([36d1bee](https://github.com/equinor/ops-actions/commit/36d1beea687faa5fa7a913d7740ccf2c907c8e0d))

## [8.10.1](https://github.com/equinor/ops-actions/compare/v8.10.0...v8.10.1) (2023-10-27)


### Bug Fixes

* **terraform:** no job summary on error ([#315](https://github.com/equinor/ops-actions/issues/315)) ([58b5f09](https://github.com/equinor/ops-actions/commit/58b5f0963150d12877a22bc21067ddb62c61ad91))

## [8.10.0](https://github.com/equinor/ops-actions/compare/v8.9.1...v8.10.0) (2023-10-25)


### Features

* **terraform:** skip Apply if no changes present ([#310](https://github.com/equinor/ops-actions/issues/310)) ([265d3a4](https://github.com/equinor/ops-actions/commit/265d3a42cf3c3428f2e6bd59c43575b6c9e01325))

## [8.9.1](https://github.com/equinor/ops-actions/compare/v8.9.0...v8.9.1) (2023-10-25)


### Bug Fixes

* **terraform:** error on plan with special chars ([#307](https://github.com/equinor/ops-actions/issues/307)) ([56243fd](https://github.com/equinor/ops-actions/commit/56243fd12551aab0ced8f17f03f6d6f1928a3c16))

## [8.9.0](https://github.com/equinor/ops-actions/compare/v8.8.0...v8.9.0) (2023-10-24)


### Features

* **super-linter:** exclude files from linting ([#299](https://github.com/equinor/ops-actions/issues/299)) ([27aaa03](https://github.com/equinor/ops-actions/commit/27aaa037e40abc6f128332aa4ae7938433d4cdf3))

## [8.8.0](https://github.com/equinor/ops-actions/compare/v8.7.4...v8.8.0) (2023-10-18)


### Features

* **docker:** set default repository ([#289](https://github.com/equinor/ops-actions/issues/289)) ([20f84c3](https://github.com/equinor/ops-actions/commit/20f84c3b374033043bc98f790fd372749a13db15))

## [8.7.4](https://github.com/equinor/ops-actions/compare/v8.7.3...v8.7.4) (2023-10-17)


### Bug Fixes

* **terraform:** empty backend config throws error ([#286](https://github.com/equinor/ops-actions/issues/286)) ([e75cbea](https://github.com/equinor/ops-actions/commit/e75cbea2473ac411fbe090717caf8beed9989b24))

## [8.7.3](https://github.com/equinor/ops-actions/compare/v8.7.2...v8.7.3) (2023-10-17)


### Bug Fixes

* remove calls to outdated action ([#283](https://github.com/equinor/ops-actions/issues/283)) ([1c29fc1](https://github.com/equinor/ops-actions/commit/1c29fc16aa3d0498901e47427580440da13e2f79))

## [8.7.2](https://github.com/equinor/ops-actions/compare/v8.7.1...v8.7.2) (2023-10-13)


### Bug Fixes

* **dotnet:** skip NPM update step if not required ([#280](https://github.com/equinor/ops-actions/issues/280)) ([0931dfe](https://github.com/equinor/ops-actions/commit/0931dfee6e423e0961ee382d9aa4ee121595f000))

## [8.7.1](https://github.com/equinor/ops-actions/compare/v8.7.0...v8.7.1) (2023-10-13)


### Bug Fixes

* **dotnet:** don't specify runtime for test and publish ([#276](https://github.com/equinor/ops-actions/issues/276)) ([1ad1560](https://github.com/equinor/ops-actions/commit/1ad15608f2604f8097b4c1a55893f060eb0cf5ea))
* **dotnet:** skip NPM update step if not required ([#275](https://github.com/equinor/ops-actions/issues/275)) ([f181815](https://github.com/equinor/ops-actions/commit/f181815ad26e35bad0551c042d86cf06cc42bac9))


### Reverts

* **azure-webapp:** add optional input `runs_on` ([#278](https://github.com/equinor/ops-actions/issues/278)) ([7d22977](https://github.com/equinor/ops-actions/commit/7d22977f4724187e9c451c19865773dfd0788394))
* **dotnet:** add optional input `runs_on` ([#279](https://github.com/equinor/ops-actions/issues/279)) ([10576cc](https://github.com/equinor/ops-actions/commit/10576cc086fbe240e51de1ffb535b49e300a9250))

## [8.7.0](https://github.com/equinor/ops-actions/compare/v8.6.0...v8.7.0) (2023-10-12)


### Features

* **azure-webapp:** add optional input `runs_on` ([#273](https://github.com/equinor/ops-actions/issues/273)) ([1d9fb31](https://github.com/equinor/ops-actions/commit/1d9fb318ddb99ff2709af9d524c0dcab3c1e941a))
* **dotnet:** add optional input `runs_on` ([#272](https://github.com/equinor/ops-actions/issues/272)) ([dd8620e](https://github.com/equinor/ops-actions/commit/dd8620e596c3de93bf599a783dd426a6f255303b))

## [8.6.0](https://github.com/equinor/ops-actions/compare/v8.5.2...v8.6.0) (2023-10-12)


### Features

* **terraform:** configure partial backend ([#267](https://github.com/equinor/ops-actions/issues/267)) ([e4d564b](https://github.com/equinor/ops-actions/commit/e4d564bbeecdaf930fdae578dc9931bd20942427))

## [8.5.2](https://github.com/equinor/ops-actions/compare/v8.5.1...v8.5.2) (2023-09-25)


### Bug Fixes

* **terraform:** Bash throws error if plan too long ([#259](https://github.com/equinor/ops-actions/issues/259)) ([0cf9966](https://github.com/equinor/ops-actions/commit/0cf9966638f7062c9de7584d560371f1dd787b9d))

## [8.5.1](https://github.com/equinor/ops-actions/compare/v8.5.0...v8.5.1) (2023-09-22)


### Bug Fixes

* **terraform:** use latest 1.5 patch version ([#257](https://github.com/equinor/ops-actions/issues/257)) ([00f63a8](https://github.com/equinor/ops-actions/commit/00f63a8299ebf070c695b2d7f544ff457ccfa8e8))

## [8.5.0](https://github.com/equinor/ops-actions/compare/v8.4.0...v8.5.0) (2023-09-22)


### Features

* **terraform:** ensure use of open-source release ([#255](https://github.com/equinor/ops-actions/issues/255)) ([106cda4](https://github.com/equinor/ops-actions/commit/106cda4cbf13895affc5d65a38a1bbc085dff89b))

## [8.4.0](https://github.com/equinor/ops-actions/compare/v8.3.1...v8.4.0) (2023-09-19)


### Features

* **terraform:** plan job deploys temporarily ([#250](https://github.com/equinor/ops-actions/issues/250)) ([a5c2dbf](https://github.com/equinor/ops-actions/commit/a5c2dbf3a85d173e609dd81efdc2bc2d366e42a0))

## [8.3.1](https://github.com/equinor/ops-actions/compare/v8.3.0...v8.3.1) (2023-08-25)


### Bug Fixes

* **terraform:** unable to delete artifact ([#227](https://github.com/equinor/ops-actions/issues/227)) ([c41a4e9](https://github.com/equinor/ops-actions/commit/c41a4e9f6da227950a6f6c7158965567d4f0ef89))

## [8.3.0](https://github.com/equinor/ops-actions/compare/v8.2.0...v8.3.0) (2023-08-25)


### Features

* **terraform:** delete artifact after Apply ([#224](https://github.com/equinor/ops-actions/issues/224)) ([691bfe6](https://github.com/equinor/ops-actions/commit/691bfe6889ad71a35dbb3c16aa67d2a12c068e5f))

## [8.2.0](https://github.com/equinor/ops-actions/compare/v8.1.0...v8.2.0) (2023-08-24)


### Features

* **terraform:** delete artifact after usage limit ([#219](https://github.com/equinor/ops-actions/issues/219)) ([84d9708](https://github.com/equinor/ops-actions/commit/84d97084f8d38fa49156f679eccb6134703b68b9))

## [8.1.0](https://github.com/equinor/ops-actions/compare/v8.0.0...v8.1.0) (2023-08-23)


### Features

* **terraform:** skip Apply if no changes present ([#211](https://github.com/equinor/ops-actions/issues/211)) ([8f18f17](https://github.com/equinor/ops-actions/commit/8f18f177f18c1c557f4d94d8e8f8c088fa7e13f0))

## [8.0.0](https://github.com/equinor/ops-actions/compare/v7.4.1...v8.0.0) (2023-08-23)


### ⚠ BREAKING CHANGES

* **terraform:** Add secret `ENCRYPTION_PASSWORD`.

### Features

* **terraform:** pass config between jobs ([#216](https://github.com/equinor/ops-actions/issues/216)) ([16c0d93](https://github.com/equinor/ops-actions/commit/16c0d93f716fda7916bb616d3c17f788ef41b38b))

## [7.4.1](https://github.com/equinor/ops-actions/compare/v7.4.0...v7.4.1) (2023-07-25)


### Bug Fixes

* **terraform:** don't run Apply without approval ([#208](https://github.com/equinor/ops-actions/issues/208)) ([2ad4ed6](https://github.com/equinor/ops-actions/commit/2ad4ed62056243bbde055d39f060007cf6302047))

## [7.4.0](https://github.com/equinor/ops-actions/compare/v7.3.0...v7.4.0) (2023-07-25)


### Features

* **terraform:** run Apply in separate job ([#205](https://github.com/equinor/ops-actions/issues/205)) ([35e7a43](https://github.com/equinor/ops-actions/commit/35e7a43658e0e4e6b0283dceb8f197b2e52d11c9))

## [7.3.0](https://github.com/equinor/ops-actions/compare/v7.2.1...v7.3.0) (2023-07-18)


### Features

* **docker:** build and push to Docker registry ([#203](https://github.com/equinor/ops-actions/issues/203)) ([946e5f4](https://github.com/equinor/ops-actions/commit/946e5f409a2f8bf5a638ac84d3cb9467a917d857))

## [7.2.1](https://github.com/equinor/ops-actions/compare/v7.2.0...v7.2.1) (2023-07-03)


### Bug Fixes

* **terraform:** pass pass through envvar before comment ([#201](https://github.com/equinor/ops-actions/issues/201)) ([875f363](https://github.com/equinor/ops-actions/commit/875f363c5cf5c364ef09810f0fcaf940c96878ce))

## [7.2.0](https://github.com/equinor/ops-actions/compare/v7.1.0...v7.2.0) (2023-07-03)


### Features

* **terraform:** create PR comment ([#198](https://github.com/equinor/ops-actions/issues/198)) ([9e658b1](https://github.com/equinor/ops-actions/commit/9e658b1e11a43328e129e052f4b4523c807ef5d5))

## [7.1.0](https://github.com/equinor/ops-actions/compare/v7.0.0...v7.1.0) (2023-05-05)


### Features

* **dotnet:** update npm ([#193](https://github.com/equinor/ops-actions/issues/193)) ([aef4fe0](https://github.com/equinor/ops-actions/commit/aef4fe0d8ac747e18c0ac8fc6956dd2a6daa1d64))

## [7.0.0](https://github.com/equinor/ops-actions/compare/v6.12.0...v7.0.0) (2023-04-04)


### ⚠ BREAKING CHANGES

* remove SQL server secret rotation workflow ([#181](https://github.com/equinor/ops-actions/issues/181))
* create GitHub issue ([#180](https://github.com/equinor/ops-actions/issues/180))
* use common convention for workflow filenames ([#176](https://github.com/equinor/ops-actions/issues/176))

### Features

* remove SQL server secret rotation workflow ([#181](https://github.com/equinor/ops-actions/issues/181)) ([b62f9e1](https://github.com/equinor/ops-actions/commit/b62f9e1564cc64a5acabe6ac24e0a9ede0e8c5c9))


### Reverts

* create GitHub issue ([#180](https://github.com/equinor/ops-actions/issues/180)) ([dfb2eec](https://github.com/equinor/ops-actions/commit/dfb2eecd033d104679d0838aaacea86195dea503))


### Code Refactoring

* use common convention for workflow filenames ([#176](https://github.com/equinor/ops-actions/issues/176)) ([97f0cd8](https://github.com/equinor/ops-actions/commit/97f0cd84da43527c88be64447330e82beb6052da))

## [6.12.0](https://github.com/equinor/ops-actions/compare/v6.11.0...v6.12.0) (2023-03-22)


### Features

* create GitHub issue ([#172](https://github.com/equinor/ops-actions/issues/172)) ([29ab373](https://github.com/equinor/ops-actions/commit/29ab373c7d54418de8c0d614cf8370dcb1eb2a5c))

## [6.11.0](https://github.com/equinor/ops-actions/compare/v6.10.1...v6.11.0) (2023-03-20)


### Features

* **commitlint:** set custom help url ([#168](https://github.com/equinor/ops-actions/issues/168)) ([0e9ce0e](https://github.com/equinor/ops-actions/commit/0e9ce0e11bb8175eda27dc02a0f091b5ba673d23))

## [6.10.1](https://github.com/equinor/ops-actions/compare/v6.10.0...v6.10.1) (2023-03-20)


### Reverts

* **dotnet:** trim trailing newlines for test projects ([#169](https://github.com/equinor/ops-actions/issues/169)) ([2f1683c](https://github.com/equinor/ops-actions/commit/2f1683ca00bb22bfafab5d797b42f1907f5f5474))

## [6.10.0](https://github.com/equinor/ops-actions/compare/v6.9.2...v6.10.0) (2023-03-13)


### Features

* deploy MkDocs to GitHub Pages ([#166](https://github.com/equinor/ops-actions/issues/166)) ([8964041](https://github.com/equinor/ops-actions/commit/896404148e5adef3abaec1d5cfdc8c0c51f62c3d))

## [6.9.2](https://github.com/equinor/ops-actions/compare/v6.9.1...v6.9.2) (2023-03-10)


### Bug Fixes

* don't mask app settings ([#163](https://github.com/equinor/ops-actions/issues/163)) ([7098187](https://github.com/equinor/ops-actions/commit/7098187d6ea28bc117e3389535c080fa04d66ca1))

## [6.9.1](https://github.com/equinor/ops-actions/compare/v6.9.0...v6.9.1) (2023-03-10)


### Bug Fixes

* correct supported app settings formats ([#161](https://github.com/equinor/ops-actions/issues/161)) ([96c2520](https://github.com/equinor/ops-actions/commit/96c2520f8b6f984b6c5dd52b1b39a451787d3072))

## [6.9.0](https://github.com/equinor/ops-actions/compare/v6.8.0...v6.9.0) (2023-03-09)


### Features

* make environment optional ([#159](https://github.com/equinor/ops-actions/issues/159)) ([a3eb971](https://github.com/equinor/ops-actions/commit/a3eb971aca64a04f3975f694932143bea02595b5))


### Bug Fixes

* **dotnet:** trim trailing newlines for test projects ([#155](https://github.com/equinor/ops-actions/issues/155)) ([1a72941](https://github.com/equinor/ops-actions/commit/1a729419eaf540a405f28617666897152acb7797))

## [6.8.0](https://github.com/equinor/ops-actions/compare/v6.7.0...v6.8.0) (2023-03-09)


### Features

* **terraform:** make environment input optional ([#157](https://github.com/equinor/ops-actions/issues/157)) ([2a0b0f9](https://github.com/equinor/ops-actions/commit/2a0b0f952bc277bd8e0a84b23ad09012cab8a4ec))

## [6.7.0](https://github.com/equinor/ops-actions/compare/v6.6.1...v6.7.0) (2023-03-08)


### Features

* **dotnet:** disable CI mode ([#150](https://github.com/equinor/ops-actions/issues/150)) ([3c9a702](https://github.com/equinor/ops-actions/commit/3c9a70266ec27f747c356ca7b778c4849c24c80b))
* **dotnet:** run multiple test projects ([#147](https://github.com/equinor/ops-actions/issues/147)) ([0ac08f7](https://github.com/equinor/ops-actions/commit/0ac08f7ff78889448d7a7e89733f9a64d480a53f))

## [6.6.1](https://github.com/equinor/ops-actions/compare/v6.6.0...v6.6.1) (2023-03-08)


### Bug Fixes

* **dotnet:** build artifact contains entire temp directory ([#148](https://github.com/equinor/ops-actions/issues/148)) ([f34971f](https://github.com/equinor/ops-actions/commit/f34971f9c415bd91fabe52847092815514465c0a))

## [6.6.0](https://github.com/equinor/ops-actions/compare/v6.5.0...v6.6.0) (2023-03-03)


### Features

* **dotnet:** run unit tests ([#95](https://github.com/equinor/ops-actions/issues/95)) ([51a2735](https://github.com/equinor/ops-actions/commit/51a27357c9c72f78713cc7ab279b6522218a6f51))
* **dotnet:** specify project file ([#142](https://github.com/equinor/ops-actions/issues/142)) ([7be58d2](https://github.com/equinor/ops-actions/commit/7be58d23fd1cdd89a5bffa27094ab41e75e07750))
* skip configuration if no input appsettings ([#143](https://github.com/equinor/ops-actions/issues/143)) ([19eca30](https://github.com/equinor/ops-actions/commit/19eca30859f38896051f7220a82737eabad5c951))

## [6.5.0](https://github.com/equinor/ops-actions/compare/v6.4.1...v6.5.0) (2023-02-17)


### Features

* **azure-function:** configure app settings ([#136](https://github.com/equinor/ops-actions/issues/136)) ([4fc282f](https://github.com/equinor/ops-actions/commit/4fc282f0700b043ab51d371bfe38f6b528c2030d))
* **azure-webapp:** more app settings formats ([#139](https://github.com/equinor/ops-actions/issues/139)) ([b4f0ae8](https://github.com/equinor/ops-actions/commit/b4f0ae8a76c457a70f31a0b7f2ccbae0007c8ece))

## [6.4.1](https://github.com/equinor/ops-actions/compare/v6.4.0...v6.4.1) (2023-02-16)


### Bug Fixes

* **azure-webapp:** set empty app settings by default ([#133](https://github.com/equinor/ops-actions/issues/133)) ([39d35ba](https://github.com/equinor/ops-actions/commit/39d35ba95dffbac794a5b78efcbf0f8175e90916))

## [6.4.0](https://github.com/equinor/ops-actions/compare/v6.3.0...v6.4.0) (2023-02-16)


### Features

* **python:** create virtual environment ([#127](https://github.com/equinor/ops-actions/issues/127)) ([b8c90a9](https://github.com/equinor/ops-actions/commit/b8c90a9881d68cb6b7b5a93088cac780fe26aedf))

## [6.3.0](https://github.com/equinor/ops-actions/compare/v6.2.1...v6.3.0) (2023-02-14)


### Features

* **azure-webapp:** configure app settings using offical action ([#122](https://github.com/equinor/ops-actions/issues/122)) ([bd3659e](https://github.com/equinor/ops-actions/commit/bd3659eb10cfaf0057bd78a7221b1cc65d635b0a))
* build Python application ([#120](https://github.com/equinor/ops-actions/issues/120)) ([9d84888](https://github.com/equinor/ops-actions/commit/9d848887047704797e48e4e35d77b9eb5db37143))
* deploy Azure function ([#121](https://github.com/equinor/ops-actions/issues/121)) ([3e5e30e](https://github.com/equinor/ops-actions/commit/3e5e30e037a444d6f6fcc8e51ec104a923595041))
* zip/unzip artifacts to improve upload/download performance ([#124](https://github.com/equinor/ops-actions/issues/124)) ([0cc604a](https://github.com/equinor/ops-actions/commit/0cc604aa5e581b8ba8433a63bf61dfb217b4c66c))

## [6.2.1](https://github.com/equinor/ops-actions/compare/v6.2.0...v6.2.1) (2023-02-09)


### Reverts

* use azuread for terraform azure backend auth ([#112](https://github.com/equinor/ops-actions/issues/112)) ([8cb9592](https://github.com/equinor/ops-actions/commit/8cb959224e99b722e703faee1d9cd44ce6b09e5d))
