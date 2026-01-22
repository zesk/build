#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="source - File. Required. File where the function is defined."$'\n'"lineNumber - String. Required. Previously computed line number of the function."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Extract a bash comment from a file. Excludes lines containing the following tokens:"$'\n'""$'\n'""$'\n'""
file="bin/build/tools/bash.sh"
fn="bashFileComment"
foundNames=""
requires="head bashFinalComment"$'\n'"__help usageDocument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceModified="1769063211"
summary="Extract a bash comment from a file. Excludes lines containing"
usage="bashFileComment source lineNumber [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashFileComment[0m [38;2;255;255;0m[35;48;2;0;0;0msource[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mlineNumber[0m[0m [94m[ --help ][0m

    [31msource      [1;97mFile. Required. File where the function is defined.[0m
    [31mlineNumber  [1;97mString. Required. Previously computed line number of the function.[0m
    [94m--help      [1;97mFlag. Optional. Display this help.[0m

Extract a bash comment from a file. Excludes lines containing the following tokens:

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bashFileComment source lineNumber [ --help ]

    source      File. Required. File where the function is defined.
    lineNumber  String. Required. Previously computed line number of the function.
    --help      Flag. Optional. Display this help.

Extract a bash comment from a file. Excludes lines containing the following tokens:

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
