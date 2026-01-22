#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"... - Arguments. Passed directly to \`grep\`."$'\n'""
base="text.sh"
description="\`grep\` but returns 0 when nothing matches"$'\n'"Allow blank files or no matches -"$'\n'"- \`grep\` - returns 1 - no lines selected"$'\n'"- \`grep\` - returns 0 - lines selected"$'\n'"Return Code: 0 - Normal operation"$'\n'""
file="bin/build/tools/text.sh"
fn="grepSafe"
requires="grep mapReturn"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="grep"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1768776345"
summary="\`grep\` but returns 0 when nothing matches"
usage="grepSafe [ --help ] [ ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgrepSafe[0m [94m[ --help ][0m [94m[ ... ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m
    [94m...     [1;97mArguments. Passed directly to [38;2;0;255;0;48;2;0;0;0mgrep[0m.[0m

[38;2;0;255;0;48;2;0;0;0mgrep[0m but returns 0 when nothing matches
Allow blank files or no matches -
- [38;2;0;255;0;48;2;0;0;0mgrep[0m - returns 1 - no lines selected
- [38;2;0;255;0;48;2;0;0;0mgrep[0m - returns 0 - lines selected
Return Code: 0 - Normal operation

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: grepSafe [ --help ] [ ... ]

    --help  Flag. Optional. Display this help.
    ...     Arguments. Passed directly to grep.

grep but returns 0 when nothing matches
Allow blank files or no matches -
- grep - returns 1 - no lines selected
- grep - returns 0 - lines selected
Return Code: 0 - Normal operation

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
