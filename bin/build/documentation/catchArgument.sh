#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="handler - Function. Required. Failure command"$'\n'"command ... - Callable. Required. Command to run."$'\n'""
base="_sugar.sh"
description="Run \`command\`, upon failure run \`handler\` with an argument error"$'\n'""
file="bin/build/tools/_sugar.sh"
fn="catchArgument"
foundNames=([0]="argument")
rawComment="Run \`command\`, upon failure run \`handler\` with an argument error"$'\n'"Argument: handler - Function. Required. Failure command"$'\n'"Argument: command ... - Callable. Required. Command to run."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="ffd716b7922cb0074e135ce841a832b800ed594b"
summary="Run \`command\`, upon failure run \`handler\` with an argument error"
summaryComputed="true"
usage="catchArgument handler command ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcatchArgument'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mhandler'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcommand ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mhandler      '$'\e''[[(value)]mFunction. Required. Failure command'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mcommand ...  '$'\e''[[(value)]mCallable. Required. Command to run.'$'\e''[[(reset)]m'$'\n'''$'\n''Run '$'\e''[[(code)]mcommand'$'\e''[[(reset)]m, upon failure run '$'\e''[[(code)]mhandler'$'\e''[[(reset)]m with an argument error'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: catchArgument handler command ...'$'\n'''$'\n''    handler      Function. Required. Failure command'$'\n''    command ...  Callable. Required. Command to run.'$'\n'''$'\n''Run command, upon failure run handler with an argument error'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
