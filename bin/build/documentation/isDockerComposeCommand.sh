#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="command - String. Required. The command to test."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="docker-compose.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Is this a docker compose command?"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/docker-compose.sh"
fn="isDockerComposeCommand"
fnMarker="isdockercomposecommand"
foundNames=([0]="argument" [1]="see" [2]="return_code")
line="125"
rawComment="Is this a docker compose command?"$'\n'"Argument: command - String. Required. The command to test."$'\n'"See: dockerComposeCommandList"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - Yes, it is."$'\n'"Return Code: 1 - No, it is not."$'\n'""$'\n'""
return_code="0 - Yes, it is."$'\n'"1 - No, it is not."$'\n'""
see="dockerComposeCommandList"$'\n'""
sourceFile="bin/build/tools/docker-compose.sh"
sourceHash="fd46ba45b4bfb981e0a17b3510aa593d2fe8dec6"
sourceLine="125"
summary="Is this a docker compose command?"
summaryComputed="true"
usage="isDockerComposeCommand command [ --help ]"
