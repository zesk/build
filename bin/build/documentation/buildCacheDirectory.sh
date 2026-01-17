#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/build.sh"
argument="pathSegment - One or more directory or file path, concatenated as path segments using \`/\`"$'\n'"--help -  Flag. Optional.Display this help."$'\n'""
base="build.sh"
description="Path to cache directory for build system."$'\n'""$'\n'"Defaults to \`\$XDG_CACHE_HOME/.build\` unless \`\$XDG_CACHE_HOME\` is not a directory."$'\n'""$'\n'"Appends any passed in arguments as path segments."$'\n'""$'\n'""
environment="XDG_CACHE_HOME"$'\n'""
example="    logFile=\$(buildCacheDirectory test.log)"$'\n'""
file="bin/build/tools/build.sh"
fn="buildCacheDirectory"
foundNames=([0]="example" [1]="argument" [2]="environment")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/build.sh"
sourceModified="1768683999"
summary="Path to cache directory for build system."
usage="buildCacheDirectory [ pathSegment ] [ --help ]"
