#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/json.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"handler - Function. Required. Error handler."$'\n'"jsonFile - File. Required. A JSON file to parse"$'\n'"... - Arguments. Optional. Passed directly to jq"$'\n'""
base="json.sh"
description="Fetch a non-blank field from a JSON file with error handling"$'\n'"Return Code: 0 - Field was found and was non-blank"$'\n'"Return Code: 1 - Field was not found or is blank"$'\n'""
file="bin/build/tools/json.sh"
fn="jsonField"
requires="jq whichExists throwEnvironment printf rm decorate head"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/json.sh"
sourceModified="1768721469"
stderr="error messages"$'\n'""
stdout="selected field"$'\n'""
summary="Fetch a non-blank field from a JSON file with error"
usage="jsonField [ --help ] handler jsonFile [ ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mjsonField[0m [94m[ --help ][0m [38;2;255;255;0m[35;48;2;0;0;0mhandler[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mjsonFile[0m[0m [94m[ ... ][0m

    [94m--help    [1;97mFlag. Optional. Display this help.[0m
    [31mhandler   [1;97mFunction. Required. Error handler.[0m
    [31mjsonFile  [1;97mFile. Required. A JSON file to parse[0m
    [94m...       [1;97mArguments. Optional. Passed directly to jq[0m

Fetch a non-blank field from a JSON file with error handling
Return Code: 0 - Field was found and was non-blank
Return Code: 1 - Field was not found or is blank

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
selected field
'
# shellcheck disable=SC2016
helpPlain='Usage: jsonField [ --help ] handler jsonFile [ ... ]

    --help    Flag. Optional. Display this help.
    handler   Function. Required. Error handler.
    jsonFile  File. Required. A JSON file to parse
    ...       Arguments. Optional. Passed directly to jq

Fetch a non-blank field from a JSON file with error handling
Return Code: 0 - Field was found and was non-blank
Return Code: 1 - Field was not found or is blank

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
selected field
'
