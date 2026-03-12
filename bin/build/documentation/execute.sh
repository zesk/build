#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="binary ... - Executable. Required. Any arguments are passed to \`binary\`."$'\n'""
base="_sugar.sh"
description="Run binary and output failed command upon error"$'\n'""
file="bin/build/tools/_sugar.sh"
fn="execute"
foundNames=([0]="argument" [1]="requires")
rawComment="Argument: binary ... - Executable. Required. Any arguments are passed to \`binary\`."$'\n'"Run binary and output failed command upon error"$'\n'"Requires: returnMessage"$'\n'""$'\n'""
requires="returnMessage"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="00f5bf2862b4fee06819afcf6d6db6adc911bcff"
summary="Run binary and output failed command upon error"
summaryComputed="true"
usage="execute binary ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mexecute'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mbinary ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mbinary ...  '$'\e''[[(value)]mExecutable. Required. Any arguments are passed to '$'\e''[[(code)]mbinary'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Run binary and output failed command upon error'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: execute binary ...'$'\n'''$'\n''    binary ...  Executable. Required. Any arguments are passed to binary.'$'\n'''$'\n''Run binary and output failed command upon error'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
