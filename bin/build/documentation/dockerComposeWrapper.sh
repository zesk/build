#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="... - Arguments. Passed to \`docker compose\` command or equivalent"$'\n'""
base="docker-compose.sh"
description="Wrapper for \`docker-compose\` or \`docker compose\`"$'\n'""
file="bin/build/tools/docker-compose.sh"
fn="dockerComposeWrapper"
foundNames=([0]="argument")
line="10"
lowerFn="dockercomposewrapper"
rawComment="Wrapper for \`docker-compose\` or \`docker compose\`"$'\n'"Argument: ... - Arguments. Passed to \`docker compose\` command or equivalent"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker-compose.sh"
sourceHash="a21ed1c073769da3a59ec67f35a55a8a1d7d14ec"
sourceLine="10"
summary="Wrapper for \`docker-compose\` or \`docker compose\`"
summaryComputed="true"
usage="dockerComposeWrapper [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerComposeWrapper'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m...  '$'\e''[[(value)]mArguments. Passed to '$'\e''[[(code)]mdocker compose'$'\e''[[(reset)]m command or equivalent'$'\e''[[(reset)]m'$'\n'''$'\n''Wrapper for '$'\e''[[(code)]mdocker-compose'$'\e''[[(reset)]m or '$'\e''[[(code)]mdocker compose'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dockerComposeWrapper [ ... ]'$'\n'''$'\n''    ...  Arguments. Passed to docker compose command or equivalent'$'\n'''$'\n''Wrapper for docker-compose or docker compose'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/docker-compose.md"
