#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--dry-run - Flag. Optional. Do not change anything."$'\n'"--cull cullCount - UnsignedInteger. Optional. Delete log file indexes which exist beyond the \`count\`. Default is \`0\`."$'\n'"logFile - File. Required. A log file which exists."$'\n'"count - PositiveInteger. Required. Integer of log file backups to maintain."$'\n'""
base="log.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Rotates a log file by adding a digit to the end numerically, and moves logs such that the most recent"$'\n'"log backup suffix is \`.1\` and the oldest log backup suffix is \`.count\`."$'\n'""$'\n'"Backs up files as:"$'\n'""$'\n'"    logFile"$'\n'"    logFile.1"$'\n'"    logFile.2"$'\n'"    logFile.3"$'\n'""$'\n'"\`--cull\` will delete \`cullCount\` files in addition to the backup files if they exist. This is useful if you change this number"$'\n'"from a higher to a lower number and want the extra files deleted."$'\n'""$'\n'"But maintains file descriptors for \`logFile\`."$'\n'""$'\n'""
descriptionLineCount="15"
file="bin/build/tools/log.sh"
fn="logRotate"
fnMarker="logrotate"
foundNames=([0]="argument" [1]="summary")
line="33"
rawComment="Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --dry-run - Flag. Optional. Do not change anything."$'\n'"Argument: --cull cullCount - UnsignedInteger. Optional. Delete log file indexes which exist beyond the \`count\`. Default is \`0\`."$'\n'"Argument: logFile - File. Required. A log file which exists."$'\n'"Argument: count - PositiveInteger. Required. Integer of log file backups to maintain."$'\n'"Summary: Rotate a log file"$'\n'"Rotates a log file by adding a digit to the end numerically, and moves logs such that the most recent"$'\n'"log backup suffix is \`.1\` and the oldest log backup suffix is \`.count\`."$'\n'"Backs up files as:"$'\n'"    logFile"$'\n'"    logFile.1"$'\n'"    logFile.2"$'\n'"    logFile.3"$'\n'"\`--cull\` will delete \`cullCount\` files in addition to the backup files if they exist. This is useful if you change this number"$'\n'"from a higher to a lower number and want the extra files deleted."$'\n'"But maintains file descriptors for \`logFile\`."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/log.sh"
sourceHash="eefc81d1b4d064347f0e0203223c091ce3e9c76c"
sourceLine="33"
summary="Rotate a log file"
summaryComputed=""
usage="logRotate [ --help ] [ --dry-run ] [ --cull cullCount ] logFile count"
