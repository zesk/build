#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
#

testIncrementor() {
  local i nl
  assertExitCode 0 incrementor 0 || return $?
  assertExitCode 0 incrementor 0 DUDE || return $?

  i=$(incrementor 1) && assertEquals "$i" 1 || return $?
  i=$(incrementor) && assertEquals "$i" 2 || return $?
  i=$(incrementor) && assertEquals "$i" 3 || return $?
  i=$(incrementor) && assertEquals "$i" 4 || return $?
  i=$(incrementor) && assertEquals "$i" 5 || return $?
  i=$(incrementor DUDE) && assertEquals "$i" 1 || return $?
  i=$(incrementor) && assertEquals "$i" 6 || return $?
  i=$(incrementor DUDE) && assertEquals "$i" 2 || return $?
  i=$(incrementor 99 DUDE) && assertEquals "$i" 99 || return $?
  i=$(incrementor DUDE) && assertEquals "$i" 100 || return $?
  i=$(incrementor -2) && assertEquals "$i" -2 || return $?
  i=$(incrementor) && assertEquals "$i" -1 || return $?
  i=$(incrementor) && assertEquals "$i" 0 || return $?
  i=$(incrementor) && assertEquals "$i" 1 || return $?

  nl=$'\n'
  assertEquals "$(incrementor 1 a b)" "1${nl}1" || return $?
  assertEquals "$(incrementor a b 1 c)" "2${nl}2${nl}1" || return $?
  assertEquals "$(incrementor a b 1 c)" "3${nl}3${nl}1" || return $?
  assertEquals "$(incrementor a b 1 c)" "4${nl}4${nl}1" || return $?
  assertEquals "$(incrementor a 1 c)" "5${nl}1" || return $?
  assertEquals "$(incrementor a b 1 c)" "6${nl}5${nl}1" || return $?
}
