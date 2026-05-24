#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--handler handler - Function. Optional. Use this error handler instead of the default error handler.\n--debug - Flag. Optional. Show additional debugging information.\n'
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Set the terminal color scheme to the specification\n\n'
descriptionLineCount="2"
file="bin/build/tools/colors.sh"
fn="colorScheme"
fnMarker="colorscheme"
foundNames=([0]="argument" [1]="stdin")
line="812"
rawComment=$'Set the terminal color scheme to the specification\nArgument: --help - Flag. Optional. Display this help.\nArgument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.\nArgument: --debug - Flag. Optional. Show additional debugging information.\nstdin: Scheme definition with `colorName=colorValue` on each line\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/colors.sh"
sourceHash="e1522f7f8cb27e1039a3dfb5f2378236eaf38df0"
sourceLine="812"
stdin=$'Scheme definition with `colorName=colorValue` on each line\n'
summary="Set the terminal color scheme to the specification"
summaryComputed="true"
usage="colorScheme [ --help ] [ --handler handler ] [ --debug ]"
