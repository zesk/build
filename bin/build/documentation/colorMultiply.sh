#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'factor - floatValue. Required. Red RGB value (0-255)\nredValue - Integer. Required. Red RGB value (0-255)\ngreenValue - Integer. Required. Red RGB value (0-255)\nblueValue - Integer. Required. Red RGB value (0-255)\n--help - Flag. Optional. Display this help.\n'
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Multiply color values by a factor and return the new values\n\n'
descriptionLineCount="2"
file="bin/build/tools/colors.sh"
fn="colorMultiply"
fnMarker="colormultiply"
foundNames=([0]="argument" [1]="requires")
line="723"
rawComment=$'Multiply color values by a factor and return the new values\nArgument: factor - floatValue. Required. Red RGB value (0-255)\nArgument: redValue - Integer. Required. Red RGB value (0-255)\nArgument: greenValue - Integer. Required. Red RGB value (0-255)\nArgument: blueValue - Integer. Required. Red RGB value (0-255)\nArgument: --help - Flag. Optional. Display this help.\nRequires: bc\n\n'
requires=$'bc\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/colors.sh"
sourceHash="e1522f7f8cb27e1039a3dfb5f2378236eaf38df0"
sourceLine="723"
summary="Multiply color values by a factor and return the new"
summaryComputed="true"
usage="colorMultiply factor redValue greenValue blueValue [ --help ]"
