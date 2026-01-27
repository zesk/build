#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"... - Arguments. Passed directly to \`grep\`."$'\n'""
base="text.sh"
description="\`grep\` but returns 0 when nothing matches"$'\n'"Allow blank files or no matches -"$'\n'"- \`grep\` - returns 1 - no lines selected"$'\n'"- \`grep\` - returns 0 - lines selected"$'\n'""
file="bin/build/tools/text.sh"
foundNames=([0]="see" [1]="return_code" [2]="argument" [3]="requires")
rawComment="\`grep\` but returns 0 when nothing matches"$'\n'"See: grep"$'\n'"Allow blank files or no matches -"$'\n'"- \`grep\` - returns 1 - no lines selected"$'\n'"- \`grep\` - returns 0 - lines selected"$'\n'"Return Code: 0 - Normal operation"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: ... - Arguments. Passed directly to \`grep\`."$'\n'"Requires: grep returnMap"$'\n'""$'\n'""
requires="grep returnMap"$'\n'""
return_code="0 - Normal operation"$'\n'""
see="grep"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1769320918"
summary="\`grep\` but returns 0 when nothing matches"
usage="grepSafe [ --help ] [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgrepSafe'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...     '$'\e''[[(value)]mArguments. Passed directly to '$'\e''[[(code)]mgrep'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n'''$'\e''[[(code)]mgrep'$'\e''[[(reset)]m but returns 0 when nothing matches'$'\n''Allow blank files or no matches -'$'\n''- '$'\e''[[(code)]mgrep'$'\e''[[(reset)]m - returns 1 - no lines selected'$'\n''- '$'\e''[[(code)]mgrep'$'\e''[[(reset)]m - returns 0 - lines selected'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Normal operation'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: grepSafe [ --help ] [ ... ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    ...     Arguments. Passed directly to grep.'$'\n'''$'\n''grep but returns 0 when nothing matches'$'\n''Allow blank files or no matches -'$'\n''- grep - returns 1 - no lines selected'$'\n''- grep - returns 0 - lines selected'$'\n'''$'\n''Return codes:'$'\n''- 0 - Normal operation'$'\n'''
# elapsed 0.464
