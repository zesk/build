#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/application.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"directory - Directory. Optional. Set the application home to this directory."$'\n'"--go - Flag. Optional. Change to the current saved application home directory."$'\n'""
base="application.sh"
description="Set, or cd to current application home directory."$'\n'""
exitCode="0"
file="bin/build/tools/application.sh"
foundNames=([0]="argument")
rawComment="Set, or cd to current application home directory."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: directory - Directory. Optional. Set the application home to this directory."$'\n'"Argument: --go - Flag. Optional. Change to the current saved application home directory."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/application.sh"
sourceModified="1769063211"
summary="Set, or cd to current application home directory."
usage="applicationHome [ --help ] [ directory ] [ --go ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mapplicationHome'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m '$'\e''[[blue]m[ directory ]'$'\e''[0m '$'\e''[[blue]m[ --go ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--help     '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mdirectory  '$'\e''[[value]mDirectory. Optional. Set the application home to this directory.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--go       '$'\e''[[value]mFlag. Optional. Change to the current saved application home directory.'$'\e''[[reset]m'$'\n'''$'\n''Set, or cd to current application home directory.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: applicationHome [ --help ] [ directory ] [ --go ]'$'\n'''$'\n''    --help     Flag. Optional. Display this help.'$'\n''    directory  Directory. Optional. Set the application home to this directory.'$'\n''    --go       Flag. Optional. Change to the current saved application home directory.'$'\n'''$'\n''Set, or cd to current application home directory.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
