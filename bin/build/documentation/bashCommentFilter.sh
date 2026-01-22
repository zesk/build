#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--only - Flag. Optional. Show ONLY comment lines. (Reverse of lines when not specified.)"$'\n'"file - File. Optional. File(s) to filter."$'\n'""
base="bash.sh"
description="Filter comments from a bash stream"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashCommentFilter"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceModified="1768776883"
stdin="a bash file"$'\n'""
stdout="bash file without line-comments \`#\`"$'\n'""
summary="Filter comments from a bash stream"
usage="bashCommentFilter [ --help ] [ --only ] [ file ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashCommentFilter[0m [94m[ --help ][0m [94m[ --only ][0m [94m[ file ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m
    [94m--only  [1;97mFlag. Optional. Show ONLY comment lines. (Reverse of lines when not specified.)[0m
    [94mfile    [1;97mFile. Optional. File(s) to filter.[0m

Filter comments from a bash stream

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
a bash file

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
bash file without line-comments [38;2;0;255;0;48;2;0;0;0m#[0m
'
# shellcheck disable=SC2016
helpPlain='Usage: bashCommentFilter [ --help ] [ --only ] [ file ]

    --help  Flag. Optional. Display this help.
    --only  Flag. Optional. Show ONLY comment lines. (Reverse of lines when not specified.)
    file    File. Optional. File(s) to filter.

Filter comments from a bash stream

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
a bash file

Writes to stdout:
bash file without line-comments #
'
