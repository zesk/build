#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"path - Directory. Required. The path to be removed from the \`MANPATH\` environment"$'\n'""
base="manpath.sh"
description="Remove a path from the MANPATH environment variable"$'\n'""
file="bin/build/tools/manpath.sh"
fn="manPathRemove"
foundNames=([0]="argument")
line="36"
lowerFn="manpathremove"
rawComment="Remove a path from the MANPATH environment variable"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: path - Directory. Required. The path to be removed from the \`MANPATH\` environment"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/manpath.sh"
sourceHash="73a3214fffa3f8f5065133619f130ecf4bdcb5bb"
sourceLine="36"
summary="Remove a path from the MANPATH environment variable"
summaryComputed="true"
usage="manPathRemove [ --help ] path"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmanPathRemove'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mpath'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mpath    '$'\e''[[(value)]mDirectory. Required. The path to be removed from the '$'\e''[[(code)]mMANPATH'$'\e''[[(reset)]m environment'$'\e''[[(reset)]m'$'\n'''$'\n''Remove a path from the MANPATH environment variable'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: manPathRemove [ --help ] path'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    path    Directory. Required. The path to be removed from the MANPATH environment'$'\n'''$'\n''Remove a path from the MANPATH environment variable'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/manpath.md"
