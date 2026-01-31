#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="npm.sh"
description="Environment: BUILD_NPM_VERSION - Read-only. Default version. If not specified, uses \`latest\`."$'\n'"Install NPM in the build environment"$'\n'"If this fails it will output the installation log."$'\n'"When this tool succeeds the \`npm\` binary is available in the local operating system."$'\n'"Environment: - \`BUILD_NPM_VERSION\` - String. Default to \`latest\`. Used to install \`npm -i npm@\$BUILD_NPM_VERSION\` on install."$'\n'"Return Code: 1 - If installation of npm fails"$'\n'"Return Code: 0 - If npm is already installed or installed without error"$'\n'"Argument: --version versionCode - String. Optional. Install this version of python."$'\n'""
file="bin/build/tools/npm.sh"
foundNames=()
rawComment="Environment: BUILD_NPM_VERSION - Read-only. Default version. If not specified, uses \`latest\`."$'\n'"Install NPM in the build environment"$'\n'"If this fails it will output the installation log."$'\n'"When this tool succeeds the \`npm\` binary is available in the local operating system."$'\n'"Environment: - \`BUILD_NPM_VERSION\` - String. Default to \`latest\`. Used to install \`npm -i npm@\$BUILD_NPM_VERSION\` on install."$'\n'"Return Code: 1 - If installation of npm fails"$'\n'"Return Code: 0 - If npm is already installed or installed without error"$'\n'"Argument: --version versionCode - String. Optional. Install this version of python."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/npm.sh"
sourceHash="29f61b341a047701101736e29216f201d60a76d6"
summary="Environment: BUILD_NPM_VERSION - Read-only. Default version. If not specified, uses"
usage="npmInstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mnpmInstall'$'\e''[0m'$'\n'''$'\n''Environment: BUILD_NPM_VERSION - Read-only. Default version. If not specified, uses '$'\e''[[(code)]mlatest'$'\e''[[(reset)]m.'$'\n''Install NPM in the build environment'$'\n''If this fails it will output the installation log.'$'\n''When this tool succeeds the '$'\e''[[(code)]mnpm'$'\e''[[(reset)]m binary is available in the local operating system.'$'\n''Environment: - '$'\e''[[(code)]mBUILD_NPM_VERSION'$'\e''[[(reset)]m - String. Default to '$'\e''[[(code)]mlatest'$'\e''[[(reset)]m. Used to install '$'\e''[[(code)]mnpm -i npm@$BUILD_NPM_VERSION'$'\e''[[(reset)]m on install.'$'\n''Return Code: 1 - If installation of npm fails'$'\n''Return Code: 0 - If npm is already installed or installed without error'$'\n''Argument: --version versionCode - String. Optional. Install this version of python.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: npmInstall'$'\n'''$'\n''Environment: BUILD_NPM_VERSION - Read-only. Default version. If not specified, uses latest.'$'\n''Install NPM in the build environment'$'\n''If this fails it will output the installation log.'$'\n''When this tool succeeds the npm binary is available in the local operating system.'$'\n''Environment: - BUILD_NPM_VERSION - String. Default to latest. Used to install npm -i npm@$BUILD_NPM_VERSION on install.'$'\n''Return Code: 1 - If installation of npm fails'$'\n''Return Code: 0 - If npm is already installed or installed without error'$'\n''Argument: --version versionCode - String. Optional. Install this version of python.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.472
