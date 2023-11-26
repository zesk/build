#!/usr/bin/env bash
#
# Fetch the version tag for the application
#
# Depends: git
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# fn: {base}
#
# Get the "tag" (or current display version) for an application
#
# The default hook uses the short git checksum
#
hookApplicationTag() {
    git describe --tags --abbrev=0
}

hookApplicationTag
