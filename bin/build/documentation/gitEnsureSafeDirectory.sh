#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\ndirectory - Directory. Required. The directory to add to the `git` `safe.directory` configuration directive\n'
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'When running git operations on a deployment host, at times it\'s necessary to\nadd the current directory (or a directory) to the git `safe.directory` directive.\n\nThis adds the directory passed to that directory in the local user\'s environment\n\n'
descriptionLineCount="5"
file="bin/build/tools/git.sh"
fn="gitEnsureSafeDirectory"
fnMarker="gitensuresafedirectory"
foundNames=([0]="argument" [1]="return_code")
line="63"
original="gitEnsureSafeDirectory"
rawComment=$'When running git operations on a deployment host, at times it\'s necessary to\nadd the current directory (or a directory) to the git `safe.directory` directive.\nThis adds the directory passed to that directory in the local user\'s environment\nArgument: --help - Flag. Optional. Display this help.\nArgument: directory - Directory. Required. The directory to add to the `git` `safe.directory` configuration directive\nReturn Code: 0 - Success\nReturn Code: 2 - Argument is not a valid directory\nReturn Code: Other - git config error codes\n\n'
return_code=$'0 - Success\n2 - Argument is not a valid directory\nOther - git config error codes\n'
sourceFile="bin/build/tools/git.sh"
sourceHash="5e91a5d4b3beafc28e8b01755133cb215bd453d8"
sourceLine="63"
summary="When running git operations on a deployment host, at times"
summaryComputed="true"
usage="gitEnsureSafeDirectory [ --help ] directory"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitEnsureSafeDirectory'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mdirectory'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mdirectory  '$'\e''[[(value)]mDirectory. Required. The directory to add to the '$'\e''[[(code)]mgit'$'\e''[[(reset)]m '$'\e''[[(code)]msafe.directory'$'\e''[[(reset)]m configuration directive'$'\e''[[(reset)]m'$'\n'''$'\n''When running git operations on a deployment host, at times it'\''s necessary to'$'\n''add the current directory (or a directory) to the git '$'\e''[[(code)]msafe.directory'$'\e''[[(reset)]m directive.'$'\n'''$'\n''This adds the directory passed to that directory in the local user'\''s environment'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument is not a valid directory'$'\n''- '$'\e''[[(code)]mOther'$'\e''[[(reset)]m - git config error codes'
# shellcheck disable=SC2016
helpPlain='Usage: gitEnsureSafeDirectory [ --help ] directory'$'\n'''$'\n''    --help     Flag. Optional. Display this help.'$'\n''    directory  Directory. Required. The directory to add to the git safe.directory configuration directive'$'\n'''$'\n''When running git operations on a deployment host, at times it'\''s necessary to'$'\n''add the current directory (or a directory) to the git safe.directory directive.'$'\n'''$'\n''This adds the directory passed to that directory in the local user'\''s environment'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 2 - Argument is not a valid directory'$'\n''- Other - git config error codes'
documentationPath="documentation/source/tools/git.md"
