#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
# shellcheck source=/dev/null
applicationFile="bin/build/tools/debug.sh"
argument="--help - Help"$'\n'"--verbose - Flag. Optional. Verbose messages when no errors exist."$'\n'"--name name - String. Optional. Name for verbose mode."$'\n'""
base="debug.sh"
description="Check output for content and trigger environment error if found"$'\n'"Usage {fn} [ --help ] [ --verbose ] [ --name name ]"$'\n'"# shellcheck source=/dev/null"$'\n'""
example="    source \"\$include\" > >(outputTrigger source \"\$include\") || return \$?"$'\n'""
file="bin/build/tools/debug.sh"
fn="outputTrigger"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceModified="1769059754"
summary="Check output for content and trigger environment error if found"
usage="outputTrigger [ --help ] [ --verbose ] [ --name name ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255moutputTrigger[0m [94m[ --help ][0m [94m[ --verbose ][0m [94m[ --name name ][0m

    [94m--help       [1;97mHelp[0m
    [94m--verbose    [1;97mFlag. Optional. Verbose messages when no errors exist.[0m
    [94m--name name  [1;97mString. Optional. Name for verbose mode.[0m

Check output for content and trigger environment error if found
Usage outputTrigger [ --help ] [ --verbose ] [ --name name ]
# shellcheck source=/dev/null

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    source "$include" > >(outputTrigger source "$include") || return $?
'
# shellcheck disable=SC2016
helpPlain='Usage: outputTrigger [ --help ] [ --verbose ] [ --name name ]

    --help       Help
    --verbose    Flag. Optional. Verbose messages when no errors exist.
    --name name  String. Optional. Name for verbose mode.

Check output for content and trigger environment error if found
Usage outputTrigger [ --help ] [ --verbose ] [ --name name ]
# shellcheck source=/dev/null

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    source "$include" > >(outputTrigger source "$include") || return $?
'
