#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/json.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="json.sh"
description="Format something neatly as JSON"$'\n'""
example="    json < inputFile > outputFile"$'\n'""
file="bin/build/tools/json.sh"
fn="json"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/json.sh"
sourceModified="1768721469"
stdin="JSONFile"$'\n'""
stdout="JSONFile pretty formatted"$'\n'""
summary="JSON pretty"$'\n'""
usage="json [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mjson[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Format something neatly as JSON

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
JSONFile

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
JSONFile pretty formatted

Example:
    json < inputFile > outputFile
'
# shellcheck disable=SC2016
helpPlain='Usage: json [ --help ]

    --help  Flag. Optional. Display this help.

Format something neatly as JSON

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
JSONFile

Writes to stdout:
JSONFile pretty formatted

Example:
    json < inputFile > outputFile
'
