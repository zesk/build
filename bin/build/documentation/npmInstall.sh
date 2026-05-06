#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--version versionCode - String. Optional. Install this version of python."$'\n'""
base="npm.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Install NPM in the build environment"$'\n'"If this fails it will output the installation log."$'\n'"When this tool succeeds the \`npm\` binary is available in the local operating system."$'\n'""$'\n'""
descriptionLineCount="4"
environment="BUILD_NPM_VERSION - Read-only. Default version. If not specified, uses \`latest\`."$'\n'"- \`BUILD_NPM_VERSION\` - String. Default to \`latest\`. Used to install \`npm -i npm@\$BUILD_NPM_VERSION\` on install."$'\n'""
file="bin/build/tools/npm.sh"
fn="npmInstall"
fnMarker="npminstall"
foundNames=([0]="environment" [1]="return_code" [2]="argument")
line="19"
rawComment="Environment: BUILD_NPM_VERSION - Read-only. Default version. If not specified, uses \`latest\`."$'\n'"Install NPM in the build environment"$'\n'"If this fails it will output the installation log."$'\n'"When this tool succeeds the \`npm\` binary is available in the local operating system."$'\n'"Environment: - \`BUILD_NPM_VERSION\` - String. Default to \`latest\`. Used to install \`npm -i npm@\$BUILD_NPM_VERSION\` on install."$'\n'"Return Code: 1 - If installation of npm fails"$'\n'"Return Code: 0 - If npm is already installed or installed without error"$'\n'"Argument: --version versionCode - String. Optional. Install this version of python."$'\n'""$'\n'""
return_code="1 - If installation of npm fails"$'\n'"0 - If npm is already installed or installed without error"$'\n'""
sourceFile="bin/build/tools/npm.sh"
sourceHash="50aaed0f2c7f0562ea7c814ae07bd5366f18fb9e"
sourceLine="19"
summary="Install NPM in the build environment"
summaryComputed="true"
usage="npmInstall [ --version versionCode ]"
