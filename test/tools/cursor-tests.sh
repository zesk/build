#!/usr/bin/env bash
#
# cursor-tests.sh
#
# Cursor tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testCursorGetSet() {
  if isTTYAvailable; then
    local x y
    IFS=$'\n' read -r -d '' x y < <(cursorGet) || :
    assertExitCode --line "$LINENO" 0 isUnsignedInteger "$x" || return $?
    assertExitCode --line "$LINENO" 0 isUnsignedInteger "$y" || return $?
    assertExitCode --line "$LINENO" 0 cursorSet 0 0 || return $?
    assertNotExitCode --line "$LINENO" 0 cursorSet 0 0 || return $?
    assertExitCode --line "$LINENO" cursorSet 1 1 || return $?
    assertExitCode --line "$LINENO" cursorSet "$(consoleColumns)" "$(consoleRows)" || return $?
    assertExitCode --line "$LINENO" cursorSet "$x" "$y" || return $?
  fi
}
