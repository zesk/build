#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-26
# shellcheck disable=SC2034
argument="none"
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Git add documentation files\nJust the first path.\n\n'
descriptionLineCount="3"
file="bin/build/tools/documentation.sh"
fn="documentationFilesAdd"
fnMarker="documentationfilesadd"
foundNames=()
line="468"
rawComment=$'Git add documentation files\nJust the first path.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="d15bc7cc6294c07449563ae7a7e924e91d663163"
sourceLine="468"
summary="Git add documentation files"
summaryComputed="true"
usage="documentationFilesAdd"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationFilesAdd'$'\e''[0m'$'\n'''$'\n''Git add documentation files'$'\n''Just the first path.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: documentationFilesAdd'$'\n'''$'\n''Git add documentation files'$'\n''Just the first path.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath=""
