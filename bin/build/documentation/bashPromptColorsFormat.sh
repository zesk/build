#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/prompt.sh"
argument="text - String. Required. List of color names in a colon separated list."$'\n'""
base="prompt.sh"
description="Given a list of color names, generate the color codes in a colon separated list"$'\n'""
file="bin/build/tools/prompt.sh"
fn="bashPromptColorsFormat"
foundNames=([0]="argument" [1]="stdout" [2]="requires")
requires="decorations read inArray decorate listJoin"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/prompt.sh"
sourceModified="1768721469"
stdout="Outputs color *codes* separated by colons."$'\n'""
summary="Given a list of color names, generate the color codes"
usage="bashPromptColorsFormat text"
