#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--first - Flag. Optional. Place any paths after this flag first in the list\n--last - Flag. Optional. Place any paths after this flag last in the list. Default.\npath - the path to be added to the `PATH` environment\n'
base="path.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Modify the PATH environment variable to add a path.\n\n'
descriptionLineCount="2"
file="bin/build/tools/path.sh"
fn="pathConfigure"
fnMarker="pathconfigure"
foundNames=([0]="argument")
line="48"
original="pathConfigure"
rawComment=$'Modify the PATH environment variable to add a path.\nArgument: --help - Flag. Optional. Display this help.\nArgument: --first - Flag. Optional. Place any paths after this flag first in the list\nArgument: --last - Flag. Optional. Place any paths after this flag last in the list. Default.\nArgument: path - the path to be added to the `PATH` environment\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/path.sh"
sourceHash="2041cf2a94fb5395067f19d0ae334a8a6432088e"
sourceLine="48"
summary="Modify the PATH environment variable to add a path."
summaryComputed="true"
usage="pathConfigure [ --help ] [ --first ] [ --last ] [ path ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpathConfigure'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --first ]'$'\e''[0m '$'\e''[[(blue)]m[ --last ]'$'\e''[0m '$'\e''[[(blue)]m[ path ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--first  '$'\e''[[(value)]mFlag. Optional. Place any paths after this flag first in the list'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--last   '$'\e''[[(value)]mFlag. Optional. Place any paths after this flag last in the list. Default.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mpath     '$'\e''[[(value)]mthe path to be added to the '$'\e''[[(code)]mPATH'$'\e''[[(reset)]m environment'$'\e''[[(reset)]m'$'\n'''$'\n''Modify the PATH environment variable to add a path.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: pathConfigure [ --help ] [ --first ] [ --last ] [ path ]'$'\n'''$'\n''    --help   Flag. Optional. Display this help.'$'\n''    --first  Flag. Optional. Place any paths after this flag first in the list'$'\n''    --last   Flag. Optional. Place any paths after this flag last in the list. Default.'$'\n''    path     the path to be added to the PATH environment'$'\n'''$'\n''Modify the PATH environment variable to add a path.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/path.md"
