#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="markdown.sh"
description="Argument: indexFile ... - File. Required. One or more index files to check."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Displays any markdown files next to the given index file which are not found within the index file as links."$'\n'""
file="bin/build/tools/markdown.sh"
foundNames=()
rawComment="Argument: indexFile ... - File. Required. One or more index files to check."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Displays any markdown files next to the given index file which are not found within the index file as links."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/markdown.sh"
sourceHash="54381ddb863dfa5c768baef2174a69a41e3ccf69"
summary="Argument: indexFile ... - File. Required. One or more index"
usage="markdownCheckIndex"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmarkdownCheckIndex'$'\e''[0m'$'\n'''$'\n''Argument: indexFile ... - File. Required. One or more index files to check.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.'$'\n''Displays any markdown files next to the given index file which are not found within the index file as links.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: markdownCheckIndex'$'\n'''$'\n''Argument: indexFile ... - File. Required. One or more index files to check.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.'$'\n''Displays any markdown files next to the given index file which are not found within the index file as links.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.435
