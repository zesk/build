#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="platform.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Get the load average using uptime"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/platform.sh"
fn="cpuLoadAverage"
fnMarker="cpuloadaverage"
foundNames=([0]="requires" [1]="uptime_output" [2]="stdout" [3]="argument")
line="390"
rawComment="Get the load average using uptime"$'\n'"Requires: uptime"$'\n'"Uptime output: 0:00  up 30 days,  6:02, 19 users, load averages: 15.01 12.66 11.64"$'\n'"Uptime output: 05:01:06 up 8 days,  4:03,  0 users,  load average: 3.87, 3.09, 2.71"$'\n'"stdout: lines:Number"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
requires="uptime"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceHash="097e41ee15602cdab3bc28d8a420362c8b93b425"
sourceLine="390"
stdout="lines:Number"$'\n'""
summary="Get the load average using uptime"
summaryComputed="true"
uptime_output="0:00  up 30 days,  6:02, 19 users, load averages: 15.01 12.66 11.64"$'\n'"05:01:06 up 8 days,  4:03,  0 users,  load average: 3.87, 3.09, 2.71"$'\n'""
usage="cpuLoadAverage [ --help ]"
