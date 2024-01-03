#!/usr/bin/env bash
#
# release-notes.sh
#
# Current release notes file path
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail
errorEnvironment=1

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. "./bin/build/tools.sh"

# Summary: Show current release notes
# Output the current release notes.
#
# If this fails it outputs an error to stderr
#
# When this tool succeeds it outputs the current release notes file relative to the project root.
# Usage: release-notes.sh
# Usage: releaseNotes
# Output: ./docs/release/v1.0.0.md
# fn: release-notes.sh
# Hook: version-current
# Exit code: 1 - if an error occurs
# Example:     open $(bin/build/release-notes.sh)
# Example:     vim $(releaseNotes)
releaseNotes() {
    version=$(runHook version-current)
    if [ -z "$version" ]; then
        consoleError "No version-current" 1>&2
        return $errorEnvironment
    fi
    releasePath="./docs/release"
    if [ ! -d "$releasePath" ]; then
        consoleError "Not a directory $releasePath" 1>&2
        return $errorEnvironment
    fi
    path="./docs/release/$version.md"
    if [ ! -f "$path" ]; then
        consoleError "No release notes found at $path" 1>&2
        return $errorEnvironment
    fi
    printf %s "$path"

}

releaseNotes
