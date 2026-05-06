#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--install - Flag. Optional. Install any packages required to get \`ifconfig\` installed first."$'\n'"--help - Flag. Optional. This help."$'\n'""
base="network.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="List IPv4 Addresses associated with this system using \`ifconfig\`"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/network.sh"
fn="networkIPList"
fnMarker="networkiplist"
foundNames=([0]="output" [1]="argument")
line="47"
output="lines:IPv4"$'\n'""
rawComment="List IPv4 Addresses associated with this system using \`ifconfig\`"$'\n'"Output: lines:IPv4"$'\n'"Argument: --install - Flag. Optional. Install any packages required to get \`ifconfig\` installed first."$'\n'"Argument: --help - Flag. Optional. This help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/network.sh"
sourceHash="23f35705edd9cb61b7c0f0d8c20699a767a97a90"
sourceLine="47"
summary="List IPv4 Addresses associated with this system using \`ifconfig\`"
summaryComputed="true"
usage="networkIPList [ --install ] [ --help ]"
