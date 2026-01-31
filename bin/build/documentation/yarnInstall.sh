#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="yarn.sh"
description="Install yarn in the build environment"$'\n'"If this fails it will output the installation log."$'\n'"Notes: \`yarn\` is part of node, I think, so no clean uninstall."$'\n'"When this tool succeeds the \`yarn\` binary is available in the local operating system."$'\n'"Environment: - \`BUILD_YARN_VERSION"$'\n'"Return Code: 1 - If installation of yarn fails"$'\n'"Return Code: 0 - If yarn is already installed or installed without error"$'\n'"Test: testYarnInstallation"$'\n'"Argument: --version versionCode - String. Optional. Install this version of yarn."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""
file="bin/build/tools/yarn.sh"
foundNames=()
rawComment="Install yarn in the build environment"$'\n'"If this fails it will output the installation log."$'\n'"Notes: \`yarn\` is part of node, I think, so no clean uninstall."$'\n'"When this tool succeeds the \`yarn\` binary is available in the local operating system."$'\n'"Environment: - \`BUILD_YARN_VERSION"$'\n'"Return Code: 1 - If installation of yarn fails"$'\n'"Return Code: 0 - If yarn is already installed or installed without error"$'\n'"Test: testYarnInstallation"$'\n'"Argument: --version versionCode - String. Optional. Install this version of yarn."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/yarn.sh"
sourceHash="c3fe8a7cd1db04e27d7675c8a02257a2c45bd801"
summary="Install yarn in the build environment"
usage="yarnInstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]myarnInstall'$'\e''[0m'$'\n'''$'\n''Install yarn in the build environment'$'\n''If this fails it will output the installation log.'$'\n''Notes: '$'\e''[[(code)]myarn'$'\e''[[(reset)]m is part of node, I think, so no clean uninstall.'$'\n''When this tool succeeds the '$'\e''[[(code)]myarn'$'\e''[[(reset)]m binary is available in the local operating system.'$'\n''Environment: - '$'\e''[[(code)]mBUILD_YARN_VERSION'$'\e''[[(reset)]m'$'\n''Return Code: 1 - If installation of yarn fails'$'\n''Return Code: 0 - If yarn is already installed or installed without error'$'\n''Test: testYarnInstallation'$'\n''Argument: --version versionCode - String. Optional. Install this version of yarn.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: yarnInstall'$'\n'''$'\n''Install yarn in the build environment'$'\n''If this fails it will output the installation log.'$'\n''Notes: yarn is part of node, I think, so no clean uninstall.'$'\n''When this tool succeeds the yarn binary is available in the local operating system.'$'\n''Environment: - BUILD_YARN_VERSION'$'\n''Return Code: 1 - If installation of yarn fails'$'\n''Return Code: 0 - If yarn is already installed or installed without error'$'\n''Test: testYarnInstallation'$'\n''Argument: --version versionCode - String. Optional. Install this version of yarn.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.49
