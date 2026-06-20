#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'source - Directory. Required. target\ntarget - FileDirectory. Required.\n'
base="directory.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Copy directory over another sort-of-atomically\n\n'
descriptionLineCount="2"
file="bin/build/tools/directory.sh"
fn="directoryClobber"
fnMarker="directoryclobber"
foundNames=([0]="argument")
line="76"
original="directoryClobber"
rawComment=$'Argument: source - Directory. Required. target\nArgument: target - FileDirectory. Required.\nCopy directory over another sort-of-atomically\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/directory.sh"
sourceHash="56e2e47efbd4d48b0fa152ed5f06ec8d0ff20d9e"
sourceLine="76"
summary="Copy directory over another sort-of-atomically"
summaryComputed="true"
usage="directoryClobber source target"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdirectoryClobber'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msource'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtarget'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]msource  '$'\e''[[(value)]mDirectory. Required. target'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mtarget  '$'\e''[[(value)]mFileDirectory. Required.'$'\e''[[(reset)]m'$'\n'''$'\n''Copy directory over another sort-of-atomically'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: directoryClobber source target'$'\n'''$'\n''    source  Directory. Required. target'$'\n''    target  FileDirectory. Required.'$'\n'''$'\n''Copy directory over another sort-of-atomically'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/directory.md"
