#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="where - Directory. Optional. Where to load the \`.env\` files."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
deprecated="2024-07-20"$'\n'""
description="Loads \`.env\` which is the current project configuration file"$'\n'"Also loads \`.env.local\` if it exists"$'\n'"Generally speaking - these are NAME=value files and should be parsable by"$'\n'"bash and other languages."$'\n'""$'\n'"Requires the file \`.env\` to exist and is loaded via bash \`source\` and all variables are \`export\`ed in the current shell context."$'\n'""$'\n'"If \`.env.local\` exists, it is also loaded in a similar manner."$'\n'""$'\n'"Use with caution on trusted content only."$'\n'"Return Code: 1 - if \`.env\` does not exist; outputs an error"$'\n'"Return Code: 0 - if files are loaded successfully"$'\n'""
file="bin/build/tools/environment.sh"
fn="dotEnvConfigure"
foundNames=([0]="argument" [1]="see" [2]="summary" [3]="deprecated")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="toDockerEnv"$'\n'"environmentFileLoad"$'\n'""
source="bin/build/tools/environment.sh"
sourceModified="1768756695"
summary="Load \`.env\` and optional \`.env.local\` into bash context"$'\n'""
usage="dotEnvConfigure [ where ] [ --help ]"
