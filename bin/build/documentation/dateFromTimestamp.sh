#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="integerTimestamp - Integer. Required. Integer. Required. Integer timestamp offset (Seconds since 1/1/1970 UTC, same as \`\$(date +%s)\`)"$'\n'"format - String. Optional. How to output the date (e.g. \`%F\` - no \`+\` is required)"$'\n'"--help - Flag. Optional. Display this help."$'\n'"--local - Flag. Optional. Show the local time, not UTC."$'\n'""
base="date.sh"
dateField=""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Converts an integer date to a date formatted timestamp (e.g. \`%Y-%m-%d %H:%M:%S\`)"$'\n'""$'\n'""
descriptionLineCount="2"
environment="Compatible with BSD and GNU date."$'\n'""
example="    dateFromTimestamp 1681966800 %F"$'\n'"    dateField=\$(dateFromTimestamp \$init %Y)"$'\n'""
file="bin/build/tools/date.sh"
fn="dateFromTimestamp"
fnMarker="datefromtimestamp"
foundNames=([0]="example" [1]="argument" [2]="environment" [3]="return_code" [4]="requires")
line="75"
rawComment="Converts an integer date to a date formatted timestamp (e.g. \`%Y-%m-%d %H:%M:%S\`)"$'\n'"Example:     dateFromTimestamp 1681966800 %F"$'\n'"Argument: integerTimestamp - Integer. Required. Integer. Required. Integer timestamp offset (Seconds since 1/1/1970 UTC, same as \`\$(date +%s)\`)"$'\n'"Argument: format - String. Optional. How to output the date (e.g. \`%F\` - no \`+\` is required)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --local - Flag. Optional. Show the local time, not UTC."$'\n'"Environment: Compatible with BSD and GNU date."$'\n'"Return Code: 0 - If parsing is successful"$'\n'"Return Code: 1 - If parsing fails"$'\n'"Example:     dateField=\$(dateFromTimestamp \$init %Y)"$'\n'"Requires: throwArgument decorate validate __dateFromTimestamp bashDocumentation"$'\n'""$'\n'""
requires="throwArgument decorate validate __dateFromTimestamp bashDocumentation"$'\n'""
return_code="0 - If parsing is successful"$'\n'"1 - If parsing fails"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceHash="8b6a5808143207c1b2329179a4d73d95ea46d8cc"
sourceLine="75"
summary="Converts an integer date to a date formatted timestamp (e.g."
summaryComputed="true"
usage="dateFromTimestamp integerTimestamp [ format ] [ --help ] [ --local ]"
