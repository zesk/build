#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Fetches a list of tags from git and filters those which start with v and a digit and returns"$'\n'"them sorted by version correctly."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/git.sh"
fn="gitVersionList"
fnMarker="gitversionlist"
foundNames=([0]="return_code" [1]="argument")
line="149"
rawComment="Fetches a list of tags from git and filters those which start with v and a digit and returns"$'\n'"them sorted by version correctly."$'\n'"Return Code: 1 - If the \`.git\` directory does not exist"$'\n'"Return Code: 0 - Success"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="1 - If the \`.git\` directory does not exist"$'\n'"0 - Success"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="149"
summary="Fetches a list of tags from git and filters those"
summaryComputed="true"
usage="gitVersionList [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitVersionList'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Fetches a list of tags from git and filters those which start with v and a digit and returns'$'\n''them sorted by version correctly.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If the '$'\e''[[(code)]m.git'$'\e''[[(reset)]m directory does not exist'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'
# shellcheck disable=SC2016
helpPlain='Usage: gitVersionList [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Fetches a list of tags from git and filters those which start with v and a digit and returns'$'\n''them sorted by version correctly.'$'\n'''$'\n''Return codes:'$'\n''- 1 - If the .git directory does not exist'$'\n''- 0 - Success'
documentationPath="documentation/source/tools/git.md"
