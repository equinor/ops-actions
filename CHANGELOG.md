# Changelog

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
