#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/documentation.sh"
argument="--documentation documentationPath - Directory. Optional. Path to documentation root. Default is \`./documentation/source\`."$'\n'"--source sourcePath - Directory. Optional. Path to source environment files. Defaults to \`\$(buildHome)/bin/env\` if not specified."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="documentation.sh"
description="Build documentation for ./bin/env (or bin/build/env) directory."$'\n'""$'\n'"Creates a cache at \`documentationBuildCache\`"$'\n'""$'\n'""$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Issue with environment"$'\n'"Return Code: 2 - Argument error"$'\n'""
file="bin/build/tools/documentation.sh"
fn="documentationBuildEnvironment"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="documentationBuild"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceModified="1769065497"
summary="Build documentation for ./bin/env (or bin/build/env) directory."
usage="documentationBuildEnvironment [ --documentation documentationPath ] [ --source sourcePath ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdocumentationBuildEnvironment[0m [94m[ --documentation documentationPath ][0m [94m[ --source sourcePath ][0m [94m[ --help ][0m

    [94m--documentation documentationPath  [1;97mDirectory. Optional. Path to documentation root. Default is [38;2;0;255;0;48;2;0;0;0m./documentation/source[0m.[0m
    [94m--source sourcePath                [1;97mDirectory. Optional. Path to source environment files. Defaults to [38;2;0;255;0;48;2;0;0;0m$(buildHome)/bin/env[0m if not specified.[0m
    [94m--help                             [1;97mFlag. Optional. Display this help.[0m

Build documentation for ./bin/env (or bin/build/env) directory.

Creates a cache at [38;2;0;255;0;48;2;0;0;0mdocumentationBuildCache[0m


Return Code: 0 - Success
Return Code: 1 - Issue with environment
Return Code: 2 - Argument error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: documentationBuildEnvironment [ --documentation documentationPath ] [ --source sourcePath ] [ --help ]

    --documentation documentationPath  Directory. Optional. Path to documentation root. Default is ./documentation/source.
    --source sourcePath                Directory. Optional. Path to source environment files. Defaults to $(buildHome)/bin/env if not specified.
    --help                             Flag. Optional. Display this help.

Build documentation for ./bin/env (or bin/build/env) directory.

Creates a cache at documentationBuildCache


Return Code: 0 - Success
Return Code: 1 - Issue with environment
Return Code: 2 - Argument error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
