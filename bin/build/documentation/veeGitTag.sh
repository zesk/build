#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-04
# shellcheck disable=SC2034
argument="none"
base="git.sh"
description="Given a tag in the form \"1.1.3\" convert it to \"v1.1.3\" so it has a character prefix \"v\""$'\n'"Delete the old tag as well"$'\n'""
file="bin/build/tools/git.sh"
rawComment="Given a tag in the form \"1.1.3\" convert it to \"v1.1.3\" so it has a character prefix \"v\""$'\n'"Delete the old tag as well"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="6ddead0079491da7c7f55886b428a38512863e13"
summary="Given a tag in the form \"1.1.3\" convert it to"
summaryComputed="true"
usage="veeGitTag"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mveeGitTag'$'\e''[0m'$'\n'''$'\n''Given a tag in the form "1.1.3" convert it to "v1.1.3" so it has a character prefix "v"'$'\n''Delete the old tag as well'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: veeGitTag'$'\n'''$'\n''Given a tag in the form "1.1.3" convert it to "v1.1.3" so it has a character prefix "v"'$'\n''Delete the old tag as well'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
