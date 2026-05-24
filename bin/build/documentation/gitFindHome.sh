#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'startingDirectory - Directory. Optional.\n'
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Finds `.git` directory above or at `startingDirectory`\n\n'
descriptionLineCount="2"
file="bin/build/tools/git.sh"
fn="gitFindHome"
fnMarker="gitfindhome"
foundNames=([0]="argument" [1]="see")
line="438"
rawComment=$'Finds `.git` directory above or at `startingDirectory`\nArgument: startingDirectory - Directory. Optional.\nSee: findFileHome\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'findFileHome\n'
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="438"
summary="Finds \`.git\` directory above or at \`startingDirectory\`"
summaryComputed="true"
usage="gitFindHome [ startingDirectory ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitFindHome'$'\e''[0m '$'\e''[[(blue)]m[ startingDirectory ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mstartingDirectory  '$'\e''[[(value)]mDirectory. Optional.'$'\e''[[(reset)]m'$'\n'''$'\n''Finds '$'\e''[[(code)]m.git'$'\e''[[(reset)]m directory above or at '$'\e''[[(code)]mstartingDirectory'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: gitFindHome [ startingDirectory ]'$'\n'''$'\n''    startingDirectory  Directory. Optional.'$'\n'''$'\n''Finds .git directory above or at startingDirectory'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/git.md"
