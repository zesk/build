#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="sugar.sh"
description="Run \`handler\` with an environment error"$'\n'"Argument: handler - Function. Required. Failure command"$'\n'"Argument: quietLog - File. Required. File to output log to temporarily for this command. If \`quietLog\` is \`-\` then creates a temporary file for the command which is deleted automatically."$'\n'"Argument: command ... - Callable. Required. Thing to run and append output to \`quietLog\`."$'\n'"Requires: isFunction returnArgument debuggingStack throwEnvironment"$'\n'""
file="bin/build/tools/sugar.sh"
foundNames=()
rawComment="Run \`handler\` with an environment error"$'\n'"Argument: handler - Function. Required. Failure command"$'\n'"Argument: quietLog - File. Required. File to output log to temporarily for this command. If \`quietLog\` is \`-\` then creates a temporary file for the command which is deleted automatically."$'\n'"Argument: command ... - Callable. Required. Thing to run and append output to \`quietLog\`."$'\n'"Requires: isFunction returnArgument debuggingStack throwEnvironment"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sugar.sh"
sourceHash="661eda875f626c8591389d4c5e16fe409793c6ba"
summary="Run \`handler\` with an environment error"
usage="catchEnvironmentQuiet"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcatchEnvironmentQuiet'$'\e''[0m'$'\n'''$'\n''Run '$'\e''[[(code)]mhandler'$'\e''[[(reset)]m with an environment error'$'\n''Argument: handler - Function. Required. Failure command'$'\n''Argument: quietLog - File. Required. File to output log to temporarily for this command. If '$'\e''[[(code)]mquietLog'$'\e''[[(reset)]m is '$'\e''[[(code)]m-'$'\e''[[(reset)]m then creates a temporary file for the command which is deleted automatically.'$'\n''Argument: command ... - Callable. Required. Thing to run and append output to '$'\e''[[(code)]mquietLog'$'\e''[[(reset)]m.'$'\n''Requires: isFunction returnArgument debuggingStack throwEnvironment'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: catchEnvironmentQuiet'$'\n'''$'\n''Run handler with an environment error'$'\n''Argument: handler - Function. Required. Failure command'$'\n''Argument: quietLog - File. Required. File to output log to temporarily for this command. If quietLog is - then creates a temporary file for the command which is deleted automatically.'$'\n''Argument: command ... - Callable. Required. Thing to run and append output to quietLog.'$'\n''Requires: isFunction returnArgument debuggingStack throwEnvironment'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.505
