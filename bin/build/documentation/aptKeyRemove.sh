#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument=$'keyName - String. Required. One or more key names to remove.\n--skip - Flag. Optional. a Do not do `apt-get update` afterwards to update the database.\n--help - Flag. Optional. Display this help.\n'
base="apt.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Remove apt keys\n\n'
descriptionLineCount="2"
file="bin/build/tools/apt.sh"
fn="aptKeyRemove"
fnMarker="aptkeyremove"
foundNames=([0]="argument" [1]="return_code")
line="95"
rawComment=$'Remove apt keys\nArgument: keyName - String. Required. One or more key names to remove.\nArgument: --skip - Flag. Optional. a Do not do `apt-get update` afterwards to update the database.\nArgument: --help - Flag. Optional. Display this help.\nReturn Code: 1 - if environment is awry\nReturn Code: 0 - Apt key was removed AOK\n\n'
return_code=$'1 - if environment is awry\n0 - Apt key was removed AOK\n'
sourceFile="bin/build/tools/apt.sh"
sourceHash="88cf0bf4880cbbb00ac4ecc16ac7dac0654df552"
sourceLine="95"
summary="Remove apt keys"
summaryComputed="true"
usage="aptKeyRemove keyName [ --skip ] [ --help ]"
documentationPath="documentation/source/tools/apt.md"
