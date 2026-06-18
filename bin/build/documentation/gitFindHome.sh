#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-15
# shellcheck disable=SC2034
argument=$'startingDirectory - Directory. Optional.\n'
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Finds `.git` directory above or at `startingDirectory`.\n\n'
descriptionLineCount="2"
file="bin/build/tools/git.sh"
fn="gitFindHome"
fnMarker="gitfindhome"
foundNames=([0]="summary" [1]="argument")
line="438"
rawComment=$'Finds `.git` directory above or at `startingDirectory`.\nSummary: Find `git` home directory\nArgument: startingDirectory - Directory. Optional.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/git.sh"
sourceHash="a0d23919137c5539c67fd2fa09a1b037d4933cfd"
sourceLine="438"
summary="Find \`git\` home directory"
summaryComputed=""
usage="gitFindHome [ startingDirectory ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitFindHome'$'\e''[0m '$'\e''[[(blue)]m[ startingDirectory ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mstartingDirectory  '$'\e''[[(value)]mDirectory. Optional.'$'\e''[[(reset)]m'$'\n'''$'\n''Finds '$'\e''[[(code)]m.git'$'\e''[[(reset)]m directory above or at '$'\e''[[(code)]mstartingDirectory'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: gitFindHome [ startingDirectory ]'$'\n'''$'\n''    startingDirectory  Directory. Optional.'$'\n'''$'\n''Finds .git directory above or at startingDirectory.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/git.md"
