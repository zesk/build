#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="readline.sh"
description="Add configuration to \`~/.inputrc\` for a key binding"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: keyStroke - String. Required."$'\n'"Argument: action - String. Required."$'\n'"Example: readlineConfigurationAdd \"\\ep\" history-search-backward"$'\n'""
file="bin/build/tools/readline.sh"
foundNames=()
rawComment="Add configuration to \`~/.inputrc\` for a key binding"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: keyStroke - String. Required."$'\n'"Argument: action - String. Required."$'\n'"Example: readlineConfigurationAdd \"\\ep\" history-search-backward"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/readline.sh"
sourceHash="4a1bfe4dda009453b217dd57d698bd72c66a1b79"
summary="Add configuration to \`~/.inputrc\` for a key binding"
usage="readlineConfigurationAdd"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreadlineConfigurationAdd'$'\e''[0m'$'\n'''$'\n''Add configuration to '$'\e''[[(code)]m~/.inputrc'$'\e''[[(reset)]m for a key binding'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: keyStroke - String. Required.'$'\n''Argument: action - String. Required.'$'\n''Example: readlineConfigurationAdd "\ep" history-search-backward'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: readlineConfigurationAdd'$'\n'''$'\n''Add configuration to ~/.inputrc for a key binding'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: keyStroke - String. Required.'$'\n''Argument: action - String. Required.'$'\n''Example: readlineConfigurationAdd "\ep" history-search-backward'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.534
