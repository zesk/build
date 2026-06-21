#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-21
# shellcheck disable=SC2034
argument=$'style - CommaDelimitedList. Required. Style arguments passed directly to decorate for each item.\ntext ... - EmptyString. Optional. Text to format. Use `--` to output begin codes only.\n'
base="core.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Add bold style to another style"
descriptionLineCount=""
example=$'> `decorate BOLD info Info is more important`\n**`Info is more important`**\n'
file="bin/build/tools/decorate/core.sh"
fn="decorate BOLD"
fnMarker="__decorateextensionbold"
foundNames=([0]="fn" [1]="summary" [2]="example" [3]="argument")
line="314"
original="__decorateExtensionBOLD"
rawComment=$'fn: decorate BOLD\nSummary: Add bold style to another style\nExample: > `decorate BOLD info Info is more important`\nExample: **`Info is more important`**\nArgument: style - CommaDelimitedList. Required. Style arguments passed directly to decorate for each item.\nArgument: text ... - EmptyString. Optional. Text to format. Use `--` to output begin codes only.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/decorate/core.sh"
sourceHash="3725cb28e12948a0b0e952bb332cba7a3044c792"
sourceLine="314"
summary="Add bold style to another style"
summaryComputed=""
usage="decorate BOLD style [ text ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdecorate BOLD'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mstyle'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ text ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mstyle     '$'\e''[[(value)]mCommaDelimitedList. Required. Style arguments passed directly to decorate for each item.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mtext ...  '$'\e''[[(value)]mEmptyString. Optional. Text to format. Use '$'\e''[[(code)]m--'$'\e''[[(reset)]m to output begin codes only.'$'\e''[[(reset)]m'$'\n'''$'\n''Add bold style to another style'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''> '$'\e''[[(code)]mdecorate BOLD info Info is more important'$'\e''[[(reset)]m'$'\n'''$'\e''[[(red)]m'$'\e''[[(code)]mInfo is more important'$'\e''[[(reset)]m'$'\e''[[(reset)]m'
# shellcheck disable=SC2016
helpPlain='Usage: decorate BOLD style [ text ... ]'$'\n'''$'\n''    style     CommaDelimitedList. Required. Style arguments passed directly to decorate for each item.'$'\n''    text ...  EmptyString. Optional. Text to format. Use -- to output begin codes only.'$'\n'''$'\n''Add bold style to another style'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''> decorate BOLD info Info is more important'$'\n''Info is more important'
documentationPath="documentation/source/tools/decorate.md"
