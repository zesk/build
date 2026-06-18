#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-15
# shellcheck disable=SC2034
argument=$'package - Additional packages to uninstall\n'
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Uninstalls the `git` binary\n\n'
descriptionLineCount="2"
file="bin/build/tools/git.sh"
fn="gitUninstall"
fnMarker="gituninstall"
foundNames=([0]="argument" [1]="summary")
line="41"
rawComment=$'Uninstalls the `git` binary\nArgument: package - Additional packages to uninstall\nSummary: Uninstall git\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/git.sh"
sourceHash="a0d23919137c5539c67fd2fa09a1b037d4933cfd"
sourceLine="41"
summary="Uninstall git"
summaryComputed=""
usage="gitUninstall [ package ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitUninstall'$'\e''[0m '$'\e''[[(blue)]m[ package ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mpackage  '$'\e''[[(value)]mAdditional packages to uninstall'$'\e''[[(reset)]m'$'\n'''$'\n''Uninstalls the '$'\e''[[(code)]mgit'$'\e''[[(reset)]m binary'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: gitUninstall [ package ]'$'\n'''$'\n''    package  Additional packages to uninstall'$'\n'''$'\n''Uninstalls the git binary'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/install.md"
