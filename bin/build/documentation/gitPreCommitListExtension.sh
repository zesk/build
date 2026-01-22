#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="extension - String. Optional. Extension to list. Use \`!\` for blank extension and \`@\` for all extensions. Can specify one or more."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
description="List the file(s) of an extension"$'\n'""
file="bin/build/tools/git.sh"
fn="gitPreCommitListExtension"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1768759336"
stdout="File. One per line."$'\n'""
summary="List the file(s) of an extension"
usage="gitPreCommitListExtension [ extension ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitPreCommitListExtension[0m [94m[ extension ][0m [94m[ --help ][0m

    [94mextension  [1;97mString. Optional. Extension to list. Use [38;2;0;255;0;48;2;0;0;0m![0m for blank extension and [38;2;0;255;0;48;2;0;0;0m@[0m for all extensions. Can specify one or more.[0m
    [94m--help     [1;97mFlag. Optional. Display this help.[0m

List the file(s) of an extension

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
File. One per line.
'
# shellcheck disable=SC2016
helpPlain='Usage: gitPreCommitListExtension [ extension ] [ --help ]

    extension  String. Optional. Extension to list. Use ! for blank extension and @ for all extensions. Can specify one or more.
    --help     Flag. Optional. Display this help.

List the file(s) of an extension

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
File. One per line.
'
