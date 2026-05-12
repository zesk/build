#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-12
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"... - Arguments. Passed directly to \`grep\`."$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="\`grep\` but returns 0 when nothing matches"$'\n'""$'\n'"Allow blank files or no matches:"$'\n'""$'\n'"- \`grep\` - returns 1 - no lines selected"$'\n'"- \`grep\` - returns 0 - lines selected"$'\n'""$'\n'""
descriptionLineCount="7"
file="bin/build/tools/text.sh"
fn="grepSafe"
fnMarker="grepsafe"
foundNames=([0]="return_code" [1]="argument" [2]="see" [3]="requires")
line="75"
rawComment="\`grep\` but returns 0 when nothing matches"$'\n'"Allow blank files or no matches:"$'\n'"- \`grep\` - returns 1 - no lines selected"$'\n'"- \`grep\` - returns 0 - lines selected"$'\n'"Return Code: 0 - Normal operation"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: ... - Arguments. Passed directly to \`grep\`."$'\n'"See: grep"$'\n'"Requires: grep returnMap"$'\n'""$'\n'""
requires="grep returnMap"$'\n'""
return_code="0 - Normal operation"$'\n'""
see="grep"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="b913e34543d2ae704942cadce5473f26955cd42e"
sourceLine="75"
summary="\`grep\` but returns 0 when nothing matches"
summaryComputed="true"
usage="grepSafe [ --help ] [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgrepSafe'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...     '$'\e''[[(value)]mArguments. Passed directly to '$'\e''[[(code)]mgrep'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n'''$'\e''[[(code)]mgrep'$'\e''[[(reset)]m but returns 0 when nothing matches'$'\n'''$'\n''Allow blank files or no matches:'$'\n'''$'\n''- '$'\e''[[(code)]mgrep'$'\e''[[(reset)]m - returns 1 - no lines selected'$'\n''- '$'\e''[[(code)]mgrep'$'\e''[[(reset)]m - returns 0 - lines selected'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Normal operation'
# shellcheck disable=SC2016
helpPlain='Usage: grepSafe [ --help ] [ ... ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    ...     Arguments. Passed directly to grep.'$'\n'''$'\n''grep but returns 0 when nothing matches'$'\n'''$'\n''Allow blank files or no matches:'$'\n'''$'\n''- grep - returns 1 - no lines selected'$'\n''- grep - returns 0 - lines selected'$'\n'''$'\n''Return codes:'$'\n''- 0 - Normal operation'
documentationPath="documentation/source/tools/text.md"
