#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-14
# shellcheck disable=SC2034
argument="none"
base="bash.sh"
description="List bash buildin functions, one per line"$'\n'""
file="bin/build/tools/bash.sh"
foundNames=([0]="stdout")
rawComment="List bash buildin functions, one per line"$'\n'"stdout: line:function"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="e66246980f40066fe4c09e2727ffc628f6b42f38"
stdout="line:function"$'\n'""
summary="List bash buildin functions, one per line"
summaryComputed="true"
usage="bashBuiltins"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashBuiltins'$'\e''[0m'$'\n'''$'\n''List bash buildin functions, one per line'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''line:function'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashBuiltins'$'\n'''$'\n''List bash buildin functions, one per line'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''line:function'$'\n'''
