#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Extracts the final comment from a stream"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashFinalComment"
foundNames=""
requires="fileReverseLines sed cut grep convertValue"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceModified="1769063211"
summary="Extracts the final comment from a stream"
usage="bashFinalComment [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashFinalComment[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Extracts the final comment from a stream

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bashFinalComment [ --help ]

    --help  Flag. Optional. Display this help.

Extracts the final comment from a stream

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
