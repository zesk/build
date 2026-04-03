#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="vendor.sh"
description="Are we within the Microsoft Visual Studio Code terminal?"$'\n'""
file="bin/build/tools/vendor.sh"
fn="isVisualStudioCode"
foundNames=([0]="argument" [1]="return_code" [2]="see")
rawComment="Are we within the Microsoft Visual Studio Code terminal?"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - within the Visual Studio Code terminal"$'\n'"Return Code: 1 - not within the Visual Studio Code terminal AFAIK"$'\n'"See: contextOpen"$'\n'""$'\n'""
return_code="0 - within the Visual Studio Code terminal"$'\n'"1 - not within the Visual Studio Code terminal AFAIK"$'\n'""
see="contextOpen"$'\n'""
sourceFile="bin/build/tools/vendor.sh"
sourceHash="392497becb3db35921e59eb87651810aa2f7c8ea"
summary="Are we within the Microsoft Visual Studio Code terminal?"
summaryComputed="true"
usage="isVisualStudioCode [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misVisualStudioCode'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Are we within the Microsoft Visual Studio Code terminal?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - within the Visual Studio Code terminal'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - not within the Visual Studio Code terminal AFAIK'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isVisualStudioCode [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Are we within the Microsoft Visual Studio Code terminal?'$'\n'''$'\n''Return codes:'$'\n''- 0 - within the Visual Studio Code terminal'$'\n''- 1 - not within the Visual Studio Code terminal AFAIK'$'\n'''
