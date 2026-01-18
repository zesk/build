#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="sourceFile - File. Required. File to check"$'\n'"targetFile ... - File. Optional. One or more files to compare. All must exist."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
description="Check to see if the first file is the newest one"$'\n'""$'\n'"If \`sourceFile\` is modified AFTER ALL \`targetFile\`s, return \`0\`\`"$'\n'"Otherwise return \`1\`\`"$'\n'""$'\n'""$'\n'"Return Code: 1 - \`sourceFile\`, 'targetFile' does not exist, or"$'\n'"Return Code: 0 - All files exist and \`sourceFile\` is the oldest file"$'\n'""$'\n'""
file="bin/build/tools/file.sh"
fn="fileIsNewest"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/file.sh"
sourceModified="1768721469"
summary="Check to see if the first file is the newest"
usage="fileIsNewest sourceFile [ targetFile ... ] [ --help ]"
