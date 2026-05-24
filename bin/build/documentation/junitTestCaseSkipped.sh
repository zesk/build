#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'message - Why test was skipped.\n'
base="junit.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output test skipped XML"
descriptionLineCount=""
file="bin/build/tools/junit.sh"
fn="junitTestCaseSkipped"
fnMarker="junittestcaseskipped"
foundNames=([0]="summary" [1]="argument")
line="246"
rawComment=$'Summary: Output test skipped XML\nArgument: message - Why test was skipped.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/junit.sh"
sourceHash="b434c2cb872c8920849edb82446bed7ed134f6d2"
sourceLine="246"
summary="Output test skipped XML"
summaryComputed=""
usage="junitTestCaseSkipped [ message ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mjunitTestCaseSkipped'$'\e''[0m '$'\e''[[(blue)]m[ message ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mmessage  '$'\e''[[(value)]mWhy test was skipped.'$'\e''[[(reset)]m'$'\n'''$'\n''Output test skipped XML'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: junitTestCaseSkipped [ message ]'$'\n'''$'\n''    message  Why test was skipped.'$'\n'''$'\n''Output test skipped XML'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/junit.md"
