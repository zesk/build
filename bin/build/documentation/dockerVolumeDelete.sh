#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="name - String. Required. Volume name to delete."$'\n'""
base="docker.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Delete a docker volume"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/docker.sh"
fn="dockerVolumeDelete"
fnMarker="dockervolumedelete"
foundNames=([0]="argument")
line="310"
rawComment="Delete a docker volume"$'\n'"Argument: name - String. Required. Volume name to delete."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker.sh"
sourceHash="7ff1d9ef9d41486d9537ae6db40de4176c5794ab"
sourceLine="310"
summary="Delete a docker volume"
summaryComputed="true"
usage="dockerVolumeDelete name"
