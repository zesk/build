#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/example.sh"
argument="exitCode - UnsignedInteger. Required. Exit code to return. Default is 1."$'\n'"message ... - String. Optional. Message to output"$'\n'""
base="example.sh"
description="Return passed in integer return code and output message to \`stderr\` (non-zero) or \`stdout\` (zero)"$'\n'"Return Code: exitCode"$'\n'""
file="bin/build/tools/example.sh"
fn="returnMessage"
foundNames=""
requires="isUnsignedInteger printf returnMessage"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/example.sh"
sourceModified="1769063211"
summary="Return passed in integer return code and output message to"
usage="returnMessage exitCode [ message ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mreturnMessage[0m [38;2;255;255;0m[35;48;2;0;0;0mexitCode[0m[0m [94m[ message ... ][0m

    [31mexitCode     [1;97mUnsignedInteger. Required. Exit code to return. Default is 1.[0m
    [94mmessage ...  [1;97mString. Optional. Message to output[0m

Return passed in integer return code and output message to [38;2;0;255;0;48;2;0;0;0mstderr[0m (non-zero) or [38;2;0;255;0;48;2;0;0;0mstdout[0m (zero)
Return Code: exitCode

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: returnMessage exitCode [ message ... ]

    exitCode     UnsignedInteger. Required. Exit code to return. Default is 1.
    message ...  String. Optional. Message to output

Return passed in integer return code and output message to stderr (non-zero) or stdout (zero)
Return Code: exitCode

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
