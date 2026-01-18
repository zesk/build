#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/pipeline.sh"
argument="logFile - File. Required. The most recent log from the current script."$'\n'"message - String. Optional. Any additional message to output."$'\n'""
base="pipeline.sh"
description="Outputs debugging information after build fails:"$'\n'""$'\n'"- last 50 lines in build log"$'\n'"- Failed message"$'\n'"- last 3 lines in build log"$'\n'""$'\n'""$'\n'"Return Code: 1 - Always fails"$'\n'""
example="    quietLog=\"\$(buildQuietLog \"\$me\")\""$'\n'"    if ! ./bin/deploy.sh >>\"\$quietLog\"; then"$'\n'"        decorate error \"Deploy failed\""$'\n'"        buildFailed \"\$quietLog\""$'\n'"    fi"$'\n'""
file="bin/build/tools/pipeline.sh"
fn="buildFailed"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="output")
output="stdout"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/pipeline.sh"
sourceModified="1768759595"
summary="Output debugging information when the build fails"$'\n'""
usage="buildFailed logFile [ message ]"
