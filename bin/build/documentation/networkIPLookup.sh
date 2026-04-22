#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="network.sh"
description="Get the current IP address of a host"$'\n'""
environment="IP_URL"$'\n'"IP_URL_FILTER"$'\n'""
file="bin/build/tools/network.sh"
fn="networkIPLookup"
foundNames=([0]="argument" [1]="environment")
line="75"
lowerFn="networkiplookup"
rawComment="Get the current IP address of a host"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Environment: IP_URL"$'\n'"Environment: IP_URL_FILTER"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/network.sh"
sourceHash="23f35705edd9cb61b7c0f0d8c20699a767a97a90"
sourceLine="75"
summary="Get the current IP address of a host"
summaryComputed="true"
usage="networkIPLookup [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mnetworkIPLookup'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Get the current IP address of a host'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- IP_URL'$'\n''- IP_URL_FILTER'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: networkIPLookup [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Get the current IP address of a host'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- IP_URL'$'\n''- IP_URL_FILTER'$'\n'''
documentationPath="documentation/source/tools/network.md"
