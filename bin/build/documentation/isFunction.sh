#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-29
# shellcheck disable=SC2034
argument="string - Required. String to test if it is a bash function. Builtins are supported. \`.\` is explicitly not supported to disambiguate it from the current directory \`.\`."$'\n'""
base="type.sh"
description="Test if argument are bash functions"$'\n'"If no arguments are passed, returns exit code 1."$'\n'""
file="bin/build/tools/type.sh"
foundNames=([0]="argument" [1]="return_code" [2]="requires")
rawComment="Test if argument are bash functions"$'\n'"Argument: string - Required. String to test if it is a bash function. Builtins are supported. \`.\` is explicitly not supported to disambiguate it from the current directory \`.\`."$'\n'"If no arguments are passed, returns exit code 1."$'\n'"Return Code: 0 - argument is bash function"$'\n'"Return Code: 1 - argument is not a bash function"$'\n'"Requires: catchArgument isUnsignedInteger usageDocument type"$'\n'""$'\n'""
requires="catchArgument isUnsignedInteger usageDocument type"$'\n'""
return_code="0 - argument is bash function"$'\n'"1 - argument is not a bash function"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceHash="5be1434c45364fe54b7ffac20b107397c81fc0c3"
summary="Test if argument are bash functions"
usage="isFunction string"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misFunction'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mstring'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mstring  '$'\e''[[(value)]mRequired. String to test if it is a bash function. Builtins are supported. '$'\e''[[(code)]m.'$'\e''[[(reset)]m is explicitly not supported to disambiguate it from the current directory '$'\e''[[(code)]m.'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n'''$'\n''Test if argument are bash functions'$'\n''If no arguments are passed, returns exit code 1.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - argument is bash function'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - argument is not a bash function'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isFunction string'$'\n'''$'\n''    string  Required. String to test if it is a bash function. Builtins are supported. . is explicitly not supported to disambiguate it from the current directory .'$'\n'''$'\n''Test if argument are bash functions'$'\n''If no arguments are passed, returns exit code 1.'$'\n'''$'\n''Return codes:'$'\n''- 0 - argument is bash function'$'\n''- 1 - argument is not a bash function'$'\n'''
# elapsed 0.517
