#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="docker-compose.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Is docker compose currently running?"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/docker-compose.sh"
fn="dockerComposeIsRunning"
fnMarker="dockercomposeisrunning"
foundNames=([0]="argument" [1]="return_code")
line="85"
rawComment="Is docker compose currently running?"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 1 - Not running"$'\n'"Return Code: 0 - Running"$'\n'""$'\n'""
return_code="1 - Not running"$'\n'"0 - Running"$'\n'""
sourceFile="bin/build/tools/docker-compose.sh"
sourceHash="fd46ba45b4bfb981e0a17b3510aa593d2fe8dec6"
sourceLine="85"
summary="Is docker compose currently running?"
summaryComputed="true"
usage="dockerComposeIsRunning [ --help ]"
