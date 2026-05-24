#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'environmentName - String. Optional. Map this value only. If not specified, all environment variables are mapped.\n--prefix - String. Optional. Prefix character for tokens, defaults to `{`.\n--suffix - String. Optional. Suffix character for tokens, defaults to `}`.\n--help - Flag. Optional. Display this help.\n'
base="map.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Map tokens in the input stream based on environment values with the same names.\nConverts tokens in the form `{ENVIRONMENT_VARIABLE}` to the associated value.\nUndefined values are not converted.\nUses environment variables passed as arguments or entire exported environment variables are used and mapped to the destination.\n\n'
descriptionLineCount="5"
example=$'    printf %s "{NAME}, {PLACE}.\\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE\n'
file="bin/build/tools/map.sh"
fn="mapEnvironmentSed"
fnMarker="mapenvironmentsed"
foundNames=([0]="summary" [1]="todo" [2]="see" [3]="argument" [4]="example" [5]="requires")
line="323"
rawComment=$'Summary: Convert tokens in files to environment variable values\nMap tokens in the input stream based on environment values with the same names.\nConverts tokens in the form `{ENVIRONMENT_VARIABLE}` to the associated value.\nUndefined values are not converted.\nUses environment variables passed as arguments or entire exported environment variables are used and mapped to the destination.\nTODO: Do this like `mapValue`\nSee: mapValue\nArgument: environmentName - String. Optional. Map this value only. If not specified, all environment variables are mapped.\nArgument: --prefix - String. Optional. Prefix character for tokens, defaults to `{`.\nArgument: --suffix - String. Optional. Suffix character for tokens, defaults to `}`.\nArgument: --help - Flag. Optional. Display this help.\nExample:     printf %s "{NAME}, {PLACE}.\\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE\nRequires: throwArgument read environmentVariables decorate sed cat rm throwEnvironment catchEnvironment returnClean\nRequires: validate fileTemporaryName\n\n'
requires=$'throwArgument read environmentVariables decorate sed cat rm throwEnvironment catchEnvironment returnClean\nvalidate fileTemporaryName\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'mapValue\n'
sourceFile="bin/build/tools/map.sh"
sourceHash="c91a3375287e38d3885f8a800913d1919243c8db"
sourceLine="323"
summary="Convert tokens in files to environment variable values"
summaryComputed=""
todo=$'Do this like `mapValue`\n'
usage="mapEnvironmentSed [ environmentName ] [ --prefix ] [ --suffix ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmapEnvironmentSed'$'\e''[0m '$'\e''[[(blue)]m[ environmentName ]'$'\e''[0m '$'\e''[[(blue)]m[ --prefix ]'$'\e''[0m '$'\e''[[(blue)]m[ --suffix ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]menvironmentName  '$'\e''[[(value)]mString. Optional. Map this value only. If not specified, all environment variables are mapped.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--prefix         '$'\e''[[(value)]mString. Optional. Prefix character for tokens, defaults to '$'\e''[[(code)]m{'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--suffix         '$'\e''[[(value)]mString. Optional. Suffix character for tokens, defaults to '$'\e''[[(code)]m}'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help           '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Map tokens in the input stream based on environment values with the same names.'$'\n''Converts tokens in the form '$'\e''[[(code)]m{ENVIRONMENT_VARIABLE}'$'\e''[[(reset)]m to the associated value.'$'\n''Undefined values are not converted.'$'\n''Uses environment variables passed as arguments or entire exported environment variables are used and mapped to the destination.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    printf %s "{NAME}, {PLACE}.\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE'
# shellcheck disable=SC2016
helpPlain='Usage: mapEnvironmentSed [ environmentName ] [ --prefix ] [ --suffix ] [ --help ]'$'\n'''$'\n''    environmentName  String. Optional. Map this value only. If not specified, all environment variables are mapped.'$'\n''    --prefix         String. Optional. Prefix character for tokens, defaults to {.'$'\n''    --suffix         String. Optional. Suffix character for tokens, defaults to }.'$'\n''    --help           Flag. Optional. Display this help.'$'\n'''$'\n''Map tokens in the input stream based on environment values with the same names.'$'\n''Converts tokens in the form {ENVIRONMENT_VARIABLE} to the associated value.'$'\n''Undefined values are not converted.'$'\n''Uses environment variables passed as arguments or entire exported environment variables are used and mapped to the destination.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    printf %s "{NAME}, {PLACE}.\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE'
documentationPath="documentation/source/tools/unused.md"
