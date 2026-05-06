#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="version.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Take one or more versions and strip the leading \`v\`"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/version.sh"
fn="versionNoVee"
fnMarker="versionnovee"
foundNames=([0]="stdin" [1]="stdout")
line="36"
rawComment="Take one or more versions and strip the leading \`v\`"$'\n'"stdin: Versions containing a preceding \`v\` character (optionally)"$'\n'"stdout: Versions with the initial \`v\` (if it exists) removed"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/version.sh"
sourceHash="8d1283d5353b479e2bc32aaf234efc0a9cb6570e"
sourceLine="36"
stdin="Versions containing a preceding \`v\` character (optionally)"$'\n'""
stdout="Versions with the initial \`v\` (if it exists) removed"$'\n'""
summary="Take one or more versions and strip the leading \`v\`"
summaryComputed="true"
usage="versionNoVee"
