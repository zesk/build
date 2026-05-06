#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="path - String. Output a json path separated by dots."$'\n'""
base="json.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Generate a path for a JSON structure for use in \`jq\` queries"$'\n'""$'\n'"Without arguments, displays help."$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/json.sh"
fn="jsonPath"
fnMarker="jsonpath"
foundNames=([0]="summary" [1]="argument")
line="48"
rawComment="Summary: Generate \`jq\` paths"$'\n'"Generate a path for a JSON structure for use in \`jq\` queries"$'\n'"Argument: path - String. Output a json path separated by dots."$'\n'"Without arguments, displays help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/json.sh"
sourceHash="e4fa7a237368db1e6a6969ecf3a1c6f05241d727"
sourceLine="48"
summary="Generate \`jq\` paths"
summaryComputed=""
usage="jsonPath [ path ]"
