#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/timing.sh"
argument="--color color - Make text this color (default is \`green\`)"$'\n'"--help - Flag. Optional.Display this help."$'\n'"--handler handler - Function. Optional.Use this error handler instead of the default error handler."$'\n'"start - Unix timestamp milliseconds. See \`timingStart\`."$'\n'"message - Any additional arguments are output before the elapsed value computed"$'\n'""
base="timing.sh"
description="Outputs the timing optionally prefixed by a message."$'\n'""$'\n'"Outputs a nice colorful message showing the number of seconds elapsed as well as your custom message."$'\n'"Return Code: 0 - Exits with exit code zero"$'\n'""
example="    init=\$(timingStart)"$'\n'"    ..."$'\n'"    timingReport \"\$init\" \"Deploy completed in\""$'\n'""
file="bin/build/tools/timing.sh"
fn="timingReport"
foundNames=([0]="summary" [1]="argument" [2]="see" [3]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="timingStart"$'\n'""
source="bin/build/tools/timing.sh"
sourceModified="1768695708"
summary="Output the time elapsed"$'\n'""
usage="timingReport [ --color color ] [ --help ] [ --handler handler ] [ start ] [ message ]"
