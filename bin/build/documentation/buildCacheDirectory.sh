#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="build.sh"
description="Path to cache directory for build system."$'\n'"Defaults to \`\$XDG_CACHE_HOME/.build\` unless \`\$XDG_CACHE_HOME\` is not a directory."$'\n'"Appends any passed in arguments as path segments."$'\n'"Example:     logFile=\$({fn} test.log)"$'\n'"Argument: pathSegment - One or more directory or file path, concatenated as path segments using \`/\`"$'\n'"Environment: XDG_CACHE_HOME"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""
file="bin/build/tools/build.sh"
foundNames=()
rawComment="Path to cache directory for build system."$'\n'"Defaults to \`\$XDG_CACHE_HOME/.build\` unless \`\$XDG_CACHE_HOME\` is not a directory."$'\n'"Appends any passed in arguments as path segments."$'\n'"Example:     logFile=\$({fn} test.log)"$'\n'"Argument: pathSegment - One or more directory or file path, concatenated as path segments using \`/\`"$'\n'"Environment: XDG_CACHE_HOME"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceHash="267ae3edaa9016ac7b2e56308eee0e1fd805c66e"
summary="Path to cache directory for build system."
usage="buildCacheDirectory"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildCacheDirectory'$'\e''[0m'$'\n'''$'\n''Path to cache directory for build system.'$'\n''Defaults to '$'\e''[[(code)]m$XDG_CACHE_HOME/.build'$'\e''[[(reset)]m unless '$'\e''[[(code)]m$XDG_CACHE_HOME'$'\e''[[(reset)]m is not a directory.'$'\n''Appends any passed in arguments as path segments.'$'\n''Example:     logFile=$(buildCacheDirectory test.log)'$'\n''Argument: pathSegment - One or more directory or file path, concatenated as path segments using '$'\e''[[(code)]m/'$'\e''[[(reset)]m'$'\n''Environment: XDG_CACHE_HOME'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: buildCacheDirectory'$'\n'''$'\n''Path to cache directory for build system.'$'\n''Defaults to $XDG_CACHE_HOME/.build unless $XDG_CACHE_HOME is not a directory.'$'\n''Appends any passed in arguments as path segments.'$'\n''Example:     logFile=$(buildCacheDirectory test.log)'$'\n''Argument: pathSegment - One or more directory or file path, concatenated as path segments using /'$'\n''Environment: XDG_CACHE_HOME'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.439
