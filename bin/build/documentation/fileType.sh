#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="item - String. Optional. Thing to classify"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
description="Better type handling of shell objects"$'\n'""$'\n'"Outputs one of \`type\` output or enhancements:"$'\n'"- \`builtin\`, \`function\`, \`alias\`, \`file\`"$'\n'"- \`link-directory\`, \`link-file\`, \`link-dead\`, \`directory\`, \`integer\`, \`unknown\`"$'\n'""
file="bin/build/tools/file.sh"
fn="fileType"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceModified="1768775696"
summary="Better type handling of shell objects"
usage="fileType [ item ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mfileType[0m [94m[ item ][0m [94m[ --help ][0m

    [94mitem    [1;97mString. Optional. Thing to classify[0m
    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Better type handling of shell objects

Outputs one of [38;2;0;255;0;48;2;0;0;0mtype[0m output or enhancements:
- [38;2;0;255;0;48;2;0;0;0mbuiltin[0m, [38;2;0;255;0;48;2;0;0;0mfunction[0m, [38;2;0;255;0;48;2;0;0;0malias[0m, [38;2;0;255;0;48;2;0;0;0mfile[0m
- [38;2;0;255;0;48;2;0;0;0mlink-directory[0m, [38;2;0;255;0;48;2;0;0;0mlink-file[0m, [38;2;0;255;0;48;2;0;0;0mlink-dead[0m, [38;2;0;255;0;48;2;0;0;0mdirectory[0m, [38;2;0;255;0;48;2;0;0;0minteger[0m, [38;2;0;255;0;48;2;0;0;0munknown[0m

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: fileType [ item ] [ --help ]

    item    String. Optional. Thing to classify
    --help  Flag. Optional. Display this help.

Better type handling of shell objects

Outputs one of type output or enhancements:
- builtin, function, alias, file
- link-directory, link-file, link-dead, directory, integer, unknown

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
