#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/usage.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"source - File. Required. File where documentation exists."$'\n'"function - String. Required. Function to document."$'\n'"returnCode - UnsignedInteger. Required. Exit code to return."$'\n'"message ... - String. Optional. Message to display to the user."$'\n'""
base="usage.sh"
description="Output a simple error message for a function"$'\n'""
file="bin/build/tools/usage.sh"
fn="usageDocumentSimple"
foundNames=""
requires="bashFunctionComment decorate read printf returnCodeString __help usageDocument __usageDocumentCached"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/usage.sh"
sourceModified="1769066611"
summary="Output a simple error message for a function"
usage="usageDocumentSimple [ --help ] source function returnCode [ message ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255musageDocumentSimple[0m [94m[ --help ][0m [38;2;255;255;0m[35;48;2;0;0;0msource[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mfunction[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mreturnCode[0m[0m [94m[ message ... ][0m

    [94m--help       [1;97mFlag. Optional. Display this help.[0m
    [31msource       [1;97mFile. Required. File where documentation exists.[0m
    [31mfunction     [1;97mString. Required. Function to document.[0m
    [31mreturnCode   [1;97mUnsignedInteger. Required. Exit code to return.[0m
    [94mmessage ...  [1;97mString. Optional. Message to display to the user.[0m

Output a simple error message for a function

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: usageDocumentSimple [ --help ] source function returnCode [ message ... ]

    --help       Flag. Optional. Display this help.
    source       File. Required. File where documentation exists.
    function     String. Required. Function to document.
    returnCode   UnsignedInteger. Required. Exit code to return.
    message ...  String. Optional. Message to display to the user.

Output a simple error message for a function

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
