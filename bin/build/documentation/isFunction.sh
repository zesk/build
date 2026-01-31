#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="type.sh"
description="Test if argument are bash functions"$'\n'"Argument: string - Required. String to test if it is a bash function. Builtins are supported. \`.\` is explicitly not supported to disambiguate it from the current directory \`.\`."$'\n'"If no arguments are passed, returns exit code 1."$'\n'"Return Code: 0 - argument is bash function"$'\n'"Return Code: 1 - argument is not a bash function"$'\n'"Requires: catchArgument isUnsignedInteger usageDocument type"$'\n'""
file="bin/build/tools/type.sh"
foundNames=()
rawComment="Test if argument are bash functions"$'\n'"Argument: string - Required. String to test if it is a bash function. Builtins are supported. \`.\` is explicitly not supported to disambiguate it from the current directory \`.\`."$'\n'"If no arguments are passed, returns exit code 1."$'\n'"Return Code: 0 - argument is bash function"$'\n'"Return Code: 1 - argument is not a bash function"$'\n'"Requires: catchArgument isUnsignedInteger usageDocument type"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceHash="5be1434c45364fe54b7ffac20b107397c81fc0c3"
summary="Test if argument are bash functions"
usage="isFunction"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misFunction'$'\e''[0m'$'\n'''$'\n''Test if argument are bash functions'$'\n''Argument: string - Required. String to test if it is a bash function. Builtins are supported. '$'\e''[[(code)]m.'$'\e''[[(reset)]m is explicitly not supported to disambiguate it from the current directory '$'\e''[[(code)]m.'$'\e''[[(reset)]m'$'\n''If no arguments are passed, returns exit code 1.'$'\n''Return Code: 0 - argument is bash function'$'\n''Return Code: 1 - argument is not a bash function'$'\n''Requires: catchArgument isUnsignedInteger usageDocument type'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isFunction'$'\n'''$'\n''Test if argument are bash functions'$'\n''Argument: string - Required. String to test if it is a bash function. Builtins are supported. . is explicitly not supported to disambiguate it from the current directory .'$'\n''If no arguments are passed, returns exit code 1.'$'\n''Return Code: 0 - argument is bash function'$'\n''Return Code: 1 - argument is not a bash function'$'\n''Requires: catchArgument isUnsignedInteger usageDocument type'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.473
