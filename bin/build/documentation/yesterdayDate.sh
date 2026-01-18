#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/date.sh"
argument="--local - Flag. Optional. Local yesterday"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="date.sh"
description="Returns yesterday's date, in YYYY-MM-DD format. (same as \`%F\`)"$'\n'""$'\n'""
example="    rotated=\"\$log.\$(yesterdayDate --local)\""$'\n'""
file="bin/build/tools/date.sh"
fn="yesterdayDate"
foundNames=([0]="summary" [1]="argument" [2]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/date.sh"
sourceModified="1768721469"
summary="Yesterday's date (UTC time)"$'\n'""
usage="yesterdayDate [ --local ] [ --help ]"
