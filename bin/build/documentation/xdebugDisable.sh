#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="xdebug.sh"
description="Disable Xdebug on systems that have it"$'\n'""
environment="XDEBUG_ENABLED"$'\n'""
file="bin/build/tools/xdebug.sh"
foundNames=([0]="environment" [1]="argument")
rawComment="Disable Xdebug on systems that have it"$'\n'"Environment: XDEBUG_ENABLED"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/xdebug.sh"
sourceHash="e0d106c72154e0193fd8960a45a5723098fd2898"
summary="Disable Xdebug on systems that have it"
summaryComputed="true"
usage="xdebugDisable [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mxdebugDisable'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Disable Xdebug on systems that have it'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- XDEBUG_ENABLED'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: [[(info)]mxdebugDisable [[(blue)]m[ --help ]'$'\n'''$'\n''    [[(blue)]m--help  Flag. Optional. Display this help.'$'\n'''$'\n''Disable Xdebug on systems that have it'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- XDEBUG_ENABLED'$'\n'''
