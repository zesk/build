#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-11
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="network.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Get the current IP address of a host"$'\n'""$'\n'""
descriptionLineCount="2"
environment="IP_URL"$'\n'"IP_URL_FILTER"$'\n'""
file="bin/build/tools/network.sh"
fn="networkIPLookup"
fnMarker="networkiplookup"
foundNames=([0]="argument" [1]="environment")
line="184"
rawComment="Get the current IP address of a host"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Environment: IP_URL"$'\n'"Environment: IP_URL_FILTER"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/network.sh"
sourceHash="c6bb29c8fed5128e9b6862594b56a1536f11596a"
sourceLine="184"
summary="Get the current IP address of a host"
summaryComputed="true"
usage="networkIPLookup [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mnetworkIPLookup'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Get the current IP address of a host'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- IP_URL'$'\n''- IP_URL_FILTER'
# shellcheck disable=SC2016
helpPlain='Usage: networkIPLookup [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Get the current IP address of a host'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- IP_URL'$'\n''- IP_URL_FILTER'
documentationPath="documentation/source/tools/network.md"
