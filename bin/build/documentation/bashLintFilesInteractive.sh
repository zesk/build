#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/lint.sh"
argument="--exec binary - Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names."$'\n'"--delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode."$'\n'"fileToCheck ... - File. Optional. Shell file to validate."$'\n'""
base="lint.sh"
description="Run checks interactively until errors are all fixed."$'\n'""
file="bin/build/tools/lint.sh"
fn="bashLintFilesInteractive"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/lint.sh"
sourceModified="1769063211"
summary="Run checks interactively until errors are all fixed."
usage="bashLintFilesInteractive [ --exec binary ] [ --delay delaySeconds ] [ fileToCheck ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashLintFilesInteractive[0m [94m[ --exec binary ][0m [94m[ --delay delaySeconds ][0m [94m[ fileToCheck ... ][0m

    [94m--exec binary         [1;97mCallable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names.[0m
    [94m--delay delaySeconds  [1;97mInteger. Optional. Delay in seconds between checks in interactive mode.[0m
    [94mfileToCheck ...       [1;97mFile. Optional. Shell file to validate.[0m

Run checks interactively until errors are all fixed.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bashLintFilesInteractive [ --exec binary ] [ --delay delaySeconds ] [ fileToCheck ... ]

    --exec binary         Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names.
    --delay delaySeconds  Integer. Optional. Delay in seconds between checks in interactive mode.
    fileToCheck ...       File. Optional. Shell file to validate.

Run checks interactively until errors are all fixed.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
