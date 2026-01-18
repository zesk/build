#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="--map - Flag. Optional. Map environment values into file before copying."$'\n'"--escalate - Flag. Optional. The file is a privilege escalation and needs visual confirmation. Requires root privileges."$'\n'"source - File. Required. Source path"$'\n'"destination - File. Required. Destination path"$'\n'""
base="interactive.sh"
description="Copy file from source to destination"$'\n'""$'\n'"Supports mapping the file using the current environment, or escalated privileges."$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Failed"$'\n'""
file="bin/build/tools/interactive.sh"
fn="fileCopy"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/interactive.sh"
sourceModified="1768695708"
summary="Copy file from source to destination"
usage="fileCopy [ --map ] [ --escalate ] source destination"
