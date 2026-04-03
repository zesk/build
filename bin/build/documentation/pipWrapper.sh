#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="--bin binary - Executable. Optional. Binary for \`pip\`."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--debug - Flag. Optional. Show outputs to \`which\` and \`command -v\` for \`pip\`"$'\n'"... - Arguments. Optional. Arguments passed to \`pip\`"$'\n'""
base="python.sh"
description="Run pip whether it is installed as a module or as a binary"$'\n'""
file="bin/build/tools/python.sh"
fn="pipWrapper"
foundNames=([0]="argument")
rawComment="Run pip whether it is installed as a module or as a binary"$'\n'"Argument: --bin binary - Executable. Optional. Binary for \`pip\`."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --debug - Flag. Optional. Show outputs to \`which\` and \`command -v\` for \`pip\`"$'\n'"Argument: ... - Arguments. Optional. Arguments passed to \`pip\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/python.sh"
sourceHash="76ef1bab7d4e571a0f70f466c3650c365d9ea30f"
summary="Run pip whether it is installed as a module or"
summaryComputed="true"
usage="pipWrapper [ --bin binary ] [ --handler handler ] [ --help ] [ --debug ] [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpipWrapper'$'\e''[0m '$'\e''[[(blue)]m[ --bin binary ]'$'\e''[0m '$'\e''[[(blue)]m[ --handler handler ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --debug ]'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--bin binary       '$'\e''[[(value)]mExecutable. Optional. Binary for '$'\e''[[(code)]mpip'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--handler handler  '$'\e''[[(value)]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help             '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--debug            '$'\e''[[(value)]mFlag. Optional. Show outputs to '$'\e''[[(code)]mwhich'$'\e''[[(reset)]m and '$'\e''[[(code)]mcommand -v'$'\e''[[(reset)]m for '$'\e''[[(code)]mpip'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...                '$'\e''[[(value)]mArguments. Optional. Arguments passed to '$'\e''[[(code)]mpip'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n'''$'\n''Run pip whether it is installed as a module or as a binary'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: pipWrapper [ --bin binary ] [ --handler handler ] [ --help ] [ --debug ] [ ... ]'$'\n'''$'\n''    --bin binary       Executable. Optional. Binary for pip.'$'\n''    --handler handler  Function. Optional. Use this error handler instead of the default error handler.'$'\n''    --help             Flag. Optional. Display this help.'$'\n''    --debug            Flag. Optional. Show outputs to which and command -v for pip'$'\n''    ...                Arguments. Optional. Arguments passed to pip'$'\n'''$'\n''Run pip whether it is installed as a module or as a binary'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
