#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/yarn.sh"
argument="--version versionCode - String. Optional. Install this version of yarn."$'\n'"--help - Flag. Optional.Display this help."$'\n'""
base="yarn.sh"
description="Install yarn in the build environment"$'\n'"If this fails it will output the installation log."$'\n'"When this tool succeeds the \`yarn\` binary is available in the local operating system."$'\n'"Return Code: 1 - If installation of yarn fails"$'\n'"Return Code: 0 - If yarn is already installed or installed without error"$'\n'""
environment="- \`BUILD_YARN_VERSION"$'\n'""
file="bin/build/tools/yarn.sh"
fn="yarnInstall"
foundNames=([0]="notes" [1]="environment" [2]="test" [3]="argument")
notes="\`yarn\` is part of node, I think, so no clean uninstall."$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/yarn.sh"
sourceModified="1768695708"
summary="Install yarn in the build environment"
test="testYarnInstallation"$'\n'""
usage="yarnInstall [ --version versionCode ] [ --help ]"
