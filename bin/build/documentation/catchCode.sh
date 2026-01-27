#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/_sugar.sh"
argument="code - UnsignedInteger. Required. Exit code to return"$'\n'"handler - Function. Required. Failure command, passed remaining arguments and error code."$'\n'"command ... - Callable. Required. Command to run."$'\n'""
base="_sugar.sh"
description="Run \`command\`, handle failure with \`handler\` with \`code\` and \`command\` as error"$'\n'""
file="bin/build/tools/_sugar.sh"
foundNames=([0]="argument" [1]="requires")
rawComment="Run \`command\`, handle failure with \`handler\` with \`code\` and \`command\` as error"$'\n'"Argument: code - UnsignedInteger. Required. Exit code to return"$'\n'"Argument: handler - Function. Required. Failure command, passed remaining arguments and error code."$'\n'"Argument: command ... - Callable. Required. Command to run."$'\n'"Requires: isUnsignedInteger returnArgument isFunction isCallable"$'\n'""$'\n'""
requires="isUnsignedInteger returnArgument isFunction isCallable"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceModified="1769063211"
summary="Run \`command\`, handle failure with \`handler\` with \`code\` and \`command\`"
usage="catchCode code handler command ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcatchCode'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcode'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mhandler'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcommand ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mcode         '$'\e''[[(value)]mUnsignedInteger. Required. Exit code to return'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mhandler      '$'\e''[[(value)]mFunction. Required. Failure command, passed remaining arguments and error code.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mcommand ...  '$'\e''[[(value)]mCallable. Required. Command to run.'$'\e''[[(reset)]m'$'\n'''$'\n''Run '$'\e''[[(code)]mcommand'$'\e''[[(reset)]m, handle failure with '$'\e''[[(code)]mhandler'$'\e''[[(reset)]m with '$'\e''[[(code)]mcode'$'\e''[[(reset)]m and '$'\e''[[(code)]mcommand'$'\e''[[(reset)]m as error'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: catchCode code handler command ...'$'\n'''$'\n''    code         UnsignedInteger. Required. Exit code to return'$'\n''    handler      Function. Required. Failure command, passed remaining arguments and error code.'$'\n''    command ...  Callable. Required. Command to run.'$'\n'''$'\n''Run command, handle failure with handler with code and command as error'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.576
