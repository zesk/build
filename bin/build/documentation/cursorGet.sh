#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="cursor.sh"
description="Get the current cursor position"$'\n'"Output is <x> <newline> <y> <newline>"$'\n'"stdout: UnsignedInteger"$'\n'"Escape: ESC \`[6n\`"$'\n'"Example:     IFS=\$'\\n' read -r -d '' saveX saveY < <(cursorGet)"$'\n'"shellcheck disable=SC2120"$'\n'""
file="bin/build/tools/cursor.sh"
foundNames=()
rawComment="Get the current cursor position"$'\n'"Output is <x> <newline> <y> <newline>"$'\n'"stdout: UnsignedInteger"$'\n'"Escape: ESC \`[6n\`"$'\n'"Example:     IFS=\$'\\n' read -r -d '' saveX saveY < <(cursorGet)"$'\n'"shellcheck disable=SC2120"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/cursor.sh"
sourceHash="79998c6dbf00b2a809818d191e98d04009983e12"
summary="Get the current cursor position"
usage="cursorGet"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcursorGet'$'\e''[0m'$'\n'''$'\n''Get the current cursor position'$'\n''Output is <x> <newline> <y> <newline>'$'\n''stdout: UnsignedInteger'$'\n''Escape: ESC '$'\e''[[(code)]m[6n'$'\e''[[(reset)]m'$'\n''Example:     IFS=$'\''\n'\'' read -r -d '\'''\'' saveX saveY < <(cursorGet)'$'\n''shellcheck disable=SC2120'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: cursorGet'$'\n'''$'\n''Get the current cursor position'$'\n''Output is <x> <newline> <y> <newline>'$'\n''stdout: UnsignedInteger'$'\n''Escape: ESC [6n'$'\n''Example:     IFS=$'\''\n'\'' read -r -d '\'''\'' saveX saveY < <(cursorGet)'$'\n''shellcheck disable=SC2120'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.467
