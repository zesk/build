#!/bin/bash
#
# Local local container to test build
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

# IDENTICAL errorArgument 1
errorArgument=2

set -eou pipefail

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

# Default option settings
documentDirectoryArgs=()
cacheDirectoryArgs=()
while [ $# -gt 0 ]; do
    case $1 in
    --cache)
        if ! inArray "$1" "${cacheDirectoryArgs[@]+${cacheDirectoryArgs[@]}}"; then
            cacheDirectoryArgs+=("$1")
        fi
        ;;
    --force)
        if ! inArray "$1" "${documentDirectoryArgs[@]+${documentDirectoryArgs[@]}}"; then
            documentDirectoryArgs+=("$1")
        fi
        ;;
    esac
    shift
done

documentDirectory "${documentDirectoryArgs[@]+${documentDirectoryArgs[@]}}" ./docs/templates/install/ ./docs/tools/install/ ./docs/__binary.sh.md "${cacheDirectoryArgs[@]+${cacheDirectoryArgs[@]}}"
documentDirectory "${documentDirectoryArgs[@]+${documentDirectoryArgs[@]}}" ./docs/templates/tools/ ./docs/tools/ ./docs/__function.sh.md "${cacheDirectoryArgs[@]+${cacheDirectoryArgs[@]}}"
