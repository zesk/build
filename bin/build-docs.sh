#!/bin/bash
set -eou pipefail

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# fn: {base}
# Build documentation for build system.
#
# Given that bash is a terrible template language, caching is sort of mandatory if you
# want builds which do not take eons.
#
# Uses a cache at `buildCacheDirectory build-docs`
#
# You can disable this with `--no-cache`.
#
# Argument: --force - Force generation, ignore cache directives
# Argument: --no-cache - Do not use cache or store cache.
# Argument: --help - I need somebody
# TODO: Stop complaining about bash
#
# Copyright: Copyright &copy; 2023 Market Acumen, Inc.
#
buildBuildDocumentation() {
    local cacheDirectory

    cacheDirectory="$(buildCacheDirectory build-docs)"
    # Default option settings
    documentDirectoryArgs=()
    cacheDirectoryArgs=("$cacheDirectory")
    while [ $# -gt 0 ]; do
        case $1 in
        --no-cache)
            cacheDirectoryArgs=()
            ;;
        --force)
            if ! inArray "$1" "${documentDirectoryArgs[@]+${documentDirectoryArgs[@]}}"; then
                documentDirectoryArgs+=("$1")
            fi
            ;;
        --help)
            usage 0
            ;;
        *)
            usage "$errorArgument" "Unknown argument $1"
            ;;
        esac
        shift
    done

    if [ "${#cacheDirectoryArgs[@]}" -gt 0 ] && ! requireDirectory "$cacheDirectory"; then
        return $errorEnvironment
    fi
    if ! documentFunctionTemplateDirectory "${documentDirectoryArgs[@]+${documentDirectoryArgs[@]}}" \
        ./bin/ ./docs/templates/hooks/ ./docs/__hook.sh.md ./docs/hooks/ "${cacheDirectoryArgs[@]+${cacheDirectoryArgs[@]}}"; then
        return "$errorEnvironment"
    fi
    for binaryDirectory in ops bin install pipeline; do
        if ! documentFunctionTemplateDirectory "${documentDirectoryArgs[@]+${documentDirectoryArgs[@]}}" \
            ./bin/build/ ./docs/templates/$binaryDirectory/ ./docs/__binary.sh.md ./docs/$binaryDirectory/ "${cacheDirectoryArgs[@]+${cacheDirectoryArgs[@]}}"; then
            return $errorEnvironment
        fi
    done
    if ! documentFunctionTemplateDirectory "${documentDirectoryArgs[@]+${documentDirectoryArgs[@]}}" \
        ./bin/build/ ./docs/templates/tools/ ./docs/__function.sh.md ./docs/tools/ "${cacheDirectoryArgs[@]+${cacheDirectoryArgs[@]}}"; then
        return $errorEnvironment
    fi
    reportTiming "$start" "Completed in"
}

#
# 2023-11-22 This file layout is easier to follow and puts the documentation at top, try and do this more
#

#
# Output usage and exit
#
usage() {
    usageDocument "./bin/$me" "buildBuildDocumentation" "$@"
    exit $?
}

# IDENTICAL errorArgument 1
errorArgument=2

cd "$(dirname "${BASH_SOURCE[0]}")/.."
me=$(basename "$0")

# shellcheck source=/dev/null
. ./bin/build/tools.sh

start=$(beginTiming)

buildBuildDocumentation "$@"
