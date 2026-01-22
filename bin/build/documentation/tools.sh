#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/build.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--start startDirectory - Directory. Optional. Start searching for a build installation at this location and searching upwards in the file hierarchy."$'\n'"--verbose - Flag. Optional. Be verbose."$'\n'"... - Callable. Optional. Run this command after loading in the current build context."$'\n'""
base="build.sh"
description="Run a Zesk Build command or load it"$'\n'""$'\n'""
file="bin/build/tools/build.sh"
fn="tools"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceModified="1769063211"
summary="Run a Zesk Build command or load it"
usage="tools [ --help ] [ --start startDirectory ] [ --verbose ] [ ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mtools[0m [94m[ --help ][0m [94m[ --start startDirectory ][0m [94m[ --verbose ][0m [94m[ ... ][0m

    [94m--help                  [1;97mFlag. Optional. Display this help.[0m
    [94m--start startDirectory  [1;97mDirectory. Optional. Start searching for a build installation at this location and searching upwards in the file hierarchy.[0m
    [94m--verbose               [1;97mFlag. Optional. Be verbose.[0m
    [94m...                     [1;97mCallable. Optional. Run this command after loading in the current build context.[0m

Run a Zesk Build command or load it

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: tools [ --help ] [ --start startDirectory ] [ --verbose ] [ ... ]

    --help                  Flag. Optional. Display this help.
    --start startDirectory  Directory. Optional. Start searching for a build installation at this location and searching upwards in the file hierarchy.
    --verbose               Flag. Optional. Be verbose.
    ...                     Callable. Optional. Run this command after loading in the current build context.

Run a Zesk Build command or load it

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
