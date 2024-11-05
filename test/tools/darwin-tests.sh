#!/usr/bin/env bash
#
# darwin-tests.sh
#
# Darwin tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

testDarwinDialog() {
  if whichExists osascript; then
    # Only can test on Darwin, but not sure how to manage dialog interaction if at all
    assertExitCode --line "$LINENO" --stdout-match osascript 0 darwinDialog --help || return $?
    assertNotExitCode --stderr-match 'not unsigned' --line "$LINENO" 0 darwinDialog --choice A --choice B --default -1 || return $?
    assertNotExitCode --stderr-match 'out of range' --line "$LINENO" 0 darwinDialog --choice A --choice B --default 2 || return $?
    assertNotExitCode --stderr-match 'blank' --line "$LINENO" 0 darwinDialog --choice "" --choice B || return $?
    assertNotExitCode --stderr-match 'blank' --line "$LINENO" 0 darwinDialog --choice "A" --choice "" || return $?
  else
    (
      export OSTYPE
      decorate info "${FUNCNAME[0]} skipped, we are not on Darwin -> ${OSTYPE-}"
    ) || :
  fi
}
