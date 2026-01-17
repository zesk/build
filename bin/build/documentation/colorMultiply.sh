#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/colors.sh"
argument="factor - floatValue. Required. Red RGB value (0-255)"$'\n'"redValue - Integer. Required. Red RGB value (0-255)"$'\n'"greenValue - Integer. Required. Red RGB value (0-255)"$'\n'"blueValue - Integer. Required. Red RGB value (0-255)"$'\n'"--help -  Flag. Optional.Display this help."$'\n'""
base="colors.sh"
description="Multiply color values by a factor and return the new values"$'\n'""
file="bin/build/tools/colors.sh"
fn="colorMultiply"
foundNames=([0]="argument" [1]="requires")
requires="bc"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/colors.sh"
sourceModified="1768686076"
summary="Multiply color values by a factor and return the new"
usage="colorMultiply factor redValue greenValue blueValue [ --help ]"
