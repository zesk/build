#!/usr/bin/env bash
#
# Run during testSuite
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Hook: bash-test-start

set -eou pipefail

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../build/tools.sh"; then

  #
  # fn: {base}
  # Summary: Run when a test is started (before running)
  __hookBashTestStart() {
    local handler="_${FUNCNAME[0]}"
    local module="$1" testFunction="$2" name
    name=$(catchReturn "$handler" buildEnvironmentGet APPLICATION_NAME) || return $?
    [ -z "$name" ] || name="🍎 ${name}"
    iTerm2Badge -i "${name}\n👀 ${module} \n➡️ ${testFunction}"
    [ ! -t 0 ] || consoleSetTitle "$name Testing : $module ➡️ $testFunction"
  }
  ___hookBashTestStart() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }
  __hookBashTestStart "$@"
fi
