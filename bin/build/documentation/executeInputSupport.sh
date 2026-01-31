#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="sugar.sh"
description="Support arguments and stdin as arguments to an executor"$'\n'"Argument: executor ... -- - The command to run on each line of input or on each additional argument. Arguments to prefix the final variable argument can be supplied prior to an initial \`--\`."$'\n'"Argument: -- - Alone after the executor forces \`stdin\` to be ignored. The \`--\` flag is also removed from the arguments passed to the executor."$'\n'"Argument: ... - Any additional arguments are passed directly to the executor"$'\n'""
file="bin/build/tools/sugar.sh"
foundNames=()
rawComment="Support arguments and stdin as arguments to an executor"$'\n'"Argument: executor ... -- - The command to run on each line of input or on each additional argument. Arguments to prefix the final variable argument can be supplied prior to an initial \`--\`."$'\n'"Argument: -- - Alone after the executor forces \`stdin\` to be ignored. The \`--\` flag is also removed from the arguments passed to the executor."$'\n'"Argument: ... - Any additional arguments are passed directly to the executor"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sugar.sh"
sourceHash="661eda875f626c8591389d4c5e16fe409793c6ba"
summary="Support arguments and stdin as arguments to an executor"
usage="executeInputSupport"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mexecuteInputSupport'$'\e''[0m'$'\n'''$'\n''Support arguments and stdin as arguments to an executor'$'\n''Argument: executor ... -- - The command to run on each line of input or on each additional argument. Arguments to prefix the final variable argument can be supplied prior to an initial '$'\e''[[(code)]m--'$'\e''[[(reset)]m.'$'\n''Argument: -- - Alone after the executor forces '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m to be ignored. The '$'\e''[[(code)]m--'$'\e''[[(reset)]m flag is also removed from the arguments passed to the executor.'$'\n''Argument: ... - Any additional arguments are passed directly to the executor'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: executeInputSupport'$'\n'''$'\n''Support arguments and stdin as arguments to an executor'$'\n''Argument: executor ... -- - The command to run on each line of input or on each additional argument. Arguments to prefix the final variable argument can be supplied prior to an initial --.'$'\n''Argument: -- - Alone after the executor forces stdin to be ignored. The -- flag is also removed from the arguments passed to the executor.'$'\n''Argument: ... - Any additional arguments are passed directly to the executor'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.451
