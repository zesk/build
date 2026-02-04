#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-04
# shellcheck disable=SC2034
argument="none"
base="cursor.sh"
description="Get the current cursor position"$'\n'"Output is <x> <newline> <y> <newline>"$'\n'""
escape="ESC \`[6n\`"$'\n'""
example="    IFS=\$'\\n' read -r -d '' saveX saveY < <(cursorGet)"$'\n'""
file="bin/build/tools/cursor.sh"
foundNames=([0]="stdout" [1]="escape" [2]="example")
rawComment="Get the current cursor position"$'\n'"Output is <x> <newline> <y> <newline>"$'\n'"stdout: UnsignedInteger"$'\n'"Escape: ESC \`[6n\`"$'\n'"Example:     IFS=\$'\\n' read -r -d '' saveX saveY < <(cursorGet)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/cursor.sh"
sourceHash="4eb5c20ecdc0bafecbdb034fb652f03796dae5fe"
stdout="UnsignedInteger"$'\n'""
summary="Get the current cursor position"
summaryComputed="true"
usage="cursorGet"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcursorGet'$'\e''[0m'$'\n'''$'\n''Get the current cursor position'$'\n''Output is <x> <newline> <y> <newline>'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''UnsignedInteger'$'\n'''$'\n''Example:'$'\n''    IFS=$'\''\n'\'' read -r -d '\'''\'' saveX saveY < <(cursorGet)'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mcursorGet'$'\n'''$'\n''Get the current cursor position'$'\n''Output is <x> <newline> <y> <newline>'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''UnsignedInteger'$'\n'''$'\n''Example:'$'\n''    IFS=$'\''\n'\'' read -r -d '\'''\'' saveX saveY < <(cursorGet)'$'\n'''
