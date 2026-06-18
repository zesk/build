#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-15
# shellcheck disable=SC2034
argument="none"
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Get the commit hash\n\n'
descriptionLineCount="2"
file="bin/build/tools/git.sh"
fn="gitCommitHash"
fnMarker="gitcommithash"
foundNames=()
line="660"
rawComment=$'Get the commit hash\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/git.sh"
sourceHash="a0d23919137c5539c67fd2fa09a1b037d4933cfd"
sourceLine="660"
summary="Get the commit hash"
summaryComputed="true"
usage="gitCommitHash"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitCommitHash'$'\e''[0m'$'\n'''$'\n''Get the commit hash'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: gitCommitHash'$'\n'''$'\n''Get the commit hash'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/git.md"
