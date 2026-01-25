#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/apt.sh"
argument="... - Arguments. Pass through arguments to \`apt-get\`"$'\n'""
base="apt.sh"
description="Run apt-get non-interactively"$'\n'""
exitCode="0"
file="bin/build/tools/apt.sh"
foundNames=([0]="argument")
rawComment="Run apt-get non-interactively"$'\n'"Argument: ... - Arguments. Pass through arguments to \`apt-get\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/apt.sh"
sourceModified="1769184734"
summary="Run apt-get non-interactively"
usage="aptNonInteractive [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]maptNonInteractive'$'\e''[0m '$'\e''[[blue]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m...  '$'\e''[[value]mArguments. Pass through arguments to '$'\e''[[code]mapt-get'$'\e''[[reset]m'$'\e''[[reset]m'$'\n'''$'\n''Run apt-get non-interactively'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: aptNonInteractive [ ... ]'$'\n'''$'\n''    ...  Arguments. Pass through arguments to apt-get'$'\n'''$'\n''Run apt-get non-interactively'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
