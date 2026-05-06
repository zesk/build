#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--version versionCode - String. Optional. Install this version of yarn. Defaults to \`stable\` if \`BUILD_YARN_VERSION\` is blank or unset."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="yarn.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Install yarn in the build environment"$'\n'"If this fails it will output the installation log."$'\n'"When this tool succeeds the \`yarn\` binary is available in the local operating system."$'\n'""$'\n'""
descriptionLineCount="4"
environment="- BUILD_YARN_VERSION"$'\n'""
file="bin/build/tools/yarn.sh"
fn="yarnInstall"
fnMarker="yarninstall"
foundNames=([0]="notes" [1]="environment" [2]="return_code" [3]="test" [4]="argument")
line="21"
notes="\`yarn\` is part of node, I think, so no clean uninstall."$'\n'""
rawComment="Install yarn in the build environment"$'\n'"If this fails it will output the installation log."$'\n'"Notes: \`yarn\` is part of node, I think, so no clean uninstall."$'\n'"When this tool succeeds the \`yarn\` binary is available in the local operating system."$'\n'"Environment: - BUILD_YARN_VERSION"$'\n'"Return Code: 1 - If installation of yarn fails"$'\n'"Return Code: 0 - If yarn is already installed or installed without error"$'\n'"Test: testYarnInstallation"$'\n'"Argument: --version versionCode - String. Optional. Install this version of yarn. Defaults to \`stable\` if \`BUILD_YARN_VERSION\` is blank or unset."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="1 - If installation of yarn fails"$'\n'"0 - If yarn is already installed or installed without error"$'\n'""
sourceFile="bin/build/tools/yarn.sh"
sourceHash="70b614f76fb49050d162a0f0de956ae4f5b23713"
sourceLine="21"
summary="Install yarn in the build environment"
summaryComputed="true"
test="testYarnInstallation"$'\n'""
usage="yarnInstall [ --version versionCode ] [ --help ]"
