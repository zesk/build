#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument="... - Arguments. Passed to \`docker compose\` command or equivalent"$'\n'""
base="docker-compose.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Wrapper for \`docker-compose\` or \`docker compose\`"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/docker-compose.sh"
fn="dockerComposeWrapper"
fnMarker="dockercomposewrapper"
foundNames=([0]="argument")
line="10"
rawComment="Wrapper for \`docker-compose\` or \`docker compose\`"$'\n'"Argument: ... - Arguments. Passed to \`docker compose\` command or equivalent"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker-compose.sh"
sourceHash="a10cd9abf0ca14f427ce8a440b925933d82759e8"
sourceLine="10"
summary="Wrapper for \`docker-compose\` or \`docker compose\`"
summaryComputed="true"
usage="dockerComposeWrapper [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerComposeWrapper'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m...  '$'\e''[[(value)]mArguments. Passed to '$'\e''[[(code)]mdocker compose'$'\e''[[(reset)]m command or equivalent'$'\e''[[(reset)]m'$'\n'''$'\n''Wrapper for '$'\e''[[(code)]mdocker-compose'$'\e''[[(reset)]m or '$'\e''[[(code)]mdocker compose'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: dockerComposeWrapper [ ... ]'$'\n'''$'\n''    ...  Arguments. Passed to docker compose command or equivalent'$'\n'''$'\n''Wrapper for docker-compose or docker compose'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/docker-compose.md"
