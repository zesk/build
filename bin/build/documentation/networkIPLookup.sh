#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
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
line="75"
rawComment="Get the current IP address of a host"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Environment: IP_URL"$'\n'"Environment: IP_URL_FILTER"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/network.sh"
sourceHash="23f35705edd9cb61b7c0f0d8c20699a767a97a90"
sourceLine="75"
summary="Get the current IP address of a host"
summaryComputed="true"
usage="networkIPLookup [ --help ]"
