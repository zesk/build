#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/host.sh"
argument="none"
base="host.sh"
description="Get the full hostname"$'\n'""
file="bin/build/tools/host.sh"
foundNames=([0]="requires")
rawComment="Get the full hostname"$'\n'"Requires: __help __hostname usageRequireBinary catchEnvironment"$'\n'""$'\n'""
requires="__help __hostname usageRequireBinary catchEnvironment"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/host.sh"
sourceModified="1768246145"
summary="Get the full hostname"
usage="hostnameFull"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mhostnameFull'$'\e''[0m'$'\n'''$'\n''Get the full hostname'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: hostnameFull'$'\n'''$'\n''Get the full hostname'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.504
