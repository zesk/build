#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--env-file envFile - File. Optional. Load this environment file prior to processing input.\n--default defaultString - String. Optional. Default string for tokens. Can use additional tokens: `{prefix}` `{suffix}` `{tokenName}` and `{token}`. Set to `--` to output `token`.\n--prefix prefixString - String. Optional. Prefix character for tokens, defaults to `{`.\n--suffix suffixString - String. Optional. Suffix character for tokens, defaults to `}`.\n mapFunction ... - Function. Required. Replacement function with arguments. Called as is with three additional arguments: `tokenName` `offset` `total`\n--help - Flag. Optional. Display this help.\n'
base="map.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Map tokens in the input stream based on some heuristic.\n\nConverts tokens in the form `{VARIABLE}` to the associated value.\n\nUndefined values are not converted.\n\n`mapFunction` should return non-zero to have the default behavior occur. If a zero exit code is output then some replacement value is assumed to be written to `stdout` by the `mapFunction`.\nThe special return code 120 is used to terminate the calling function immediately.\n\n'
descriptionLineCount="9"
file="bin/build/tools/map.sh"
fn="mapFunction"
fnMarker="mapfunction"
foundNames=([0]="summary" [1]="see" [2]="argument" [3]="return_code" [4]="requires")
line="37"
rawComment=$'Summary: Convert tokens in input to values\nMap tokens in the input stream based on some heuristic.\nConverts tokens in the form `{VARIABLE}` to the associated value.\nUndefined values are not converted.\nSee: mapValue mapEnvironment\nArgument: --env-file envFile - File. Optional. Load this environment file prior to processing input.\nArgument: --default defaultString - String. Optional. Default string for tokens. Can use additional tokens: `{prefix}` `{suffix}` `{tokenName}` and `{token}`. Set to `--` to output `token`.\nArgument: --prefix prefixString - String. Optional. Prefix character for tokens, defaults to `{`.\nArgument: --suffix suffixString - String. Optional. Suffix character for tokens, defaults to `}`.\nArgument:  mapFunction ... - Function. Required. Replacement function with arguments. Called as is with three additional arguments: `tokenName` `offset` `total`\n`mapFunction` should return non-zero to have the default behavior occur. If a zero exit code is output then some replacement value is assumed to be written to `stdout` by the `mapFunction`.\nThe special return code 120 is used to terminate the calling function immediately.\nReturn Code: 120 - Map function exited early\nReturn Code: 130 - User interrupt (exits early)\nReturn Code: 141 - System interrupt (exits early)\nArgument: --help - Flag. Optional. Display this help.\nRequires: cat throwEnvironment catchEnvironment\nRequires: throwArgument decorate validate\n\n'
requires=$'cat throwEnvironment catchEnvironment\nthrowArgument decorate validate\n'
return_code=$'120 - Map function exited early\n130 - User interrupt (exits early)\n141 - System interrupt (exits early)\n'
see=$'mapValue mapEnvironment\n'
sourceFile="bin/build/tools/map.sh"
sourceHash="ad239b6bc25f5b8d6c7ef606feeaa9161fae799e"
sourceLine="37"
summary="Convert tokens in input to values"
summaryComputed=""
usage="mapFunction [ --env-file envFile ] [ --default defaultString ] [ --prefix prefixString ] [ --suffix suffixString ]  mapFunction ... [ --help ]"
