#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-03
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\ndirectory - Directory. Optional. Set the application home to this directory.\n--go - Flag. Optional. Change to the current saved application home directory.\n'
base="application.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Set, or cd to current application home directory.\n\n'
descriptionLineCount="2"
file="bin/build/tools/application.sh"
fn="applicationHome"
fnMarker="applicationhome"
foundNames=([0]="argument")
line="53"
rawComment=$'Set, or cd to current application home directory.\nArgument: --help - Flag. Optional. Display this help.\nArgument: directory - Directory. Optional. Set the application home to this directory.\nArgument: --go - Flag. Optional. Change to the current saved application home directory.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/application.sh"
sourceHash="61088ae29549ecda8415ae30fc12d87bd7b80773"
sourceLine="53"
summary="Set, or cd to current application home directory."
summaryComputed="true"
usage="applicationHome [ --help ] [ directory ] [ --go ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mapplicationHome'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ directory ]'$'\e''[0m '$'\e''[[(blue)]m[ --go ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mdirectory  '$'\e''[[(value)]mDirectory. Optional. Set the application home to this directory.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--go       '$'\e''[[(value)]mFlag. Optional. Change to the current saved application home directory.'$'\e''[[(reset)]m'$'\n'''$'\n''Set, or cd to current application home directory.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: applicationHome [ --help ] [ directory ] [ --go ]'$'\n'''$'\n''    --help     Flag. Optional. Display this help.'$'\n''    directory  Directory. Optional. Set the application home to this directory.'$'\n''    --go       Flag. Optional. Change to the current saved application home directory.'$'\n'''$'\n''Set, or cd to current application home directory.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/application.md"
