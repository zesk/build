#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="test.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Stop faking `consoleHasAnimation` for testing\n\n'
descriptionLineCount="2"
file="bin/build/tools/test.sh"
fn="mockConsoleAnimationStop"
fnMarker="mockconsoleanimationstop"
foundNames=([0]="argument")
line="1474"
original="mockConsoleAnimationStop"
rawComment=$'Stop faking `consoleHasAnimation` for testing\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/test.sh"
sourceHash="1643b40c1684bb3bbf723c7097d1aba261079515"
sourceLine="1474"
summary="Stop faking \`consoleHasAnimation\` for testing"
summaryComputed="true"
usage="mockConsoleAnimationStop [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmockConsoleAnimationStop'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Stop faking '$'\e''[[(code)]mconsoleHasAnimation'$'\e''[[(reset)]m for testing'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: mockConsoleAnimationStop [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Stop faking consoleHasAnimation for testing'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/assert.md"
