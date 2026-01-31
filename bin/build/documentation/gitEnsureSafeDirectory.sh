#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="git.sh"
description="When running git operations on a deployment host, at times it's necessary to"$'\n'"add the current directory (or a directory) to the git \`safe.directory\` directive."$'\n'"This adds the directory passed to that directory in the local user's environment"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: directory - Directory. Required. The directory to add to the \`git\` \`safe.directory\` configuration directive"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 2 - Argument is not a valid directory"$'\n'"Return Code: Other - git config error codes"$'\n'""
file="bin/build/tools/git.sh"
foundNames=()
rawComment="When running git operations on a deployment host, at times it's necessary to"$'\n'"add the current directory (or a directory) to the git \`safe.directory\` directive."$'\n'"This adds the directory passed to that directory in the local user's environment"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: directory - Directory. Required. The directory to add to the \`git\` \`safe.directory\` configuration directive"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 2 - Argument is not a valid directory"$'\n'"Return Code: Other - git config error codes"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="3d571e2d1ac61ab50aca59a14e16e0ada007496b"
summary="When running git operations on a deployment host, at times"
usage="gitEnsureSafeDirectory"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitEnsureSafeDirectory'$'\e''[0m'$'\n'''$'\n''When running git operations on a deployment host, at times it'\''s necessary to'$'\n''add the current directory (or a directory) to the git '$'\e''[[(code)]msafe.directory'$'\e''[[(reset)]m directive.'$'\n''This adds the directory passed to that directory in the local user'\''s environment'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: directory - Directory. Required. The directory to add to the '$'\e''[[(code)]mgit'$'\e''[[(reset)]m '$'\e''[[(code)]msafe.directory'$'\e''[[(reset)]m configuration directive'$'\n''Return Code: 0 - Success'$'\n''Return Code: 2 - Argument is not a valid directory'$'\n''Return Code: Other - git config error codes'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitEnsureSafeDirectory'$'\n'''$'\n''When running git operations on a deployment host, at times it'\''s necessary to'$'\n''add the current directory (or a directory) to the git safe.directory directive.'$'\n''This adds the directory passed to that directory in the local user'\''s environment'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: directory - Directory. Required. The directory to add to the git safe.directory configuration directive'$'\n''Return Code: 0 - Success'$'\n''Return Code: 2 - Argument is not a valid directory'$'\n''Return Code: Other - git config error codes'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.494
