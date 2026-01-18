#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="--map - Flag. Optional. Map environment values into file before copying."$'\n'"source - File. Required. Source path"$'\n'"destination - File. Required. Destination path"$'\n'""
base="interactive.sh"
description="Check whether copying a file would change it"$'\n'"This function does not modify the source or destination."$'\n'"Return Code: 0 - Something would change"$'\n'"Return Code: 1 - Nothing would change"$'\n'""
file="bin/build/tools/interactive.sh"
fn="fileCopyWouldChange"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/interactive.sh"
sourceModified="1768759374"
summary="Check whether copying a file would change it"
usage="fileCopyWouldChange [ --map ] source destination"
