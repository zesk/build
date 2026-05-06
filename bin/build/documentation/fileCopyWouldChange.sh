#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--map - Flag. Optional. Map environment values into file before copying."$'\n'"source - File. Required. Source path"$'\n'"destination - File. Required. Destination path"$'\n'""
base="interactive.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Check whether copying a file would change it"$'\n'"This function does not modify the source or destination."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/interactive.sh"
fn="fileCopyWouldChange"
fnMarker="filecopywouldchange"
foundNames=([0]="argument" [1]="return_code")
line="70"
rawComment="Check whether copying a file would change it"$'\n'"This function does not modify the source or destination."$'\n'"Argument: --map - Flag. Optional. Map environment values into file before copying."$'\n'"Argument: source - File. Required. Source path"$'\n'"Argument: destination - File. Required. Destination path"$'\n'"Return Code: 0 - Something would change"$'\n'"Return Code: 1 - Nothing would change"$'\n'""$'\n'""
return_code="0 - Something would change"$'\n'"1 - Nothing would change"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceHash="378aca49779b1c4a5f70a0c419c2a078d3e0d369"
sourceLine="70"
summary="Check whether copying a file would change it"
summaryComputed="true"
usage="fileCopyWouldChange [ --map ] source destination"
