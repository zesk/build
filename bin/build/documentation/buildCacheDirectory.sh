#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/build.sh"
argument="pathSegment - One or more directory or file path, concatenated as path segments using \`/\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="build.sh"
description="Path to cache directory for build system."$'\n'"Defaults to \`\$XDG_CACHE_HOME/.build\` unless \`\$XDG_CACHE_HOME\` is not a directory."$'\n'"Appends any passed in arguments as path segments."$'\n'""
environment="XDG_CACHE_HOME"$'\n'""
example="    logFile=\$(buildCacheDirectory test.log)"$'\n'""
exitCode="0"
file="bin/build/tools/build.sh"
foundNames=([0]="example" [1]="argument" [2]="environment")
logFile=""
rawComment="Path to cache directory for build system."$'\n'"Defaults to \`\$XDG_CACHE_HOME/.build\` unless \`\$XDG_CACHE_HOME\` is not a directory."$'\n'"Appends any passed in arguments as path segments."$'\n'"Example:     logFile=\$({fn} test.log)"$'\n'"Argument: pathSegment - One or more directory or file path, concatenated as path segments using \`/\`"$'\n'"Environment: XDG_CACHE_HOME"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceModified="1769208503"
summary="Path to cache directory for build system."
usage="buildCacheDirectory [ pathSegment ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mbuildCacheDirectory'$'\e''[0m '$'\e''[[blue]m[ pathSegment ]'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]mpathSegment  '$'\e''[[value]mOne or more directory or file path, concatenated as path segments using '$'\e''[[code]m/'$'\e''[[reset]m'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--help       '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n'''$'\n''Path to cache directory for build system.'$'\n''Defaults to '$'\e''[[code]m$XDG_CACHE_HOME/.build'$'\e''[[reset]m unless '$'\e''[[code]m$XDG_CACHE_HOME'$'\e''[[reset]m is not a directory.'$'\n''Appends any passed in arguments as path segments.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- XDG_CACHE_HOME'$'\n'''$'\n''Example:'$'\n''    logFile=$(buildCacheDirectory test.log)'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: buildCacheDirectory [ pathSegment ] [ --help ]'$'\n'''$'\n''    pathSegment  One or more directory or file path, concatenated as path segments using /'$'\n''    --help       Flag. Optional. Display this help.'$'\n'''$'\n''Path to cache directory for build system.'$'\n''Defaults to $XDG_CACHE_HOME/.build unless $XDG_CACHE_HOME is not a directory.'$'\n''Appends any passed in arguments as path segments.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- XDG_CACHE_HOME'$'\n'''$'\n''Example:'$'\n''    logFile=$(buildCacheDirectory test.log)'$'\n'''
