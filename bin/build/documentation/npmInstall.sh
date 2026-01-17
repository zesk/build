#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/npm.sh"
argument="--version versionCode - String. Optional. Install this version of python."$'\n'""
base="npm.sh"
description="Install NPM in the build environment"$'\n'"If this fails it will output the installation log."$'\n'"When this tool succeeds the \`npm\` binary is available in the local operating system."$'\n'"Return Code: 1 - If installation of npm fails"$'\n'"Return Code: 0 - If npm is already installed or installed without error"$'\n'""
environment="BUILD_NPM_VERSION - Read-only. Default version. If not specified, uses \`latest\`."$'\n'"- \`BUILD_NPM_VERSION\` - String. Default to \`latest\`. Used to install \`npm -i npm@\$BUILD_NPM_VERSION\` on install."$'\n'""
file="bin/build/tools/npm.sh"
fn="npmInstall"
foundNames=([0]="environment" [1]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""$'\n'""$'\n'""
source="bin/build/tools/npm.sh"
sourceModified="1768513812"
summary="Install NPM in the build environment"
usage="npmInstall [ --version versionCode ]"
