#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'value - Set the restart flag to this value (blank to remove)\n'
base="package.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'INTERNAL - has `packageUpdate` set the `restart` flag at some point?\n\n'
descriptionLineCount="2"
file="bin/build/tools/package.sh"
fn="packageNeedRestartFlag"
fnMarker="packageneedrestartflag"
foundNames=([0]="argument")
line="657"
original="packageNeedRestartFlag"
rawComment=$'INTERNAL - has `packageUpdate` set the `restart` flag at some point?\nArgument: value - Set the restart flag to this value (blank to remove)\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/package.sh"
sourceHash="3044284fc1f27bf20924a72ed04c7da3af05f86f"
sourceLine="657"
summary="INTERNAL - has \`packageUpdate\` set the \`restart\` flag at some"
summaryComputed="true"
usage="packageNeedRestartFlag [ value ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpackageNeedRestartFlag'$'\e''[0m '$'\e''[[(blue)]m[ value ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mvalue  '$'\e''[[(value)]mSet the restart flag to this value (blank to remove)'$'\e''[[(reset)]m'$'\n'''$'\n''INTERNAL - has '$'\e''[[(code)]mpackageUpdate'$'\e''[[(reset)]m set the '$'\e''[[(code)]mrestart'$'\e''[[(reset)]m flag at some point?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: packageNeedRestartFlag [ value ]'$'\n'''$'\n''    value  Set the restart flag to this value (blank to remove)'$'\n'''$'\n''INTERNAL - has packageUpdate set the restart flag at some point?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/package.md"
