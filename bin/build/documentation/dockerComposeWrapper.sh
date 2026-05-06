#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
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
sourceHash="fd46ba45b4bfb981e0a17b3510aa593d2fe8dec6"
sourceLine="10"
summary="Wrapper for \`docker-compose\` or \`docker compose\`"
summaryComputed="true"
usage="dockerComposeWrapper [ ... ]"
