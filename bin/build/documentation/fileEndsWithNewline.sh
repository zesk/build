#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="text.sh"
description="Does a file end with a newline or is empty?"$'\n'"Typically used to determine if a newline is needed before appending a file."$'\n'"Argument: file ... - File. Required. File to check if the last character is a newline."$'\n'"Return Code: 0 - All files ends with a newline"$'\n'"Return Code: 1 - One or more files ends with a non-newline"$'\n'"Test: testFileEndsWithNewline"$'\n'""
file="bin/build/tools/text.sh"
foundNames=()
rawComment="Does a file end with a newline or is empty?"$'\n'"Typically used to determine if a newline is needed before appending a file."$'\n'"Argument: file ... - File. Required. File to check if the last character is a newline."$'\n'"Return Code: 0 - All files ends with a newline"$'\n'"Return Code: 1 - One or more files ends with a non-newline"$'\n'"Test: testFileEndsWithNewline"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Does a file end with a newline or is empty?"
usage="fileEndsWithNewline"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileEndsWithNewline'$'\e''[0m'$'\n'''$'\n''Does a file end with a newline or is empty?'$'\n''Typically used to determine if a newline is needed before appending a file.'$'\n''Argument: file ... - File. Required. File to check if the last character is a newline.'$'\n''Return Code: 0 - All files ends with a newline'$'\n''Return Code: 1 - One or more files ends with a non-newline'$'\n''Test: testFileEndsWithNewline'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileEndsWithNewline'$'\n'''$'\n''Does a file end with a newline or is empty?'$'\n''Typically used to determine if a newline is needed before appending a file.'$'\n''Argument: file ... - File. Required. File to check if the last character is a newline.'$'\n''Return Code: 0 - All files ends with a newline'$'\n''Return Code: 1 - One or more files ends with a non-newline'$'\n''Test: testFileEndsWithNewline'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.435
