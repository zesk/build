#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="bash.sh"
description="Argument: builtin - String. Required. String to check if it's a bash builtin."$'\n'"Return Code: 0 - Yes, this string is a bash builtin command."$'\n'"Return Code: 1 - No, this is not a bash builtin command"$'\n'""
file="bin/build/tools/bash.sh"
foundNames=()
rawComment="Argument: builtin - String. Required. String to check if it's a bash builtin."$'\n'"Return Code: 0 - Yes, this string is a bash builtin command."$'\n'"Return Code: 1 - No, this is not a bash builtin command"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="c27f4788f9122cfbb778e66b32894938a8ca0ace"
summary="Argument: builtin - String. Required. String to check if it's"
usage="isBashBuiltin"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misBashBuiltin'$'\e''[0m'$'\n'''$'\n''Argument: builtin - String. Required. String to check if it'\''s a bash builtin.'$'\n''Return Code: 0 - Yes, this string is a bash builtin command.'$'\n''Return Code: 1 - No, this is not a bash builtin command'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isBashBuiltin'$'\n'''$'\n''Argument: builtin - String. Required. String to check if it'\''s a bash builtin.'$'\n''Return Code: 0 - Yes, this string is a bash builtin command.'$'\n''Return Code: 1 - No, this is not a bash builtin command'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.465
