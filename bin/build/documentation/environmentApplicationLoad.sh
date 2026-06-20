#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="application.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Loads application environment variables, set them to their default values if needed, and outputs the list of variables and values.\n\n'
descriptionLineCount="2"
environment=$'BUILD_TIMESTAMP\nAPPLICATION_BUILD_DATE\nAPPLICATION_VERSION\nAPPLICATION_ID\nAPPLICATION_TAG\n'
file="bin/build/tools/environment/application.sh"
fn="environmentApplicationLoad"
fnMarker="environmentapplicationload"
foundNames=([0]="environment" [1]="argument")
line="27"
original="environmentApplicationLoad"
rawComment=$'Loads application environment variables, set them to their default values if needed, and outputs the list of variables and values.\nEnvironment: BUILD_TIMESTAMP\nEnvironment: APPLICATION_BUILD_DATE\nEnvironment: APPLICATION_VERSION\nEnvironment: APPLICATION_ID\nEnvironment: APPLICATION_TAG\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/environment/application.sh"
sourceHash="222bffd60c8180751cb6d31ef5e4e6f51512a220"
sourceLine="27"
summary="Loads application environment variables, set them to their default values"
summaryComputed="true"
usage="environmentApplicationLoad [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentApplicationLoad'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Loads application environment variables, set them to their default values if needed, and outputs the list of variables and values.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_TIMESTAMP'$'\n''- APPLICATION_BUILD_DATE'$'\n''- APPLICATION_VERSION'$'\n''- APPLICATION_ID'$'\n''- APPLICATION_TAG'
# shellcheck disable=SC2016
helpPlain='Usage: environmentApplicationLoad [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Loads application environment variables, set them to their default values if needed, and outputs the list of variables and values.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_TIMESTAMP'$'\n''- APPLICATION_BUILD_DATE'$'\n''- APPLICATION_VERSION'$'\n''- APPLICATION_ID'$'\n''- APPLICATION_TAG'
documentationPath="documentation/source/tools/environment.md"
