#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="builtin - String. Required. String to check if it's a bash builtin."$'\n'""
base="bash.sh"
description="No documentation for \`isBashBuiltin\`."$'\n'""
file="bin/build/tools/bash.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Argument: builtin - String. Required. String to check if it's a bash builtin."$'\n'"Return Code: 0 - Yes, this string is a bash builtin command."$'\n'"Return Code: 1 - No, this is not a bash builtin command"$'\n'""$'\n'""
return_code="0 - Yes, this string is a bash builtin command."$'\n'"1 - No, this is not a bash builtin command"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="c27f4788f9122cfbb778e66b32894938a8ca0ace"
summary="undocumented"
usage="isBashBuiltin builtin"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misBashBuiltin'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mbuiltin'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mbuiltin  '$'\e''[[(value)]mString. Required. String to check if it'\''s a bash builtin.'$'\e''[[(reset)]m'$'\n'''$'\n''No documentation for '$'\e''[[(code)]misBashBuiltin'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Yes, this string is a bash builtin command.'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - No, this is not a bash builtin command'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isBashBuiltin builtin'$'\n'''$'\n''    builtin  String. Required. String to check if it'\''s a bash builtin.'$'\n'''$'\n''No documentation for isBashBuiltin.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Yes, this string is a bash builtin command.'$'\n''- 1 - No, this is not a bash builtin command'$'\n'''
# elapsed 3.37
