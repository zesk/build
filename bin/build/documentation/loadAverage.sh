#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/platform.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="platform.sh"
description="Get the load average using uptime"$'\n'"Uptime output: 0:00  up 30 days,  6:02, 19 users, load averages: 15.01 12.66 11.64"$'\n'"Uptime output: 05:01:06 up 8 days,  4:03,  0 users,  load average: 3.87, 3.09, 2.71"$'\n'""
file="bin/build/tools/platform.sh"
fn="loadAverage"
foundNames=""
requires="uptime"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceModified="1768873865"
stdout="lines:Number"$'\n'""
summary="Get the load average using uptime"
usage="loadAverage [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mloadAverage[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Get the load average using uptime
Uptime output: 0:00  up 30 days,  6:02, 19 users, load averages: 15.01 12.66 11.64
Uptime output: 05:01:06 up 8 days,  4:03,  0 users,  load average: 3.87, 3.09, 2.71

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
lines:Number
'
# shellcheck disable=SC2016
helpPlain='Usage: loadAverage [ --help ]

    --help  Flag. Optional. Display this help.

Get the load average using uptime
Uptime output: 0:00  up 30 days,  6:02, 19 users, load averages: 15.01 12.66 11.64
Uptime output: 05:01:06 up 8 days,  4:03,  0 users,  load average: 3.87, 3.09, 2.71

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
lines:Number
'
