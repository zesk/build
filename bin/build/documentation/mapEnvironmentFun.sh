#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'environmentName - String. Optional. Map this value only. If not specified, all environment variables are mapped.\n--env-file envFile - File. Optional. Load this environment file prior to processing input.\n--prefix - String. Optional. Prefix character for tokens, defaults to `{`.\n--suffix - String. Optional. Suffix character for tokens, defaults to `}`.\n--help - Flag. Optional. Display this help.\n'
base="map.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Map tokens in the input stream based on environment values with the same names.\nConverts tokens in the form `{ENVIRONMENT_VARIABLE}` to the associated value.\nUndefined values are not converted.\nUses environment variables passed as arguments or entire exported environment variables are used and mapped to the destination.\n\n'
descriptionLineCount="5"
example=$'    printf %s "{NAME}, {PLACE}.\\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE\n'
file="bin/build/tools/map.sh"
fn="mapEnvironmentFun"
fnMarker="mapenvironmentfun"
foundNames=([0]="summary" [1]="see" [2]="argument" [3]="example" [4]="requires")
line="420"
rawComment=$'Summary: Convert tokens in files to environment variable values\nMap tokens in the input stream based on environment values with the same names.\nConverts tokens in the form `{ENVIRONMENT_VARIABLE}` to the associated value.\nUndefined values are not converted.\nUses environment variables passed as arguments or entire exported environment variables are used and mapped to the destination.\nSee: mapEnvironment\nSee: mapValue\nArgument: environmentName - String. Optional. Map this value only. If not specified, all environment variables are mapped.\nArgument: --env-file envFile - File. Optional. Load this environment file prior to processing input.\nArgument: --prefix - String. Optional. Prefix character for tokens, defaults to `{`.\nArgument: --suffix - String. Optional. Suffix character for tokens, defaults to `}`.\nArgument: --help - Flag. Optional. Display this help.\nExample:     printf %s "{NAME}, {PLACE}.\\n" | NAME=Hello PLACE=world mapEnvironment NAME PLACE\nRequires: throwArgument decorate\nRequires: validate\n\n'
requires=$'throwArgument decorate\nvalidate\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'mapEnvironment\nmapValue\n'
sourceFile="bin/build/tools/map.sh"
sourceHash="ad239b6bc25f5b8d6c7ef606feeaa9161fae799e"
sourceLine="420"
summary="Convert tokens in files to environment variable values"
summaryComputed=""
usage="mapEnvironmentFun [ environmentName ] [ --env-file envFile ] [ --prefix ] [ --suffix ] [ --help ]"
