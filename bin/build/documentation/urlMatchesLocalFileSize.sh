#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="web.sh"
description="Compare a remote file size with a local file size"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: url - URL. Required. URL to check."$'\n'"Argument: file - File. Required. File to compare."$'\n'""
file="bin/build/tools/web.sh"
foundNames=()
rawComment="Compare a remote file size with a local file size"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: url - URL. Required. URL to check."$'\n'"Argument: file - File. Required. File to compare."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/web.sh"
sourceHash="1fcdcd2f89593d5b69e5f6e898f0f7281cff2e61"
summary="Compare a remote file size with a local file size"
usage="urlMatchesLocalFileSize"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]murlMatchesLocalFileSize'$'\e''[0m'$'\n'''$'\n''Compare a remote file size with a local file size'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: url - URL. Required. URL to check.'$'\n''Argument: file - File. Required. File to compare.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: urlMatchesLocalFileSize'$'\n'''$'\n''Compare a remote file size with a local file size'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: url - URL. Required. URL to check.'$'\n''Argument: file - File. Required. File to compare.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.489
