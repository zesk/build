#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/yarn.sh"
argument="--version versionCode - String. Optional. Install this version of yarn."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="yarn.sh"
description="Install yarn in the build environment"$'\n'"If this fails it will output the installation log."$'\n'"When this tool succeeds the \`yarn\` binary is available in the local operating system."$'\n'"Return Code: 1 - If installation of yarn fails"$'\n'"Return Code: 0 - If yarn is already installed or installed without error"$'\n'""
environment="- \`BUILD_YARN_VERSION"$'\n'""
file="bin/build/tools/yarn.sh"
fn="yarnInstall"
foundNames=""
notes="\`yarn\` is part of node, I think, so no clean uninstall."$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/yarn.sh"
sourceModified="1769063211"
summary="Install yarn in the build environment"
test="testYarnInstallation"$'\n'""
usage="yarnInstall [ --version versionCode ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255myarnInstall[0m [94m[ --version versionCode ][0m [94m[ --help ][0m

    [94m--version versionCode  [1;97mString. Optional. Install this version of yarn.[0m
    [94m--help                 [1;97mFlag. Optional. Display this help.[0m

Install yarn in the build environment
If this fails it will output the installation log.
When this tool succeeds the [38;2;0;255;0;48;2;0;0;0myarn[0m binary is available in the local operating system.
Return Code: 1 - If installation of yarn fails
Return Code: 0 - If yarn is already installed or installed without error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- - [38;2;0;255;0;48;2;0;0;0mBUILD_YARN_VERSION[0m
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: yarnInstall [ --version versionCode ] [ --help ]

    --version versionCode  String. Optional. Install this version of yarn.
    --help                 Flag. Optional. Display this help.

Install yarn in the build environment
If this fails it will output the installation log.
When this tool succeeds the yarn binary is available in the local operating system.
Return Code: 1 - If installation of yarn fails
Return Code: 0 - If yarn is already installed or installed without error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- - BUILD_YARN_VERSION
- 
'
