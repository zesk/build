#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="apk.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Is this an Alpine system and is apk installed?\n\n'
descriptionLineCount="2"
file="bin/build/tools/apk.sh"
fn="apkIsInstalled"
fnMarker="apkisinstalled"
foundNames=([0]="argument" [1]="return_code")
line="16"
rawComment=$'Is this an Alpine system and is apk installed?\nArgument: --help - Flag. Optional. Display this help.\nReturn Code: 0 - System is an alpine system and apk is installed\nReturn Code: 1 - System is not an alpine system or apk is not installed\n\n'
return_code=$'0 - System is an alpine system and apk is installed\n1 - System is not an alpine system or apk is not installed\n'
sourceFile="bin/build/tools/apk.sh"
sourceHash="92aca540203b07d09d3e678e98cbe97a1ecce081"
sourceLine="16"
summary="Is this an Alpine system and is apk installed?"
summaryComputed="true"
usage="apkIsInstalled [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mapkIsInstalled'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Is this an Alpine system and is apk installed?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - System is an alpine system and apk is installed'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - System is not an alpine system or apk is not installed'
# shellcheck disable=SC2016
helpPlain='Usage: apkIsInstalled [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Is this an Alpine system and is apk installed?'$'\n'''$'\n''Return codes:'$'\n''- 0 - System is an alpine system and apk is installed'$'\n''- 1 - System is not an alpine system or apk is not installed'
documentationPath="documentation/source/tools/apk.md"
