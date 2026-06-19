#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="coverage.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Is bash coverage currently running?\n\n'
descriptionLineCount="2"
file="bin/build/tools/coverage.sh"
fn="bashCoverageEnabled"
fnMarker="bashcoverageenabled"
foundNames=([0]="argument" [1]="return_code")
line="114"
rawComment=$'Is bash coverage currently running?\nArgument: --help - Flag. Optional. Display this help.\nReturn Code: 0 - Yes, it\'s running.\nReturn Code: 1 - No, it is not running.=\nReturn Code: 2 - Argument error\n\n'
return_code=$'0 - Yes, it\'s running.\n1 - No, it is not running.=\n2 - Argument error\n'
sourceFile="bin/build/tools/coverage.sh"
sourceHash="942def75e2c55f10f5a8c1d72625773f1a3e4dd1"
sourceLine="114"
summary="Is bash coverage currently running?"
summaryComputed="true"
usage="bashCoverageEnabled [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashCoverageEnabled'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Is bash coverage currently running?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Yes, it'\''s running.'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - No, it is not running.='$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bashCoverageEnabled [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Is bash coverage currently running?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Yes, it'\''s running.'$'\n''- 1 - No, it is not running.='$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/coverage.md"
