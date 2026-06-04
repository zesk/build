#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="prompt-modules.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'The dot files approved file. Add files to this to approve.\n\n'
descriptionLineCount="2"
file="bin/build/tools/prompt-modules.sh"
fn="dotFilesApprovedFile"
fnMarker="dotfilesapprovedfile"
foundNames=([0]="argument")
line="106"
rawComment=$'The dot files approved file. Add files to this to approve.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/prompt-modules.sh"
sourceHash="2bee64ea201a03444ec1e39db3efb63042869b7e"
sourceLine="106"
summary="The dot files approved file. Add files to this to"
summaryComputed="true"
usage="dotFilesApprovedFile [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdotFilesApprovedFile'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''The dot files approved file. Add files to this to approve.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: dotFilesApprovedFile [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''The dot files approved file. Add files to this to approve.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/prompt.md"
