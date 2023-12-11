#!/usr/bin/env bash
#
# Fetch a checksum which represents the current application build/code state which is unique
#
# Depends: git
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

# fn: {base}
#
# Generate a unique checksum for the state of the application files
#
# The default hook uses the short git checksum
#
hookApplicationChecksum() {
  gitEnsureSafeDirectory "$(pwd)"
  git rev-parse --short HEAD
}

hookApplicationChecksum
