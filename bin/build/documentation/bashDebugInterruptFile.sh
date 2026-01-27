#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/debug.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--error - Flag. Add ERR trap."$'\n'"--interrupt - Flag. Add INT trap."$'\n'""
base="debug.sh"
description="Adds a trap to capture the debugging stack on interrupt"$'\n'"Use this in a bash script which runs forever or runs in an infinite loop to"$'\n'"determine where the problem or loop exists."$'\n'""
file="bin/build/tools/debug.sh"
foundNames=([0]="requires" [1]="argument")
rawComment="Adds a trap to capture the debugging stack on interrupt"$'\n'"Use this in a bash script which runs forever or runs in an infinite loop to"$'\n'"determine where the problem or loop exists."$'\n'"Requires: trap"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --error - Flag. Add ERR trap."$'\n'"Argument: --interrupt - Flag. Add INT trap."$'\n'""$'\n'""
requires="trap"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceModified="1769208503"
summary="Adds a trap to capture the debugging stack on interrupt"
usage="bashDebugInterruptFile [ --help ] [ --error ] [ --interrupt ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashDebugInterruptFile'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --error ]'$'\e''[0m '$'\e''[[(blue)]m[ --interrupt ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help       '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--error      '$'\e''[[(value)]mFlag. Add ERR trap.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--interrupt  '$'\e''[[(value)]mFlag. Add INT trap.'$'\e''[[(reset)]m'$'\n'''$'\n''Adds a trap to capture the debugging stack on interrupt'$'\n''Use this in a bash script which runs forever or runs in an infinite loop to'$'\n''determine where the problem or loop exists.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashDebugInterruptFile [ --help ] [ --error ] [ --interrupt ]'$'\n'''$'\n''    --help       Flag. Optional. Display this help.'$'\n''    --error      Flag. Add ERR trap.'$'\n''    --interrupt  Flag. Add INT trap.'$'\n'''$'\n''Adds a trap to capture the debugging stack on interrupt'$'\n''Use this in a bash script which runs forever or runs in an infinite loop to'$'\n''determine where the problem or loop exists.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.636
