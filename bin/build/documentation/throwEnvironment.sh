#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/_sugar.sh"
argument="handler - Function. Required. Failure command"$'\n'"message ... - String. Optional. Error message to display."$'\n'""
base="_sugar.sh"
description="Run \`handler\` with an environment error"$'\n'""
file="bin/build/tools/_sugar.sh"
foundNames=([0]="argument")
rawComment="Run \`handler\` with an environment error"$'\n'"Argument: handler - Function. Required. Failure command"$'\n'"Argument: message ... - String. Optional. Error message to display."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceModified="1769063211"
summary="Run \`handler\` with an environment error"
usage="throwEnvironment handler [ message ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mthrowEnvironment'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mhandler'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ message ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mhandler      '$'\e''[[(value)]mFunction. Required. Failure command'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mmessage ...  '$'\e''[[(value)]mString. Optional. Error message to display.'$'\e''[[(reset)]m'$'\n'''$'\n''Run '$'\e''[[(code)]mhandler'$'\e''[[(reset)]m with an environment error'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: throwEnvironment handler [ message ... ]'$'\n'''$'\n''    handler      Function. Required. Failure command'$'\n''    message ...  String. Optional. Error message to display.'$'\n'''$'\n''Run handler with an environment error'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.606
