#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
description="Check out a branch with the current version and optional formatting"$'\n'""$'\n'"\`BUILD_BRANCH_FORMAT\` is a string which can contain tokens in the form \`{user}\` and \`{version}\`"$'\n'""$'\n'"The default value is \`{version}-{user}\`"$'\n'""$'\n'""
environment="BUILD_BRANCH_FORMAT"$'\n'""
file="bin/build/tools/git.sh"
fn="gitBranchify"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1768759336"
summary="Check out a branch with the current version and optional"
usage="gitBranchify [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitBranchify[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Check out a branch with the current version and optional formatting

[38;2;0;255;0;48;2;0;0;0mBUILD_BRANCH_FORMAT[0m is a string which can contain tokens in the form [38;2;0;255;0;48;2;0;0;0m{user}[0m and [38;2;0;255;0;48;2;0;0;0m{version}[0m

The default value is [38;2;0;255;0;48;2;0;0;0m{version}-{user}[0m

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_BRANCH_FORMAT
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: gitBranchify [ --help ]

    --help  Flag. Optional. Display this help.

Check out a branch with the current version and optional formatting

BUILD_BRANCH_FORMAT is a string which can contain tokens in the form {user} and {version}

The default value is {version}-{user}

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_BRANCH_FORMAT
- 
'
