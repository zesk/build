#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/platform.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="platform.sh"
description="Get the load average using uptime"$'\n'"Uptime output: 0:00  up 30 days,  6:02, 19 users, load averages: 15.01 12.66 11.64"$'\n'"Uptime output: 05:01:06 up 8 days,  4:03,  0 users,  load average: 3.87, 3.09, 2.71"$'\n'""
file="bin/build/tools/platform.sh"
fn="loadAverage"
foundNames=([0]="requires" [1]="stdout" [2]="argument")
requires="uptime"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/platform.sh"
sourceModified="1768759698"
stdout="lines:Number"$'\n'""
summary="Get the load average using uptime"
usage="loadAverage [ --help ]"
