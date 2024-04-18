# Changelog

## [10.0.4](https://github.com/equinor/ops-actions/compare/v10.0.4...v10.0.4) (2024-04-18)


### ⚠ BREAKING CHANGES

* **terraform:** remove secrets `AZURE_CLIENT_ID`, `AZURE_SUBSCRIPTION_ID` and `AZURE_TENANT_ID`. To migrate your project, run the latest version of the `oidc.sh` script and delete GitHub secrets `AZURE_CLIENT_ID`, `AZURE_SUBSCRIPTION_ID` and `AZURE_TENANT_ID`.
* **docker-acr:** remove secrets `AZURE_CLIENT_ID`, `AZURE_SUBSCRIPTION_ID` and `AZURE_TENANT_ID`. To migrate your project, run the latest version of the `oidc.sh` script and delete GitHub secrets `AZURE_CLIENT_ID`, `AZURE_SUBSCRIPTION_ID` and `AZURE_TENANT_ID`.
* **azure-webapp:** remove secrets `AZURE_CLIENT_ID`, `AZURE_SUBSCRIPTION_ID` and `AZURE_TENANT_ID`. To migrate your project, run the latest version of the `oidc.sh` script and delete GitHub secrets `AZURE_CLIENT_ID`, `AZURE_SUBSCRIPTION_ID` and `AZURE_TENANT_ID`.
* **azure-function:** remove secrets `AZURE_CLIENT_ID`, `AZURE_SUBSCRIPTION_ID` and `AZURE_TENANT_ID`. To migrate your project, run the latest version of the `oidc.sh` script and delete GitHub secrets `AZURE_CLIENT_ID`, `AZURE_SUBSCRIPTION_ID` and `AZURE_TENANT_ID`.
* remove Azure SQL DB restore workflow ([#349](https://github.com/equinor/ops-actions/issues/349))
* **terraform:** Add secret `ENCRYPTION_PASSWORD`.
* remove SQL server secret rotation workflow ([#181](https://github.com/equinor/ops-actions/issues/181))
* create GitHub issue ([#180](https://github.com/equinor/ops-actions/issues/180))
* use common convention for workflow filenames ([#176](https://github.com/equinor/ops-actions/issues/176))
* **deploy-azure-webapp:** rename workflow `deploy-azure-webapp-container.yml` to `deploy-azure-webapp.yml`
* **commitlint:** Add input `message`. To migrate your project, set value to `${{ github.event.pull_request.title }}`.
* **deploy:** remove secret `web_app_publish_profile`
* **build-docker-acr:** add secret `AZURE_TENANT_ID`
* **terraform:** add secret `AZURE_TENANT_ID`

### Features

* add Azure SQL DB restore workflow ([#322](https://github.com/equinor/ops-actions/issues/322)) ([9447486](https://github.com/equinor/ops-actions/commit/94474867d82889809de1d9bb8cf5a3f197953d88))
* add docker workflow ([#23](https://github.com/equinor/ops-actions/issues/23)) ([de83093](https://github.com/equinor/ops-actions/commit/de830936993fd928b50233d082f13ae4aa1f0d5f))
* add super-linter ([#25](https://github.com/equinor/ops-actions/issues/25)) ([08e13d6](https://github.com/equinor/ops-actions/commit/08e13d6d6e8db3f1af6b304d5394aab9e327f56f))
* add workflow for commitlint ([#20](https://github.com/equinor/ops-actions/issues/20)) ([d113d0b](https://github.com/equinor/ops-actions/commit/d113d0b36056015dd93802cfd823700f92ed5507))
* **azure-function:** configure app settings ([#136](https://github.com/equinor/ops-actions/issues/136)) ([4fc282f](https://github.com/equinor/ops-actions/commit/4fc282f0700b043ab51d371bfe38f6b528c2030d))
* **azure-webapp-container:** replace app settings ([#82](https://github.com/equinor/ops-actions/issues/82)) ([e85989f](https://github.com/equinor/ops-actions/commit/e85989ff70ebdb9109ff366ee225be704368c892))
* **azure-webapp:** add optional input `runs_on` ([#273](https://github.com/equinor/ops-actions/issues/273)) ([1d9fb31](https://github.com/equinor/ops-actions/commit/1d9fb318ddb99ff2709af9d524c0dcab3c1e941a))
* **azure-webapp:** configure app settings using offical action ([#122](https://github.com/equinor/ops-actions/issues/122)) ([bd3659e](https://github.com/equinor/ops-actions/commit/bd3659eb10cfaf0057bd78a7221b1cc65d635b0a))
* **azure-webapp:** more app settings formats ([#139](https://github.com/equinor/ops-actions/issues/139)) ([b4f0ae8](https://github.com/equinor/ops-actions/commit/b4f0ae8a76c457a70f31a0b7f2ccbae0007c8ece))
* build .NET application ([#40](https://github.com/equinor/ops-actions/issues/40)) ([a495606](https://github.com/equinor/ops-actions/commit/a49560637256780dd89d31c43b90ed0dda898896))
* build Python application ([#120](https://github.com/equinor/ops-actions/issues/120)) ([9d84888](https://github.com/equinor/ops-actions/commit/9d848887047704797e48e4e35d77b9eb5db37143))
* **build-docker-acr:** `environment` input optional ([#88](https://github.com/equinor/ops-actions/issues/88)) ([35a35af](https://github.com/equinor/ops-actions/commit/35a35af664f4b8513cd1d0d23a4ee9171c43e46f))
* **build-docker-acr:** specify tag ([#83](https://github.com/equinor/ops-actions/issues/83)) ([e6147c1](https://github.com/equinor/ops-actions/commit/e6147c12b34970f033c4728c11cb1890070bd2d0))
* **build-docker-acr:** use oidc for acr authentication ([#60](https://github.com/equinor/ops-actions/issues/60)) ([a89e4d3](https://github.com/equinor/ops-actions/commit/a89e4d37d57cb4e15b25b75b011a1cc46970949d))
* **commitlint:** lint latest commit message by default ([#350](https://github.com/equinor/ops-actions/issues/350)) ([9971f51](https://github.com/equinor/ops-actions/commit/9971f51ba23cb1b47b8da219a332a2b976c1c9f0))
* **commitlint:** set configuration ([#77](https://github.com/equinor/ops-actions/issues/77)) ([01b63fb](https://github.com/equinor/ops-actions/commit/01b63fb69affc2bc63cc7f24868804ada4b94e3c))
* **commitlint:** set custom help url ([#168](https://github.com/equinor/ops-actions/issues/168)) ([0e9ce0e](https://github.com/equinor/ops-actions/commit/0e9ce0e11bb8175eda27dc02a0f091b5ba673d23))
* create GitHub issue ([#172](https://github.com/equinor/ops-actions/issues/172)) ([29ab373](https://github.com/equinor/ops-actions/commit/29ab373c7d54418de8c0d614cf8370dcb1eb2a5c))
* deploy Azure function ([#121](https://github.com/equinor/ops-actions/issues/121)) ([3e5e30e](https://github.com/equinor/ops-actions/commit/3e5e30e037a444d6f6fcc8e51ec104a923595041))
* deploy MkDocs to GitHub Pages ([#166](https://github.com/equinor/ops-actions/issues/166)) ([8964041](https://github.com/equinor/ops-actions/commit/896404148e5adef3abaec1d5cfdc8c0c51f62c3d))
* **deploy-azure-webapp-container:** use envvars in appsettings json ([#85](https://github.com/equinor/ops-actions/issues/85)) ([2854ef7](https://github.com/equinor/ops-actions/commit/2854ef75c515926e2ed2271f0ceb78d5cb5ef034))
* **deploy-azure-webapp:** deploy package ([#90](https://github.com/equinor/ops-actions/issues/90)) ([e75a7b4](https://github.com/equinor/ops-actions/commit/e75a7b40328d4aa26e8ee887a69ca707a3be90ca))
* **deploy-azure-webapp:** don't reset appsettings by default ([#92](https://github.com/equinor/ops-actions/issues/92)) ([db89a22](https://github.com/equinor/ops-actions/commit/db89a2241bcaf4b9fb31e8350a031796c792bafb))
* **deploy:** get image from input ([#61](https://github.com/equinor/ops-actions/issues/61)) ([b517055](https://github.com/equinor/ops-actions/commit/b5170556ad085b447338991083a7343ac17d74c8))
* **docker:** build and push to Docker registry ([#203](https://github.com/equinor/ops-actions/issues/203)) ([946e5f4](https://github.com/equinor/ops-actions/commit/946e5f409a2f8bf5a638ac84d3cb9467a917d857))
* **docker:** set default repository ([#289](https://github.com/equinor/ops-actions/issues/289)) ([20f84c3](https://github.com/equinor/ops-actions/commit/20f84c3b374033043bc98f790fd372749a13db15))
* **dotnet:** add optional input `runs_on` ([#272](https://github.com/equinor/ops-actions/issues/272)) ([dd8620e](https://github.com/equinor/ops-actions/commit/dd8620e596c3de93bf599a783dd426a6f255303b))
* **dotnet:** disable CI mode ([#150](https://github.com/equinor/ops-actions/issues/150)) ([3c9a702](https://github.com/equinor/ops-actions/commit/3c9a70266ec27f747c356ca7b778c4849c24c80b))
* **dotnet:** run multiple test projects ([#147](https://github.com/equinor/ops-actions/issues/147)) ([0ac08f7](https://github.com/equinor/ops-actions/commit/0ac08f7ff78889448d7a7e89733f9a64d480a53f))
* **dotnet:** run unit tests ([#95](https://github.com/equinor/ops-actions/issues/95)) ([51a2735](https://github.com/equinor/ops-actions/commit/51a27357c9c72f78713cc7ab279b6522218a6f51))
* **dotnet:** specify project file ([#142](https://github.com/equinor/ops-actions/issues/142)) ([7be58d2](https://github.com/equinor/ops-actions/commit/7be58d23fd1cdd89a5bffa27094ab41e75e07750))
* **dotnet:** update npm ([#193](https://github.com/equinor/ops-actions/issues/193)) ([aef4fe0](https://github.com/equinor/ops-actions/commit/aef4fe0d8ac747e18c0ac8fc6956dd2a6daa1d64))
* make environment optional ([#159](https://github.com/equinor/ops-actions/issues/159)) ([a3eb971](https://github.com/equinor/ops-actions/commit/a3eb971aca64a04f3975f694932143bea02595b5))
* make terraform backend script executable ([#74](https://github.com/equinor/ops-actions/issues/74)) ([8e60829](https://github.com/equinor/ops-actions/commit/8e60829e1b8fee9c631ded16d585bde938f27f1a))
* **oidc:** add script ([#29](https://github.com/equinor/ops-actions/issues/29)) ([f5b10e0](https://github.com/equinor/ops-actions/commit/f5b10e0ecdc273ea91c6fd4cfcc3ecbe50e7148d))
* **oidc:** create multiple role assignments ([#31](https://github.com/equinor/ops-actions/issues/31)) ([2b866f0](https://github.com/equinor/ops-actions/commit/2b866f02713ed9ecc5bf3e619610a77657f6053a)), closes [#30](https://github.com/equinor/ops-actions/issues/30)
* **python:** create virtual environment ([#127](https://github.com/equinor/ops-actions/issues/127)) ([b8c90a9](https://github.com/equinor/ops-actions/commit/b8c90a9881d68cb6b7b5a93088cac780fe26aedf))
* remove Azure SQL DB restore workflow ([#349](https://github.com/equinor/ops-actions/issues/349)) ([41d734d](https://github.com/equinor/ops-actions/commit/41d734dd372904ff02a42506b7c21bcb481d828c)), closes [#339](https://github.com/equinor/ops-actions/issues/339)
* remove required permissions for oidc ([#71](https://github.com/equinor/ops-actions/issues/71)) ([dc7dd9e](https://github.com/equinor/ops-actions/commit/dc7dd9e86cc9c8e8160d7a94f8f2e1e6f1476963))
* remove SQL server secret rotation workflow ([#181](https://github.com/equinor/ops-actions/issues/181)) ([b62f9e1](https://github.com/equinor/ops-actions/commit/b62f9e1564cc64a5acabe6ac24e0a9ede0e8c5c9))
* **semantic-release:** add inputs to pin tools to a specific version ([#62](https://github.com/equinor/ops-actions/issues/62)) ([af0eed0](https://github.com/equinor/ops-actions/commit/af0eed05658d69ab707f8e1a1312d2b49d2f65c8))
* **semantic-release:** allow custom release configuration ([#35](https://github.com/equinor/ops-actions/issues/35)) ([8e296a8](https://github.com/equinor/ops-actions/commit/8e296a857a051c15b12f14835ca9ace144ed49a0))
* **semantic-release:** remove config file ([#12](https://github.com/equinor/ops-actions/issues/12)) ([2015e49](https://github.com/equinor/ops-actions/commit/2015e49ed409c3b46420e10f51a26e727369044b))
* **semantic-release:** use newline-separator for all string inputs ([#50](https://github.com/equinor/ops-actions/issues/50)) ([8337fc0](https://github.com/equinor/ops-actions/commit/8337fc09cc8aafff2c36dd3ec24cb148e0bf8b0e))
* skip configuration if no input appsettings ([#143](https://github.com/equinor/ops-actions/issues/143)) ([19eca30](https://github.com/equinor/ops-actions/commit/19eca30859f38896051f7220a82737eabad5c951))
* **super-linter:** exclude files from linting ([#299](https://github.com/equinor/ops-actions/issues/299)) ([27aaa03](https://github.com/equinor/ops-actions/commit/27aaa037e40abc6f128332aa4ae7938433d4cdf3))
* **terraform:** add azure cli login ([#36](https://github.com/equinor/ops-actions/issues/36)) ([a70693d](https://github.com/equinor/ops-actions/commit/a70693d40318780db52e003d9f84dd5ae671de81))
* **terraform:** add backend script ([#32](https://github.com/equinor/ops-actions/issues/32)) ([6df56dc](https://github.com/equinor/ops-actions/commit/6df56dc25a07b72e2479cabcb5ced853a4876a0d))
* **terraform:** add option to send runner type as parameter ([#383](https://github.com/equinor/ops-actions/issues/383)) ([3560f76](https://github.com/equinor/ops-actions/commit/3560f76979055ee86b7bf00b6f8ed25d3ab96563))
* **terraform:** configure partial backend ([#267](https://github.com/equinor/ops-actions/issues/267)) ([e4d564b](https://github.com/equinor/ops-actions/commit/e4d564bbeecdaf930fdae578dc9931bd20942427))
* **terraform:** configure to run in automation ([#110](https://github.com/equinor/ops-actions/issues/110)) ([ef4bc67](https://github.com/equinor/ops-actions/commit/ef4bc67443099ae82a77c5ee2c007c6c5e5a549e))
* **terraform:** create job summary ([#81](https://github.com/equinor/ops-actions/issues/81)) ([16ae569](https://github.com/equinor/ops-actions/commit/16ae5698b68bc5b78848e30a99bb3ff9f8b43ea6))
* **terraform:** create PR comment ([#198](https://github.com/equinor/ops-actions/issues/198)) ([9e658b1](https://github.com/equinor/ops-actions/commit/9e658b1e11a43328e129e052f4b4523c807ef5d5))
* **terraform:** delete artifact after Apply ([#224](https://github.com/equinor/ops-actions/issues/224)) ([691bfe6](https://github.com/equinor/ops-actions/commit/691bfe6889ad71a35dbb3c16aa67d2a12c068e5f))
* **terraform:** delete artifact after usage limit ([#219](https://github.com/equinor/ops-actions/issues/219)) ([84d9708](https://github.com/equinor/ops-actions/commit/84d97084f8d38fa49156f679eccb6134703b68b9))
* **terraform:** enable output colors ([#28](https://github.com/equinor/ops-actions/issues/28)) ([895c933](https://github.com/equinor/ops-actions/commit/895c933c745991adc05f3f8ac0a8fd39900f1eed))
* **terraform:** ensure use of open-source release ([#255](https://github.com/equinor/ops-actions/issues/255)) ([106cda4](https://github.com/equinor/ops-actions/commit/106cda4cbf13895affc5d65a38a1bbc085dff89b))
* **terraform:** make environment input optional ([#157](https://github.com/equinor/ops-actions/issues/157)) ([2a0b0f9](https://github.com/equinor/ops-actions/commit/2a0b0f952bc277bd8e0a84b23ad09012cab8a4ec))
* **terraform:** pass config between jobs ([#216](https://github.com/equinor/ops-actions/issues/216)) ([16c0d93](https://github.com/equinor/ops-actions/commit/16c0d93f716fda7916bb616d3c17f788ef41b38b))
* **terraform:** plan job deploys temporarily ([#250](https://github.com/equinor/ops-actions/issues/250)) ([a5c2dbf](https://github.com/equinor/ops-actions/commit/a5c2dbf3a85d173e609dd81efdc2bc2d366e42a0))
* **terraform:** queue jobs that target same config ([#57](https://github.com/equinor/ops-actions/issues/57)) ([0d7fc5e](https://github.com/equinor/ops-actions/commit/0d7fc5e55cafd4166a7537796f7be99abf833dbf))
* **terraform:** remove azure cli login ([#39](https://github.com/equinor/ops-actions/issues/39)) ([89be029](https://github.com/equinor/ops-actions/commit/89be029ec9fed9839126b67699848485d5449af8))
* **terraform:** run Apply in separate job ([#205](https://github.com/equinor/ops-actions/issues/205)) ([35e7a43](https://github.com/equinor/ops-actions/commit/35e7a43658e0e4e6b0283dceb8f197b2e52d11c9))
* **terraform:** run on latest ubuntu machine ([#16](https://github.com/equinor/ops-actions/issues/16)) ([923ba8c](https://github.com/equinor/ops-actions/commit/923ba8c24f4ac8d9eeb936be4ef3eee4b8551813))
* **terraform:** run terraform apply on schedule ([#27](https://github.com/equinor/ops-actions/issues/27)) ([e1f827e](https://github.com/equinor/ops-actions/commit/e1f827e04db432924649f87d8d06dc93589ce296))
* **terraform:** set environment-specific artifact name by default ([#389](https://github.com/equinor/ops-actions/issues/389)) ([06ce89a](https://github.com/equinor/ops-actions/commit/06ce89a91ce980bde7e20578f86df08b09300a59))
* **terraform:** skip Apply if no changes present ([#211](https://github.com/equinor/ops-actions/issues/211)) ([8f18f17](https://github.com/equinor/ops-actions/commit/8f18f177f18c1c557f4d94d8e8f8c088fa7e13f0))
* **terraform:** skip Apply if no changes present ([#310](https://github.com/equinor/ops-actions/issues/310)) ([265d3a4](https://github.com/equinor/ops-actions/commit/265d3a42cf3c3428f2e6bd59c43575b6c9e01325))
* **terraform:** speed up archiving of config ([#335](https://github.com/equinor/ops-actions/issues/335)) ([20bf45e](https://github.com/equinor/ops-actions/commit/20bf45e47c86b70e74e51c971bbe708d56cf844a))
* **terraform:** use BSL releases ([#358](https://github.com/equinor/ops-actions/issues/358)) ([ef822fd](https://github.com/equinor/ops-actions/commit/ef822fdb5bfb2dd8fc8b7124a672804700d4ddfb))
* **terraform:** use oidc for azure auth ([#21](https://github.com/equinor/ops-actions/issues/21)) ([a3e5ca5](https://github.com/equinor/ops-actions/commit/a3e5ca5cf0590948a07efa4368d9fbf01e5df1e1))
* use azuread for terraform azure backend auth ([#73](https://github.com/equinor/ops-actions/issues/73)) ([08e20d7](https://github.com/equinor/ops-actions/commit/08e20d7af5ff45b2639a0131c2d01ede32363b45))
* zip/unzip artifacts to improve upload/download performance ([#124](https://github.com/equinor/ops-actions/issues/124)) ([0cc604a](https://github.com/equinor/ops-actions/commit/0cc604aa5e581b8ba8433a63bf61dfb217b4c66c))


### Bug Fixes

* **azure-webapp:** set empty app settings by default ([#133](https://github.com/equinor/ops-actions/issues/133)) ([39d35ba](https://github.com/equinor/ops-actions/commit/39d35ba95dffbac794a5b78efcbf0f8175e90916))
* bump actions/setup-dotnet from 2 to 4 ([#375](https://github.com/equinor/ops-actions/issues/375)) ([e545362](https://github.com/equinor/ops-actions/commit/e54536215e0c5ed472119c77965a83cd1e5ae7f1))
* bump actions/setup-python from 4 to 5 ([#367](https://github.com/equinor/ops-actions/issues/367)) ([a76c0eb](https://github.com/equinor/ops-actions/commit/a76c0eb912cd5f88494ba616f091786bdefe3672))
* bump azure/webapps-deploy from 2 to 3 ([#376](https://github.com/equinor/ops-actions/issues/376)) ([ed49dc7](https://github.com/equinor/ops-actions/commit/ed49dc766764ce7441e8b000f3a7c2cbcad5fcd3))
* bump docker/build-push-action from 3 to 5 ([#374](https://github.com/equinor/ops-actions/issues/374)) ([6311824](https://github.com/equinor/ops-actions/commit/631182404f245373feae63a723ab030a6a678ebc))
* bump docker/setup-buildx-action from 2 to 3 ([#370](https://github.com/equinor/ops-actions/issues/370)) ([cfd58de](https://github.com/equinor/ops-actions/commit/cfd58de0b2009aaf2ec41e63cad713bc3881135d))
* **commitlint:** upgrade  action version ([#353](https://github.com/equinor/ops-actions/issues/353)) ([431fe13](https://github.com/equinor/ops-actions/commit/431fe135c00acf8e4523d56c74c5e229c9c059a1))
* correct concurrency group for terraform jobs ([#68](https://github.com/equinor/ops-actions/issues/68)) ([4d92bb8](https://github.com/equinor/ops-actions/commit/4d92bb892e4e09d5a9229d9c7df2e995f51a8fed))
* correct supported app settings formats ([#161](https://github.com/equinor/ops-actions/issues/161)) ([96c2520](https://github.com/equinor/ops-actions/commit/96c2520f8b6f984b6c5dd52b1b39a451787d3072))
* **deps:** bump azure/login from 1 to 2 ([#414](https://github.com/equinor/ops-actions/issues/414)) ([2a8a7d4](https://github.com/equinor/ops-actions/commit/2a8a7d4ab2a75387028ccbe58bfbada86e4a516a))
* **docker:** bump docker/login-action from 2 to 3 ([#377](https://github.com/equinor/ops-actions/issues/377)) ([998c428](https://github.com/equinor/ops-actions/commit/998c428fae7ed20cc5b22b76244cafc55d874204))
* **docker:** correct secret reference ([#24](https://github.com/equinor/ops-actions/issues/24)) ([8737419](https://github.com/equinor/ops-actions/commit/8737419223d90015e1451a2e07934e9b6b2e15bf))
* don't mask app settings ([#163](https://github.com/equinor/ops-actions/issues/163)) ([7098187](https://github.com/equinor/ops-actions/commit/7098187d6ea28bc117e3389535c080fa04d66ca1))
* **dotnet:** build artifact contains entire temp directory ([#148](https://github.com/equinor/ops-actions/issues/148)) ([f34971f](https://github.com/equinor/ops-actions/commit/f34971f9c415bd91fabe52847092815514465c0a))
* **dotnet:** don't specify runtime for test and publish ([#276](https://github.com/equinor/ops-actions/issues/276)) ([1ad1560](https://github.com/equinor/ops-actions/commit/1ad15608f2604f8097b4c1a55893f060eb0cf5ea))
* **dotnet:** skip NPM update step if not required ([#275](https://github.com/equinor/ops-actions/issues/275)) ([f181815](https://github.com/equinor/ops-actions/commit/f181815ad26e35bad0551c042d86cf06cc42bac9))
* **dotnet:** skip NPM update step if not required ([#280](https://github.com/equinor/ops-actions/issues/280)) ([0931dfe](https://github.com/equinor/ops-actions/commit/0931dfee6e423e0961ee382d9aa4ee121595f000))
* **dotnet:** support self-contained publish ([#323](https://github.com/equinor/ops-actions/issues/323)) ([36d1bee](https://github.com/equinor/ops-actions/commit/36d1beea687faa5fa7a913d7740ccf2c907c8e0d))
* **dotnet:** trim trailing newlines for test projects ([#155](https://github.com/equinor/ops-actions/issues/155)) ([1a72941](https://github.com/equinor/ops-actions/commit/1a729419eaf540a405f28617666897152acb7797))
* prevent use of deprecated node versions ([#56](https://github.com/equinor/ops-actions/issues/56)) ([8986d0e](https://github.com/equinor/ops-actions/commit/8986d0e423487af0425f431b749e04ee3f5f3959)), closes [#55](https://github.com/equinor/ops-actions/issues/55)
* remove calls to outdated action ([#283](https://github.com/equinor/ops-actions/issues/283)) ([1c29fc1](https://github.com/equinor/ops-actions/commit/1c29fc16aa3d0498901e47427580440da13e2f79))
* remove trailing forward slash ([#33](https://github.com/equinor/ops-actions/issues/33)) ([59cc931](https://github.com/equinor/ops-actions/commit/59cc931700744fbc97b83b87b8d9695f85b8589a))
* **semantic-release:** bash fails when converting string to array ([06d910f](https://github.com/equinor/ops-actions/commit/06d910fa3d1bd9e4595f308f654273ff96a43834))
* **semantic-release:** bump actions/setup-node from 3 to 4 ([#368](https://github.com/equinor/ops-actions/issues/368)) ([12fa565](https://github.com/equinor/ops-actions/commit/12fa5653e7bcdf7fe51463ca10b97e9af18b8756))
* **semantic-release:** convert newline-separated plugins into array ([#49](https://github.com/equinor/ops-actions/issues/49)) ([1576ed1](https://github.com/equinor/ops-actions/commit/1576ed114825cd9179b2019d834507d66d76c6ed))
* **semantic-release:** correct argument types ([#48](https://github.com/equinor/ops-actions/issues/48)) ([412c8d0](https://github.com/equinor/ops-actions/commit/412c8d0658f5ea7cbf50e608874aa10c31892a66))
* **semantic-release:** correct cli args ([#14](https://github.com/equinor/ops-actions/issues/14)) ([8339314](https://github.com/equinor/ops-actions/commit/83393145828e97b09fbfb4bc64391d58878283d1))
* **semantic-release:** correct plugins input ([#15](https://github.com/equinor/ops-actions/issues/15)) ([8661ca4](https://github.com/equinor/ops-actions/commit/8661ca4a9c13110dcaa1bd90b9450025026b36fd))
* **semantic-release:** install multiple additional plugins ([5c9e8e6](https://github.com/equinor/ops-actions/commit/5c9e8e6d4766b87fb351e5dd82e041a7cd961532))
* **semantic-release:** remove plugins ([#13](https://github.com/equinor/ops-actions/issues/13)) ([49a5d33](https://github.com/equinor/ops-actions/commit/49a5d3366e6857e9e247a0540a498cea1ca7a926))
* **super-linter:** upgrade  action version ([#352](https://github.com/equinor/ops-actions/issues/352)) ([31b007f](https://github.com/equinor/ops-actions/commit/31b007f610475d4b047ceaa0d42736c0d79b0eb0))
* **terraform:** artifact already exists ([#392](https://github.com/equinor/ops-actions/issues/392)) ([315ba0f](https://github.com/equinor/ops-actions/commit/315ba0f95f218c7a6845a61e08e83337e48e4849))
* **terraform:** Bash throws error if plan too long ([#259](https://github.com/equinor/ops-actions/issues/259)) ([0cf9966](https://github.com/equinor/ops-actions/commit/0cf9966638f7062c9de7584d560371f1dd787b9d))
* **terraform:** bump GeekyEggo/delete-artifact from 2.0.0 to 4.1.0 ([#369](https://github.com/equinor/ops-actions/issues/369)) ([a023f14](https://github.com/equinor/ops-actions/commit/a023f14b3bc7db9958b0bc67902167fd612225c1))
* **terraform:** disable output colors ([#22](https://github.com/equinor/ops-actions/issues/22)) ([bf10131](https://github.com/equinor/ops-actions/commit/bf101319233f76a3134b024bd77ed665957ad5ff))
* **terraform:** don't run Apply without approval ([#208](https://github.com/equinor/ops-actions/issues/208)) ([2ad4ed6](https://github.com/equinor/ops-actions/commit/2ad4ed62056243bbde055d39f060007cf6302047))
* **terraform:** downgrade GeekyEggo/delete-artifact from 4.1.0 to 2.0.0 ([#387](https://github.com/equinor/ops-actions/issues/387)) ([ad0fab3](https://github.com/equinor/ops-actions/commit/ad0fab33d1445f233441b7e42a83b89c5cdd3cbd))
* **terraform:** empty backend config throws error ([#286](https://github.com/equinor/ops-actions/issues/286)) ([e75cbea](https://github.com/equinor/ops-actions/commit/e75cbea2473ac411fbe090717caf8beed9989b24))
* **terraform:** error on plan with special chars ([#307](https://github.com/equinor/ops-actions/issues/307)) ([56243fd](https://github.com/equinor/ops-actions/commit/56243fd12551aab0ced8f17f03f6d6f1928a3c16))
* **terraform:** make backend script executable ([938f8eb](https://github.com/equinor/ops-actions/commit/938f8eb0f34003292d7444fe6c286f4cefbdbaa5))
* **terraform:** no job summary on error ([#315](https://github.com/equinor/ops-actions/issues/315)) ([58b5f09](https://github.com/equinor/ops-actions/commit/58b5f0963150d12877a22bc21067ddb62c61ad91))
* **terraform:** pass pass through envvar before comment ([#201](https://github.com/equinor/ops-actions/issues/201)) ([875f363](https://github.com/equinor/ops-actions/commit/875f363c5cf5c364ef09810f0fcaf940c96878ce))
* **terraform:** prevent duplicate plans on merge ([#42](https://github.com/equinor/ops-actions/issues/42)) ([717f64d](https://github.com/equinor/ops-actions/commit/717f64dce073dcb788b649aef0f299f8e6613a0d)), closes [#45](https://github.com/equinor/ops-actions/issues/45)
* **terraform:** run Apply job on same runner as Plan job ([716baf5](https://github.com/equinor/ops-actions/commit/716baf59bcb6045b5523804deeeb3338d16dd249))
* **terraform:** unable to delete artifact ([#227](https://github.com/equinor/ops-actions/issues/227)) ([c41a4e9](https://github.com/equinor/ops-actions/commit/c41a4e9f6da227950a6f6c7158965567d4f0ef89))
* **terraform:** unable to delete artifact ([#391](https://github.com/equinor/ops-actions/issues/391)) ([9848dc4](https://github.com/equinor/ops-actions/commit/9848dc4522b0171cb9338b260e84d4d491258885))
* **terraform:** upgrade action versions ([#356](https://github.com/equinor/ops-actions/issues/356)) ([b7f0f24](https://github.com/equinor/ops-actions/commit/b7f0f24e0216d57630141d7da2952cf7a592ea5a))
* **terraform:** use latest 1.5 patch version ([#257](https://github.com/equinor/ops-actions/issues/257)) ([00f63a8](https://github.com/equinor/ops-actions/commit/00f63a8299ebf070c695b2d7f544ff457ccfa8e8))
* upgrade action versions ([#359](https://github.com/equinor/ops-actions/issues/359)) ([43e2559](https://github.com/equinor/ops-actions/commit/43e2559744413ea6130ff29b1d6349bda2c12201))
* upgrade action versions ([#362](https://github.com/equinor/ops-actions/issues/362)) ([ad05797](https://github.com/equinor/ops-actions/commit/ad05797edb3adade15b5e4df29daabfa06deb193))


### Reverts

* **azure-webapp:** add optional input `runs_on` ([#278](https://github.com/equinor/ops-actions/issues/278)) ([7d22977](https://github.com/equinor/ops-actions/commit/7d22977f4724187e9c451c19865773dfd0788394))
* create GitHub issue ([#180](https://github.com/equinor/ops-actions/issues/180)) ([dfb2eec](https://github.com/equinor/ops-actions/commit/dfb2eecd033d104679d0838aaacea86195dea503))
* **dotnet:** add optional input `runs_on` ([#279](https://github.com/equinor/ops-actions/issues/279)) ([10576cc](https://github.com/equinor/ops-actions/commit/10576cc086fbe240e51de1ffb535b49e300a9250))
* **dotnet:** disable CI mode ([#439](https://github.com/equinor/ops-actions/issues/439)) ([98d539e](https://github.com/equinor/ops-actions/commit/98d539ee5ac29dcdbbf004c034bf763bc8dfab7d))
* **dotnet:** disable CI mode ([#439](https://github.com/equinor/ops-actions/issues/439)) ([4904824](https://github.com/equinor/ops-actions/commit/49048242acc3d13156512f9f1c0d179f7cb414c6))
* **dotnet:** trim trailing newlines for test projects ([#169](https://github.com/equinor/ops-actions/issues/169)) ([2f1683c](https://github.com/equinor/ops-actions/commit/2f1683ca00bb22bfafab5d797b42f1907f5f5474))
* use azuread for terraform azure backend auth ([#112](https://github.com/equinor/ops-actions/issues/112)) ([8cb9592](https://github.com/equinor/ops-actions/commit/8cb959224e99b722e703faee1d9cd44ce6b09e5d))


### Miscellaneous Chores

* **main:** release 10.0.3 ([#435](https://github.com/equinor/ops-actions/issues/435)) ([34d3997](https://github.com/equinor/ops-actions/commit/34d39974b94e61d3ad193ef5a4d5de0e3e6b6739))


### Code Refactoring

* **azure-function:** get Azure credentials from inputs ([#408](https://github.com/equinor/ops-actions/issues/408)) ([12914b1](https://github.com/equinor/ops-actions/commit/12914b16b521ad80440467a5fa282848f7565ccd))
* **azure-webapp:** get Azure credentials from inputs ([#410](https://github.com/equinor/ops-actions/issues/410)) ([8604b1a](https://github.com/equinor/ops-actions/commit/8604b1ae4402f496e39a873f3b41277adf184da7))
* **docker-acr:** get Azure credentials from inputs ([#406](https://github.com/equinor/ops-actions/issues/406)) ([2cd15a9](https://github.com/equinor/ops-actions/commit/2cd15a9abfb7d6bbdf7663ebee9fb7e0bebcbd9b))
* **terraform:** get Azure credentials from inputs ([#405](https://github.com/equinor/ops-actions/issues/405)) ([6b8647a](https://github.com/equinor/ops-actions/commit/6b8647aabd104272ccc1ecd71202cd2a0f4d4084))
* **terraform:** remove dependency on third-party action ([#432](https://github.com/equinor/ops-actions/issues/432)) ([4d1600d](https://github.com/equinor/ops-actions/commit/4d1600de060929f2bde0b0eb960b589b7c6b4cb4))
* use common convention for workflow filenames ([#176](https://github.com/equinor/ops-actions/issues/176)) ([97f0cd8](https://github.com/equinor/ops-actions/commit/97f0cd84da43527c88be64447330e82beb6052da))

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
