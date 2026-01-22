#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"directory - Directory. Required. The directory to add to the \`git\` \`safe.directory\` configuration directive"$'\n'""
base="git.sh"
description="When running git operations on a deployment host, at times it's necessary to"$'\n'"add the current directory (or a directory) to the git \`safe.directory\` directive."$'\n'""$'\n'"This adds the directory passed to that directory in the local user's environment"$'\n'""$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 2 - Argument is not a valid directory"$'\n'"Return Code: Other - git config error codes"$'\n'""$'\n'""
file="bin/build/tools/git.sh"
fn="gitEnsureSafeDirectory"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1768759336"
summary="When running git operations on a deployment host, at times"
usage="gitEnsureSafeDirectory [ --help ] directory"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitEnsureSafeDirectory[0m [94m[ --help ][0m [38;2;255;255;0m[35;48;2;0;0;0mdirectory[0m[0m

    [94m--help     [1;97mFlag. Optional. Display this help.[0m
    [31mdirectory  [1;97mDirectory. Required. The directory to add to the [38;2;0;255;0;48;2;0;0;0mgit[0m [38;2;0;255;0;48;2;0;0;0msafe.directory[0m configuration directive[0m

When running git operations on a deployment host, at times it'\''s necessary to
add the current directory (or a directory) to the git [38;2;0;255;0;48;2;0;0;0msafe.directory[0m directive.

This adds the directory passed to that directory in the local user'\''s environment

Return Code: 0 - Success
Return Code: 2 - Argument is not a valid directory
Return Code: Other - git config error codes

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: gitEnsureSafeDirectory [ --help ] directory

    --help     Flag. Optional. Display this help.
    directory  Directory. Required. The directory to add to the git safe.directory configuration directive

When running git operations on a deployment host, at times it'\''s necessary to
add the current directory (or a directory) to the git safe.directory directive.

This adds the directory passed to that directory in the local user'\''s environment

Return Code: 0 - Success
Return Code: 2 - Argument is not a valid directory
Return Code: Other - git config error codes

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
