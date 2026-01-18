#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/date.sh"
argument="date - String in the form \`YYYY-MM-DD\` (e.g. \`2023-10-15\`)"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="date.sh"
description="Converts a date to an integer timestamp"$'\n'""$'\n'"Return Code: 1 - if parsing fails"$'\n'"Return Code: 0 - if parsing succeeds"$'\n'""
environment="Compatible with BSD and GNU date."$'\n'""
example="    timestamp=\$(dateToTimestamp '2023-10-15')"$'\n'""
file="bin/build/tools/date.sh"
fn="dateToTimestamp"
foundNames=([0]="argument" [1]="environment" [2]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/date.sh"
sourceModified="1768721469"
summary="Converts a date to an integer timestamp"
usage="dateToTimestamp [ date ] [ --help ]"
