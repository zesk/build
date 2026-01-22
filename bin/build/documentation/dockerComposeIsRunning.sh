#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/docker-compose.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="docker-compose.sh"
description="Is docker compose currently running?"$'\n'"Return Code: 1 - Not running"$'\n'"Return Code: 0 - Running"$'\n'""
file="bin/build/tools/docker-compose.sh"
fn="dockerComposeIsRunning"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker-compose.sh"
sourceModified="1768721469"
summary="Is docker compose currently running?"
usage="dockerComposeIsRunning [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdockerComposeIsRunning[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Is docker compose currently running?
Return Code: 1 - Not running
Return Code: 0 - Running

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: dockerComposeIsRunning [ --help ]

    --help  Flag. Optional. Display this help.

Is docker compose currently running?
Return Code: 1 - Not running
Return Code: 0 - Running

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
