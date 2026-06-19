#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--install - Flag. Optional. Install any packages required to get `ifconfig` installed first.\n--help - Flag. Optional. This help.\n'
base="network.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'List MAC addresses associated with this system using `ifconfig`\n\n'
descriptionLineCount="2"
file="bin/build/tools/network.sh"
fn="networkMACAddressList"
fnMarker="networkmacaddresslist"
foundNames=([0]="output" [1]="argument")
line="169"
output=$'lines:IPv4\n'
rawComment=$'List MAC addresses associated with this system using `ifconfig`\nOutput: lines:IPv4\nArgument: --install - Flag. Optional. Install any packages required to get `ifconfig` installed first.\nArgument: --help - Flag. Optional. This help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/network.sh"
sourceHash="8e348568373c9cc01fe79d8a8cf35f22192cc6bb"
sourceLine="169"
summary="List MAC addresses associated with this system using \`ifconfig\`"
summaryComputed="true"
usage="networkMACAddressList [ --install ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mnetworkMACAddressList'$'\e''[0m '$'\e''[[(blue)]m[ --install ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]m--install  '$'\e''[[(value)]mFlag. Optional. Install any packages required to get '$'\e''[[(code)]mifconfig'$'\e''[[(reset)]m installed first.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. This help.'$'\e''[[(reset)]m'$'\n'''$'\n''List MAC addresses associated with this system using '$'\e''[[(code)]mifconfig'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: networkMACAddressList [ --install ] [ --help ]'$'\n'''$'\n''    --install  Flag. Optional. Install any packages required to get ifconfig installed first.'$'\n''    --help     Flag. Optional. This help.'$'\n'''$'\n''List MAC addresses associated with this system using ifconfig'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/network.md"
