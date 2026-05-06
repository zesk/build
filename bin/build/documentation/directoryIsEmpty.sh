#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="directory - Directory. Optional. Directory to check if empty."$'\n'""
base="directory.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Does a directory exist and is it empty?"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/directory.sh"
fn="directoryIsEmpty"
fnMarker="directoryisempty"
foundNames=([0]="argument" [1]="return_code")
line="256"
rawComment="Argument: directory - Directory. Optional. Directory to check if empty."$'\n'"Does a directory exist and is it empty?"$'\n'"Return Code: 2 - Directory does not exist"$'\n'"Return Code: 1 - Directory is not empty"$'\n'"Return Code: 0 - Directory is empty"$'\n'""$'\n'""
return_code="2 - Directory does not exist"$'\n'"1 - Directory is not empty"$'\n'"0 - Directory is empty"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceHash="da838a55948477df4605f58aff4c29b4f13319f7"
sourceLine="256"
summary="Does a directory exist and is it empty?"
summaryComputed="true"
usage="directoryIsEmpty [ directory ]"
