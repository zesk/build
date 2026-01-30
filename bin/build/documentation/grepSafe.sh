#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
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
sourceHash="fe2d9b708c7989f56c14d5c18c68077ff92c9081"
summary="\`grep\` but returns 0 when nothing matches"
usage="grepSafe [ --help ] [ ... ]"
