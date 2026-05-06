#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="environmentVariableName - String. Optional. Map this value only. If not specified, all environment variables are mapped."$'\n'"--prefix - String. Optional. Prefix character for tokens, defaults to \`{\`."$'\n'"--suffix - String. Optional. Suffix character for tokens, defaults to \`}\`."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="map.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Map tokens in the input stream based on environment values with the same names."$'\n'"Converts tokens in the form \`{ENVIRONMENT_VARIABLE}\` to the associated value."$'\n'"Undefined values are not converted."$'\n'"This one does it like \`mapValue\`"$'\n'"Environment is accessed via arguments passed or entire exported environment value space are and mapped to the destination."$'\n'""$'\n'""
descriptionLineCount="6"
example="    printf %s \"{NAME}, {PLACE}.\\n\" | NAME=Hello PLACE=world mapEnvironment NAME PLACE"$'\n'""
file="bin/build/tools/map.sh"
fn="mapEnvironment"
fnMarker="mapenvironment"
foundNames=([0]="summary" [1]="see" [2]="argument" [3]="example" [4]="requires")
line="256"
rawComment="Summary: Convert tokens in files to environment variable values"$'\n'"Map tokens in the input stream based on environment values with the same names."$'\n'"Converts tokens in the form \`{ENVIRONMENT_VARIABLE}\` to the associated value."$'\n'"Undefined values are not converted."$'\n'"This one does it like \`mapValue\`"$'\n'"Environment is accessed via arguments passed or entire exported environment value space are and mapped to the destination."$'\n'"See: mapValue"$'\n'"Argument: environmentVariableName - String. Optional. Map this value only. If not specified, all environment variables are mapped."$'\n'"Argument: --prefix - String. Optional. Prefix character for tokens, defaults to \`{\`."$'\n'"Argument: --suffix - String. Optional. Suffix character for tokens, defaults to \`}\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     printf %s \"{NAME}, {PLACE}.\\n\" | NAME=Hello PLACE=world mapEnvironment NAME PLACE"$'\n'"Requires: environmentVariables cat throwEnvironment catchEnvironment"$'\n'"Requires: throwArgument decorate validate"$'\n'""$'\n'""
requires="environmentVariables cat throwEnvironment catchEnvironment"$'\n'"throwArgument decorate validate"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="mapValue"$'\n'""
sourceFile="bin/build/tools/map.sh"
sourceHash="940f9ebf8bd346b36b369627516a0d1367a6cdfa"
sourceLine="256"
summary="Convert tokens in files to environment variable values"
summaryComputed=""
usage="mapEnvironment [ environmentVariableName ] [ --prefix ] [ --suffix ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmapEnvironment'$'\e''[0m '$'\e''[[(blue)]m[ environmentVariableName ]'$'\e''[0m '$'\e''[[(blue)]m[ --prefix ]'$'\e''[0m '$'\e''[[(blue)]m[ --suffix ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]menvironmentVariableName  '$'\e''[[(value)]mString. Optional. Map this value only. If not specified, all environment variables are mapped.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--prefix                 '$'\e''[[(value)]mString. Optional. Prefix character for tokens, defaults to '$'\e''[[(code)]m{'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--suffix                 '$'\e''[[(value)]mString. Optional. Suffix character for tokens, defaults to '$'\e''[[(code)]m}'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help                   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Map tokens in the input stream based on environment values with the same names.'$'\n''Converts tokens in the form '$'\e''[[(code)]m{ENVIRONMENT_VARIABLE}'$'\e''[[(reset)]m to the associated value.'$'\n''Undefined values are not converted.'$'\n''This one does it like '$'\e''[[(code)]mmapValue'$'\e''[[(reset)]m'$'\n''Environment is accessed via arguments passed or entire exported environment value space are and mapped to the destination.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    printf %s "{NAME}, {PLACE}.\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE'
# shellcheck disable=SC2016
helpPlain='Usage: mapEnvironment [ environmentVariableName ] [ --prefix ] [ --suffix ] [ --help ]'$'\n'''$'\n''    environmentVariableName  String. Optional. Map this value only. If not specified, all environment variables are mapped.'$'\n''    --prefix                 String. Optional. Prefix character for tokens, defaults to {.'$'\n''    --suffix                 String. Optional. Suffix character for tokens, defaults to }.'$'\n''    --help                   Flag. Optional. Display this help.'$'\n'''$'\n''Map tokens in the input stream based on environment values with the same names.'$'\n''Converts tokens in the form {ENVIRONMENT_VARIABLE} to the associated value.'$'\n''Undefined values are not converted.'$'\n''This one does it like mapValue'$'\n''Environment is accessed via arguments passed or entire exported environment value space are and mapped to the destination.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    printf %s "{NAME}, {PLACE}.\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE'
documentationPath="documentation/source/tools/map.md"
