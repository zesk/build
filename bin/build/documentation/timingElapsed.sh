#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/timing.sh"
argument="timingOffset - UnsignedInteger. Required. Offset in milliseconds from January 1, 1970."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="timing.sh"
description="Show elapsed time from a start time"$'\n'""
example="    init=\$(timingStart)"$'\n'"    ..."$'\n'"    timingElapsed \"\$init\""$'\n'""
file="bin/build/tools/timing.sh"
fn="timingElapsed"
foundNames=""
init=""
requires="__timestamp returnEnvironment validate date"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/timing.sh"
sourceModified="1768782153"
summary="Show elapsed time from a start time"$'\n'""
usage="timingElapsed timingOffset [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mtimingElapsed[0m [38;2;255;255;0m[35;48;2;0;0;0mtimingOffset[0m[0m [94m[ --help ][0m

    [31mtimingOffset  [1;97mUnsignedInteger. Required. Offset in milliseconds from January 1, 1970.[0m
    [94m--help        [1;97mFlag. Optional. Display this help.[0m

Show elapsed time from a start time

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    init=$(timingStart)
    ...
    timingElapsed "$init"
'
# shellcheck disable=SC2016
helpPlain='Usage: timingElapsed timingOffset [ --help ]

    timingOffset  UnsignedInteger. Required. Offset in milliseconds from January 1, 1970.
    --help        Flag. Optional. Display this help.

Show elapsed time from a start time

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    init=$(timingStart)
    ...
    timingElapsed "$init"
'
