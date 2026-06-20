#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--version versionCode - String. Optional. Install this version of yarn. Defaults to `stable` if `BUILD_YARN_VERSION` is blank or unset.\n--help - Flag. Optional. Display this help.\n'
base="yarn.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Install yarn in the build environment.\n\nWhen this tool succeeds the `yarn` binary is available in the local operating system.\n\n'
descriptionLineCount="4"
environment=$'- BUILD_YARN_VERSION\n'
file="bin/build/tools/yarn.sh"
fn="yarnInstall"
fnMarker="yarninstall"
foundNames=([0]="summary" [1]="notes" [2]="environment" [3]="return_code" [4]="test" [5]="argument")
line="24"
notes=$'`yarn` is part of node, I think, so no clean uninstall.\n'
original="yarnInstall"
rawComment=$'Summary: Install yarn\nInstall yarn in the build environment.\nNotes: `yarn` is part of node, I think, so no clean uninstall.\nWhen this tool succeeds the `yarn` binary is available in the local operating system.\nEnvironment: - BUILD_YARN_VERSION\nReturn Code: 1 - If installation of yarn fails\nReturn Code: 0 - If yarn is already installed or installed without error\nTest: testYarnInstallation\nArgument: --version versionCode - String. Optional. Install this version of yarn. Defaults to `stable` if `BUILD_YARN_VERSION` is blank or unset.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'1 - If installation of yarn fails\n0 - If yarn is already installed or installed without error\n'
sourceFile="bin/build/tools/yarn.sh"
sourceHash="b946508061ba2d8949a03696311f38ff13a2d1b8"
sourceLine="24"
summary="Install yarn"
summaryComputed=""
test=$'testYarnInstallation\n'
usage="yarnInstall [ --version versionCode ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]myarnInstall'$'\e''[0m '$'\e''[[(blue)]m[ --version versionCode ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--version versionCode  '$'\e''[[(value)]mString. Optional. Install this version of yarn. Defaults to '$'\e''[[(code)]mstable'$'\e''[[(reset)]m if '$'\e''[[(code)]mBUILD_YARN_VERSION'$'\e''[[(reset)]m is blank or unset.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help                 '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Install yarn in the build environment.'$'\n'''$'\n''When this tool succeeds the '$'\e''[[(code)]myarn'$'\e''[[(reset)]m binary is available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If installation of yarn fails'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If yarn is already installed or installed without error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_YARN_VERSION'
# shellcheck disable=SC2016
helpPlain='Usage: yarnInstall [ --version versionCode ] [ --help ]'$'\n'''$'\n''    --version versionCode  String. Optional. Install this version of yarn. Defaults to stable if BUILD_YARN_VERSION is blank or unset.'$'\n''    --help                 Flag. Optional. Display this help.'$'\n'''$'\n''Install yarn in the build environment.'$'\n'''$'\n''When this tool succeeds the yarn binary is available in the local operating system.'$'\n'''$'\n''Return codes:'$'\n''- 1 - If installation of yarn fails'$'\n''- 0 - If yarn is already installed or installed without error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_YARN_VERSION'
documentationPath="documentation/source/tools/node.md"
