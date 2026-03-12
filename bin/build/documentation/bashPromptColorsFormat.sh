#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="text - String. Required. List of color names in a colon separated list."$'\n'""
base="prompt.sh"
description="Given a list of color names, generate the color codes in a colon separated list"$'\n'""
file="bin/build/tools/prompt.sh"
fn="bashPromptColorsFormat"
foundNames=([0]="argument" [1]="stdout" [2]="requires")
rawComment="Given a list of color names, generate the color codes in a colon separated list"$'\n'"Argument: text - String. Required. List of color names in a colon separated list."$'\n'"stdout: Outputs color *codes* separated by colons."$'\n'"Requires: decorations read inArray decorate listJoin"$'\n'""$'\n'""
requires="decorations read inArray decorate listJoin"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/prompt.sh"
sourceHash="6366b89e08fb52dd710f1f586d8a48d1dab1509d"
stdout="Outputs color *codes* separated by colons."$'\n'""
summary="Given a list of color names, generate the color codes"
summaryComputed="true"
usage="bashPromptColorsFormat text"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
