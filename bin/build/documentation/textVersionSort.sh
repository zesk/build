#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
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
line="1372"
rawComment=$'Summary: Sort versions in the format v0.0.0\nSorts semantic versions prefixed with a `v` character; intended to be used as a pipe.\nvXXX.XXX.XXX\nfor sort - -k 1.c,1 - the `c` is the 1-based character index, so 2 means skip the 1st character\nOdd you can\'t globally flip sort order with -r - that only works with non-keyed entries I assume\nArgument: -r | --reverse - Reverse the sort order (optional)\nArgument: --help - Flag. Optional. Display this help.\nExample:     git tag | grep -e \'^v[0-9.]*$\' | textVersionSort\nRequires: throwArgument sort bashDocumentation decorate\n\n'
requires=$'throwArgument sort bashDocumentation decorate\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="1372"
summary="Sort versions in the format v0.0.0"
summaryComputed=""
usage="textVersionSort [ -r | --reverse ] [ --help ]"
