#!/usr/bin/env bash
#
# Run during testSuite
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Hook: test-pass

set -eou pipefail

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../build/tools.sh"; then

  #
  # fn: {base}
  # Summary: Run after a test passes
  __hookTestStop() {
    local handler="_${FUNCNAME[0]}"

    local suiteName="" testName="" stateFile="" failedMessage=""

    # _IDENTICAL_ argumentNonBlankLoopHandler 6
    local __saved=("$@") __count=$#
    while [ $# -gt 0 ]; do
      local argument="$1" __index=$((__count - $# + 1))
      # __IDENTICAL__ __checkBlankArgumentHandler 1
      [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
      case "$argument" in
      --failed) shift && failedMessage="$(validate "$handler" String "$argument" "${1-}")" || return $? ;;
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

    export TEST_SUCCESS

    local passed=true
    booleanParse "${TEST_SUCCESS-}" || passed=false

    local symbol="✅" && $passed || symbol="❌"

    local name && name=$(catchReturn "$handler" buildEnvironmentGet APPLICATION_NAME) || return $?
    [ -z "$name" ] || name="🍎 ${name}"

    local badge="${name}\n👀 ${suiteName} \n${symbol}️ ${testName}"
    [ -z "$failedMessage" ] || badge="$badge\n${failedMessage:0:20}"
    iTerm2Badge -i "$badge"

    # IDENTICAL hookRunOptionalNext 1
    catchReturn "$handler" hookRunOptional --next "${BASH_SOURCE[0]}" "$HOOK_NAME" "${__saved[@]+"${__saved[@]}"}" || return $?
  }
  ___hookTestStop() {
    # __IDENTICAL__ bashDocumentation 1
    bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }
  __hookTestStop "$@"
fi
