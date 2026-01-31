#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--version versionCode - String. Optional. Install this version of python."$'\n'""
base="npm.sh"
description="Install NPM in the build environment"$'\n'"If this fails it will output the installation log."$'\n'"When this tool succeeds the \`npm\` binary is available in the local operating system."$'\n'""
environment="BUILD_NPM_VERSION - Read-only. Default version. If not specified, uses \`latest\`."$'\n'"- \`BUILD_NPM_VERSION\` - String. Default to \`latest\`. Used to install \`npm -i npm@\$BUILD_NPM_VERSION\` on install."$'\n'""
file="bin/build/tools/npm.sh"
foundNames=([0]="environment" [1]="return_code" [2]="argument")
rawComment="Environment: BUILD_NPM_VERSION - Read-only. Default version. If not specified, uses \`latest\`."$'\n'"Install NPM in the build environment"$'\n'"If this fails it will output the installation log."$'\n'"When this tool succeeds the \`npm\` binary is available in the local operating system."$'\n'"Environment: - \`BUILD_NPM_VERSION\` - String. Default to \`latest\`. Used to install \`npm -i npm@\$BUILD_NPM_VERSION\` on install."$'\n'"Return Code: 1 - If installation of npm fails"$'\n'"Return Code: 0 - If npm is already installed or installed without error"$'\n'"Argument: --version versionCode - String. Optional. Install this version of python."$'\n'""$'\n'""
return_code="1 - If installation of npm fails"$'\n'"0 - If npm is already installed or installed without error"$'\n'""
sourceFile="bin/build/tools/npm.sh"
sourceHash="29f61b341a047701101736e29216f201d60a76d6"
summary="Install NPM in the build environment"
summaryComputed="true"
usage="npmInstall [ --version versionCode ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mnpmInstall'$'\e''[0m '$'\e''[[(blue)]m[ --version versionCode ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--version versionCode  '$'\e''[[(value)]mString. Optional. Install this version of python.'$'\e''[[(reset)]m'$'\n'''$'\n''Install NPM in the build environment'$'\n''If this fails it will output the installation log.'$'\n''When this tool succeeds the '$'\e''[[(code)]mnpm'$'\e''[[(reset)]m binary is available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If installation of npm fails'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If npm is already installed or installed without error'$'\n'''$'\n''Environment variables:'$'\n''- '$'\e''[[(code)]mBUILD_NPM_VERSION'$'\e''[[(reset)]m - Read-only. Default version. If not specified, uses '$'\e''[[(code)]mlatest'$'\e''[[(reset)]m.'$'\n''- '$'\e''[[(code)]mBUILD_NPM_VERSION'$'\e''[[(reset)]m - String. Default to '$'\e''[[(code)]mlatest'$'\e''[[(reset)]m. Used to install '$'\e''[[(code)]mnpm -i npm@$BUILD_NPM_VERSION'$'\e''[[(reset)]m on install.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: [[(info)]mnpmInstall [ --version versionCode ]'$'\n'''$'\n''    --version versionCode  String. Optional. Install this version of python.'$'\n'''$'\n''Install NPM in the build environment'$'\n''If this fails it will output the installation log.'$'\n''When this tool succeeds the npm binary is available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- 1 - If installation of npm fails'$'\n''- 0 - If npm is already installed or installed without error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_NPM_VERSION - Read-only. Default version. If not specified, uses latest.'$'\n''- BUILD_NPM_VERSION - String. Default to latest. Used to install npm -i npm@$BUILD_NPM_VERSION on install.'$'\n'''
