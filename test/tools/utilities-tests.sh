#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: assert.sh usage.sh
#
declare -a tests
tests+=(testIncrementor)

testIncrementor() {
  local i nl
  assertExitCode 0 incrementor 0 || return $?
  assertExitCode 0 incrementor DUDE 0 || return $?

  i=$(incrementor 1) && assertEquals --line "$LINENO" "$i" 1 || return $?
  i=$(incrementor) && assertEquals --line "$LINENO" "$i" 2 || return $?
  i=$(incrementor) && assertEquals --line "$LINENO" "$i" 3 || return $?
  i=$(incrementor) && assertEquals --line "$LINENO" "$i" 4 || return $?
  i=$(incrementor) && assertEquals --line "$LINENO" "$i" 5 || return $?
  i=$(incrementor DUDE) && assertEquals --line "$LINENO" "$i" 1 || return $?
  i=$(incrementor) && assertEquals --line "$LINENO" "$i" 6 || return $?
  i=$(incrementor DUDE) && assertEquals --line "$LINENO" "$i" 2 || return $?
  i=$(incrementor 99 DUDE) && assertEquals --line "$LINENO" "$i" 99 || return $?
  i=$(incrementor DUDE) && assertEquals --line "$LINENO" "$i" 100 || return $?
  i=$(incrementor -2) && assertEquals --line "$LINENO" "$i" -2 || return $?
  i=$(incrementor) && assertEquals --line "$LINENO" "$i" -1 || return $?
  i=$(incrementor) && assertEquals --line "$LINENO" "$i" 0 || return $?
  i=$(incrementor) && assertEquals --line "$LINENO" "$i" 1 || return $?

  nl=$'\n'
  assertEquals --line "$LINENO" "$(incrementor 1 a b)" "1${nl}1" || return $?
  assertEquals --line "$LINENO" "$(incrementor a b 1 c)" "2${nl}2${nl}1" || return $?
  assertEquals --line "$LINENO" "$(incrementor a b 1 c)" "3${nl}3${nl}1" || return $?
  assertEquals --line "$LINENO" "$(incrementor a b 1 c)" "4${nl}4${nl}1" || return $?
  assertEquals --line "$LINENO" "$(incrementor a 1 c)" "5${nl}1" || return $?
  assertEquals --line "$LINENO" "$(incrementor a b 1 c)" "6${nl}5${nl}1" || return $?
}
