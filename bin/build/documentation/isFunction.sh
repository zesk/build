#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="string - String. Required. String to test if it is a bash function. Builtins are supported. \`.\` is explicitly not supported to disambiguate it from the current directory \`.\`."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="type.sh"
description="Test if argument are bash functions"$'\n'"If no arguments are passed, returns exit code 1."$'\n'""
file="bin/build/tools/type.sh"
fn="isFunction"
foundNames=([0]="argument" [1]="return_code" [2]="requires")
line="177"
lowerFn="isfunction"
rawComment="Test if argument are bash functions"$'\n'"Argument: string - String. Required. String to test if it is a bash function. Builtins are supported. \`.\` is explicitly not supported to disambiguate it from the current directory \`.\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"If no arguments are passed, returns exit code 1."$'\n'"Return Code: 0 - argument is bash function"$'\n'"Return Code: 1 - argument is not a bash function"$'\n'"Requires: catchArgument isUnsignedInteger bashDocumentation type helpArgument"$'\n'""$'\n'""
requires="catchArgument isUnsignedInteger bashDocumentation type helpArgument"$'\n'""
return_code="0 - argument is bash function"$'\n'"1 - argument is not a bash function"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceHash="3df0d84917e775e2aba0d9280d56eb8d73b4a8c3"
sourceLine="177"
summary="Test if argument are bash functions"
summaryComputed="true"
usage="isFunction string [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misFunction'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mstring'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mstring  '$'\e''[[(value)]mString. Required. String to test if it is a bash function. Builtins are supported. '$'\e''[[(code)]m.'$'\e''[[(reset)]m is explicitly not supported to disambiguate it from the current directory '$'\e''[[(code)]m.'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Test if argument are bash functions'$'\n''If no arguments are passed, returns exit code 1.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - argument is bash function'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - argument is not a bash function'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isFunction string [ --help ]'$'\n'''$'\n''    string  String. Required. String to test if it is a bash function. Builtins are supported. . is explicitly not supported to disambiguate it from the current directory .'$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Test if argument are bash functions'$'\n''If no arguments are passed, returns exit code 1.'$'\n'''$'\n''Return codes:'$'\n''- 0 - argument is bash function'$'\n''- 1 - argument is not a bash function'$'\n'''
documentationPath="documentation/source/tools/type.md"
