#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deprecated-tools.sh"
argument="findArgumentFunction - Function. Required. Find arguments (for \`find\`) for cannon."$'\n'"search - String. Required. String to search for (one or more)"$'\n'"--path cannonPath - Directory. Optional. Run cannon operation starting in this directory."$'\n'""
base="deprecated-tools.sh"
description="Find files which match a token or tokens"$'\n'"Return Code: 0 - One of the search tokens was found in a file (which matches find arguments)"$'\n'"Return Code: 1 - Search tokens were not found in any file (which matches find arguments)"$'\n'""
file="bin/build/tools/deprecated-tools.sh"
fn="deprecatedFind"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="buildHome"$'\n'""
sourceFile="bin/build/tools/deprecated-tools.sh"
sourceModified="1768721469"
summary="Find files which match a token or tokens"
usage="deprecatedFind findArgumentFunction search [ --path cannonPath ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdeprecatedFind[0m [38;2;255;255;0m[35;48;2;0;0;0mfindArgumentFunction[0m[0m [38;2;255;255;0m[35;48;2;0;0;0msearch[0m[0m [94m[ --path cannonPath ][0m

    [31mfindArgumentFunction  [1;97mFunction. Required. Find arguments (for [38;2;0;255;0;48;2;0;0;0mfind[0m) for cannon.[0m
    [31msearch                [1;97mString. Required. String to search for (one or more)[0m
    [94m--path cannonPath     [1;97mDirectory. Optional. Run cannon operation starting in this directory.[0m

Find files which match a token or tokens
Return Code: 0 - One of the search tokens was found in a file (which matches find arguments)
Return Code: 1 - Search tokens were not found in any file (which matches find arguments)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: deprecatedFind findArgumentFunction search [ --path cannonPath ]

    findArgumentFunction  Function. Required. Find arguments (for find) for cannon.
    search                String. Required. String to search for (one or more)
    --path cannonPath     Directory. Optional. Run cannon operation starting in this directory.

Find files which match a token or tokens
Return Code: 0 - One of the search tokens was found in a file (which matches find arguments)
Return Code: 1 - Search tokens were not found in any file (which matches find arguments)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
