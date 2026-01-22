#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="file ... - File. Required. File to check if the last character is a newline."$'\n'""
base="text.sh"
description="Does a file end with a newline or is empty?"$'\n'""$'\n'"Typically used to determine if a newline is needed before appending a file."$'\n'""$'\n'"Return Code: 0 - All files ends with a newline"$'\n'"Return Code: 1 - One or more files ends with a non-newline"$'\n'""
file="bin/build/tools/text.sh"
fn="fileEndsWithNewline"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1768776345"
summary="Does a file end with a newline or is empty?"
test="testFileEndsWithNewline"$'\n'""
usage="fileEndsWithNewline file ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mfileEndsWithNewline[0m [38;2;255;255;0m[35;48;2;0;0;0mfile ...[0m[0m

    [31mfile ...  [1;97mFile. Required. File to check if the last character is a newline.[0m

Does a file end with a newline or is empty?

Typically used to determine if a newline is needed before appending a file.

Return Code: 0 - All files ends with a newline
Return Code: 1 - One or more files ends with a non-newline

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: fileEndsWithNewline file ...

    file ...  File. Required. File to check if the last character is a newline.

Does a file end with a newline or is empty?

Typically used to determine if a newline is needed before appending a file.

Return Code: 0 - All files ends with a newline
Return Code: 1 - One or more files ends with a non-newline

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
