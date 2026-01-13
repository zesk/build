#!/usr/bin/env bash
#
# Run during testSuite
#
# Hook: bash-test-fail
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

set -eou pipefail

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../build/tools.sh"; then
  # fn: {base}
  # Summary: Run after a test fails
  __hookBashTestFail() {
    local handler="_${FUNCNAME[0]}"
    local module="$1" testFunction="$2" name symbol="❌"
    # IDENTICAL hookBashTestFinish 3
    name=$(catchReturn "$handler" buildEnvironmentGet APPLICATION_NAME) || return $?
    [ -z "$name" ] || name="🍎 ${name}\n"
    iTerm2Badge -i "${name}👀 ${module} \n${symbol}️ ${testFunction}"
  }
  ___hookBashTestFail() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }

  __hookBashTestFail "$@"
fi
