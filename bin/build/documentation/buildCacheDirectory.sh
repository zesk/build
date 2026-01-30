#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
argument="pathSegment - One or more directory or file path, concatenated as path segments using \`/\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="build.sh"
description="Path to cache directory for build system."$'\n'"Defaults to \`\$XDG_CACHE_HOME/.build\` unless \`\$XDG_CACHE_HOME\` is not a directory."$'\n'"Appends any passed in arguments as path segments."$'\n'""
environment="XDG_CACHE_HOME"$'\n'""
example="    logFile=\$(buildCacheDirectory test.log)"$'\n'""
file="bin/build/tools/build.sh"
foundNames=([0]="example" [1]="argument" [2]="environment")
logFile=""
rawComment="Path to cache directory for build system."$'\n'"Defaults to \`\$XDG_CACHE_HOME/.build\` unless \`\$XDG_CACHE_HOME\` is not a directory."$'\n'"Appends any passed in arguments as path segments."$'\n'"Example:     logFile=\$({fn} test.log)"$'\n'"Argument: pathSegment - One or more directory or file path, concatenated as path segments using \`/\`"$'\n'"Environment: XDG_CACHE_HOME"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceHash="89694a048c4f040422139ae53c7ea8087844fdf2"
summary="Path to cache directory for build system."
usage="buildCacheDirectory [ pathSegment ] [ --help ]"
