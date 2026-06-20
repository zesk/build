#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'-r | --reverse - Reverse the sort order (optional)\n--help - Flag. Optional. Display this help.\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Sorts semantic versions prefixed with a `v` character; intended to be used as a pipe.\n\nvXXX.XXX.XXX\n\nfor sort - -k 1.c,1 - the `c` is the 1-based character index, so 2 means skip the 1st character\n\nOdd you can\'t globally flip sort order with -r - that only works with non-keyed entries I assume\n\n'
descriptionLineCount="8"
example=$'    git tag | grep -e \'^v[0-9.]*$\' | textVersionSort\n'
file="bin/build/tools/text.sh"
fn="textVersionSort"
fnMarker="textversionsort"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="requires")
line="1365"
original="textVersionSort"
rawComment=$'Summary: Sort versions in the format v0.0.0\nSorts semantic versions prefixed with a `v` character; intended to be used as a pipe.\nvXXX.XXX.XXX\nfor sort - -k 1.c,1 - the `c` is the 1-based character index, so 2 means skip the 1st character\nOdd you can\'t globally flip sort order with -r - that only works with non-keyed entries I assume\nArgument: -r | --reverse - Reverse the sort order (optional)\nArgument: --help - Flag. Optional. Display this help.\nExample:     git tag | grep -e \'^v[0-9.]*$\' | textVersionSort\nRequires: throwArgument sort bashDocumentation decorate\n\n'
requires=$'throwArgument sort bashDocumentation decorate\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="6d769d6727070a6dc8632961d7250fe1f73eea0f"
sourceLine="1365"
summary="Sort versions in the format v0.0.0"
summaryComputed=""
usage="textVersionSort [ -r | --reverse ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtextVersionSort'$'\e''[0m '$'\e''[[(blue)]m[ -r | --reverse ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m-r | --reverse  '$'\e''[[(value)]mReverse the sort order (optional)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help          '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Sorts semantic versions prefixed with a '$'\e''[[(code)]mv'$'\e''[[(reset)]m character; intended to be used as a pipe.'$'\n'''$'\n''vXXX.XXX.XXX'$'\n'''$'\n''for sort - -k 1.c,1 - the '$'\e''[[(code)]mc'$'\e''[[(reset)]m is the 1-based character index, so 2 means skip the 1st character'$'\n'''$'\n''Odd you can'\''t globally flip sort order with -r - that only works with non-keyed entries I assume'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    git tag | grep -e '\''^v[0-9.]'$'\e''[[(cyan)]m$'\'' | textVersionSort'$'\e''[[(reset)]m'
# shellcheck disable=SC2016
helpPlain='Usage: textVersionSort [ -r | --reverse ] [ --help ]'$'\n'''$'\n''    -r | --reverse  Reverse the sort order (optional)'$'\n''    --help          Flag. Optional. Display this help.'$'\n'''$'\n''Sorts semantic versions prefixed with a v character; intended to be used as a pipe.'$'\n'''$'\n''vXXX.XXX.XXX'$'\n'''$'\n''for sort - -k 1.c,1 - the c is the 1-based character index, so 2 means skip the 1st character'$'\n'''$'\n''Odd you can'\''t globally flip sort order with -r - that only works with non-keyed entries I assume'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    git tag | grep -e '\''^v[0-9.]$'\'' | textVersionSort'
documentationPath="documentation/source/tools/text.md"
