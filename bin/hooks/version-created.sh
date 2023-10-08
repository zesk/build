#!/usr/bin/env bash
#
# Run during bin/build/new-release.sh when a new version is created
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

BUILD_VERSION_CREATED_EDITOR=${BUILD_VERSION_CREATED_EDITOR:-${EDITOR-}}
# shellcheck source=/dev/null
. ./bin/build/tools.sh

currentVersion=$1
shift
releaseNotes=$1
shift

consoleSuccess "Current version created $currentVersion, release notes are $releaseNotes"
if [ -n "$BUILD_VERSION_CREATED_EDITOR" ]; then
    if which "$BUILD_VERSION_CREATED_EDITOR" >/dev/null; then
        "$BUILD_VERSION_CREATED_EDITOR" "$releaseNotes"
    fi
fi
