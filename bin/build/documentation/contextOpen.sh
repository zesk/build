#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="vendor.sh"
description="Open a file in a shell using the program we are using. Supports VSCode and PHPStorm."$'\n'""
environment="EDITOR - Used as a default editor (first)"$'\n'"VISUAL - Used as another default editor (last)"$'\n'""
file="bin/build/tools/vendor.sh"
fn="contextOpen"
foundNames=([0]="environment" [1]="argument")
rawComment="Open a file in a shell using the program we are using. Supports VSCode and PHPStorm."$'\n'"Environment: EDITOR - Used as a default editor (first)"$'\n'"Environment: VISUAL - Used as another default editor (last)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/vendor.sh"
sourceHash="392497becb3db35921e59eb87651810aa2f7c8ea"
summary="Open a file in a shell using the program we"
summaryComputed="true"
usage="contextOpen [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcontextOpen'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Open a file in a shell using the program we are using. Supports VSCode and PHPStorm.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- '$'\e''[[(code)]mEDITOR'$'\e''[[(reset)]m - Used as a default editor (first)'$'\n''- '$'\e''[[(code)]mVISUAL'$'\e''[[(reset)]m - Used as another default editor (last)'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: contextOpen [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Open a file in a shell using the program we are using. Supports VSCode and PHPStorm.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- EDITOR - Used as a default editor (first)'$'\n''- VISUAL - Used as another default editor (last)'$'\n'''
