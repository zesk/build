#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/pipeline.sh"
argument="-r | --reverse - Reverse the sort order (optional)"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="pipeline.sh"
description="Sorts semantic versions prefixed with a \`v\` character; intended to be used as a pipe."$'\n'""$'\n'"vXXX.XXX.XXX"$'\n'""$'\n'"for sort - -k 1.c,1 - the \`c\` is the 1-based character index, so 2 means skip the 1st character"$'\n'""$'\n'"Odd you can't globally flip sort order with -r - that only works with non-keyed entries I assume"$'\n'""$'\n'""
example="    git tag | grep -e '^v[0-9.]*\$' | versionSort"$'\n'""
file="bin/build/tools/pipeline.sh"
fn="versionSort"
foundNames=""
requires="throwArgument sort usageDocument decorate"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/pipeline.sh"
sourceModified="1769063211"
summary="Sort versions in the format v0.0.0"$'\n'""
usage="versionSort [ -r | --reverse ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mversionSort[0m [94m[ -r | --reverse ][0m [94m[ --help ][0m

    [94m-r | --reverse  [1;97mReverse the sort order (optional)[0m
    [94m--help          [1;97mFlag. Optional. Display this help.[0m

Sorts semantic versions prefixed with a [38;2;0;255;0;48;2;0;0;0mv[0m character; intended to be used as a pipe.

vXXX.XXX.XXX

for sort - -k 1.c,1 - the [38;2;0;255;0;48;2;0;0;0mc[0m is the 1-based character index, so 2 means skip the 1st character

Odd you can'\''t globally flip sort order with -r - that only works with non-keyed entries I assume

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    git tag | grep -e '\''^v[0-9.][36m$'\'' | versionSort[0m
'
# shellcheck disable=SC2016
helpPlain='Usage: versionSort [ -r | --reverse ] [ --help ]

    -r | --reverse  Reverse the sort order (optional)
    --help          Flag. Optional. Display this help.

Sorts semantic versions prefixed with a v character; intended to be used as a pipe.

vXXX.XXX.XXX

for sort - -k 1.c,1 - the c is the 1-based character index, so 2 means skip the 1st character

Odd you can'\''t globally flip sort order with -r - that only works with non-keyed entries I assume

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    git tag | grep -e '\''^v[0-9.]$'\'' | versionSort
'
