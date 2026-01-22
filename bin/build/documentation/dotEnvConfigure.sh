#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="where - Directory. Optional. Where to load the \`.env\` files."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
deprecated="2024-07-20"$'\n'""
description="Loads \`.env\` which is the current project configuration file"$'\n'"Also loads \`.env.local\` if it exists"$'\n'"Generally speaking - these are NAME=value files and should be parsable by"$'\n'"bash and other languages."$'\n'""$'\n'"Requires the file \`.env\` to exist and is loaded via bash \`source\` and all variables are \`export\`ed in the current shell context."$'\n'""$'\n'"If \`.env.local\` exists, it is also loaded in a similar manner."$'\n'""$'\n'"Use with caution on trusted content only."$'\n'"Return Code: 1 - if \`.env\` does not exist; outputs an error"$'\n'"Return Code: 0 - if files are loaded successfully"$'\n'""
file="bin/build/tools/environment.sh"
fn="dotEnvConfigure"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="toDockerEnv"$'\n'"environmentFileLoad"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceModified="1769061401"
summary="Load \`.env\` and optional \`.env.local\` into bash context"$'\n'""
usage="dotEnvConfigure [ where ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdotEnvConfigure[0m [94m[ where ][0m [94m[ --help ][0m

    [94mwhere   [1;97mDirectory. Optional. Where to load the [38;2;0;255;0;48;2;0;0;0m.env[0m files.[0m
    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Loads [38;2;0;255;0;48;2;0;0;0m.env[0m which is the current project configuration file
Also loads [38;2;0;255;0;48;2;0;0;0m.env.local[0m if it exists
Generally speaking - these are NAME=value files and should be parsable by
bash and other languages.

Requires the file [38;2;0;255;0;48;2;0;0;0m.env[0m to exist and is loaded via bash [38;2;0;255;0;48;2;0;0;0msource[0m and all variables are [38;2;0;255;0;48;2;0;0;0mexport[0med in the current shell context.

If [38;2;0;255;0;48;2;0;0;0m.env.local[0m exists, it is also loaded in a similar manner.

Use with caution on trusted content only.
Return Code: 1 - if [38;2;0;255;0;48;2;0;0;0m.env[0m does not exist; outputs an error
Return Code: 0 - if files are loaded successfully

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: dotEnvConfigure [ where ] [ --help ]

    where   Directory. Optional. Where to load the .env files.
    --help  Flag. Optional. Display this help.

Loads .env which is the current project configuration file
Also loads .env.local if it exists
Generally speaking - these are NAME=value files and should be parsable by
bash and other languages.

Requires the file .env to exist and is loaded via bash source and all variables are exported in the current shell context.

If .env.local exists, it is also loaded in a similar manner.

Use with caution on trusted content only.
Return Code: 1 - if .env does not exist; outputs an error
Return Code: 0 - if files are loaded successfully

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
