#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\nbinary - Executable. Optional. Display where this executable appears in the path.\n'
base="path.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Show the path and where binaries are found\n\n'
descriptionLineCount="2"
file="bin/build/tools/path.sh"
fn="pathShow"
fnMarker="pathshow"
foundNames=([0]="argument")
line="113"
original="pathShow"
rawComment=$'Show the path and where binaries are found\nArgument: --help - Flag. Optional. Display this help.\nArgument: binary - Executable. Optional. Display where this executable appears in the path.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/path.sh"
sourceHash="2041cf2a94fb5395067f19d0ae334a8a6432088e"
sourceLine="113"
summary="Show the path and where binaries are found"
summaryComputed="true"
usage="pathShow [ --help ] [ binary ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpathShow'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ binary ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mbinary  '$'\e''[[(value)]mExecutable. Optional. Display where this executable appears in the path.'$'\e''[[(reset)]m'$'\n'''$'\n''Show the path and where binaries are found'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: pathShow [ --help ] [ binary ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    binary  Executable. Optional. Display where this executable appears in the path.'$'\n'''$'\n''Show the path and where binaries are found'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/path.md"
