#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/docker.sh"
argument="none"
base="docker.sh"
checked="2025-07-09"$'\n'""
description="Are we inside a docker container right now?"$'\n'""$'\n'"Return Code: 0 - Yes"$'\n'"Return Code: 1 - No"$'\n'""$'\n'""
file="bin/build/tools/docker.sh"
fn="insideDocker"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker.sh"
sourceModified="1768759328"
summary="Are we inside a docker container right now?"
todo="This changed 2023 ..."$'\n'"Write a test to check this date every oh, say, 3 months"$'\n'""
usage="insideDocker"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255minsideDocker[0m

Are we inside a docker container right now?

Return Code: 0 - Yes
Return Code: 1 - No

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: insideDocker

Are we inside a docker container right now?

Return Code: 0 - Yes
Return Code: 1 - No

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
