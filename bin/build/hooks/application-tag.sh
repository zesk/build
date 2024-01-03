#!/usr/bin/env bash
#
# Fetch the version tag for the application
#
# Depends: git
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL bashHeader 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

# fn: {base}
#
# Get the "tag" (or current display version) for an application
#
# The default hook uses most recent tag associated in git or `v0.0.1` if no tags exist.
#
hookApplicationTag() {
  gitEnsureSafeDirectory "$(pwd)"
  if ! git describe --tags --abbrev=0 2>/dev/null; then
    printf %s "v0.0.1"
  fi
}

hookApplicationTag
