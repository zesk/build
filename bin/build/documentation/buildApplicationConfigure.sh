#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--non-interactive - Flag. Optional. Do not prompt for input and fail if input is required.\n--owner ownerName - String. Optional. The `APPLICATION_OWNER`.\n--name applicationName - String. Optional. The `APPLICATION_NAME`.\n--code codeName - String. Optional. The `APPLICATION_CODE`.\n--help - Flag. Optional. Display this help.\n'
base="application.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Set up a new project for Zesk Build\n- Creates shell development environment\n- Registers git hooks\n- Configures base environment variables\nEXPERIMENTAL - not finished yet.\n\n'
descriptionLineCount="6"
file="bin/build/tools/application.sh"
fn="buildApplicationConfigure"
fnMarker="buildapplicationconfigure"
foundNames=([0]="summary" [1]="argument")
line="151"
rawComment=$'Summary: Configure project for Zesk Build\nSet up a new project for Zesk Build\n- Creates shell development environment\n- Registers git hooks\n- Configures base environment variables\nEXPERIMENTAL - not finished yet.\nArgument: --non-interactive - Flag. Optional. Do not prompt for input and fail if input is required.\nArgument: --owner ownerName - String. Optional. The `APPLICATION_OWNER`.\nArgument: --name applicationName - String. Optional. The `APPLICATION_NAME`.\nArgument: --code codeName - String. Optional. The `APPLICATION_CODE`.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/application.sh"
sourceHash="b17015a1dababfad8b603f4af30089a720ec9300"
sourceLine="151"
summary="Configure project for Zesk Build"
summaryComputed=""
usage="buildApplicationConfigure --non-interactive [ --owner ownerName ] [ --name applicationName ] [ --code codeName ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildApplicationConfigure'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]m--non-interactive'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --owner ownerName ]'$'\e''[0m '$'\e''[[(blue)]m[ --name applicationName ]'$'\e''[0m '$'\e''[[(blue)]m[ --code codeName ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]m--non-interactive       '$'\e''[[(value)]mFlag. Optional. Do not prompt for input and fail if input is required.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--owner ownerName       '$'\e''[[(value)]mString. Optional. The '$'\e''[[(code)]mAPPLICATION_OWNER'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--name applicationName  '$'\e''[[(value)]mString. Optional. The '$'\e''[[(code)]mAPPLICATION_NAME'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--code codeName         '$'\e''[[(value)]mString. Optional. The '$'\e''[[(code)]mAPPLICATION_CODE'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help                  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Set up a new project for Zesk Build'$'\n''- Creates shell development environment'$'\n''- Registers git hooks'$'\n''- Configures base environment variables'$'\n''EXPERIMENTAL - not finished yet.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: buildApplicationConfigure --non-interactive [ --owner ownerName ] [ --name applicationName ] [ --code codeName ] [ --help ]'$'\n'''$'\n''    --non-interactive       Flag. Optional. Do not prompt for input and fail if input is required.'$'\n''    --owner ownerName       String. Optional. The APPLICATION_OWNER.'$'\n''    --name applicationName  String. Optional. The APPLICATION_NAME.'$'\n''    --code codeName         String. Optional. The APPLICATION_CODE.'$'\n''    --help                  Flag. Optional. Display this help.'$'\n'''$'\n''Set up a new project for Zesk Build'$'\n''- Creates shell development environment'$'\n''- Registers git hooks'$'\n''- Configures base environment variables'$'\n''EXPERIMENTAL - not finished yet.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/build.md"
