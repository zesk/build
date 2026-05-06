#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="pathSegment - One or more directory or file path, concatenated as path segments using \`/\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Path to cache directory for build system."$'\n'""$'\n'"Defaults to \`\$XDG_CACHE_HOME/.build\` unless \`\$XDG_CACHE_HOME\` is not a directory."$'\n'""$'\n'"Appends any passed in arguments as path segments."$'\n'""$'\n'""
descriptionLineCount="6"
environment="XDG_CACHE_HOME"$'\n'""
example="    logFile=\$(buildCacheDirectory test.log)"$'\n'""
file="bin/build/tools/build.sh"
fn="buildCacheDirectory"
fnMarker="buildcachedirectory"
foundNames=([0]="example" [1]="argument" [2]="environment")
line="135"
logFile=""
rawComment="Path to cache directory for build system."$'\n'"Defaults to \`\$XDG_CACHE_HOME/.build\` unless \`\$XDG_CACHE_HOME\` is not a directory."$'\n'"Appends any passed in arguments as path segments."$'\n'"Example:     logFile=\$({fn} test.log)"$'\n'"Argument: pathSegment - One or more directory or file path, concatenated as path segments using \`/\`"$'\n'"Environment: XDG_CACHE_HOME"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceHash="8814c5b6b68b94aa734c4c337d9463150c6d754d"
sourceLine="135"
summary="Path to cache directory for build system."
summaryComputed="true"
usage="buildCacheDirectory [ pathSegment ] [ --help ]"
