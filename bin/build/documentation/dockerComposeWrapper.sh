#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/docker-compose.sh"
argument="... - Arguments. Passed to \`docker compose\` command or equivalent"$'\n'""
base="docker-compose.sh"
description="Wrapper for \`docker-compose\` or \`docker compose\`"$'\n'""
file="bin/build/tools/docker-compose.sh"
fn="dockerComposeWrapper"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker-compose.sh"
sourceModified="1769063211"
summary="Wrapper for \`docker-compose\` or \`docker compose\`"
usage="dockerComposeWrapper [ ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdockerComposeWrapper[0m [94m[ ... ][0m

    [94m...  [1;97mArguments. Passed to [38;2;0;255;0;48;2;0;0;0mdocker compose[0m command or equivalent[0m

Wrapper for [38;2;0;255;0;48;2;0;0;0mdocker-compose[0m or [38;2;0;255;0;48;2;0;0;0mdocker compose[0m

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: dockerComposeWrapper [ ... ]

    ...  Arguments. Passed to docker compose command or equivalent

Wrapper for docker-compose or docker compose

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
