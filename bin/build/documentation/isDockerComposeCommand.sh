#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-04
# shellcheck disable=SC2034
argument="command - String. Required. The command to test."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="docker-compose.sh"
description="Is this a docker compose command?"$'\n'""
file="bin/build/tools/docker-compose.sh"
foundNames=([0]="argument" [1]="see" [2]="return_code")
rawComment="Is this a docker compose command?"$'\n'"Argument: command - String. Required. The command to test."$'\n'"See: dockerComposeCommandList"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - Yes, it is."$'\n'"Return Code: 1 - No, it is not."$'\n'""$'\n'""
return_code="0 - Yes, it is."$'\n'"1 - No, it is not."$'\n'""
see="dockerComposeCommandList"$'\n'""
sourceFile="bin/build/tools/docker-compose.sh"
sourceHash="d76bbd31ab881ad7554c01ea2d1740afa9a1a92d"
summary="Is this a docker compose command?"
summaryComputed="true"
usage="isDockerComposeCommand command [ --help ]"
