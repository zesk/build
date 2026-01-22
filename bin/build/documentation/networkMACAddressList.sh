#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/network.sh"
argument="--install - Flag. Optional. Install any packages required to get \`ifconfig\` installed first."$'\n'"--help - Flag. Optional. This help."$'\n'""
base="network.sh"
description="List MAC addresses associated with this system using \`ifconfig\`"$'\n'""
file="bin/build/tools/network.sh"
fn="networkMACAddressList"
foundNames=""
output="lines:IPv4"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/network.sh"
sourceModified="1768513812"
summary="List MAC addresses associated with this system using \`ifconfig\`"
usage="networkMACAddressList [ --install ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mnetworkMACAddressList[0m [94m[ --install ][0m [94m[ --help ][0m

    [31m--install  [1;97mFlag. Optional. Install any packages required to get [38;2;0;255;0;48;2;0;0;0mifconfig[0m installed first.[0m
    [94m--help     [1;97mFlag. Optional. This help.[0m

List MAC addresses associated with this system using [38;2;0;255;0;48;2;0;0;0mifconfig[0m

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: networkMACAddressList [ --install ] [ --help ]

    --install  Flag. Optional. Install any packages required to get ifconfig installed first.
    --help     Flag. Optional. This help.

List MAC addresses associated with this system using ifconfig

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
