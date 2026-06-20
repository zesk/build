#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\nrequiredEnvironment ... - EnvironmentName. Optional. One or more environment variables which should be non-blank and included in the `.env` file.\n-- - Divider. Optional. Divides the requiredEnvironment values from the optionalEnvironment\noptionalEnvironment ... - EnvironmentName. Optional. One or more environment variables which are included if blank or not\n'
base="application.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Check application environment is populated correctly.\nAlso verifies that `environmentApplicationVariables` and `environmentApplicationLoad` are defined.\n\n'
descriptionLineCount="3"
file="bin/build/tools/environment/application.sh"
fn="environmentFileApplicationVerify"
fnMarker="environmentfileapplicationverify"
foundNames=([0]="argument")
line="140"
original="environmentFileApplicationVerify"
rawComment=$'Check application environment is populated correctly.\nArgument: --help - Flag. Optional. Display this help.\nArgument: requiredEnvironment ... - EnvironmentName. Optional. One or more environment variables which should be non-blank and included in the `.env` file.\nArgument: -- - Divider. Optional. Divides the requiredEnvironment values from the optionalEnvironment\nArgument: optionalEnvironment ... - EnvironmentName. Optional. One or more environment variables which are included if blank or not\nAlso verifies that `environmentApplicationVariables` and `environmentApplicationLoad` are defined.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/environment/application.sh"
sourceHash="222bffd60c8180751cb6d31ef5e4e6f51512a220"
sourceLine="140"
summary="Check application environment is populated correctly."
summaryComputed="true"
usage="environmentFileApplicationVerify [ --help ] [ requiredEnvironment ... ] [ -- ] [ optionalEnvironment ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentFileApplicationVerify'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ requiredEnvironment ... ]'$'\e''[0m '$'\e''[[(blue)]m[ -- ]'$'\e''[0m '$'\e''[[(blue)]m[ optionalEnvironment ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help                   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mrequiredEnvironment ...  '$'\e''[[(value)]mEnvironmentName. Optional. One or more environment variables which should be non-blank and included in the '$'\e''[[(code)]m.env'$'\e''[[(reset)]m file.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]m--                       '$'\e''[[(value)]mDivider. Optional. Divides the requiredEnvironment values from the optionalEnvironment'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]moptionalEnvironment ...  '$'\e''[[(value)]mEnvironmentName. Optional. One or more environment variables which are included if blank or not'$'\e''[[(reset)]m'$'\n'''$'\n''Check application environment is populated correctly.'$'\n''Also verifies that '$'\e''[[(code)]menvironmentApplicationVariables'$'\e''[[(reset)]m and '$'\e''[[(code)]menvironmentApplicationLoad'$'\e''[[(reset)]m are defined.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: environmentFileApplicationVerify [ --help ] [ requiredEnvironment ... ] [ -- ] [ optionalEnvironment ... ]'$'\n'''$'\n''    --help                   Flag. Optional. Display this help.'$'\n''    requiredEnvironment ...  EnvironmentName. Optional. One or more environment variables which should be non-blank and included in the .env file.'$'\n''    --                       Divider. Optional. Divides the requiredEnvironment values from the optionalEnvironment'$'\n''    optionalEnvironment ...  EnvironmentName. Optional. One or more environment variables which are included if blank or not'$'\n'''$'\n''Check application environment is populated correctly.'$'\n''Also verifies that environmentApplicationVariables and environmentApplicationLoad are defined.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/environment.md"
