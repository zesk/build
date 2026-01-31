#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="user.sh"
description="The current user HOME (must exist)"$'\n'"Argument: pathSegment - String. Optional. Add these path segments to the HOME directory returned. Does not create them."$'\n'"No directories *should* be created by calling this, nor should any assumptions be made about the ability to read or write files in this directory."$'\n'"Return Code: 1 - Issue with \`buildEnvironmentGet HOME\` or \$HOME is not a directory (say, it's a file)"$'\n'"Return Code: 0 - Home directory exists."$'\n'""
file="bin/build/tools/user.sh"
foundNames=()
rawComment="The current user HOME (must exist)"$'\n'"Argument: pathSegment - String. Optional. Add these path segments to the HOME directory returned. Does not create them."$'\n'"No directories *should* be created by calling this, nor should any assumptions be made about the ability to read or write files in this directory."$'\n'"Return Code: 1 - Issue with \`buildEnvironmentGet HOME\` or \$HOME is not a directory (say, it's a file)"$'\n'"Return Code: 0 - Home directory exists."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/user.sh"
sourceHash="3e129c267173e6702926193e8e7d4f847f1f0619"
summary="The current user HOME (must exist)"
usage="userHome"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]muserHome'$'\e''[0m'$'\n'''$'\n''The current user HOME (must exist)'$'\n''Argument: pathSegment - String. Optional. Add these path segments to the HOME directory returned. Does not create them.'$'\n''No directories '$'\e''[[(cyan)]mshould'$'\e''[[(reset)]m be created by calling this, nor should any assumptions be made about the ability to read or write files in this directory.'$'\n''Return Code: 1 - Issue with '$'\e''[[(code)]mbuildEnvironmentGet HOME'$'\e''[[(reset)]m or $HOME is not a directory (say, it'\''s a file)'$'\n''Return Code: 0 - Home directory exists.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: userHome'$'\n'''$'\n''The current user HOME (must exist)'$'\n''Argument: pathSegment - String. Optional. Add these path segments to the HOME directory returned. Does not create them.'$'\n''No directories should be created by calling this, nor should any assumptions be made about the ability to read or write files in this directory.'$'\n''Return Code: 1 - Issue with buildEnvironmentGet HOME or $HOME is not a directory (say, it'\''s a file)'$'\n''Return Code: 0 - Home directory exists.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.429
