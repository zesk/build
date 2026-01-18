#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/colors.sh"
argument="format - String. Optional. Formatting string."$'\n'"red - UnsignedInteger. Optional. Red component."$'\n'"green - UnsignedInteger. Optional. Blue component."$'\n'"blue - UnsignedInteger. Optional. Green component."$'\n'"--help - Flag. Optional.Display this help."$'\n'""
base="colors.sh"
description="Take r g b decimal values and convert them to hex color values"$'\n'"Takes arguments or stdin values in groups of 3."$'\n'""
file="bin/build/tools/colors.sh"
fn="colorFormat"
foundNames=([0]="stdin" [1]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/colors.sh"
sourceModified="1768695708"
stdin="list:UnsignedInteger"$'\n'""
summary="Take r g b decimal values and convert them to"
usage="colorFormat [ format ] [ red ] [ green ] [ blue ] [ --help ]"
