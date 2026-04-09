#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="none"
base="git.sh"
description="Given a tag in the form \"1.1.3\" convert it to \"v1.1.3\" so it has a character prefix \"v\""$'\n'"Delete the old tag as well"$'\n'""
file="bin/build/tools/git.sh"
fn="gitTagVee"
foundNames=()
line="185"
lowerFn="gittagvee"
rawComment="Given a tag in the form \"1.1.3\" convert it to \"v1.1.3\" so it has a character prefix \"v\""$'\n'"Delete the old tag as well"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="4f7e4ceea530507ccd2bd4a042d5d5d5b9ef4356"
sourceLine="185"
summary="Given a tag in the form \"1.1.3\" convert it to"
summaryComputed="true"
usage="gitTagVee"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitTagVee'$'\e''[0m'$'\n'''$'\n''Given a tag in the form "1.1.3" convert it to "v1.1.3" so it has a character prefix "v"'$'\n''Delete the old tag as well'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitTagVee'$'\n'''$'\n''Given a tag in the form "1.1.3" convert it to "v1.1.3" so it has a character prefix "v"'$'\n''Delete the old tag as well'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/git.md"
