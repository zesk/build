#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"... - Arguments. Passed directly to \`grep\`."$'\n'""
base="text.sh"
description="\`grep\` but returns 0 when nothing matches"$'\n'"Allow blank files or no matches -"$'\n'"- \`grep\` - returns 1 - no lines selected"$'\n'"- \`grep\` - returns 0 - lines selected"$'\n'"Return Code: 0 - Normal operation"$'\n'""
file="bin/build/tools/text.sh"
fn="grepSafe"
foundNames=([0]="see" [1]="argument" [2]="requires")
requires="grep mapReturn"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="grep"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768759798"
summary="\`grep\` but returns 0 when nothing matches"
usage="grepSafe [ --help ] [ ... ]"
