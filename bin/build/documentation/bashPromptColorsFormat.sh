#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="text - String. Required. List of color names in a colon separated list."$'\n'""
base="prompt.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Given a list of color names, generate the color codes in a colon separated list"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/prompt.sh"
fn="bashPromptColorsFormat"
fnMarker="bashpromptcolorsformat"
foundNames=([0]="argument" [1]="stdout" [2]="requires")
line="196"
rawComment="Given a list of color names, generate the color codes in a colon separated list"$'\n'"Argument: text - String. Required. List of color names in a colon separated list."$'\n'"stdout: Outputs color *codes* separated by colons."$'\n'"Requires: decorations read inArray decorate listJoin"$'\n'""$'\n'""
requires="decorations read inArray decorate listJoin"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/prompt.sh"
sourceHash="b61c792ae723865297730f9775c4f0b5fcba937d"
sourceLine="196"
stdout="Outputs color *codes* separated by colons."$'\n'""
summary="Given a list of color names, generate the color codes"
summaryComputed="true"
usage="bashPromptColorsFormat text"
