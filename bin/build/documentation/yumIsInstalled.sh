#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="yum.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Is yum installed?"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/yum.sh"
fn="yumIsInstalled"
fnMarker="yumisinstalled"
foundNames=([0]="argument")
line="14"
rawComment="Is yum installed?"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/yum.sh"
sourceHash="dd277d2c1f6f73b679d879352695b6447f522626"
sourceLine="14"
summary="Is yum installed?"
summaryComputed="true"
usage="yumIsInstalled [ --help ]"
