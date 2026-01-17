#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--underscore - Flag. Include environment variables which begin with underscore \`_\`."$'\n'"--secure - Flag. Include environment variables which are in \`environmentSecureVariables\`"$'\n'"--keep-comments - Flag. Keep all comments in the source"$'\n'"environmentFile - File. Required. Environment file to load, evaluate, and output in raw form (Bash-compatible)."$'\n'""
base="environment.sh"
description="Load an environment file and evaluate it using bash and output the changed environment variables after running"$'\n'"Do not perform this operation on files which are untrusted."$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentCompile"
foundNames=([0]="argument" [1]="security")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
security="source"$'\n'""
source="bin/build/tools/environment.sh"
sourceModified="1768683999"
summary="Load an environment file and evaluate it using bash and"
usage="environmentCompile [ --underscore ] [ --secure ] [ --keep-comments ] environmentFile"
