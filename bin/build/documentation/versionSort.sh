#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/pipeline.sh"
argument="-r | --reverse - Reverse the sort order (optional)"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="pipeline.sh"
description="Sorts semantic versions prefixed with a \`v\` character; intended to be used as a pipe."$'\n'""$'\n'"vXXX.XXX.XXX"$'\n'""$'\n'"for sort - -k 1.c,1 - the \`c\` is the 1-based character index, so 2 means skip the 1st character"$'\n'""$'\n'"Odd you can't globally flip sort order with -r - that only works with non-keyed entries I assume"$'\n'""$'\n'""
example="    git tag | grep -e '^v[0-9.]*\$' | versionSort"$'\n'""
file="bin/build/tools/pipeline.sh"
fn="versionSort"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="requires")
requires="throwArgument sort usageDocument decorate"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/pipeline.sh"
sourceModified="1768759595"
summary="Sort versions in the format v0.0.0"$'\n'""
usage="versionSort [ -r | --reverse ] [ --help ]"
