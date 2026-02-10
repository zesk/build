#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-10
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"directory - Directory. Required. The directory to add to the \`git\` \`safe.directory\` configuration directive"$'\n'""
base="git.sh"
description="When running git operations on a deployment host, at times it's necessary to"$'\n'"add the current directory (or a directory) to the git \`safe.directory\` directive."$'\n'"This adds the directory passed to that directory in the local user's environment"$'\n'""
file="bin/build/tools/git.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="When running git operations on a deployment host, at times it's necessary to"$'\n'"add the current directory (or a directory) to the git \`safe.directory\` directive."$'\n'"This adds the directory passed to that directory in the local user's environment"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: directory - Directory. Required. The directory to add to the \`git\` \`safe.directory\` configuration directive"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 2 - Argument is not a valid directory"$'\n'"Return Code: Other - git config error codes"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"2 - Argument is not a valid directory"$'\n'"Other - git config error codes"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="d861975b11d1fbf7234ff66f942c86779f09fac7"
summary="When running git operations on a deployment host, at times"
summaryComputed="true"
usage="gitEnsureSafeDirectory [ --help ] directory"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitEnsureSafeDirectory'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mdirectory'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mdirectory  '$'\e''[[(value)]mDirectory. Required. The directory to add to the '$'\e''[[(code)]mgit'$'\e''[[(reset)]m '$'\e''[[(code)]msafe.directory'$'\e''[[(reset)]m configuration directive'$'\e''[[(reset)]m'$'\n'''$'\n''When running git operations on a deployment host, at times it'\''s necessary to'$'\n''add the current directory (or a directory) to the git '$'\e''[[(code)]msafe.directory'$'\e''[[(reset)]m directive.'$'\n''This adds the directory passed to that directory in the local user'\''s environment'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument is not a valid directory'$'\n''- '$'\e''[[(code)]mOther'$'\e''[[(reset)]m - git config error codes'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitEnsureSafeDirectory [ --help ] directory'$'\n'''$'\n''    --help     Flag. Optional. Display this help.'$'\n''    directory  Directory. Required. The directory to add to the git safe.directory configuration directive'$'\n'''$'\n''When running git operations on a deployment host, at times it'\''s necessary to'$'\n''add the current directory (or a directory) to the git safe.directory directive.'$'\n''This adds the directory passed to that directory in the local user'\''s environment'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 2 - Argument is not a valid directory'$'\n''- Other - git config error codes'$'\n'''
