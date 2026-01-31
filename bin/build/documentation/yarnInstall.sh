#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--version versionCode - String. Optional. Install this version of yarn."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="yarn.sh"
description="Install yarn in the build environment"$'\n'"If this fails it will output the installation log."$'\n'"When this tool succeeds the \`yarn\` binary is available in the local operating system."$'\n'""
environment="- \`BUILD_YARN_VERSION"$'\n'""
file="bin/build/tools/yarn.sh"
foundNames=([0]="notes" [1]="environment" [2]="return_code" [3]="test" [4]="argument")
notes="\`yarn\` is part of node, I think, so no clean uninstall."$'\n'""
rawComment="Install yarn in the build environment"$'\n'"If this fails it will output the installation log."$'\n'"Notes: \`yarn\` is part of node, I think, so no clean uninstall."$'\n'"When this tool succeeds the \`yarn\` binary is available in the local operating system."$'\n'"Environment: - \`BUILD_YARN_VERSION"$'\n'"Return Code: 1 - If installation of yarn fails"$'\n'"Return Code: 0 - If yarn is already installed or installed without error"$'\n'"Test: testYarnInstallation"$'\n'"Argument: --version versionCode - String. Optional. Install this version of yarn."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="1 - If installation of yarn fails"$'\n'"0 - If yarn is already installed or installed without error"$'\n'""
sourceFile="bin/build/tools/yarn.sh"
sourceHash="c3fe8a7cd1db04e27d7675c8a02257a2c45bd801"
summary="Install yarn in the build environment"
summaryComputed="true"
test="testYarnInstallation"$'\n'""
usage="yarnInstall [ --version versionCode ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]myarnInstall'$'\e''[0m '$'\e''[[(blue)]m[ --version versionCode ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--version versionCode  '$'\e''[[(value)]mString. Optional. Install this version of yarn.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help                 '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Install yarn in the build environment'$'\n''If this fails it will output the installation log.'$'\n''When this tool succeeds the '$'\e''[[(code)]myarn'$'\e''[[(reset)]m binary is available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If installation of yarn fails'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If yarn is already installed or installed without error'$'\n'''$'\n''Environment variables:'$'\n''- '$'\e''[[(code)]mBUILD_YARN_VERSION'$'\e''[[(reset)]m'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: yarnInstall [ --version versionCode ] [ --help ]'$'\n'''$'\n''    --version versionCode  String. Optional. Install this version of yarn.'$'\n''    --help                 Flag. Optional. Display this help.'$'\n'''$'\n''Install yarn in the build environment'$'\n''If this fails it will output the installation log.'$'\n''When this tool succeeds the yarn binary is available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- 1 - If installation of yarn fails'$'\n''- 0 - If yarn is already installed or installed without error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_YARN_VERSION'$'\n'''
# elapsed 3.245
