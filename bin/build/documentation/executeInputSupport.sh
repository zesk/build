#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-09
# shellcheck disable=SC2034
argument="executor ... -- - The command to run on each line of input or on each additional argument. Arguments to prefix the final variable argument can be supplied prior to an initial \`--\`."$'\n'"-- - Alone after the executor forces \`stdin\` to be ignored. The \`--\` flag is also removed from the arguments passed to the executor."$'\n'"... - Any additional arguments are passed directly to the executor"$'\n'""
base="sugar.sh"
description="Support arguments and stdin as arguments to an executor"$'\n'""
file="bin/build/tools/sugar.sh"
foundNames=([0]="argument")
rawComment="Support arguments and stdin as arguments to an executor"$'\n'"Argument: executor ... -- - The command to run on each line of input or on each additional argument. Arguments to prefix the final variable argument can be supplied prior to an initial \`--\`."$'\n'"Argument: -- - Alone after the executor forces \`stdin\` to be ignored. The \`--\` flag is also removed from the arguments passed to the executor."$'\n'"Argument: ... - Any additional arguments are passed directly to the executor"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sugar.sh"
sourceHash="6ee10abbe0bbfcb62e1afb931a286aa3b9ce8c92"
summary="Support arguments and stdin as arguments to an executor"
summaryComputed="true"
usage="executeInputSupport [ executor ... -- ] [ -- ] [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mexecuteInputSupport'$'\e''[0m '$'\e''[[(blue)]m[ executor ... -- ]'$'\e''[0m '$'\e''[[(blue)]m[ -- ]'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mexecutor ... --  '$'\e''[[(value)]mThe command to run on each line of input or on each additional argument. Arguments to prefix the final variable argument can be supplied prior to an initial '$'\e''[[(code)]m--'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--               '$'\e''[[(value)]mAlone after the executor forces '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m to be ignored. The '$'\e''[[(code)]m--'$'\e''[[(reset)]m flag is also removed from the arguments passed to the executor.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...              '$'\e''[[(value)]mAny additional arguments are passed directly to the executor'$'\e''[[(reset)]m'$'\n'''$'\n''Support arguments and stdin as arguments to an executor'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: executeInputSupport [ executor ... -- ] [ -- ] [ ... ]'$'\n'''$'\n''    executor ... --  The command to run on each line of input or on each additional argument. Arguments to prefix the final variable argument can be supplied prior to an initial --.'$'\n''    --               Alone after the executor forces stdin to be ignored. The -- flag is also removed from the arguments passed to the executor.'$'\n''    ...              Any additional arguments are passed directly to the executor'$'\n'''$'\n''Support arguments and stdin as arguments to an executor'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
