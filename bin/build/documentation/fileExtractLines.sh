#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument="startLine - Integer. Required. Starting line number."$'\n'"endLine - Integer. Required. Ending line number."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Extract a range of lines from a file"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/text.sh"
fn="fileExtractLines"
fnMarker="fileextractlines"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
line="27"
rawComment="Extract a range of lines from a file"$'\n'"Argument: startLine - Integer. Required. Starting line number."$'\n'"Argument: endLine - Integer. Required. Ending line number."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdin: Reads lines until EOF"$'\n'"stdout: Outputs the selected lines only"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="b913e34543d2ae704942cadce5473f26955cd42e"
sourceLine="27"
stdin="Reads lines until EOF"$'\n'""
stdout="Outputs the selected lines only"$'\n'""
summary="Extract a range of lines from a file"
summaryComputed="true"
usage="fileExtractLines startLine endLine [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileExtractLines'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mstartLine'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mendLine'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mstartLine  '$'\e''[[(value)]mInteger. Required. Starting line number.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mendLine    '$'\e''[[(value)]mInteger. Required. Ending line number.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Extract a range of lines from a file'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Reads lines until EOF'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''Outputs the selected lines only'
# shellcheck disable=SC2016
helpPlain='Usage: fileExtractLines startLine endLine [ --help ]'$'\n'''$'\n''    startLine  Integer. Required. Starting line number.'$'\n''    endLine    Integer. Required. Ending line number.'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''Extract a range of lines from a file'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Reads lines until EOF'$'\n'''$'\n''Writes to stdout:'$'\n''Outputs the selected lines only'
documentationPath="documentation/source/tools/file.md"
