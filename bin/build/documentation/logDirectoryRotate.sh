#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--dry-run - Flag. Optional. Do not change anything."$'\n'"--cull cullCount - UnsignedInteger. Optional. Delete log file indexes which exist beyond the \`count\`. Default is \`0\`."$'\n'"logPath - Directory. Required. Path where log files exist. Looks for files which match \`*.log\`."$'\n'"count - PositiveInteger. Required. Integer of log files to maintain."$'\n'""
base="log.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="For all log files in logPath with extension \`.log\`, rotate them safely."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/log.sh"
fn="logDirectoryRotate"
fnMarker="logdirectoryrotate"
foundNames=([0]="summary" [1]="see" [2]="argument")
line="108"
rawComment="Summary: Rotate log files"$'\n'"For all log files in logPath with extension \`.log\`, rotate them safely."$'\n'"See: logRotate"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --dry-run - Flag. Optional. Do not change anything."$'\n'"Argument: --cull cullCount - UnsignedInteger. Optional. Delete log file indexes which exist beyond the \`count\`. Default is \`0\`."$'\n'"Argument: logPath - Directory. Required. Path where log files exist. Looks for files which match \`*.log\`."$'\n'"Argument: count - PositiveInteger. Required. Integer of log files to maintain."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="logRotate"$'\n'""
sourceFile="bin/build/tools/log.sh"
sourceHash="eefc81d1b4d064347f0e0203223c091ce3e9c76c"
sourceLine="108"
summary="Rotate log files"
summaryComputed=""
usage="logDirectoryRotate [ --help ] [ --dry-run ] [ --cull cullCount ] logPath count"
