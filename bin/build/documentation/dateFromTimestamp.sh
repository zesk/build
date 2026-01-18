#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/date.sh"
argument="integerTimestamp - Integer. Required. Integer timestamp offset (unix timestamp, same as \`\$(date +%s)\`)"$'\n'"format - String. Optional. How to output the date (e.g. \`%F\` - no \`+\` is required)"$'\n'"--help - Flag. Optional. Display this help."$'\n'"--local - Flag. Optional. Show the local time, not UTC."$'\n'""
base="date.sh"
description="Converts an integer date to a date formatted timestamp (e.g. %Y-%m-%d %H:%M:%S)"$'\n'""$'\n'"dateFromTimestamp 1681966800 %F"$'\n'""$'\n'"Return Code: 0 - If parsing is successful"$'\n'"Return Code: 1 - If parsing fails"$'\n'""
environment="Compatible with BSD and GNU date."$'\n'""
example="    dateField=\$(dateFromTimestamp \$init %Y)"$'\n'""
file="bin/build/tools/date.sh"
fn="dateFromTimestamp"
foundNames=([0]="argument" [1]="environment" [2]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/date.sh"
sourceModified="1768721469"
summary="Converts an integer date to a date formatted timestamp (e.g."
usage="dateFromTimestamp integerTimestamp [ format ] [ --help ] [ --local ]"
