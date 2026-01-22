#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
description="List the extensions available"$'\n'""
file="bin/build/tools/git.sh"
fn="gitPreCommitExtensionList"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1768759336"
stdout="String. One per line."$'\n'""
summary="List the extensions available"
usage="gitPreCommitExtensionList [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitPreCommitExtensionList[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

List the extensions available

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
String. One per line.
'
# shellcheck disable=SC2016
helpPlain='Usage: gitPreCommitExtensionList [ --help ]

    --help  Flag. Optional. Display this help.

List the extensions available

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
String. One per line.
'
