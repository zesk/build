#!/usr/bin/env bash
#
# Run during bin/build/new-release.sh when a new version is created
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

# IDENTICAL bashHeader 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

# IDENTICAL errorEnvironment 1
errorEnvironment=1

BUILD_VERSION_CREATED_EDITOR=${BUILD_VERSION_CREATED_EDITOR:-${EDITOR-}}

currentVersion=$1
shift
releaseNotes=$1
shift

consoleSuccess "Current version created $currentVersion, release notes are $releaseNotes"
if [ -n "$BUILD_VERSION_CREATED_EDITOR" ]; then
    editorParts=()
    IFS=' ' read -ra tokens <<<"$BUILD_VERSION_CREATED_EDITOR"
    for token in "${tokens[@]}"; do
        editorParts+=("$token")
    done
    if which "${editorParts[0]}" >/dev/null; then
        "${editorParts[@]}" "$releaseNotes"
    else
        consoleWarning "BUILD_VERSION_CREATED_EDITOR not found ${editorParts[*]}"
        exit "$errorEnvironment"
    fi
fi
