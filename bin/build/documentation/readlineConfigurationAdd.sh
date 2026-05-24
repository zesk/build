#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\nkeyStroke - String. Required.\naction - String. Required.\n'
base="readline.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Add configuration to `~/.inputrc` for a key binding\n\n'
descriptionLineCount="2"
example=$'readlineConfigurationAdd "\\ep" history-search-backward\n'
file="bin/build/tools/readline.sh"
fn="readlineConfigurationAdd"
fnMarker="readlineconfigurationadd"
foundNames=([0]="argument" [1]="example")
line="13"
rawComment=$'Add configuration to `~/.inputrc` for a key binding\nArgument: --help - Flag. Optional. Display this help.\nArgument: keyStroke - String. Required.\nArgument: action - String. Required.\nExample: readlineConfigurationAdd "\\ep" history-search-backward\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/readline.sh"
sourceHash="ea9774938e79ec8413d673a5a0be7dc2a19eb038"
sourceLine="13"
summary="Add configuration to \`~/.inputrc\` for a key binding"
summaryComputed="true"
usage="readlineConfigurationAdd [ --help ] keyStroke action"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreadlineConfigurationAdd'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mkeyStroke'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]maction'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mkeyStroke  '$'\e''[[(value)]mString. Required.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]maction     '$'\e''[[(value)]mString. Required.'$'\e''[[(reset)]m'$'\n'''$'\n''Add configuration to '$'\e''[[(code)]m~/.inputrc'$'\e''[[(reset)]m for a key binding'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''readlineConfigurationAdd "\ep" history-search-backward'
# shellcheck disable=SC2016
helpPlain='Usage: readlineConfigurationAdd [ --help ] keyStroke action'$'\n'''$'\n''    --help     Flag. Optional. Display this help.'$'\n''    keyStroke  String. Required.'$'\n''    action     String. Required.'$'\n'''$'\n''Add configuration to ~/.inputrc for a key binding'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''readlineConfigurationAdd "\ep" history-search-backward'
documentationPath="documentation/source/tools/readline.md"
