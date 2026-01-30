#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-29
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"keyStroke - String. Required."$'\n'"action - String. Required."$'\n'""
base="readline.sh"
description="Add configuration to \`~/.inputrc\` for a key binding"$'\n'""
example="readlineConfigurationAdd \"\\ep\" history-search-backward"$'\n'""
file="bin/build/tools/readline.sh"
foundNames=([0]="argument" [1]="example")
rawComment="Add configuration to \`~/.inputrc\` for a key binding"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: keyStroke - String. Required."$'\n'"Argument: action - String. Required."$'\n'"Example: readlineConfigurationAdd \"\\ep\" history-search-backward"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/readline.sh"
sourceHash="4a1bfe4dda009453b217dd57d698bd72c66a1b79"
summary="Add configuration to \`~/.inputrc\` for a key binding"
usage="readlineConfigurationAdd [ --help ] keyStroke action"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreadlineConfigurationAdd'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mkeyStroke'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]maction'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mkeyStroke  '$'\e''[[(value)]mString. Required.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]maction     '$'\e''[[(value)]mString. Required.'$'\e''[[(reset)]m'$'\n'''$'\n''Add configuration to '$'\e''[[(code)]m~/.inputrc'$'\e''[[(reset)]m for a key binding'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''readlineConfigurationAdd "\ep" history-search-backward'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: readlineConfigurationAdd [ --help ] keyStroke action'$'\n'''$'\n''    --help     Flag. Optional. Display this help.'$'\n''    keyStroke  String. Required.'$'\n''    action     String. Required.'$'\n'''$'\n''Add configuration to ~/.inputrc for a key binding'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''readlineConfigurationAdd "\ep" history-search-backward'$'\n'''
# elapsed 0.555
