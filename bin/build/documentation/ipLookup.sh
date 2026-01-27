#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/pipeline.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="pipeline.sh"
description="Get the current IP address of a host"$'\n'""
environment="IP_URL"$'\n'"IP_URL_FILTER"$'\n'""
file="bin/build/tools/pipeline.sh"
foundNames=([0]="argument" [1]="environment")
rawComment="Get the current IP address of a host"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Environment: IP_URL"$'\n'"Environment: IP_URL_FILTER"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/pipeline.sh"
sourceModified="1769185900"
summary="Get the current IP address of a host"
usage="ipLookup [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mipLookup'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Get the current IP address of a host'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- IP_URL'$'\n''- IP_URL_FILTER'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: ipLookup [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Get the current IP address of a host'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- IP_URL'$'\n''- IP_URL_FILTER'$'\n'''
# elapsed 0.472
