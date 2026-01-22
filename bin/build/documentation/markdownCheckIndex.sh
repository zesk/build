#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/markdown.sh"
argument="indexFile ... - File. Required. One or more index files to check."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'""
base="markdown.sh"
description="Displays any markdown files next to the given index file which are not found within the index file as links."$'\n'""
file="bin/build/tools/markdown.sh"
fn="markdownCheckIndex"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/markdown.sh"
sourceModified="1768721469"
summary="Displays any markdown files next to the given index file"
usage="markdownCheckIndex indexFile ... [ --help ] [ --handler handler ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mmarkdownCheckIndex[0m [38;2;255;255;0m[35;48;2;0;0;0mindexFile ...[0m[0m [94m[ --help ][0m [94m[ --handler handler ][0m

    [31mindexFile ...      [1;97mFile. Required. One or more index files to check.[0m
    [94m--help             [1;97mFlag. Optional. Display this help.[0m
    [94m--handler handler  [1;97mFunction. Optional. Use this error handler instead of the default error handler.[0m

Displays any markdown files next to the given index file which are not found within the index file as links.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: markdownCheckIndex indexFile ... [ --help ] [ --handler handler ]

    indexFile ...      File. Required. One or more index files to check.
    --help             Flag. Optional. Display this help.
    --handler handler  Function. Optional. Use this error handler instead of the default error handler.

Displays any markdown files next to the given index file which are not found within the index file as links.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
