#!/usr/bin/env bash
#
# Run during testSuite
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Hook: bash-test-pass

set -eou pipefail

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../build/tools.sh"; then

  #
  # fn: {base}
  # Summary: Run after a test passes
  # Usage: {fn} module testFunction
  __hookBashTestPass() {
    local handler="_${FUNCNAME[0]}"
    local module="$1" testFunction="$2" name symbol="✅"
    # IDENTICAL hookBashTestFinish 3
    name=$(catchReturn "$handler" buildEnvironmentGet APPLICATION_NAME) || return $?
    [ -z "$name" ] || name="🍎 ${name}\n"
    iTerm2Badge -i "${name}👀 ${module} \n${symbol}️ ${testFunction}"
  }
  ___hookBashTestPass() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }
  __hookBashTestPass "$@"
fi
