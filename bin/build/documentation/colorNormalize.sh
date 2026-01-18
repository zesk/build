#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/colors.sh"
argument="--help - Flag. Optional.Display this help."$'\n'""
base="colors.sh"
description="Redistribute color values to make brightness adjustments more balanced"$'\n'""
file="bin/build/tools/colors.sh"
fn="colorNormalize"
foundNames=([0]="argument" [1]="requires")
requires="bc catchEnvironment read usageArgumentUnsignedInteger packageWhich __colorNormalize"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/colors.sh"
sourceModified="1768695708"
summary="Redistribute color values to make brightness adjustments more balanced"
usage="colorNormalize [ --help ]"
