#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/docker-compose.sh"
argument="command - String. Required. The command to test."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="docker-compose.sh"
description="Is this a docker compose command?"$'\n'"Return Code: 0 - Yes, it is."$'\n'"Return Code: 1 - No, it is not."$'\n'""
file="bin/build/tools/docker-compose.sh"
fn="isDockerComposeCommand"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="dockerComposeCommandList"$'\n'""
sourceFile="bin/build/tools/docker-compose.sh"
sourceModified="1769063211"
summary="Is this a docker compose command?"
usage="isDockerComposeCommand command [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255misDockerComposeCommand[0m [38;2;255;255;0m[35;48;2;0;0;0mcommand[0m[0m [94m[ --help ][0m

    [31mcommand  [1;97mString. Required. The command to test.[0m
    [94m--help   [1;97mFlag. Optional. Display this help.[0m

Is this a docker compose command?
Return Code: 0 - Yes, it is.
Return Code: 1 - No, it is not.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: isDockerComposeCommand command [ --help ]

    command  String. Required. The command to test.
    --help   Flag. Optional. Display this help.

Is this a docker compose command?
Return Code: 0 - Yes, it is.
Return Code: 1 - No, it is not.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
