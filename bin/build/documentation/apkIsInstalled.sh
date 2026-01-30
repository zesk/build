#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-29
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="apk.sh"
description="Is this an Alpine system and is apk installed?"$'\n'""
file="bin/build/tools/apk.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Is this an Alpine system and is apk installed?"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - System is an alpine system and apk is installed"$'\n'"Return Code: 1 - System is not an alpine system or apk is not installed"$'\n'""$'\n'""
return_code="0 - System is an alpine system and apk is installed"$'\n'"1 - System is not an alpine system or apk is not installed"$'\n'""
sourceFile="bin/build/tools/apk.sh"
sourceHash="bf1ba6c70d8b06ada0fad0896671bac9cdb70c6f"
summary="Is this an Alpine system and is apk installed?"
usage="apkIsInstalled [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mapkIsInstalled'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Is this an Alpine system and is apk installed?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - System is an alpine system and apk is installed'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - System is not an alpine system or apk is not installed'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mapkIsInstalled [[(blue)]m[ --help ]'$'\n'''$'\n''    [[(blue)]m--help  [[(value)]mFlag. Optional. Display this help.'$'\n'''$'\n''Is this an Alpine system and is apk installed?'$'\n'''$'\n''Return codes:'$'\n''- 0 - System is an alpine system and apk is installed'$'\n''- 1 - System is not an alpine system or apk is not installed'$'\n'''
# elapsed 2.391
