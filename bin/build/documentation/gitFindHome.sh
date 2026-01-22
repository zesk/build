#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="startingDirectory - Directory. Optional."$'\n'""
base="git.sh"
description="Finds \`.git\` directory above or at \`startingDirectory\`"$'\n'""
file="bin/build/tools/git.sh"
fn="gitFindHome"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="findFileHome"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1768759336"
summary="Finds \`.git\` directory above or at \`startingDirectory\`"
usage="gitFindHome [ startingDirectory ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitFindHome[0m [94m[ startingDirectory ][0m

    [94mstartingDirectory  [1;97mDirectory. Optional.[0m

Finds [38;2;0;255;0;48;2;0;0;0m.git[0m directory above or at [38;2;0;255;0;48;2;0;0;0mstartingDirectory[0m

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: gitFindHome [ startingDirectory ]

    startingDirectory  Directory. Optional.

Finds .git directory above or at startingDirectory

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
