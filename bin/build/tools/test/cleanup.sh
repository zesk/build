#!/usr/bin/env bash
# IDENTICAL zeskBuildBashHeader 5
#
# cleanup.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

#
#
__testCleanup() {
  local handler="returnMessage"
  local home
  home=$(catchReturn "$handler" buildHome) || return $?
  shopt -u failglob
  export __TEST_CLEANUP_DIRS

  catchEnvironment "$handler" rm -rf "$home/test."*/ "$home/.test"*/ "${__TEST_CLEANUP_DIRS[@]+"${__TEST_CLEANUP_DIRS[@]}"}" || return $?
}

__testCleanupMess() {
  local exitCode=$? messyOption="${1-}"

  export __TEST_SUITE_CLEAN_EXIT

  __TEST_SUITE_CLEAN_EXIT="${__TEST_SUITE_CLEAN_EXIT-}"
  if [ "$__TEST_SUITE_CLEAN_EXIT" != "true" ]; then
    printf -- "%s\n%s\n" "Stack:" "$(debuggingStack)"
    local blank
    blank=$(decorate value "(blank)")
    printf "\n%s\n" "$(basename "${BASH_SOURCE[0]}") FAILED $exitCode: TRACE ${__TEST_SUITE_TRACE:-$blank}"
  fi
  if [ "$messyOption" = "true" ]; then
    printf "%s\n" "Messy ... no cleanup"
    return 0
  fi
  __testCleanup
}

_testExit() {
  local returnCode="${1-0}"
  export __TEST_SUITE_CLEAN_EXIT
  __TEST_SUITE_CLEAN_EXIT=true
  trap - EXIT QUIT TERM ERR
  return "$returnCode"
}
