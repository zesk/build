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

    local suiteName="" testName="" stateFile=""

    # _IDENTICAL_ argumentNonBlankLoopHandler 6
    local __saved=("$@") __count=$#
    while [ $# -gt 0 ]; do
      local argument="$1" __index=$((__count - $# + 1))
      # __IDENTICAL__ __checkBlankArgumentHandler 1
      [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
      case "$argument" in
      *)
        if [ -z "$suiteName" ]; then
          suiteName=$(validate "$handler" String "suiteName" "$argument") || return $?
        elif [ -z "$testName" ]; then
          testName=$(validate "$handler" String "testName" "$argument") || return $?
        elif [ -z "$stateFile" ]; then
          stateFile=$(validate "$handler" File "stateFile" "$argument") || return $?
        fi
        ;;
      esac
      shift
    done

    local symbol="➡️"

    local name && name=$(catchReturn "$handler" buildEnvironmentGet APPLICATION_NAME) || return $?
    [ -z "$name" ] || name="🍎 ${name}"
    iTerm2Badge -i "${name}\n👀 ${suiteName} \n${symbol}️ ${testName}"

    [ ! -t 0 ] || consoleSetTitle "$name Testing : ${suiteName} ${symbol}️ $testName"

    # IDENTICAL hookRunOptionalNext 1
    catchReturn "$handler" hookRunOptional --next "${BASH_SOURCE[0]}" "$HOOK_NAME" "${__saved[@]+"${__saved[@]}"}" || return $?
  }
  ___hookTestStart() {
    # __IDENTICAL__ bashDocumentation 1
    bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }
  __hookTestStart "$@"
fi
