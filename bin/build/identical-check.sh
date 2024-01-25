#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL bashHeader2 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

# fn: {base}
# Usage: {fn}
# See: identicalCheck
# Utility to check source code for identical sections which MUST match to succeed.
#
_identicalCheckScript() {
  return 0
}

_identicalCheckScript && identicalCheck "$@"
