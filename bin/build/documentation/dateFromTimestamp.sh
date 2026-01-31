#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="date.sh"
description="Converts an integer date to a date formatted timestamp (e.g. %Y-%m-%d %H:%M:%S)"$'\n'"dateFromTimestamp 1681966800 %F"$'\n'"Argument: integerTimestamp - Integer. Required. Integer timestamp offset (unix timestamp, same as \`\$(date +%s)\`)"$'\n'"Argument: format - String. Optional. How to output the date (e.g. \`%F\` - no \`+\` is required)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --local - Flag. Optional. Show the local time, not UTC."$'\n'"Environment: Compatible with BSD and GNU date."$'\n'"Return Code: 0 - If parsing is successful"$'\n'"Return Code: 1 - If parsing fails"$'\n'"Example:     dateField=\$(dateFromTimestamp \$init %Y)"$'\n'""
file="bin/build/tools/date.sh"
foundNames=()
rawComment="Converts an integer date to a date formatted timestamp (e.g. %Y-%m-%d %H:%M:%S)"$'\n'"dateFromTimestamp 1681966800 %F"$'\n'"Argument: integerTimestamp - Integer. Required. Integer timestamp offset (unix timestamp, same as \`\$(date +%s)\`)"$'\n'"Argument: format - String. Optional. How to output the date (e.g. \`%F\` - no \`+\` is required)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --local - Flag. Optional. Show the local time, not UTC."$'\n'"Environment: Compatible with BSD and GNU date."$'\n'"Return Code: 0 - If parsing is successful"$'\n'"Return Code: 1 - If parsing fails"$'\n'"Example:     dateField=\$(dateFromTimestamp \$init %Y)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceHash="9a217a468b4498cc58a48e05ea655c248a77d8c1"
summary="Converts an integer date to a date formatted timestamp (e.g."
usage="dateFromTimestamp"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdateFromTimestamp'$'\e''[0m'$'\n'''$'\n''Converts an integer date to a date formatted timestamp (e.g. %Y-%m-%d %H:%M:%S)'$'\n''dateFromTimestamp 1681966800 %F'$'\n''Argument: integerTimestamp - Integer. Required. Integer timestamp offset (unix timestamp, same as '$'\e''[[(code)]m$(date +%s)'$'\e''[[(reset)]m)'$'\n''Argument: format - String. Optional. How to output the date (e.g. '$'\e''[[(code)]m%F'$'\e''[[(reset)]m - no '$'\e''[[(code)]m+'$'\e''[[(reset)]m is required)'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --local - Flag. Optional. Show the local time, not UTC.'$'\n''Environment: Compatible with BSD and GNU date.'$'\n''Return Code: 0 - If parsing is successful'$'\n''Return Code: 1 - If parsing fails'$'\n''Example:     dateField=$(dateFromTimestamp $init %Y)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dateFromTimestamp'$'\n'''$'\n''Converts an integer date to a date formatted timestamp (e.g. %Y-%m-%d %H:%M:%S)'$'\n''dateFromTimestamp 1681966800 %F'$'\n''Argument: integerTimestamp - Integer. Required. Integer timestamp offset (unix timestamp, same as $(date +%s))'$'\n''Argument: format - String. Optional. How to output the date (e.g. %F - no + is required)'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --local - Flag. Optional. Show the local time, not UTC.'$'\n''Environment: Compatible with BSD and GNU date.'$'\n''Return Code: 0 - If parsing is successful'$'\n''Return Code: 1 - If parsing fails'$'\n''Example:     dateField=$(dateFromTimestamp $init %Y)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.492
