#!/bin/bash
#
# Local local container to test build
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

set -eou pipefail

# IDENTICAL errorArgument 1
errorArgument=2

cd "$(dirname "${BASH_SOURCE[0]}")/.."
me=$(basename "$0")
cacheDirectory="./.build-docs"

#shellcheck source=/dev/null
. ./bin/build/tools.sh

export usageDelimiter=,
usageOptions() {
    cat <<EOF
--force,Force generation, ignore cache directives
--cache,Use a cache at \"$cacheDirectory\"
EOF
}
usageDescription() {
    cat <<EOF
Build documentation for build system.
EOF
}
#
# Argument: --force - Force generation, ignore cache directives
# Argument: --cache - Use a cache at "./.build-docs/"
#
usage() {
    usageMain "$me" "$@"
    exit $?
}

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
    exit $?
fi
for binaryDirectory in ops bin install pipeline; do
    if ! documentFunctionTemplateDirectory "${documentDirectoryArgs[@]+${documentDirectoryArgs[@]}}" \
        ./bin/build/ ./docs/templates/$binaryDirectory/ ./docs/__binary.sh.md ./docs/$binaryDirectory/ "${cacheDirectoryArgs[@]+${cacheDirectoryArgs[@]}}"; then
        exit $?
    fi
done
if ! documentFunctionTemplateDirectory "${documentDirectoryArgs[@]+${documentDirectoryArgs[@]}}" \
    ./bin/build/ ./docs/templates/tools/ ./docs/__function.sh.md ./docs/tools/ "${cacheDirectoryArgs[@]+${cacheDirectoryArgs[@]}}"; then
    exit $?
fi
