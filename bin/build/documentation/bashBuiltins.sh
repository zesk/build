#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument="none"
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'List bash builtin functions, one per line\n\n'
descriptionLineCount="2"
file="bin/build/tools/bash.sh"
fn="bashBuiltins"
fnMarker="bashbuiltins"
foundNames=([0]="stdout")
line="83"
original="bashBuiltins"
rawComment=$'List bash builtin functions, one per line\nstdout: line:function\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/bash.sh"
sourceHash="9822477a1f3a6f53599f6f26b9aa3886ba4c5595"
sourceLine="83"
stdout=$'line:function\n'
summary="List bash builtin functions, one per line"
summaryComputed="true"
usage="bashBuiltins"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashBuiltins'$'\e''[0m'$'\n'''$'\n''List bash builtin functions, one per line'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''line:function'
# shellcheck disable=SC2016
helpPlain='Usage: bashBuiltins'$'\n'''$'\n''List bash builtin functions, one per line'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''line:function'
documentationPath="documentation/source/tools/bash.md"
