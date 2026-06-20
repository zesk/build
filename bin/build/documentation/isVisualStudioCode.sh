#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="vendor.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Are we within the Microsoft Visual Studio Code terminal?\n\n'
descriptionLineCount="2"
file="bin/build/tools/vendor.sh"
fn="isVisualStudioCode"
fnMarker="isvisualstudiocode"
foundNames=([0]="argument" [1]="return_code" [2]="see")
line="60"
original="isVisualStudioCode"
rawComment=$'Are we within the Microsoft Visual Studio Code terminal?\nArgument: --help - Flag. Optional. Display this help.\nReturn Code: 0 - within the Visual Studio Code terminal\nReturn Code: 1 - not within the Visual Studio Code terminal AFAIK\nSee: contextOpen\n\n'
return_code=$'0 - within the Visual Studio Code terminal\n1 - not within the Visual Studio Code terminal AFAIK\n'
see=$'contextOpen\n'
sourceFile="bin/build/tools/vendor.sh"
sourceHash="6a1c6758472ed8ae9048cda1a9a026cbbe718421"
sourceLine="60"
summary="Are we within the Microsoft Visual Studio Code terminal?"
summaryComputed="true"
usage="isVisualStudioCode [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misVisualStudioCode'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Are we within the Microsoft Visual Studio Code terminal?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - within the Visual Studio Code terminal'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - not within the Visual Studio Code terminal AFAIK'
# shellcheck disable=SC2016
helpPlain='Usage: isVisualStudioCode [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Are we within the Microsoft Visual Studio Code terminal?'$'\n'''$'\n''Return codes:'$'\n''- 0 - within the Visual Studio Code terminal'$'\n''- 1 - not within the Visual Studio Code terminal AFAIK'
documentationPath="documentation/source/tools/vendor.md"
