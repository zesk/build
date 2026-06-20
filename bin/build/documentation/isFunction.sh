#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument="string - String. Required. String to test if it is a bash function. Builtins are supported. \`.\` is explicitly not supported to disambiguate it from the current directory \`.\`."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="type.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Test if arguments are bash functions."$'\n'"If no arguments are passed, returns exit code 1."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/type.sh"
fn="isFunction"
fnMarker="isfunction"
foundNames=([0]="summary" [1]="argument" [2]="return_code" [3]="requires")
line="178"
original="isFunction"
rawComment="Summary: Is argument a bash function?"$'\n'"Test if arguments are bash functions."$'\n'"Argument: string - String. Required. String to test if it is a bash function. Builtins are supported. \`.\` is explicitly not supported to disambiguate it from the current directory \`.\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"If no arguments are passed, returns exit code 1."$'\n'"Return Code: 0 - argument is bash function"$'\n'"Return Code: 1 - argument is not a bash function"$'\n'"Requires: catchArgument isUnsignedInteger bashDocumentation type helpArgument"$'\n'""$'\n'""
requires="catchArgument isUnsignedInteger bashDocumentation type helpArgument"$'\n'""
return_code="0 - argument is bash function"$'\n'"1 - argument is not a bash function"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceHash="a44ecefca78b37437c11852fd5a4111cdbe0d376"
sourceLine="178"
summary="Is argument a bash function?"
summaryComputed=""
usage="isFunction string [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misFunction'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mstring'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mstring  '$'\e''[[(value)]mString. Required. String to test if it is a bash function. Builtins are supported. '$'\e''[[(code)]m.'$'\e''[[(reset)]m is explicitly not supported to disambiguate it from the current directory '$'\e''[[(code)]m.'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Test if arguments are bash functions.'$'\n''If no arguments are passed, returns exit code 1.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - argument is bash function'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - argument is not a bash function'
# shellcheck disable=SC2016
helpPlain='Usage: isFunction string [ --help ]'$'\n'''$'\n''    string  String. Required. String to test if it is a bash function. Builtins are supported. . is explicitly not supported to disambiguate it from the current directory .'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Test if arguments are bash functions.'$'\n''If no arguments are passed, returns exit code 1.'$'\n'''$'\n''Return codes:'$'\n''- 0 - argument is bash function'$'\n''- 1 - argument is not a bash function'
documentationPath="documentation/source/tools/type.md"
