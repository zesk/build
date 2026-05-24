#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'format - String. Optional. Formatting string.\nred - UnsignedInteger. Optional. Red component.\ngreen - UnsignedInteger. Optional. Blue component.\nblue - UnsignedInteger. Optional. Green component.\n--help - Flag. Optional. Display this help.\n'
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Take r g b decimal values and convert them to hex color values\nTakes arguments or stdin values in groups of 3.\n\n'
descriptionLineCount="3"
file="bin/build/tools/colors.sh"
fn="colorFormat"
fnMarker="colorformat"
foundNames=([0]="stdin" [1]="argument")
line="656"
rawComment=$'Take r g b decimal values and convert them to hex color values\nstdin: list:UnsignedInteger\nArgument: format - String. Optional. Formatting string.\nArgument: red - UnsignedInteger. Optional. Red component.\nArgument: green - UnsignedInteger. Optional. Blue component.\nArgument: blue - UnsignedInteger. Optional. Green component.\nArgument: --help - Flag. Optional. Display this help.\nTakes arguments or stdin values in groups of 3.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/colors.sh"
sourceHash="e1522f7f8cb27e1039a3dfb5f2378236eaf38df0"
sourceLine="656"
stdin=$'list:UnsignedInteger\n'
summary="Take r g b decimal values and convert them to"
summaryComputed="true"
usage="colorFormat [ format ] [ red ] [ green ] [ blue ] [ --help ]"
