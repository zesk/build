#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="-r | --reverse - Reverse the sort order (optional)"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="text.sh"
description="Sorts semantic versions prefixed with a \`v\` character; intended to be used as a pipe."$'\n'"vXXX.XXX.XXX"$'\n'"for sort - -k 1.c,1 - the \`c\` is the 1-based character index, so 2 means skip the 1st character"$'\n'"Odd you can't globally flip sort order with -r - that only works with non-keyed entries I assume"$'\n'""
example="    git tag | grep -e '^v[0-9.]*\$' | textVersionSort"$'\n'""
file="bin/build/tools/text.sh"
fn="textVersionSort"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="requires")
line="1325"
lowerFn="textversionsort"
rawComment="Summary: Sort versions in the format v0.0.0"$'\n'"Sorts semantic versions prefixed with a \`v\` character; intended to be used as a pipe."$'\n'"vXXX.XXX.XXX"$'\n'"for sort - -k 1.c,1 - the \`c\` is the 1-based character index, so 2 means skip the 1st character"$'\n'"Odd you can't globally flip sort order with -r - that only works with non-keyed entries I assume"$'\n'"Argument: -r | --reverse - Reverse the sort order (optional)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     git tag | grep -e '^v[0-9.]*\$' | textVersionSort"$'\n'"Requires: throwArgument sort bashDocumentation decorate"$'\n'""$'\n'""
requires="throwArgument sort bashDocumentation decorate"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="7f4afd0db4aa281d91724f7bdc480865ea6088e9"
sourceLine="1325"
summary="Sort versions in the format v0.0.0"$'\n'""
usage="textVersionSort [ -r | --reverse ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtextVersionSort'$'\e''[0m '$'\e''[[(blue)]m[ -r | --reverse ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m-r | --reverse  '$'\e''[[(value)]mReverse the sort order (optional)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help          '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Sorts semantic versions prefixed with a '$'\e''[[(code)]mv'$'\e''[[(reset)]m character; intended to be used as a pipe.'$'\n''vXXX.XXX.XXX'$'\n''for sort - -k 1.c,1 - the '$'\e''[[(code)]mc'$'\e''[[(reset)]m is the 1-based character index, so 2 means skip the 1st character'$'\n''Odd you can'\''t globally flip sort order with -r - that only works with non-keyed entries I assume'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    git tag | grep -e '\''^v[0-9.]'$'\e''[[(cyan)]m$'\'' | textVersionSort'$'\e''[[(reset)]m'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: textVersionSort [ -r | --reverse ] [ --help ]'$'\n'''$'\n''    -r | --reverse  Reverse the sort order (optional)'$'\n''    --help          Flag. Optional. Display this help.'$'\n'''$'\n''Sorts semantic versions prefixed with a v character; intended to be used as a pipe.'$'\n''vXXX.XXX.XXX'$'\n''for sort - -k 1.c,1 - the c is the 1-based character index, so 2 means skip the 1st character'$'\n''Odd you can'\''t globally flip sort order with -r - that only works with non-keyed entries I assume'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    git tag | grep -e '\''^v[0-9.]$'\'' | textVersionSort'$'\n'''
documentationPath="documentation/source/tools/text.md"
