#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/date.sh"
argument="--local - Flag. Optional. Local today."$'\n'"--help - Flag. Optional.Display this help."$'\n'""
base="date.sh"
description="Returns the current date, in YYYY-MM-DD format. (same as \`%F\`)"$'\n'""
environment="Compatible with BSD and GNU date."$'\n'""
example="    date=\"\$(todayDate)\""$'\n'""
file="bin/build/tools/date.sh"
fn="todayDate"
foundNames=([0]="summary" [1]="argument" [2]="environment" [3]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/date.sh"
sourceModified="1768695708"
summary="Today's date in UTC"$'\n'""
usage="todayDate [ --local ] [ --help ]"
