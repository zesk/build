#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
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
line="705"
rawComment=$'Does a file end with a newline or is empty?\nTypically used to determine if a newline is needed before appending a file.\nArgument: file ... - File. Required. File to check if the last character is a newline.\nReturn Code: 0 - All files ends with a newline\nReturn Code: 1 - One or more files ends with a non-newline\nTest: testFileEndsWithNewline\n\n'
return_code=$'0 - All files ends with a newline\n1 - One or more files ends with a non-newline\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="705"
summary="Does a file end with a newline or is empty?"
summaryComputed="true"
test=$'testFileEndsWithNewline\n'
usage="fileEndsWithNewline file ..."
