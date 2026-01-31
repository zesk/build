#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="apk.sh"
description="Is this an Alpine system and is apk installed?"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - System is an alpine system and apk is installed"$'\n'"Return Code: 1 - System is not an alpine system or apk is not installed"$'\n'""
file="bin/build/tools/apk.sh"
foundNames=()
rawComment="Is this an Alpine system and is apk installed?"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - System is an alpine system and apk is installed"$'\n'"Return Code: 1 - System is not an alpine system or apk is not installed"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/apk.sh"
sourceHash="bf1ba6c70d8b06ada0fad0896671bac9cdb70c6f"
summary="Is this an Alpine system and is apk installed?"
usage="apkIsInstalled"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mapkIsInstalled'$'\e''[0m'$'\n'''$'\n''Is this an Alpine system and is apk installed?'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 0 - System is an alpine system and apk is installed'$'\n''Return Code: 1 - System is not an alpine system or apk is not installed'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: apkIsInstalled'$'\n'''$'\n''Is this an Alpine system and is apk installed?'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 0 - System is an alpine system and apk is installed'$'\n''Return Code: 1 - System is not an alpine system or apk is not installed'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.43
