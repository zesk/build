#!/usr/bin/env bash
# IDENTICAL zeskBuildBashHeader 5
#
# console.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

#
# Output debugging for terminal issues and colors/CI
#
__testDebugTermDisplay() {
  printf -- "TERM: %s DISPLAY: %s consoleHasColors: %s\n" "${TERM-none}" "${DISPLAY-none}" "$(
    consoleHasColors
    printf %d $?
  )"
}

#
# Output a heading for a test section
#
# Argument: String. Required. Test heading.
#
__testSection() {
  [ -n "$*" ] || returnArgument "Blank argument $(debuggingStack)"
  consoleLineFill
  consoleHeadingBoxed --size 0 "$@"
}

#
# Output a heading for a test
#
__testHeading() {
  local bar

  bar=$(decorate code "$(consoleLine '*')")

  consoleLineFill
  printf -- "%s\n" "$bar"
  decorate big "$@" | decorate wrap --fill " " "    " | decorate code
  printf -- "%s\n" "$bar"
}

# Our test failed
# BUILD_DEBUG: test-dump-environment - When set tests will dump the environment at the end.
__testFailed() {
  local handler="$1" && shift
  local returnCode="$1" && shift
  local stateFile="$1" && shift
  local suiteName="$1" && shift
  local item="$1" && shift

  (
    catchReturn "$handler" source "$stateFile" || return $?
    ! buildDebugEnabled "test-dump-environment" || dumpEnvironment || :
    catchReturn "$handler" dumpLoadAverages || :

    printf "\n%s: %s %s (Suite: %s) on %s\n" "$(decorate error "Test failed")" "$(decorate code "[ $returnCode ]")" "$(decorate info "$item")" "$(decorate magenta "$suiteName")" "$(decorate value "$(date +"%F %T")")" || :
  ) || return $?
  returnAssert
}
