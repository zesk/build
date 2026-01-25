#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/completion.sh"
argument="--quiet - Flag. Optional. Do not output any messages to stdout."$'\n'"--alias name - String. Optional. The name of the alias to create."$'\n'"--reload-alias name - String. Optional. The name of the alias which reloads Zesk Build. (source)"$'\n'""
base="completion.sh"
description="Add completion handler for Zesk Build to Bash"$'\n'"This has the side effect of turning on the shell option \`expand_aliases\`"$'\n'""
exitCode="0"
file="bin/build/tools/completion.sh"
foundNames=([0]="argument" [1]="shell_option")
rawComment="Add completion handler for Zesk Build to Bash"$'\n'"Argument: --quiet - Flag. Optional. Do not output any messages to stdout."$'\n'"Argument: --alias name - String. Optional. The name of the alias to create."$'\n'"Argument: --reload-alias name - String. Optional. The name of the alias which reloads Zesk Build. (source)"$'\n'"This has the side effect of turning on the shell option \`expand_aliases\`"$'\n'"Shell Option: +expand_aliases"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
shell_option="+expand_aliases"$'\n'""
sourceModified="1769063211"
summary="Add completion handler for Zesk Build to Bash"
usage="buildCompletion [ --quiet ] [ --alias name ] [ --reload-alias name ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mbuildCompletion'$'\e''[0m '$'\e''[[blue]m[ --quiet ]'$'\e''[0m '$'\e''[[blue]m[ --alias name ]'$'\e''[0m '$'\e''[[blue]m[ --reload-alias name ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--quiet              '$'\e''[[value]mFlag. Optional. Do not output any messages to stdout.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--alias name         '$'\e''[[value]mString. Optional. The name of the alias to create.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--reload-alias name  '$'\e''[[value]mString. Optional. The name of the alias which reloads Zesk Build. (source)'$'\e''[[reset]m'$'\n'''$'\n''Add completion handler for Zesk Build to Bash'$'\n''This has the side effect of turning on the shell option '$'\e''[[code]mexpand_aliases'$'\e''[[reset]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: buildCompletion [ --quiet ] [ --alias name ] [ --reload-alias name ]'$'\n'''$'\n''    --quiet              Flag. Optional. Do not output any messages to stdout.'$'\n''    --alias name         String. Optional. The name of the alias to create.'$'\n''    --reload-alias name  String. Optional. The name of the alias which reloads Zesk Build. (source)'$'\n'''$'\n''Add completion handler for Zesk Build to Bash'$'\n''This has the side effect of turning on the shell option expand_aliases'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
