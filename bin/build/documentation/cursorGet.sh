#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/cursor.sh"
argument="none"
base="cursor.sh"
description="Get the current cursor position"$'\n'"Output is <x> <newline> <y> <newline>"$'\n'""
escape="ESC \`[6n\`"$'\n'""
example="    IFS=\$'\\n' read -r -d '' saveX saveY < <(cursorGet)"$'\n'""
file="bin/build/tools/cursor.sh"
fn="cursorGet"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/cursor.sh"
sourceModified="1768695708"
stdout="UnsignedInteger"$'\n'""
summary="Get the current cursor position"
usage="cursorGet"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mcursorGet[0m

Get the current cursor position
Output is <x> <newline> <y> <newline>

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
UnsignedInteger

Example:
    IFS=$'\''\n'\'' read -r -d '\'''\'' saveX saveY < <(cursorGet)
'
# shellcheck disable=SC2016
helpPlain='Usage: cursorGet

Get the current cursor position
Output is <x> <newline> <y> <newline>

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
UnsignedInteger

Example:
    IFS=$'\''\n'\'' read -r -d '\'''\'' saveX saveY < <(cursorGet)
'
