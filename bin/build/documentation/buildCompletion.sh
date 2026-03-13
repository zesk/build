#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-13
# shellcheck disable=SC2034
argument="--quiet - Flag. Optional. Do not output any messages to stdout."$'\n'"--alias name - String. Optional. The name of the alias to create."$'\n'"--reload-alias name - String. Optional. The name of the alias which reloads Zesk Build. (source)"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="completion.sh"
description="Add completion handler for Zesk Build to Bash (EXPERIMENTAL)"$'\n'"This has the side effect of turning on the shell option \`expand_aliases\`"$'\n'""
file="bin/build/tools/completion.sh"
fn="buildCompletion"
foundNames=([0]="summary" [1]="argument" [2]="shell_option")
rawComment="Add completion handler for Zesk Build to Bash (EXPERIMENTAL)"$'\n'"Summary: Completion for Zesk Build (EXPERIMENTAL)"$'\n'"Argument: --quiet - Flag. Optional. Do not output any messages to stdout."$'\n'"Argument: --alias name - String. Optional. The name of the alias to create."$'\n'"Argument: --reload-alias name - String. Optional. The name of the alias which reloads Zesk Build. (source)"$'\n'"This has the side effect of turning on the shell option \`expand_aliases\`"$'\n'"Shell Option: +expand_aliases"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
shell_option="+expand_aliases"$'\n'""
sourceFile="bin/build/tools/completion.sh"
sourceHash="dce8c52456f1a10c5237225e490b0bcabff90676"
summary="Completion for Zesk Build (EXPERIMENTAL)"$'\n'""
usage="buildCompletion [ --quiet ] [ --alias name ] [ --reload-alias name ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildCompletion'$'\e''[0m '$'\e''[[(blue)]m[ --quiet ]'$'\e''[0m '$'\e''[[(blue)]m[ --alias name ]'$'\e''[0m '$'\e''[[(blue)]m[ --reload-alias name ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--quiet              '$'\e''[[(value)]mFlag. Optional. Do not output any messages to stdout.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--alias name         '$'\e''[[(value)]mString. Optional. The name of the alias to create.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--reload-alias name  '$'\e''[[(value)]mString. Optional. The name of the alias which reloads Zesk Build. (source)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help               '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Add completion handler for Zesk Build to Bash (EXPERIMENTAL)'$'\n''This has the side effect of turning on the shell option '$'\e''[[(code)]mexpand_aliases'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: buildCompletion [ --quiet ] [ --alias name ] [ --reload-alias name ] [ --help ]'$'\n'''$'\n''    --quiet              Flag. Optional. Do not output any messages to stdout.'$'\n''    --alias name         String. Optional. The name of the alias to create.'$'\n''    --reload-alias name  String. Optional. The name of the alias which reloads Zesk Build. (source)'$'\n''    --help               Flag. Optional. Display this help.'$'\n'''$'\n''Add completion handler for Zesk Build to Bash (EXPERIMENTAL)'$'\n''This has the side effect of turning on the shell option expand_aliases'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
