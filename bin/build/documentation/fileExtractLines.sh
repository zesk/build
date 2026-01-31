#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="text.sh"
description="Extract a range of lines from a file"$'\n'"Argument: startLine - Integer. Required. Starting line number."$'\n'"Argument: endLine - Integer. Required. Ending line number."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdin: Reads lines until EOF"$'\n'"stdout: Outputs the selected lines only"$'\n'""
file="bin/build/tools/text.sh"
foundNames=()
rawComment="Extract a range of lines from a file"$'\n'"Argument: startLine - Integer. Required. Starting line number."$'\n'"Argument: endLine - Integer. Required. Ending line number."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdin: Reads lines until EOF"$'\n'"stdout: Outputs the selected lines only"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Extract a range of lines from a file"
usage="fileExtractLines"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileExtractLines'$'\e''[0m'$'\n'''$'\n''Extract a range of lines from a file'$'\n''Argument: startLine - Integer. Required. Starting line number.'$'\n''Argument: endLine - Integer. Required. Ending line number.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''stdin: Reads lines until EOF'$'\n''stdout: Outputs the selected lines only'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileExtractLines'$'\n'''$'\n''Extract a range of lines from a file'$'\n''Argument: startLine - Integer. Required. Starting line number.'$'\n''Argument: endLine - Integer. Required. Ending line number.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''stdin: Reads lines until EOF'$'\n''stdout: Outputs the selected lines only'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.477
