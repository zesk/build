#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="junit.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Close tag for `system-out` - test output\n\n'
descriptionLineCount="2"
file="bin/build/tools/junit.sh"
fn="junitSystemOutputClose"
fnMarker="junitsystemoutputclose"
foundNames=([0]="argument")
line="172"
rawComment=$'Close tag for `system-out` - test output\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/junit.sh"
sourceHash="a70894c42131c6c776b314f435ca478555a88f0b"
sourceLine="172"
summary="Close tag for \`system-out\` - test output"
summaryComputed="true"
usage="junitSystemOutputClose [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mjunitSystemOutputClose'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Close tag for '$'\e''[[(code)]msystem-out'$'\e''[[(reset)]m - test output'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: junitSystemOutputClose [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Close tag for system-out - test output'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/junit.md"
