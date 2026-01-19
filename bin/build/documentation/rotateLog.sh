#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/log.sh"
argument="--dry-run - Flag. Optional. Do not change anything."$'\n'"logFile - Required. A log file which exists."$'\n'"count - Required. Integer of log files to maintain."$'\n'""
base="log.sh"
description="Rotate a log file"$'\n'""$'\n'"Backs up files as:"$'\n'""$'\n'"    logFile"$'\n'"    logFile.1"$'\n'"    logFile.2"$'\n'"    logFile.3"$'\n'""$'\n'"But maintains file descriptors for \`logFile\`."$'\n'""
file="bin/build/tools/log.sh"
fn="rotateLog"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/log.sh"
sourceModified="1768513812"
summary="Rotate a log file"
usage="rotateLog [ --dry-run ] logFile count"
