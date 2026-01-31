#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="list.sh"
description="Output arguments joined by a character"$'\n'"Output: text"$'\n'"Argument: separator - EmptyString. Required. Single character to join elements. If a multi-character string is used only the first character is used as the delimiter."$'\n'"Argument: text0 ... - String. Optional. One or more strings to join"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""
file="bin/build/tools/list.sh"
foundNames=()
rawComment="Output arguments joined by a character"$'\n'"Output: text"$'\n'"Argument: separator - EmptyString. Required. Single character to join elements. If a multi-character string is used only the first character is used as the delimiter."$'\n'"Argument: text0 ... - String. Optional. One or more strings to join"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/list.sh"
sourceHash="d039b4726ef8e08c7e4f11ceb46d9ee4af719992"
summary="Output arguments joined by a character"
usage="listJoin"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mlistJoin'$'\e''[0m'$'\n'''$'\n''Output arguments joined by a character'$'\n''Output: text'$'\n''Argument: separator - EmptyString. Required. Single character to join elements. If a multi-character string is used only the first character is used as the delimiter.'$'\n''Argument: text0 ... - String. Optional. One or more strings to join'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: listJoin'$'\n'''$'\n''Output arguments joined by a character'$'\n''Output: text'$'\n''Argument: separator - EmptyString. Required. Single character to join elements. If a multi-character string is used only the first character is used as the delimiter.'$'\n''Argument: text0 ... - String. Optional. One or more strings to join'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.449
