#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="cursor.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Get the current cursor position"$'\n'"Output is <x> <newline> <y> <newline>"$'\n'""$'\n'""
descriptionLineCount="3"
escape="ESC \`[6n\`"$'\n'""
example="    IFS=\$'\\n' read -r -d '' saveX saveY < <(cursorGet)"$'\n'""
file="bin/build/tools/cursor.sh"
fn="cursorGet"
fnMarker="cursorget"
foundNames=([0]="stdout" [1]="escape" [2]="example")
line="16"
rawComment="Get the current cursor position"$'\n'"Output is <x> <newline> <y> <newline>"$'\n'"stdout: UnsignedInteger"$'\n'"Escape: ESC \`[6n\`"$'\n'"Example:     IFS=\$'\\n' read -r -d '' saveX saveY < <(cursorGet)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/cursor.sh"
sourceHash="168857d25babe32c4b67235ad26a6f7d090b0a94"
sourceLine="16"
stdout="UnsignedInteger"$'\n'""
summary="Get the current cursor position"
summaryComputed="true"
usage="cursorGet"
