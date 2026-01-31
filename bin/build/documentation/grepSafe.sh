#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="text.sh"
description="\`grep\` but returns 0 when nothing matches"$'\n'"See: grep"$'\n'"Allow blank files or no matches -"$'\n'"- \`grep\` - returns 1 - no lines selected"$'\n'"- \`grep\` - returns 0 - lines selected"$'\n'"Return Code: 0 - Normal operation"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: ... - Arguments. Passed directly to \`grep\`."$'\n'"Requires: grep returnMap"$'\n'""
file="bin/build/tools/text.sh"
foundNames=()
rawComment="\`grep\` but returns 0 when nothing matches"$'\n'"See: grep"$'\n'"Allow blank files or no matches -"$'\n'"- \`grep\` - returns 1 - no lines selected"$'\n'"- \`grep\` - returns 0 - lines selected"$'\n'"Return Code: 0 - Normal operation"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: ... - Arguments. Passed directly to \`grep\`."$'\n'"Requires: grep returnMap"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="\`grep\` but returns 0 when nothing matches"
usage="grepSafe"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgrepSafe'$'\e''[0m'$'\n'''$'\n'''$'\e''[[(code)]mgrep'$'\e''[[(reset)]m but returns 0 when nothing matches'$'\n''See: grep'$'\n''Allow blank files or no matches -'$'\n''- '$'\e''[[(code)]mgrep'$'\e''[[(reset)]m - returns 1 - no lines selected'$'\n''- '$'\e''[[(code)]mgrep'$'\e''[[(reset)]m - returns 0 - lines selected'$'\n''Return Code: 0 - Normal operation'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: ... - Arguments. Passed directly to '$'\e''[[(code)]mgrep'$'\e''[[(reset)]m.'$'\n''Requires: grep returnMap'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: grepSafe'$'\n'''$'\n''grep but returns 0 when nothing matches'$'\n''See: grep'$'\n''Allow blank files or no matches -'$'\n''- grep - returns 1 - no lines selected'$'\n''- grep - returns 0 - lines selected'$'\n''Return Code: 0 - Normal operation'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: ... - Arguments. Passed directly to grep.'$'\n''Requires: grep returnMap'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.461
