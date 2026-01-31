#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="bash.sh"
description="Argument: script - File. Required. Bash script to fetch requires tokens from."$'\n'"Gets a list of the \`Requires:\` comments in a bash file"$'\n'"Returns a unique list of tokens"$'\n'""
file="bin/build/tools/bash.sh"
foundNames=()
rawComment="Argument: script - File. Required. Bash script to fetch requires tokens from."$'\n'"Gets a list of the \`Requires:\` comments in a bash file"$'\n'"Returns a unique list of tokens"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="c27f4788f9122cfbb778e66b32894938a8ca0ace"
summary="Argument: script - File. Required. Bash script to fetch requires"
usage="bashGetRequires"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashGetRequires'$'\e''[0m'$'\n'''$'\n''Argument: script - File. Required. Bash script to fetch requires tokens from.'$'\n''Gets a list of the '$'\e''[[(code)]mRequires:'$'\e''[[(reset)]m comments in a bash file'$'\n''Returns a unique list of tokens'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashGetRequires'$'\n'''$'\n''Argument: script - File. Required. Bash script to fetch requires tokens from.'$'\n''Gets a list of the Requires: comments in a bash file'$'\n''Returns a unique list of tokens'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.473
