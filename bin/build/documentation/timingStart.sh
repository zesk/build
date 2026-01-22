#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/timing.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="timing.sh"
description="Outputs the offset in milliseconds from January 1, 1970."$'\n'""$'\n'"Should never fail, unless date is not installed"$'\n'""
example="    init=\$(timingStart)"$'\n'"    ..."$'\n'"    timingReport \"\$init\" \"Completed in\""$'\n'""
file="bin/build/tools/timing.sh"
fn="timingStart"
foundNames=""
init=""
requires="__timestamp, returnEnvironment date"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/timing.sh"
sourceModified="1769063211"
summary="Start a timer"$'\n'""
usage="timingStart [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mtimingStart[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Outputs the offset in milliseconds from January 1, 1970.

Should never fail, unless date is not installed

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    init=$(timingStart)
    ...
    timingReport "$init" "Completed in"
'
# shellcheck disable=SC2016
helpPlain='Usage: timingStart [ --help ]

    --help  Flag. Optional. Display this help.

Outputs the offset in milliseconds from January 1, 1970.

Should never fail, unless date is not installed

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    init=$(timingStart)
    ...
    timingReport "$init" "Completed in"
'
