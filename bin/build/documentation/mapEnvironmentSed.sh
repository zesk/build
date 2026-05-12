#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
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
line="320"
rawComment=$'Summary: Convert tokens in files to environment variable values\nMap tokens in the input stream based on environment values with the same names.\nConverts tokens in the form `{ENVIRONMENT_VARIABLE}` to the associated value.\nUndefined values are not converted.\nUses environment variables passed as arguments or entire exported environment variables are used and mapped to the destination.\nTODO: Do this like `mapValue`\nSee: mapValue\nArgument: environmentName - String. Optional. Map this value only. If not specified, all environment variables are mapped.\nArgument: --prefix - String. Optional. Prefix character for tokens, defaults to `{`.\nArgument: --suffix - String. Optional. Suffix character for tokens, defaults to `}`.\nArgument: --help - Flag. Optional. Display this help.\nExample:     printf %s "{NAME}, {PLACE}.\\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE\nRequires: throwArgument read environmentVariables decorate sed cat rm throwEnvironment catchEnvironment returnClean\nRequires: validate fileTemporaryName\n\n'
requires=$'throwArgument read environmentVariables decorate sed cat rm throwEnvironment catchEnvironment returnClean\nvalidate fileTemporaryName\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'mapValue\n'
sourceFile="bin/build/tools/map.sh"
sourceHash="ad239b6bc25f5b8d6c7ef606feeaa9161fae799e"
sourceLine="320"
summary="Convert tokens in files to environment variable values"
summaryComputed=""
todo=$'Do this like `mapValue`\n'
usage="mapEnvironmentSed [ environmentName ] [ --prefix ] [ --suffix ] [ --help ]"
