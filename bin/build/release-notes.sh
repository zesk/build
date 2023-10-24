#!/usr/bin/env bash
#
# release-notes.sh
#
# Current release notes file path
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail
errorEnvironment=1

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. "./bin/build/tools.sh"

version=$(runHook version-current)
if [ -z "$version" ]; then
    consoleError "No version-current" 1>&2
    exit $errorEnvironment
fi
releasePath="./docs/release"
if [ ! -d "$releasePath" ]; then
    consoleError "Not a directory $releasePath" 1>&2
    exit $errorEnvironment
fi
path="./docs/release/$version.md"
if [ ! -f "$path" ]; then
    consoleError "No release notes found at $path" 1>&2
    exit $errorEnvironment
fi
echo -n "$path"
