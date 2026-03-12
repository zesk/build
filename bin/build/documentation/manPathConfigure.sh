#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--first - Flag. Optional. Place any paths after this flag first in the list"$'\n'"--last - Flag. Optional. Place any paths after this flag last in the list. Default."$'\n'"path - the path to be added to the \`MANPATH\` environment"$'\n'""
base="manpath.sh"
description="Modify the MANPATH environment variable to add a path."$'\n'""
file="bin/build/tools/manpath.sh"
fn="manPathConfigure"
foundNames=([0]="see" [1]="argument")
rawComment="Modify the MANPATH environment variable to add a path."$'\n'"See: manPathRemove"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --first - Flag. Optional. Place any paths after this flag first in the list"$'\n'"Argument: --last - Flag. Optional. Place any paths after this flag last in the list. Default."$'\n'"Argument: path - the path to be added to the \`MANPATH\` environment"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="manPathRemove"$'\n'""
sourceFile="bin/build/tools/manpath.sh"
sourceHash="8a6b17740b41a6485576efda52769baec3f7ddd4"
summary="Modify the MANPATH environment variable to add a path."
summaryComputed="true"
usage="manPathConfigure [ --help ] [ --first ] [ --last ] [ path ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmanPathConfigure'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --first ]'$'\e''[0m '$'\e''[[(blue)]m[ --last ]'$'\e''[0m '$'\e''[[(blue)]m[ path ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--first  '$'\e''[[(value)]mFlag. Optional. Place any paths after this flag first in the list'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--last   '$'\e''[[(value)]mFlag. Optional. Place any paths after this flag last in the list. Default.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mpath     '$'\e''[[(value)]mthe path to be added to the '$'\e''[[(code)]mMANPATH'$'\e''[[(reset)]m environment'$'\e''[[(reset)]m'$'\n'''$'\n''Modify the MANPATH environment variable to add a path.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: manPathConfigure [ --help ] [ --first ] [ --last ] [ path ]'$'\n'''$'\n''    --help   Flag. Optional. Display this help.'$'\n''    --first  Flag. Optional. Place any paths after this flag first in the list'$'\n''    --last   Flag. Optional. Place any paths after this flag last in the list. Default.'$'\n''    path     the path to be added to the MANPATH environment'$'\n'''$'\n''Modify the MANPATH environment variable to add a path.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
