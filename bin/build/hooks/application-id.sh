#!/usr/bin/env bash
#
# Fetch an ID which represents the current application build/code state which is unique
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

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# fn: {base}
# Usage: {fn}
#
# Generate a unique ID for the state of the application files
#
# The default hook uses the short git sha:
#
#     git rev-parse --short HEAD
#
# Example:     885acc3
#
hookApplicationChecksum() {
  local here
  if ! here="$(pwd -P 2>/dev/null)"; then
    return 1
  fi
  if ! gitEnsureSafeDirectory "$here"; then
    _hookApplicationChecksum "$errorEnvironment" "Unable to gitEnsureSafeDirectory $here"
    return 1
  fi
  git rev-parse --short HEAD
}
_hookApplicationChecksum() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
hookApplicationChecksum
