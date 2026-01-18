#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="file ... - File. Required. File to check if the last character is a newline."$'\n'""
base="text.sh"
description="Does a file end with a newline or is empty?"$'\n'""$'\n'"Typically used to determine if a newline is needed before appending a file."$'\n'""$'\n'"Return Code: 0 - All files ends with a newline"$'\n'"Return Code: 1 - One or more files ends with a non-newline"$'\n'""
file="bin/build/tools/text.sh"
fn="fileEndsWithNewline"
foundNames=([0]="argument" [1]="test")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768721469"
summary="Does a file end with a newline or is empty?"
test="testFileEndsWithNewline"$'\n'""
usage="fileEndsWithNewline file ..."
