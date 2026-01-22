#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/npm.sh"
argument="--version versionCode - String. Optional. Install this version of python."$'\n'""
base="npm.sh"
description="Install NPM in the build environment"$'\n'"If this fails it will output the installation log."$'\n'"When this tool succeeds the \`npm\` binary is available in the local operating system."$'\n'"Return Code: 1 - If installation of npm fails"$'\n'"Return Code: 0 - If npm is already installed or installed without error"$'\n'""
environment="BUILD_NPM_VERSION - Read-only. Default version. If not specified, uses \`latest\`."$'\n'"- \`BUILD_NPM_VERSION\` - String. Default to \`latest\`. Used to install \`npm -i npm@\$BUILD_NPM_VERSION\` on install."$'\n'""
file="bin/build/tools/npm.sh"
fn="npmInstall"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/npm.sh"
sourceModified="1768513812"
summary="Install NPM in the build environment"
usage="npmInstall [ --version versionCode ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mnpmInstall[0m [94m[ --version versionCode ][0m

    [94m--version versionCode  [1;97mString. Optional. Install this version of python.[0m

Install NPM in the build environment
If this fails it will output the installation log.
When this tool succeeds the [38;2;0;255;0;48;2;0;0;0mnpm[0m binary is available in the local operating system.
Return Code: 1 - If installation of npm fails
Return Code: 0 - If npm is already installed or installed without error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_NPM_VERSION - Read-only. Default version. If not specified, uses [38;2;0;255;0;48;2;0;0;0mlatest[0m.
- - [38;2;0;255;0;48;2;0;0;0mBUILD_NPM_VERSION[0m - String. Default to [38;2;0;255;0;48;2;0;0;0mlatest[0m. Used to install [38;2;0;255;0;48;2;0;0;0mnpm -i npm@$BUILD_NPM_VERSION[0m on install.
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: npmInstall [ --version versionCode ]

    --version versionCode  String. Optional. Install this version of python.

Install NPM in the build environment
If this fails it will output the installation log.
When this tool succeeds the npm binary is available in the local operating system.
Return Code: 1 - If installation of npm fails
Return Code: 0 - If npm is already installed or installed without error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_NPM_VERSION - Read-only. Default version. If not specified, uses latest.
- - BUILD_NPM_VERSION - String. Default to latest. Used to install npm -i npm@$BUILD_NPM_VERSION on install.
- 
'
