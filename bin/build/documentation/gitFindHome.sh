#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="startingDirectory - Directory. Optional."$'\n'""
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Finds \`.git\` directory above or at \`startingDirectory\`"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/git.sh"
fn="gitFindHome"
fnMarker="gitfindhome"
foundNames=([0]="argument" [1]="see")
line="438"
rawComment="Finds \`.git\` directory above or at \`startingDirectory\`"$'\n'"Argument: startingDirectory - Directory. Optional."$'\n'"See: findFileHome"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="findFileHome"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="438"
summary="Finds \`.git\` directory above or at \`startingDirectory\`"
summaryComputed="true"
usage="gitFindHome [ startingDirectory ]"
