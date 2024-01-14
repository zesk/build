#!/usr/bin/env bash
#
# release-notes.sh
#
# Current release notes file path
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# See: releaseNotes
#
set -eou pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. "./bin/build/tools.sh"

releaseNotes "$@"
