#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="none"
base="git.sh"
description="Return Code: 1 - Already in main, staging, or HEAD, or git merge failed"$'\n'"Return Code: 0 - git merge succeeded"$'\n'"Merge \`staging\` and \`main\` branches of a git repository into the current branch."$'\n'""$'\n'"Will merge \`origin/staging\` and \`origin/main\` after doing a \`--pull\` for both of them"$'\n'""$'\n'"Current repository should be clean and have no modified files."$'\n'""$'\n'""
file="bin/build/tools/git.sh"
fn="gitMainly"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1768759336"
summary="Return Code: 1 - Already in main, staging, or HEAD,"
usage="gitMainly"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitMainly[0m

Return Code: 1 - Already in main, staging, or HEAD, or git merge failed
Return Code: 0 - git merge succeeded
Merge [38;2;0;255;0;48;2;0;0;0mstaging[0m and [38;2;0;255;0;48;2;0;0;0mmain[0m branches of a git repository into the current branch.

Will merge [38;2;0;255;0;48;2;0;0;0morigin/staging[0m and [38;2;0;255;0;48;2;0;0;0morigin/main[0m after doing a [38;2;0;255;0;48;2;0;0;0m--pull[0m for both of them

Current repository should be clean and have no modified files.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: gitMainly

Return Code: 1 - Already in main, staging, or HEAD, or git merge failed
Return Code: 0 - git merge succeeded
Merge staging and main branches of a git repository into the current branch.

Will merge origin/staging and origin/main after doing a --pull for both of them

Current repository should be clean and have no modified files.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
