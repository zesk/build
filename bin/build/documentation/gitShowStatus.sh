#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
credit="Chris Johnsen"$'\n'""
description="Return Code: 0 - the repo has been modified"$'\n'"Return Code: 1 - the repo has NOT bee modified"$'\n'""$'\n'"Show changed files from HEAD with their status prefix character:"$'\n'""$'\n'"- ' ' = unmodified"$'\n'"- \`M\` = modified"$'\n'"- \`A\` = added"$'\n'"- \`D\` = deleted"$'\n'"- \`R\` = renamed"$'\n'"- \`C\` = copied"$'\n'"- \`U\` = updated but unmerged"$'\n'""$'\n'"(See \`man git\` for more details on status flags)"$'\n'""$'\n'""$'\n'""
file="bin/build/tools/git.sh"
fn="gitShowStatus"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="https://stackoverflow.com/questions/3882838/whats-an-easy-way-to-detect-modified-files-in-a-git-workspace/3899339#3899339"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1769063211"
summary="Return Code: 0 - the repo has been modified"
usage="gitShowStatus [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitShowStatus[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Return Code: 0 - the repo has been modified
Return Code: 1 - the repo has NOT bee modified

Show changed files from HEAD with their status prefix character:

- '\'' '\'' = unmodified
- [38;2;0;255;0;48;2;0;0;0mM[0m = modified
- [38;2;0;255;0;48;2;0;0;0mA[0m = added
- [38;2;0;255;0;48;2;0;0;0mD[0m = deleted
- [38;2;0;255;0;48;2;0;0;0mR[0m = renamed
- [38;2;0;255;0;48;2;0;0;0mC[0m = copied
- [38;2;0;255;0;48;2;0;0;0mU[0m = updated but unmerged

(See [38;2;0;255;0;48;2;0;0;0mman git[0m for more details on status flags)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: gitShowStatus [ --help ]

    --help  Flag. Optional. Display this help.

Return Code: 0 - the repo has been modified
Return Code: 1 - the repo has NOT bee modified

Show changed files from HEAD with their status prefix character:

- '\'' '\'' = unmodified
- M = modified
- A = added
- D = deleted
- R = renamed
- C = copied
- U = updated but unmerged

(See man git for more details on status flags)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
