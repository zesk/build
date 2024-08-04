#!/usr/bin/env bash
#
# darwin-tests.sh
#
# Darwin tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

declare -a tests
tests+=(testDarwinDialog)
testDarwinDialog() {
  if whichExists osascript; then
    # Only can test on Darwin, but not sure how to manage dialog interaction if at all
    assertExitCode --stdout-match osascript 0 darwinDialog --help || return $?
    assertNotExitCode 0 darwinDialog --choice A --choice B --default -1 || return $?
    assertNotExitCode 0 darwinDialog --choice A --choice B --default 2 || return $?
    assertNotExitCode 0 darwinDialog --choice "" --choice B || return $?
    assertNotExitCode 0 darwinDialog --choice "A" --choice "" || return $?
  else
    export OSTYPE
    consoleInfo "${FUNCNAME[0]} skipped not on Darwin ${OSTYPE-}"
  fi
}
