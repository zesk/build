#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="_sugar.sh"
description="Run \`command\`, handle failure with \`handler\` with \`code\` and \`command\` as error"$'\n'"Argument: code - UnsignedInteger. Required. Exit code to return"$'\n'"Argument: handler - Function. Required. Failure command, passed remaining arguments and error code."$'\n'"Argument: command ... - Callable. Required. Command to run."$'\n'"Requires: isUnsignedInteger returnArgument isFunction isCallable"$'\n'""
file="bin/build/tools/_sugar.sh"
foundNames=()
rawComment="Run \`command\`, handle failure with \`handler\` with \`code\` and \`command\` as error"$'\n'"Argument: code - UnsignedInteger. Required. Exit code to return"$'\n'"Argument: handler - Function. Required. Failure command, passed remaining arguments and error code."$'\n'"Argument: command ... - Callable. Required. Command to run."$'\n'"Requires: isUnsignedInteger returnArgument isFunction isCallable"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="4bce6d8a22071b1c44a64aadb33672fc47a840f1"
summary="Run \`command\`, handle failure with \`handler\` with \`code\` and \`command\`"
usage="catchCode"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcatchCode'$'\e''[0m'$'\n'''$'\n''Run '$'\e''[[(code)]mcommand'$'\e''[[(reset)]m, handle failure with '$'\e''[[(code)]mhandler'$'\e''[[(reset)]m with '$'\e''[[(code)]mcode'$'\e''[[(reset)]m and '$'\e''[[(code)]mcommand'$'\e''[[(reset)]m as error'$'\n''Argument: code - UnsignedInteger. Required. Exit code to return'$'\n''Argument: handler - Function. Required. Failure command, passed remaining arguments and error code.'$'\n''Argument: command ... - Callable. Required. Command to run.'$'\n''Requires: isUnsignedInteger returnArgument isFunction isCallable'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: catchCode'$'\n'''$'\n''Run command, handle failure with handler with code and command as error'$'\n''Argument: code - UnsignedInteger. Required. Exit code to return'$'\n''Argument: handler - Function. Required. Failure command, passed remaining arguments and error code.'$'\n''Argument: command ... - Callable. Required. Command to run.'$'\n''Requires: isUnsignedInteger returnArgument isFunction isCallable'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.46
