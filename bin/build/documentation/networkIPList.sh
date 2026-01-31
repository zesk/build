#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="network.sh"
description="List IPv4 Addresses associated with this system using \`ifconfig\`"$'\n'"Output: lines:IPv4"$'\n'"Argument: --install - Flag. Optional. Install any packages required to get \`ifconfig\` installed first."$'\n'"Argument: --help - Flag. Optional. This help."$'\n'""
file="bin/build/tools/network.sh"
foundNames=()
rawComment="List IPv4 Addresses associated with this system using \`ifconfig\`"$'\n'"Output: lines:IPv4"$'\n'"Argument: --install - Flag. Optional. Install any packages required to get \`ifconfig\` installed first."$'\n'"Argument: --help - Flag. Optional. This help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/network.sh"
sourceHash="7becd8e1f186aeaecbee3a360f0347446df81715"
summary="List IPv4 Addresses associated with this system using \`ifconfig\`"
usage="networkIPList"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mnetworkIPList'$'\e''[0m'$'\n'''$'\n''List IPv4 Addresses associated with this system using '$'\e''[[(code)]mifconfig'$'\e''[[(reset)]m'$'\n''Output: lines:IPv4'$'\n''Argument: --install - Flag. Optional. Install any packages required to get '$'\e''[[(code)]mifconfig'$'\e''[[(reset)]m installed first.'$'\n''Argument: --help - Flag. Optional. This help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: networkIPList'$'\n'''$'\n''List IPv4 Addresses associated with this system using ifconfig'$'\n''Output: lines:IPv4'$'\n''Argument: --install - Flag. Optional. Install any packages required to get ifconfig installed first.'$'\n''Argument: --help - Flag. Optional. This help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.455
