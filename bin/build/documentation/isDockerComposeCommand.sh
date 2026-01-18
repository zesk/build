#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/docker-compose.sh"
argument="command - String. Required. The command to test."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="docker-compose.sh"
description="Is this a docker compose command?"$'\n'"Return Code: 0 - Yes, it is."$'\n'"Return Code: 1 - No, it is not."$'\n'""
file="bin/build/tools/docker-compose.sh"
fn="isDockerComposeCommand"
foundNames=([0]="argument" [1]="see")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="dockerComposeCommandList"$'\n'""
source="bin/build/tools/docker-compose.sh"
sourceModified="1768721469"
summary="Is this a docker compose command?"
usage="isDockerComposeCommand command [ --help ]"
