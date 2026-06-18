#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-15
# shellcheck disable=SC2034
argument=$'tag - String. Optional. The tag to tag again.\n'
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Remove a tag everywhere and tag again on the current branch\n\n'
descriptionLineCount="2"
file="bin/build/tools/git.sh"
fn="gitTagAgain"
fnMarker="gittagagain"
foundNames=([0]="argument")
line="122"
rawComment=$'Remove a tag everywhere and tag again on the current branch\nArgument: tag - String. Optional. The tag to tag again.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/git.sh"
sourceHash="a0d23919137c5539c67fd2fa09a1b037d4933cfd"
sourceLine="122"
summary="Remove a tag everywhere and tag again on the current"
summaryComputed="true"
usage="gitTagAgain [ tag ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitTagAgain'$'\e''[0m '$'\e''[[(blue)]m[ tag ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mtag  '$'\e''[[(value)]mString. Optional. The tag to tag again.'$'\e''[[(reset)]m'$'\n'''$'\n''Remove a tag everywhere and tag again on the current branch'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: gitTagAgain [ tag ]'$'\n'''$'\n''    tag  String. Optional. The tag to tag again.'$'\n'''$'\n''Remove a tag everywhere and tag again on the current branch'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/git.md"
