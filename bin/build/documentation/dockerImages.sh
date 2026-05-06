#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--filter reference - String. Optional. Filter list by reference provided."$'\n'""
base="docker.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="List docker images which are currently pulled"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/docker.sh"
fn="dockerImages"
fnMarker="dockerimages"
foundNames=([0]="argument")
line="218"
rawComment="List docker images which are currently pulled"$'\n'"Argument: --filter reference - String. Optional. Filter list by reference provided."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker.sh"
sourceHash="7ff1d9ef9d41486d9537ae6db40de4176c5794ab"
sourceLine="218"
summary="List docker images which are currently pulled"
summaryComputed="true"
usage="dockerImages [ --filter reference ]"
