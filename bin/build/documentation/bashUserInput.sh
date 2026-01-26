#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/prompt.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"... - Arguments. Optional. Identical arguments to \`read\` (but includes \`-r\`)"$'\n'""
base="prompt.sh"
description="Prompt the user properly honoring any attached console."$'\n'"Arguments are the same as \`read\`, except:"$'\n'"\`-r\` is implied and does not need to be specified"$'\n'""
file="bin/build/tools/prompt.sh"
foundNames=([0]="see" [1]="argument")
rawComment="Prompt the user properly honoring any attached console."$'\n'"Arguments are the same as \`read\`, except:"$'\n'"\`-r\` is implied and does not need to be specified"$'\n'"See: read"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: ... - Arguments. Optional. Identical arguments to \`read\` (but includes \`-r\`)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="read"$'\n'""
sourceFile="bin/build/tools/prompt.sh"
sourceModified="1769063211"
summary="Prompt the user properly honoring any attached console."
usage="bashUserInput [ --help ] [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashUserInput'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...     '$'\e''[[(value)]mArguments. Optional. Identical arguments to '$'\e''[[(code)]mread'$'\e''[[(reset)]m (but includes '$'\e''[[(code)]m-r'$'\e''[[(reset)]m)'$'\e''[[(reset)]m'$'\n'''$'\n''Prompt the user properly honoring any attached console.'$'\n''Arguments are the same as '$'\e''[[(code)]mread'$'\e''[[(reset)]m, except:'$'\n'''$'\e''[[(code)]m-r'$'\e''[[(reset)]m is implied and does not need to be specified'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashUserInput [ --help ] [ ... ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    ...     Arguments. Optional. Identical arguments to read (but includes -r)'$'\n'''$'\n''Prompt the user properly honoring any attached console.'$'\n''Arguments are the same as read, except:'$'\n''-r is implied and does not need to be specified'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.501
