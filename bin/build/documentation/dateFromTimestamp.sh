#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-29
# shellcheck disable=SC2034
argument="integerTimestamp - Integer. Required. Integer timestamp offset (unix timestamp, same as \`\$(date +%s)\`)"$'\n'"format - String. Optional. How to output the date (e.g. \`%F\` - no \`+\` is required)"$'\n'"--help - Flag. Optional. Display this help."$'\n'"--local - Flag. Optional. Show the local time, not UTC."$'\n'""
base="date.sh"
dateField=""
description="Converts an integer date to a date formatted timestamp (e.g. %Y-%m-%d %H:%M:%S)"$'\n'"dateFromTimestamp 1681966800 %F"$'\n'""
environment="Compatible with BSD and GNU date."$'\n'""
example="    dateField=\$(dateFromTimestamp \$init %Y)"$'\n'""
file="bin/build/tools/date.sh"
foundNames=([0]="argument" [1]="environment" [2]="return_code" [3]="example")
rawComment="Converts an integer date to a date formatted timestamp (e.g. %Y-%m-%d %H:%M:%S)"$'\n'"dateFromTimestamp 1681966800 %F"$'\n'"Argument: integerTimestamp - Integer. Required. Integer timestamp offset (unix timestamp, same as \`\$(date +%s)\`)"$'\n'"Argument: format - String. Optional. How to output the date (e.g. \`%F\` - no \`+\` is required)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --local - Flag. Optional. Show the local time, not UTC."$'\n'"Environment: Compatible with BSD and GNU date."$'\n'"Return Code: 0 - If parsing is successful"$'\n'"Return Code: 1 - If parsing fails"$'\n'"Example:     dateField=\$(dateFromTimestamp \$init %Y)"$'\n'""$'\n'""
return_code="0 - If parsing is successful"$'\n'"1 - If parsing fails"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceHash="9a217a468b4498cc58a48e05ea655c248a77d8c1"
summary="Converts an integer date to a date formatted timestamp (e.g."
usage="dateFromTimestamp integerTimestamp [ format ] [ --help ] [ --local ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdateFromTimestamp'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mintegerTimestamp'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ format ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --local ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mintegerTimestamp  '$'\e''[[(value)]mInteger. Required. Integer timestamp offset (unix timestamp, same as '$'\e''[[(code)]m$(date +%s)'$'\e''[[(reset)]m)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mformat            '$'\e''[[(value)]mString. Optional. How to output the date (e.g. '$'\e''[[(code)]m%F'$'\e''[[(reset)]m - no '$'\e''[[(code)]m+'$'\e''[[(reset)]m is required)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help            '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--local           '$'\e''[[(value)]mFlag. Optional. Show the local time, not UTC.'$'\e''[[(reset)]m'$'\n'''$'\n''Converts an integer date to a date formatted timestamp (e.g. %Y-%m-%d %H:%M:%S)'$'\n''dateFromTimestamp 1681966800 %F'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If parsing is successful'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If parsing fails'$'\n'''$'\n''Environment variables:'$'\n''- Compatible with BSD and GNU date.'$'\n'''$'\n''Example:'$'\n''    dateField=$(dateFromTimestamp $init %Y)'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mdateFromTimestamp [[(bold)]m[[(magenta)]mintegerTimestamp [ format ] [ --help ] [ --local ]'$'\n'''$'\n''    [[(red)]mintegerTimestamp  [[(value)]mInteger. Required. Integer timestamp offset (unix timestamp, same as [[(code)]m$(date +%s))'$'\n''    [[(red)]mformat            [[(value)]mString. Optional. How to output the date (e.g. [[(code)]m%F - no [[(code)]m+ is required)'$'\n''    --help            [[(value)]mFlag. Optional. Display this help.'$'\n''    --local           [[(value)]mFlag. Optional. Show the local time, not UTC.'$'\n'''$'\n''Converts an integer date to a date formatted timestamp (e.g. %Y-%m-%d %H:%M:%S)'$'\n''dateFromTimestamp 1681966800 %F'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - If parsing is successful'$'\n''- [[(code)]m1 - If parsing fails'$'\n'''$'\n''Environment variables:'$'\n''- Compatible with BSD and GNU date.'$'\n'''$'\n''Example:'$'\n''    dateField=$(dateFromTimestamp $init %Y)'$'\n'''
# elapsed 2.389
