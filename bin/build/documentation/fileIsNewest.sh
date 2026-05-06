#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="sourceFile - File. Required. File to check"$'\n'"targetFile ... - File. Optional. One or more files to compare. All must exist."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Check to see if the first file is the newest one"$'\n'""$'\n'"If \`sourceFile\` is modified AFTER ALL \`targetFile\`s, return \`0\`\`"$'\n'"Otherwise return \`1\`\`"$'\n'""$'\n'""
descriptionLineCount="5"
file="bin/build/tools/file.sh"
fn="fileIsNewest"
fnMarker="fileisnewest"
foundNames=([0]="argument" [1]="return_code")
line="158"
rawComment="Check to see if the first file is the newest one"$'\n'"If \`sourceFile\` is modified AFTER ALL \`targetFile\`s, return \`0\`\`"$'\n'"Otherwise return \`1\`\`"$'\n'"Argument: sourceFile - File. Required. File to check"$'\n'"Argument: targetFile ... - File. Optional. One or more files to compare. All must exist."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 1 - \`sourceFile\`, 'targetFile' does not exist, or"$'\n'"Return Code: 0 - All files exist and \`sourceFile\` is the oldest file"$'\n'""$'\n'""
return_code="1 - \`sourceFile\`, 'targetFile' does not exist, or"$'\n'"0 - All files exist and \`sourceFile\` is the oldest file"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="158"
summary="Check to see if the first file is the newest"
summaryComputed="true"
usage="fileIsNewest sourceFile [ targetFile ... ] [ --help ]"
