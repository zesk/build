#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="loopCallable - Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails."$'\n'"--exec binary - Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names."$'\n'"--delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode."$'\n'"fileToCheck ... - File. Optional. Shell file to validate. May also supply file names via stdin."$'\n'""
base="interactive.sh"
description="Run checks interactively until errors are all fixed."$'\n'"Not ready for prime time yet - written not tested."$'\n'""
file="bin/build/tools/interactive.sh"
fn="interactiveManager"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceModified="1768759374"
summary="Run checks interactively until errors are all fixed."
usage="interactiveManager loopCallable [ --exec binary ] [ --delay delaySeconds ] [ fileToCheck ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255minteractiveManager[0m [38;2;255;255;0m[35;48;2;0;0;0mloopCallable[0m[0m [94m[ --exec binary ][0m [94m[ --delay delaySeconds ][0m [94m[ fileToCheck ... ][0m

    [31mloopCallable          [1;97mCallable. Required. Call this on each file and a zero result code means passed and non-zero means fails.[0m
    [94m--exec binary         [1;97mCallable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names.[0m
    [94m--delay delaySeconds  [1;97mInteger. Optional. Delay in seconds between checks in interactive mode.[0m
    [94mfileToCheck ...       [1;97mFile. Optional. Shell file to validate. May also supply file names via stdin.[0m

Run checks interactively until errors are all fixed.
Not ready for prime time yet - written not tested.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: interactiveManager loopCallable [ --exec binary ] [ --delay delaySeconds ] [ fileToCheck ... ]

    loopCallable          Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails.
    --exec binary         Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names.
    --delay delaySeconds  Integer. Optional. Delay in seconds between checks in interactive mode.
    fileToCheck ...       File. Optional. Shell file to validate. May also supply file names via stdin.

Run checks interactively until errors are all fixed.
Not ready for prime time yet - written not tested.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
