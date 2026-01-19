#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/log.sh"
argument="--dry-run - Flag. Optional. Do not change anything."$'\n'"logPath - Required. Path where log files exist."$'\n'"count - Required. Integer of log files to maintain."$'\n'""
base="log.sh"
description="For all log files in logPath with extension \`.log\`, rotate them safely"$'\n'""
file="bin/build/tools/log.sh"
fn="rotateLogs"
foundNames=([0]="summary" [1]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/log.sh"
sourceModified="1768513812"
summary="Rotate log files"$'\n'""
usage="rotateLogs [ --dry-run ] logPath count"
