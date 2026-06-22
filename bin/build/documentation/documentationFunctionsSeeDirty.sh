#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-22
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\npath - Directory. Required. The documentation path to examine.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Changes the modification date of the associated files such that it will be regenerated with `documentationFunctionsCompile`.\n\n'
descriptionLineCount="2"
file="bin/build/tools/documentation.sh"
fn="documentationFunctionsSeeDirty"
fnMarker="documentationfunctionsseedirty"
foundNames=([0]="summary" [1]="see" [2]="argument")
line="998"
original="documentationFunctionsSeeDirty"
rawComment=$'Summary: Dirty documentation files with unresolved `SEE:` tokens in documentation path\nChanges the modification date of the associated files such that it will be regenerated with `documentationFunctionsCompile`.\nSee: documentationFunctionsCompile\nArgument: --help - Flag. Optional. Display this help.\nArgument: path - Directory. Required. The documentation path to examine.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'documentationFunctionsCompile\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="d51e4672057607172307c44e6065c356ed05ce35"
sourceLine="998"
summary="Dirty documentation files with unresolved \`SEE:\` tokens in documentation path"
summaryComputed=""
usage="documentationFunctionsSeeDirty [ --help ] path"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationFunctionsSeeDirty'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mpath'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mpath    '$'\e''[[(value)]mDirectory. Required. The documentation path to examine.'$'\e''[[(reset)]m'$'\n'''$'\n''Changes the modification date of the associated files such that it will be regenerated with '$'\e''[[(code)]mdocumentationFunctionsCompile'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: documentationFunctionsSeeDirty [ --help ] path'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    path    Directory. Required. The documentation path to examine.'$'\n'''$'\n''Changes the modification date of the associated files such that it will be regenerated with documentationFunctionsCompile.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/documentation.md"
