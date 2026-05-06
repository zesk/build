#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--map - Flag. Optional. Map environment values into file before copying."$'\n'"--escalate - Flag. Optional. The file is a privilege escalation and needs visual confirmation. Requires root privileges."$'\n'"source - File. Required. Source path"$'\n'"destination - File. Required. Destination path"$'\n'""
base="interactive.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Copy file from source to destination"$'\n'""$'\n'"Supports mapping the file using the current environment, or escalated privileges."$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/interactive.sh"
fn="fileCopy"
fnMarker="filecopy"
foundNames=([0]="argument" [1]="return_code")
line="55"
rawComment="Copy file from source to destination"$'\n'"Supports mapping the file using the current environment, or escalated privileges."$'\n'"Argument: --map - Flag. Optional. Map environment values into file before copying."$'\n'"Argument: --escalate - Flag. Optional. The file is a privilege escalation and needs visual confirmation. Requires root privileges."$'\n'"Argument: source - File. Required. Source path"$'\n'"Argument: destination - File. Required. Destination path"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Failed"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Failed"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceHash="378aca49779b1c4a5f70a0c419c2a078d3e0d369"
sourceLine="55"
summary="Copy file from source to destination"
summaryComputed="true"
usage="fileCopy [ --map ] [ --escalate ] source destination"
