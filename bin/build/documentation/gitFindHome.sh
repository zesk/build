#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="startingDirectory - Directory. Optional."$'\n'""
base="git.sh"
description="Finds \`.git\` directory above or at \`startingDirectory\`"$'\n'""
file="bin/build/tools/git.sh"
fn="gitFindHome"
foundNames=([0]="argument" [1]="see")
line="438"
lowerFn="gitfindhome"
rawComment="Finds \`.git\` directory above or at \`startingDirectory\`"$'\n'"Argument: startingDirectory - Directory. Optional."$'\n'"See: findFileHome"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="findFileHome"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="4f7e4ceea530507ccd2bd4a042d5d5d5b9ef4356"
sourceLine="438"
summary="Finds \`.git\` directory above or at \`startingDirectory\`"
summaryComputed="true"
usage="gitFindHome [ startingDirectory ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitFindHome'$'\e''[0m '$'\e''[[(blue)]m[ startingDirectory ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mstartingDirectory  '$'\e''[[(value)]mDirectory. Optional.'$'\e''[[(reset)]m'$'\n'''$'\n''Finds '$'\e''[[(code)]m.git'$'\e''[[(reset)]m directory above or at '$'\e''[[(code)]mstartingDirectory'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitFindHome [ startingDirectory ]'$'\n'''$'\n''    startingDirectory  Directory. Optional.'$'\n'''$'\n''Finds .git directory above or at startingDirectory'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/git.md"
