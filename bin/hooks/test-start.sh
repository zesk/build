#!/usr/bin/env bash
#
# Run during testSuite
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Hook: test-start

set -eou pipefail

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../build/tools.sh"; then

  # fn: {base}
  # Summary: Run when a test is started (before running)
  __hookTestStart() {
    local handler="_${FUNCNAME[0]}"

    local symbol="➡️"

    local module="$1" testFunction="$2"

    # IDENTICAL hookBashTestFinish 3
    local name && name=$(catchReturn "$handler" buildEnvironmentGet APPLICATION_NAME) || return $?
    [ -z "$name" ] || name="🍎 ${name}"
    iTerm2Badge -i "${name}\n👀 ${module} \n${symbol}️ ${testFunction}"

    [ ! -t 0 ] || consoleSetTitle "$name Testing : ${module} ${symbol}️ $testFunction"

    local home && home=$(catchReturn "$handler" buildHome) || return $?

    catchReturn "$handler" hookRunOptional --application "$home" --next "${BASH_SOURCE[0]}" "$HOOK_NAME" "$@" || return $?
  }
  ___hookTestStart() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }
  __hookTestStart "$@"
fi
