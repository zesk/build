#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="pipeline.sh"
description="Summary: Sort versions in the format v0.0.0"$'\n'"Sorts semantic versions prefixed with a \`v\` character; intended to be used as a pipe."$'\n'"vXXX.XXX.XXX"$'\n'"for sort - -k 1.c,1 - the \`c\` is the 1-based character index, so 2 means skip the 1st character"$'\n'"Odd you can't globally flip sort order with -r - that only works with non-keyed entries I assume"$'\n'"Argument: -r | --reverse - Reverse the sort order (optional)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     git tag | grep -e '^v[0-9.]*\$' | versionSort"$'\n'"Requires: throwArgument sort usageDocument decorate"$'\n'""
file="bin/build/tools/pipeline.sh"
foundNames=()
rawComment="Summary: Sort versions in the format v0.0.0"$'\n'"Sorts semantic versions prefixed with a \`v\` character; intended to be used as a pipe."$'\n'"vXXX.XXX.XXX"$'\n'"for sort - -k 1.c,1 - the \`c\` is the 1-based character index, so 2 means skip the 1st character"$'\n'"Odd you can't globally flip sort order with -r - that only works with non-keyed entries I assume"$'\n'"Argument: -r | --reverse - Reverse the sort order (optional)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     git tag | grep -e '^v[0-9.]*\$' | versionSort"$'\n'"Requires: throwArgument sort usageDocument decorate"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/pipeline.sh"
sourceHash="236d41c061fbee87ffcd2c61127468ab3331c832"
summary="Summary: Sort versions in the format v0.0.0"
usage="versionSort"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mversionSort'$'\e''[0m'$'\n'''$'\n''Summary: Sort versions in the format v0.0.0'$'\n''Sorts semantic versions prefixed with a '$'\e''[[(code)]mv'$'\e''[[(reset)]m character; intended to be used as a pipe.'$'\n''vXXX.XXX.XXX'$'\n''for sort - -k 1.c,1 - the '$'\e''[[(code)]mc'$'\e''[[(reset)]m is the 1-based character index, so 2 means skip the 1st character'$'\n''Odd you can'\''t globally flip sort order with -r - that only works with non-keyed entries I assume'$'\n''Argument: -r | --reverse - Reverse the sort order (optional)'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Example:     git tag | grep -e '\''^v[0-9.]'$'\e''[[(cyan)]m$'\'' | versionSort'$'\e''[[(reset)]m'$'\n''Requires: throwArgument sort usageDocument decorate'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: versionSort'$'\n'''$'\n''Summary: Sort versions in the format v0.0.0'$'\n''Sorts semantic versions prefixed with a v character; intended to be used as a pipe.'$'\n''vXXX.XXX.XXX'$'\n''for sort - -k 1.c,1 - the c is the 1-based character index, so 2 means skip the 1st character'$'\n''Odd you can'\''t globally flip sort order with -r - that only works with non-keyed entries I assume'$'\n''Argument: -r | --reverse - Reverse the sort order (optional)'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Example:     git tag | grep -e '\''^v[0-9.]$'\'' | versionSort'$'\n''Requires: throwArgument sort usageDocument decorate'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.453
