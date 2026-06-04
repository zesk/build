#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"delta - Integer. Milliseconds"$'\n'""
base="timing.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Format a timing output (milliseconds) as seconds using a decimal"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/timing.sh"
fn="timingFormat"
fnMarker="timingformat"
foundNames=([0]="argument")
line="163"
rawComment="Format a timing output (milliseconds) as seconds using a decimal"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: delta - Integer. Milliseconds"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/timing.sh"
sourceHash="752e3f656f86676b045a390a6cda420507fab0e1"
sourceLine="163"
summary="Format a timing output (milliseconds) as seconds using a decimal"
summaryComputed="true"
usage="timingFormat [ --help ] [ delta ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtimingFormat'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ delta ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mdelta   '$'\e''[[(value)]mInteger. Milliseconds'$'\e''[[(reset)]m'$'\n'''$'\n''Format a timing output (milliseconds) as seconds using a decimal'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: timingFormat [ --help ] [ delta ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    delta   Integer. Milliseconds'$'\n'''$'\n''Format a timing output (milliseconds) as seconds using a decimal'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/timing.md"
