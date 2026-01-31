#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="git.sh"
description="Finds \`.git\` directory above or at \`startingDirectory\`"$'\n'"Argument: startingDirectory - Directory. Optional."$'\n'"See: findFileHome"$'\n'""
file="bin/build/tools/git.sh"
foundNames=()
rawComment="Finds \`.git\` directory above or at \`startingDirectory\`"$'\n'"Argument: startingDirectory - Directory. Optional."$'\n'"See: findFileHome"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="3d571e2d1ac61ab50aca59a14e16e0ada007496b"
summary="Finds \`.git\` directory above or at \`startingDirectory\`"
usage="gitFindHome"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitFindHome'$'\e''[0m'$'\n'''$'\n''Finds '$'\e''[[(code)]m.git'$'\e''[[(reset)]m directory above or at '$'\e''[[(code)]mstartingDirectory'$'\e''[[(reset)]m'$'\n''Argument: startingDirectory - Directory. Optional.'$'\n''See: findFileHome'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitFindHome'$'\n'''$'\n''Finds .git directory above or at startingDirectory'$'\n''Argument: startingDirectory - Directory. Optional.'$'\n''See: findFileHome'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.469
