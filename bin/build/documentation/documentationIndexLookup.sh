#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
##
applicationFile="bin/build/tools/documentation.sh"
argument="--settings - Flag. Optional. \`matchText\` is a function name. Outputs a file name containing function settings"$'\n'"--comment - Flag. Optional. \`matchText\` is a function name. Outputs a file name containing function settings"$'\n'"--source - Flag. Optional. \`matchText\` is a function name. Outputs the source code path to where the function is defined"$'\n'"--line - Flag. Optional. \`matchText\` is a function name. Outputs the source code line where the function is defined"$'\n'"--combined - Flag. Optional. \`matchText\` is a function name. Outputs the source code path and line where the function is defined as \`path:line\`"$'\n'"--file - Flag. Optional. \`matchText\` is a file name. Find files which match this base file name."$'\n'"matchText - String. Token to look up in the index."$'\n'""
base="documentation.sh"
description="Looks up information in the function index"$'\n'"##"$'\n'""
file="bin/build/tools/documentation.sh"
fn="documentationIndexLookup"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceModified="1769058814"
summary="Looks up information in the function index"
usage="documentationIndexLookup [ --settings ] [ --comment ] [ --source ] [ --line ] [ --combined ] [ --file ] [ matchText ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdocumentationIndexLookup[0m [94m[ --settings ][0m [94m[ --comment ][0m [94m[ --source ][0m [94m[ --line ][0m [94m[ --combined ][0m [94m[ --file ][0m [94m[ matchText ][0m

    [94m--settings  [1;97mFlag. Optional. [38;2;0;255;0;48;2;0;0;0mmatchText[0m is a function name. Outputs a file name containing function settings[0m
    [94m--comment   [1;97mFlag. Optional. [38;2;0;255;0;48;2;0;0;0mmatchText[0m is a function name. Outputs a file name containing function settings[0m
    [94m--source    [1;97mFlag. Optional. [38;2;0;255;0;48;2;0;0;0mmatchText[0m is a function name. Outputs the source code path to where the function is defined[0m
    [94m--line      [1;97mFlag. Optional. [38;2;0;255;0;48;2;0;0;0mmatchText[0m is a function name. Outputs the source code line where the function is defined[0m
    [94m--combined  [1;97mFlag. Optional. [38;2;0;255;0;48;2;0;0;0mmatchText[0m is a function name. Outputs the source code path and line where the function is defined as [38;2;0;255;0;48;2;0;0;0mpath:line[0m[0m
    [94m--file      [1;97mFlag. Optional. [38;2;0;255;0;48;2;0;0;0mmatchText[0m is a file name. Find files which match this base file name.[0m
    [94mmatchText   [1;97mString. Token to look up in the index.[0m

Looks up information in the function index
##

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: documentationIndexLookup [ --settings ] [ --comment ] [ --source ] [ --line ] [ --combined ] [ --file ] [ matchText ]

    --settings  Flag. Optional. matchText is a function name. Outputs a file name containing function settings
    --comment   Flag. Optional. matchText is a function name. Outputs a file name containing function settings
    --source    Flag. Optional. matchText is a function name. Outputs the source code path to where the function is defined
    --line      Flag. Optional. matchText is a function name. Outputs the source code line where the function is defined
    --combined  Flag. Optional. matchText is a function name. Outputs the source code path and line where the function is defined as path:line
    --file      Flag. Optional. matchText is a file name. Find files which match this base file name.
    matchText   String. Token to look up in the index.

Looks up information in the function index
##

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
