#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="_sugar.sh"
description="Run \`command\`, upon failure run \`handler\` with an environment error"$'\n'"Argument: handler - Function. Required. Failure command"$'\n'"Argument: command ... - Callable. Required. Command to run."$'\n'""
file="bin/build/tools/_sugar.sh"
foundNames=()
rawComment="Run \`command\`, upon failure run \`handler\` with an environment error"$'\n'"Argument: handler - Function. Required. Failure command"$'\n'"Argument: command ... - Callable. Required. Command to run."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="4bce6d8a22071b1c44a64aadb33672fc47a840f1"
summary="Run \`command\`, upon failure run \`handler\` with an environment error"
usage="catchEnvironment"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcatchEnvironment'$'\e''[0m'$'\n'''$'\n''Run '$'\e''[[(code)]mcommand'$'\e''[[(reset)]m, upon failure run '$'\e''[[(code)]mhandler'$'\e''[[(reset)]m with an environment error'$'\n''Argument: handler - Function. Required. Failure command'$'\n''Argument: command ... - Callable. Required. Command to run.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: catchEnvironment'$'\n'''$'\n''Run command, upon failure run handler with an environment error'$'\n''Argument: handler - Function. Required. Failure command'$'\n''Argument: command ... - Callable. Required. Command to run.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.474
