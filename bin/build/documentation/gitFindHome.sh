#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="startingDirectory - Directory. Optional."$'\n'""
base="git.sh"
description="Finds \`.git\` directory above or at \`startingDirectory\`"$'\n'""
file="bin/build/tools/git.sh"
fn="gitFindHome"
foundNames=([0]="argument" [1]="see")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="findFileHome"$'\n'""
source="bin/build/tools/git.sh"
sourceModified="1768759336"
summary="Finds \`.git\` directory above or at \`startingDirectory\`"
usage="gitFindHome [ startingDirectory ]"
