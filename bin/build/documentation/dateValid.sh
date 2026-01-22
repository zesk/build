#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/date.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"-- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning."$'\n'"text - String. Required. Text to validate as a date after the year 1600. Does not validate month and day combinations."$'\n'""
base="date.sh"
description="Is a date valid?"$'\n'""
file="bin/build/tools/date.sh"
fn="dateValid"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceModified="1769056043"
summary="Is a date valid?"
usage="dateValid [ --help ] [ -- ] text"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdateValid[0m [94m[ --help ][0m [94m[ -- ][0m [38;2;255;255;0m[35;48;2;0;0;0mtext[0m[0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m
    [94m--      [1;97mFlag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.[0m
    [31mtext    [1;97mString. Required. Text to validate as a date after the year 1600. Does not validate month and day combinations.[0m

Is a date valid?

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: dateValid [ --help ] [ -- ] text

    --help  Flag. Optional. Display this help.
    --      Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.
    text    String. Required. Text to validate as a date after the year 1600. Does not validate month and day combinations.

Is a date valid?

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
