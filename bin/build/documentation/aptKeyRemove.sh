#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="apt.sh"
description="Remove apt keys"$'\n'"Argument: keyName - String. Required. One or more key names to remove."$'\n'"Argument: --skip - Flag. Optional. a Do not do \`apt-get update\` afterwards to update the database."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 1 - if environment is awry"$'\n'"Return Code: 0 - Apt key was removed AOK"$'\n'""
file="bin/build/tools/apt.sh"
foundNames=()
rawComment="Remove apt keys"$'\n'"Argument: keyName - String. Required. One or more key names to remove."$'\n'"Argument: --skip - Flag. Optional. a Do not do \`apt-get update\` afterwards to update the database."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 1 - if environment is awry"$'\n'"Return Code: 0 - Apt key was removed AOK"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/apt.sh"
sourceHash="4984b9c9b6822f2422dcb890964923b29cf63287"
summary="Remove apt keys"
usage="aptKeyRemove"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]maptKeyRemove'$'\e''[0m'$'\n'''$'\n''Remove apt keys'$'\n''Argument: keyName - String. Required. One or more key names to remove.'$'\n''Argument: --skip - Flag. Optional. a Do not do '$'\e''[[(code)]mapt-get update'$'\e''[[(reset)]m afterwards to update the database.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 1 - if environment is awry'$'\n''Return Code: 0 - Apt key was removed AOK'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: aptKeyRemove'$'\n'''$'\n''Remove apt keys'$'\n''Argument: keyName - String. Required. One or more key names to remove.'$'\n''Argument: --skip - Flag. Optional. a Do not do apt-get update afterwards to update the database.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 1 - if environment is awry'$'\n''Return Code: 0 - Apt key was removed AOK'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.469
