#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/json.sh"
argument="path - String. Output a json path separated by dots."$'\n'""
base="json.sh"
description="Generate a path for a JSON structure for use in \`jq\` queries"$'\n'""$'\n'"Without arguments, displays help."$'\n'""
file="bin/build/tools/json.sh"
fn="jsonPath"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/json.sh"
sourceModified="1768721469"
summary="Generate \`jq\` paths"$'\n'""
usage="jsonPath [ path ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mjsonPath[0m [94m[ path ][0m

    [94mpath  [1;97mString. Output a json path separated by dots.[0m

Generate a path for a JSON structure for use in [38;2;0;255;0;48;2;0;0;0mjq[0m queries

Without arguments, displays help.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: jsonPath [ path ]

    path  String. Output a json path separated by dots.

Generate a path for a JSON structure for use in jq queries

Without arguments, displays help.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
