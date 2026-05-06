#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="name - String. Required."$'\n'""
base="docker.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Does a docker volume exist with name?"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/docker.sh"
fn="dockerVolumeExists"
fnMarker="dockervolumeexists"
foundNames=([0]="argument")
line="297"
rawComment="Does a docker volume exist with name?"$'\n'"Argument: name - String. Required."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker.sh"
sourceHash="7ff1d9ef9d41486d9537ae6db40de4176c5794ab"
sourceLine="297"
summary="Does a docker volume exist with name?"
summaryComputed="true"
usage="dockerVolumeExists name"
