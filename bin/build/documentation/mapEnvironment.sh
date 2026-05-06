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
