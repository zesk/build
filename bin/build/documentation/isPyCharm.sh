#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/vendor.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="vendor.sh"
description="Are we within the JetBrains PyCharm terminal?"$'\n'""
exitCode="0"
file="bin/build/tools/vendor.sh"
foundNames=([0]="argument" [1]="return_code" [2]="see")
rawComment="Are we within the JetBrains PyCharm terminal?"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - within the PyCharm terminal"$'\n'"Return Code: 1 - not within the PyCharm terminal AFAIK"$'\n'"See: contextOpen"$'\n'""$'\n'""
return_code="0 - within the PyCharm terminal"$'\n'"1 - not within the PyCharm terminal AFAIK"$'\n'""
see="contextOpen"$'\n'""
sourceModified="1769063211"
summary="Are we within the JetBrains PyCharm terminal?"
usage="isPyCharm [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]misPyCharm'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--help  '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n'''$'\n''Are we within the JetBrains PyCharm terminal?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - within the PyCharm terminal'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - not within the PyCharm terminal AFAIK'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isPyCharm [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Are we within the JetBrains PyCharm terminal?'$'\n'''$'\n''Return codes:'$'\n''- 0 - within the PyCharm terminal'$'\n''- 1 - not within the PyCharm terminal AFAIK'$'\n'''
