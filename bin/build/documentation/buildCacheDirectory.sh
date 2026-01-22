#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/build.sh"
argument="pathSegment - One or more directory or file path, concatenated as path segments using \`/\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="build.sh"
description="Path to cache directory for build system."$'\n'""$'\n'"Defaults to \`\$XDG_CACHE_HOME/.build\` unless \`\$XDG_CACHE_HOME\` is not a directory."$'\n'""$'\n'"Appends any passed in arguments as path segments."$'\n'""$'\n'""
environment="XDG_CACHE_HOME"$'\n'""
example="    logFile=\$(buildCacheDirectory test.log)"$'\n'""
file="bin/build/tools/build.sh"
fn="buildCacheDirectory"
foundNames=""
logFile=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceModified="1768843054"
summary="Path to cache directory for build system."
usage="buildCacheDirectory [ pathSegment ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbuildCacheDirectory[0m [94m[ pathSegment ][0m [94m[ --help ][0m

    [94mpathSegment  [1;97mOne or more directory or file path, concatenated as path segments using [38;2;0;255;0;48;2;0;0;0m/[0m[0m
    [94m--help       [1;97mFlag. Optional. Display this help.[0m

Path to cache directory for build system.

Defaults to [38;2;0;255;0;48;2;0;0;0m$XDG_CACHE_HOME/.build[0m unless [38;2;0;255;0;48;2;0;0;0m$XDG_CACHE_HOME[0m is not a directory.

Appends any passed in arguments as path segments.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- XDG_CACHE_HOME
- 

Example:
    logFile=$(buildCacheDirectory test.log)
'
# shellcheck disable=SC2016
helpPlain='Usage: buildCacheDirectory [ pathSegment ] [ --help ]

    pathSegment  One or more directory or file path, concatenated as path segments using /
    --help       Flag. Optional. Display this help.

Path to cache directory for build system.

Defaults to $XDG_CACHE_HOME/.build unless $XDG_CACHE_HOME is not a directory.

Appends any passed in arguments as path segments.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- XDG_CACHE_HOME
- 

Example:
    logFile=$(buildCacheDirectory test.log)
'
