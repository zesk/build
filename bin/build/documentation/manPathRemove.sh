#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"path ... - Directory. Required. The path to be removed from the \`MANPATH\` environment"$'\n'""
base="manpath.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Remove a path from the MANPATH environment variable"$'\n'""$'\n'""
descriptionLineCount="2"
environment="MANPATH"$'\n'""
file="bin/build/tools/manpath.sh"
fn="manPathRemove"
fnMarker="manpathremove"
foundNames=([0]="argument" [1]="environment")
line="37"
rawComment="Remove a path from the MANPATH environment variable"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: path ... - Directory. Required. The path to be removed from the \`MANPATH\` environment"$'\n'"Environment: MANPATH"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/manpath.sh"
sourceHash="3610cefbf165c42a60f9d8dc4e7f3fbae16965f5"
sourceLine="37"
summary="Remove a path from the MANPATH environment variable"
summaryComputed="true"
usage="manPathRemove [ --help ] path ..."
