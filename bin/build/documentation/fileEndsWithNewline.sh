#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'file ... - File. Required. File to check if the last character is a newline.\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Does a file end with a newline or is empty?\n\nTypically used to determine if a newline is needed before appending a file.\n\n'
descriptionLineCount="4"
file="bin/build/tools/text.sh"
fn="fileEndsWithNewline"
fnMarker="fileendswithnewline"
foundNames=([0]="argument" [1]="return_code" [2]="test")
line="701"
rawComment=$'Does a file end with a newline or is empty?\nTypically used to determine if a newline is needed before appending a file.\nArgument: file ... - File. Required. File to check if the last character is a newline.\nReturn Code: 0 - All files ends with a newline\nReturn Code: 1 - One or more files ends with a non-newline\nTest: testFileEndsWithNewline\n\n'
return_code=$'0 - All files ends with a newline\n1 - One or more files ends with a non-newline\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="6d769d6727070a6dc8632961d7250fe1f73eea0f"
sourceLine="701"
summary="Does a file end with a newline or is empty?"
summaryComputed="true"
test=$'testFileEndsWithNewline\n'
usage="fileEndsWithNewline file ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileEndsWithNewline'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfile ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mfile ...  '$'\e''[[(value)]mFile. Required. File to check if the last character is a newline.'$'\e''[[(reset)]m'$'\n'''$'\n''Does a file end with a newline or is empty?'$'\n'''$'\n''Typically used to determine if a newline is needed before appending a file.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All files ends with a newline'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - One or more files ends with a non-newline'
# shellcheck disable=SC2016
helpPlain='Usage: fileEndsWithNewline file ...'$'\n'''$'\n''    file ...  File. Required. File to check if the last character is a newline.'$'\n'''$'\n''Does a file end with a newline or is empty?'$'\n'''$'\n''Typically used to determine if a newline is needed before appending a file.'$'\n'''$'\n''Return codes:'$'\n''- 0 - All files ends with a newline'$'\n''- 1 - One or more files ends with a non-newline'
documentationPath="documentation/source/tools/text.md"
