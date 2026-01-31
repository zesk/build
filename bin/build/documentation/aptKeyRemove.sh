#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="keyName - String. Required. One or more key names to remove."$'\n'"--skip - Flag. Optional. a Do not do \`apt-get update\` afterwards to update the database."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="apt.sh"
description="Remove apt keys"$'\n'""
file="bin/build/tools/apt.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Remove apt keys"$'\n'"Argument: keyName - String. Required. One or more key names to remove."$'\n'"Argument: --skip - Flag. Optional. a Do not do \`apt-get update\` afterwards to update the database."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 1 - if environment is awry"$'\n'"Return Code: 0 - Apt key was removed AOK"$'\n'""$'\n'""
return_code="1 - if environment is awry"$'\n'"0 - Apt key was removed AOK"$'\n'""
sourceFile="bin/build/tools/apt.sh"
sourceHash="4984b9c9b6822f2422dcb890964923b29cf63287"
summary="Remove apt keys"
summaryComputed="true"
usage="aptKeyRemove keyName [ --skip ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]maptKeyRemove'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mkeyName'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --skip ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mkeyName  '$'\e''[[(value)]mString. Required. One or more key names to remove.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--skip   '$'\e''[[(value)]mFlag. Optional. a Do not do '$'\e''[[(code)]mapt-get update'$'\e''[[(reset)]m afterwards to update the database.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Remove apt keys'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - if environment is awry'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Apt key was removed AOK'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: [[(info)]maptKeyRemove [[(bold)]mkeyName [[(blue)]m[ --skip ] [[(blue)]m[ --help ]'$'\n'''$'\n''    [[(red)]mkeyName  [[(value)]mString. Required. One or more key names to remove.'$'\n''    [[(blue)]m--skip   [[(value)]mFlag. Optional. a Do not do [[(code)]mapt-get update afterwards to update the database.'$'\n''    [[(blue)]m--help   [[(value)]mFlag. Optional. Display this help.'$'\n'''$'\n''Remove apt keys'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m1 - if environment is awry'$'\n''- [[(code)]m0 - Apt key was removed AOK'$'\n'''
# elapsed 4
