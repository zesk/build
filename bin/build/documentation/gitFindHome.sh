#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="startingDirectory - Directory. Optional."$'\n'""
base="git.sh"
description="Finds \`.git\` directory above or at \`startingDirectory\`"$'\n'""
file="bin/build/tools/git.sh"
foundNames=([0]="argument" [1]="see")
rawComment="Finds \`.git\` directory above or at \`startingDirectory\`"$'\n'"Argument: startingDirectory - Directory. Optional."$'\n'"See: findFileHome"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="findFileHome"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="6ddead0079491da7c7f55886b428a38512863e13"
summary="Finds \`.git\` directory above or at \`startingDirectory\`"
summaryComputed="true"
usage="gitFindHome [ startingDirectory ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitFindHome'$'\e''[0m '$'\e''[[(blue)]m[ startingDirectory ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mstartingDirectory  '$'\e''[[(value)]mDirectory. Optional.'$'\e''[[(reset)]m'$'\n'''$'\n''Finds '$'\e''[[(code)]m.git'$'\e''[[(reset)]m directory above or at '$'\e''[[(code)]mstartingDirectory'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mgitFindHome [[(blue)]m[ startingDirectory ]'$'\n'''$'\n''    [[(blue)]mstartingDirectory  Directory. Optional.'$'\n'''$'\n''Finds .git directory above or at startingDirectory'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
