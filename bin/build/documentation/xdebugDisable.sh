#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/xdebug.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="xdebug.sh"
description="Disable Xdebug on systems that have it"$'\n'""
environment="XDEBUG_ENABLED"$'\n'""
exitCode="0"
file="bin/build/tools/xdebug.sh"
foundNames=([0]="environment" [1]="argument")
rawComment="Disable Xdebug on systems that have it"$'\n'"Environment: XDEBUG_ENABLED"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/xdebug.sh"
sourceModified="1769063211"
summary="Disable Xdebug on systems that have it"
usage="xdebugDisable [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mxdebugDisable'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--help  '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n'''$'\n''Disable Xdebug on systems that have it'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- XDEBUG_ENABLED'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: xdebugDisable [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Disable Xdebug on systems that have it'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- XDEBUG_ENABLED'$'\n'''
