#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-05
# shellcheck disable=SC2034
argument="handler - String. Required. Failure command"$'\n'"command ... - Callable. Required. Command to run."$'\n'"... - Arguments. Optional. Arguments to \`command\`"$'\n'""
base="_sugar.sh"
description="Run \`command\`, upon failure run \`handler\` with an environment error"$'\n'""
file="bin/build/tools/_sugar.sh"
fn="catchEnvironment"
foundNames=([0]="argument" [1]="requires")
rawComment="Run \`command\`, upon failure run \`handler\` with an environment error"$'\n'"Argument: handler - String. Required. Failure command"$'\n'"Argument: command ... - Callable. Required. Command to run."$'\n'"Argument: ... - Arguments. Optional. Arguments to \`command\`"$'\n'"Requires: catchCode"$'\n'""$'\n'""
requires="catchCode"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="ad64f1104aaf90acd5d1ea92a123fe7fc851a0b1"
summary="Run \`command\`, upon failure run \`handler\` with an environment error"
summaryComputed="true"
usage="catchEnvironment handler command ... [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcatchEnvironment'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mhandler'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcommand ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mhandler      '$'\e''[[(value)]mString. Required. Failure command'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mcommand ...  '$'\e''[[(value)]mCallable. Required. Command to run.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...          '$'\e''[[(value)]mArguments. Optional. Arguments to '$'\e''[[(code)]mcommand'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n'''$'\n''Run '$'\e''[[(code)]mcommand'$'\e''[[(reset)]m, upon failure run '$'\e''[[(code)]mhandler'$'\e''[[(reset)]m with an environment error'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: catchEnvironment handler command ... [ ... ]'$'\n'''$'\n''    handler      String. Required. Failure command'$'\n''    command ...  Callable. Required. Command to run.'$'\n''    ...          Arguments. Optional. Arguments to command'$'\n'''$'\n''Run command, upon failure run handler with an environment error'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
