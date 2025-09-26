#!/usr/bin/env bash
#
# cursor-tests.sh
#
# Cursor tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testCursorGetSet() {
  mockEnvironmentStart __BUILD_HAS_TTY
  if isTTYAvailable; then
    local x y

    exec 2>&1
    cursorGet
    IFS=$'\n' read -t 3 -r -d $'\0' x y < <(cursorGet) || :
    assertExitCode --display "$x is not unsigned integer" 0 isUnsignedInteger "$x" || return $?
    assertExitCode --display "$y is not unsigned integer" 0 isUnsignedInteger "$y" || return $?
    assertExitCode 0 cursorSet 0 0 || return $?
    #    assertNotExitCode 0 cursorSet 0 0 || return $?
    assertExitCode 0 cursorSet 1 1 || return $?
    assertExitCode 0 cursorSet "$(consoleColumns)" "$(consoleRows)" || return $?
    assertExitCode 0 cursorSet "$x" "$y" || return $?
  fi
  mockEnvironmentStop __BUILD_HAS_TTY
}
