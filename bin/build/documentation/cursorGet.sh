#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/cursor.sh"
argument="none"
base="cursor.sh"
description="Get the current cursor position"$'\n'"Output is <x> <newline> <y> <newline>"$'\n'""
escape="ESC \`[6n\`"$'\n'""
example="    IFS=\$'\\n' read -r -d '' saveX saveY < <(cursorGet)"$'\n'""
file="bin/build/tools/cursor.sh"
fn="cursorGet"
foundNames=([0]="stdout" [1]="escape" [2]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/cursor.sh"
sourceModified="1768695708"
stdout="UnsignedInteger"$'\n'""
summary="Get the current cursor position"
usage="cursorGet"
