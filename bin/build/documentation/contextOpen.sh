#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/vendor.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="vendor.sh"
description="Open a file in a shell using the program we are using. Supports VSCode and PHPStorm."$'\n'""
environment="EDITOR - Used as a default editor (first)"$'\n'"VISUAL - Used as another default editor (last)"$'\n'""
exitCode="0"
file="bin/build/tools/vendor.sh"
foundNames=([0]="environment" [1]="argument")
rawComment="Open a file in a shell using the program we are using. Supports VSCode and PHPStorm."$'\n'"Environment: EDITOR - Used as a default editor (first)"$'\n'"Environment: VISUAL - Used as another default editor (last)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/vendor.sh"
sourceModified="1769063211"
summary="Open a file in a shell using the program we"
usage="contextOpen [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mcontextOpen'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--help  '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n'''$'\n''Open a file in a shell using the program we are using. Supports VSCode and PHPStorm.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- '$'\e''[[code]mEDITOR'$'\e''[[reset]m - Used as a default editor (first)'$'\n''- '$'\e''[[code]mVISUAL'$'\e''[[reset]m - Used as another default editor (last)'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: contextOpen [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Open a file in a shell using the program we are using. Supports VSCode and PHPStorm.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- EDITOR - Used as a default editor (first)'$'\n''- VISUAL - Used as another default editor (last)'$'\n'''
