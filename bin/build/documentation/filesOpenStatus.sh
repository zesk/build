#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-23
# shellcheck disable=SC2034
argument="none"
base="debug.sh"
description="Output current open files"$'\n'"stdout"$'\n'""
file="bin/build/tools/debug.sh"
fn="filesOpenStatus"
foundNames=()
rawComment="Output current open files"$'\n'"stdout"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="e63fcc99dec04cd39a71d72e430b7e22a07145ab"
summary="Output current open files"
summaryComputed="true"
usage="filesOpenStatus"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfilesOpenStatus'$'\e''[0m'$'\n'''$'\n''Output current open files'$'\n''stdout'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: filesOpenStatus'$'\n'''$'\n''Output current open files'$'\n''stdout'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
