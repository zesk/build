#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/platform.sh"
argument="count - The number of times to run the binary"$'\n'"binary - The binary to run"$'\n'"args ... - Any arguments to pass to the binary each run"$'\n'""
base="platform.sh"
description="Return Code: 0 - success"$'\n'"Return Code: 2 - \`count\` is not an unsigned number"$'\n'"Return Code: Any - If \`binary\` fails, the exit code is returned"$'\n'""
file="bin/build/tools/platform.sh"
fn="runCount"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceModified="1768873865"
summary="Run a binary count times"$'\n'""
usage="runCount [ count ] [ binary ] [ args ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mrunCount[0m [94m[ count ][0m [94m[ binary ][0m [94m[ args ... ][0m

    [94mcount     [1;97mThe number of times to run the binary[0m
    [94mbinary    [1;97mThe binary to run[0m
    [94margs ...  [1;97mAny arguments to pass to the binary each run[0m

Return Code: 0 - success
Return Code: 2 - [38;2;0;255;0;48;2;0;0;0mcount[0m is not an unsigned number
Return Code: Any - If [38;2;0;255;0;48;2;0;0;0mbinary[0m fails, the exit code is returned

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: runCount [ count ] [ binary ] [ args ... ]

    count     The number of times to run the binary
    binary    The binary to run
    args ...  Any arguments to pass to the binary each run

Return Code: 0 - success
Return Code: 2 - count is not an unsigned number
Return Code: Any - If binary fails, the exit code is returned

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
