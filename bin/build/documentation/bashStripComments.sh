#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Removes literally any line which begins with zero or more whitespace characters and then a \`#\`."$'\n'""
file="bin/build/tools/bash.sh"
fn="bashStripComments"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceModified="1768776883"
summary="Pipe to strip comments from a bash file"$'\n'""
usage="bashStripComments [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashStripComments[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Removes literally any line which begins with zero or more whitespace characters and then a [38;2;0;255;0;48;2;0;0;0m#[0m.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bashStripComments [ --help ]

    --help  Flag. Optional. Display this help.

Removes literally any line which begins with zero or more whitespace characters and then a #.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
