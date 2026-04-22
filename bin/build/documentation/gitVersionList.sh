#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
description="Fetches a list of tags from git and filters those which start with v and a digit and returns"$'\n'"them sorted by version correctly."$'\n'""
file="bin/build/tools/git.sh"
fn="gitVersionList"
foundNames=([0]="return_code" [1]="argument")
line="149"
lowerFn="gitversionlist"
rawComment="Fetches a list of tags from git and filters those which start with v and a digit and returns"$'\n'"them sorted by version correctly."$'\n'"Return Code: 1 - If the \`.git\` directory does not exist"$'\n'"Return Code: 0 - Success"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="1 - If the \`.git\` directory does not exist"$'\n'"0 - Success"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="149"
summary="Fetches a list of tags from git and filters those"
summaryComputed="true"
usage="gitVersionList [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitVersionList'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Fetches a list of tags from git and filters those which start with v and a digit and returns'$'\n''them sorted by version correctly.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If the '$'\e''[[(code)]m.git'$'\e''[[(reset)]m directory does not exist'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitVersionList [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Fetches a list of tags from git and filters those which start with v and a digit and returns'$'\n''them sorted by version correctly.'$'\n'''$'\n''Return codes:'$'\n''- 1 - If the .git directory does not exist'$'\n''- 0 - Success'$'\n'''
documentationPath="documentation/source/tools/git.md"
