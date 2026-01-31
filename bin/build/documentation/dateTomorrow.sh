#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="date.sh"
description="Summary: Tomorrow's date in UTC"$'\n'"Returns tomorrow's date (UTC time), in YYYY-MM-DD format. (same as \`%F\`)"$'\n'"Argument: --local - Flag. Optional. Local tomorrow"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     rotated=\"\$log.\$({fn})\""$'\n'""
file="bin/build/tools/date.sh"
foundNames=()
rawComment="Summary: Tomorrow's date in UTC"$'\n'"Returns tomorrow's date (UTC time), in YYYY-MM-DD format. (same as \`%F\`)"$'\n'"Argument: --local - Flag. Optional. Local tomorrow"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     rotated=\"\$log.\$({fn})\""$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceHash="9a217a468b4498cc58a48e05ea655c248a77d8c1"
summary="Summary: Tomorrow's date in UTC"
usage="dateTomorrow"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdateTomorrow'$'\e''[0m'$'\n'''$'\n''Summary: Tomorrow'\''s date in UTC'$'\n''Returns tomorrow'\''s date (UTC time), in YYYY-MM-DD format. (same as '$'\e''[[(code)]m%F'$'\e''[[(reset)]m)'$'\n''Argument: --local - Flag. Optional. Local tomorrow'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Example:     rotated="$log.$(dateTomorrow)"'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dateTomorrow'$'\n'''$'\n''Summary: Tomorrow'\''s date in UTC'$'\n''Returns tomorrow'\''s date (UTC time), in YYYY-MM-DD format. (same as %F)'$'\n''Argument: --local - Flag. Optional. Local tomorrow'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Example:     rotated="$log.$(dateTomorrow)"'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.461
