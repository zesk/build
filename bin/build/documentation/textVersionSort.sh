#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-12
# shellcheck disable=SC2034
argument="-r | --reverse - Reverse the sort order (optional)"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Sorts semantic versions prefixed with a \`v\` character; intended to be used as a pipe."$'\n'""$'\n'"vXXX.XXX.XXX"$'\n'""$'\n'"for sort - -k 1.c,1 - the \`c\` is the 1-based character index, so 2 means skip the 1st character"$'\n'""$'\n'"Odd you can't globally flip sort order with -r - that only works with non-keyed entries I assume"$'\n'""$'\n'""
descriptionLineCount="8"
example="    git tag | grep -e '^v[0-9.]*\$' | textVersionSort"$'\n'""
file="bin/build/tools/text.sh"
fn="textVersionSort"
fnMarker="textversionsort"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="requires")
line="1365"
rawComment="Summary: Sort versions in the format v0.0.0"$'\n'"Sorts semantic versions prefixed with a \`v\` character; intended to be used as a pipe."$'\n'"vXXX.XXX.XXX"$'\n'"for sort - -k 1.c,1 - the \`c\` is the 1-based character index, so 2 means skip the 1st character"$'\n'"Odd you can't globally flip sort order with -r - that only works with non-keyed entries I assume"$'\n'"Argument: -r | --reverse - Reverse the sort order (optional)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     git tag | grep -e '^v[0-9.]*\$' | textVersionSort"$'\n'"Requires: throwArgument sort bashDocumentation decorate"$'\n'""$'\n'""
requires="throwArgument sort bashDocumentation decorate"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="b913e34543d2ae704942cadce5473f26955cd42e"
sourceLine="1365"
summary="Sort versions in the format v0.0.0"
summaryComputed=""
usage="textVersionSort [ -r | --reverse ] [ --help ]"
