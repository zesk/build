#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="python.sh"
description="Run pip whether it is installed as a module or as a binary"$'\n'"Argument: --bin binary - Executable. Optional. Binary for \`pip\`."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --debug - Flag. Optional. Show outputs to \`which\` and \`command -v\` for \`pip\`"$'\n'"Argument: ... - Arguments. Optional. Arguments passed to \`pip\`"$'\n'""
file="bin/build/tools/python.sh"
foundNames=()
rawComment="Run pip whether it is installed as a module or as a binary"$'\n'"Argument: --bin binary - Executable. Optional. Binary for \`pip\`."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --debug - Flag. Optional. Show outputs to \`which\` and \`command -v\` for \`pip\`"$'\n'"Argument: ... - Arguments. Optional. Arguments passed to \`pip\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/python.sh"
sourceHash="c1e4cce2b3109ebc21697635fdb1e0bfb5cf244a"
summary="Run pip whether it is installed as a module or"
usage="pipWrapper"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpipWrapper'$'\e''[0m'$'\n'''$'\n''Run pip whether it is installed as a module or as a binary'$'\n''Argument: --bin binary - Executable. Optional. Binary for '$'\e''[[(code)]mpip'$'\e''[[(reset)]m.'$'\n''Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --debug - Flag. Optional. Show outputs to '$'\e''[[(code)]mwhich'$'\e''[[(reset)]m and '$'\e''[[(code)]mcommand -v'$'\e''[[(reset)]m for '$'\e''[[(code)]mpip'$'\e''[[(reset)]m'$'\n''Argument: ... - Arguments. Optional. Arguments passed to '$'\e''[[(code)]mpip'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: pipWrapper'$'\n'''$'\n''Run pip whether it is installed as a module or as a binary'$'\n''Argument: --bin binary - Executable. Optional. Binary for pip.'$'\n''Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --debug - Flag. Optional. Show outputs to which and command -v for pip'$'\n''Argument: ... - Arguments. Optional. Arguments passed to pip'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.504
