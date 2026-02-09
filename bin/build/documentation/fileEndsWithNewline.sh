#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-09
# shellcheck disable=SC2034
argument="file ... - File. Required. File to check if the last character is a newline."$'\n'""
base="text.sh"
description="Does a file end with a newline or is empty?"$'\n'"Typically used to determine if a newline is needed before appending a file."$'\n'""
file="bin/build/tools/text.sh"
foundNames=([0]="argument" [1]="return_code" [2]="test")
rawComment="Does a file end with a newline or is empty?"$'\n'"Typically used to determine if a newline is needed before appending a file."$'\n'"Argument: file ... - File. Required. File to check if the last character is a newline."$'\n'"Return Code: 0 - All files ends with a newline"$'\n'"Return Code: 1 - One or more files ends with a non-newline"$'\n'"Test: testFileEndsWithNewline"$'\n'""$'\n'""
return_code="0 - All files ends with a newline"$'\n'"1 - One or more files ends with a non-newline"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="c20cbacc0c65838645f2e404358fc35b5b38e188"
summary="Does a file end with a newline or is empty?"
summaryComputed="true"
test="testFileEndsWithNewline"$'\n'""
usage="fileEndsWithNewline file ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileEndsWithNewline'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfile ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mfile ...  '$'\e''[[(value)]mFile. Required. File to check if the last character is a newline.'$'\e''[[(reset)]m'$'\n'''$'\n''Does a file end with a newline or is empty?'$'\n''Typically used to determine if a newline is needed before appending a file.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All files ends with a newline'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - One or more files ends with a non-newline'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileEndsWithNewline file ...'$'\n'''$'\n''    file ...  File. Required. File to check if the last character is a newline.'$'\n'''$'\n''Does a file end with a newline or is empty?'$'\n''Typically used to determine if a newline is needed before appending a file.'$'\n'''$'\n''Return codes:'$'\n''- 0 - All files ends with a newline'$'\n''- 1 - One or more files ends with a non-newline'$'\n'''
