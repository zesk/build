#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--first - Flag. Optional. Place any paths after this flag first in the list"$'\n'"--last - Flag. Optional. Place any paths after this flag last in the list. Default."$'\n'"path - the path to be added to the \`MANPATH\` environment"$'\n'""
base="manpath.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Modify the MANPATH environment variable to add a path."$'\n'""$'\n'""
descriptionLineCount="2"
environment="MANPATH"$'\n'""
file="bin/build/tools/manpath.sh"
fn="manPathConfigure"
fnMarker="manpathconfigure"
foundNames=([0]="see" [1]="argument" [2]="environment")
line="16"
rawComment="Modify the MANPATH environment variable to add a path."$'\n'"See: manPathRemove"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --first - Flag. Optional. Place any paths after this flag first in the list"$'\n'"Argument: --last - Flag. Optional. Place any paths after this flag last in the list. Default."$'\n'"Argument: path - the path to be added to the \`MANPATH\` environment"$'\n'"Environment: MANPATH"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="manPathRemove"$'\n'""
sourceFile="bin/build/tools/manpath.sh"
sourceHash="3610cefbf165c42a60f9d8dc4e7f3fbae16965f5"
sourceLine="16"
summary="Modify the MANPATH environment variable to add a path."
summaryComputed="true"
usage="manPathConfigure [ --help ] [ --first ] [ --last ] [ path ]"
