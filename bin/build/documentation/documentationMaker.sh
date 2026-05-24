#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--verbose - Flag. Optional. Be wordy.\n--default defaultValue - EmptyString. Optional. Pass `--default` flag to `mapFunction`\nsourcePath - Exists. Required. File or directory to convert.\ntargetPath - FileDirectory. Optional. Outputs to `stdout` if not specified, otherwise outputs mirror.\nmapFunction ... - Function. Optional. Mapping function to use, and any arguments.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Generate documentation using source markdown and a mapping function.\n\n'
descriptionLineCount="2"
file="bin/build/tools/documentation.sh"
fn="documentationMaker"
fnMarker="documentationmaker"
foundNames=([0]="argument" [1]="return_code")
line="443"
rawComment=$'Generate documentation using source markdown and a mapping function.\nArgument: --verbose - Flag. Optional. Be wordy.\nArgument: --default defaultValue - EmptyString. Optional. Pass `--default` flag to `mapFunction`\nArgument: sourcePath - Exists. Required. File or directory to convert.\nArgument: targetPath - FileDirectory. Optional. Outputs to `stdout` if not specified, otherwise outputs mirror.\nArgument: mapFunction ... - Function. Optional. Mapping function to use, and any arguments.\nReturn Code: 0 - Success\nReturn Code: 1 - Template file not found\n\n'
return_code=$'0 - Success\n1 - Template file not found\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="fa382137d00499e888f4c9bf0ffc9e1256277eb1"
sourceLine="443"
summary="Generate documentation using source markdown and a mapping function."
summaryComputed="true"
usage="documentationMaker [ --verbose ] [ --default defaultValue ] sourcePath [ targetPath ] [ mapFunction ... ]"
