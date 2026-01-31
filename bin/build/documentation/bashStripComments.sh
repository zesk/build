#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="bash.sh"
description="Summary: Pipe to strip comments from a bash file"$'\n'"Removes literally any line which begins with zero or more whitespace characters and then a \`#\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""
file="bin/build/tools/bash.sh"
foundNames=()
rawComment="Summary: Pipe to strip comments from a bash file"$'\n'"Removes literally any line which begins with zero or more whitespace characters and then a \`#\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="c27f4788f9122cfbb778e66b32894938a8ca0ace"
summary="Summary: Pipe to strip comments from a bash file"
usage="bashStripComments"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashStripComments'$'\e''[0m'$'\n'''$'\n''Summary: Pipe to strip comments from a bash file'$'\n''Removes literally any line which begins with zero or more whitespace characters and then a '$'\e''[[(code)]m#'$'\e''[[(reset)]m.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashStripComments'$'\n'''$'\n''Summary: Pipe to strip comments from a bash file'$'\n''Removes literally any line which begins with zero or more whitespace characters and then a #.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.433
