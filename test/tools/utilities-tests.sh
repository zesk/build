#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: assert.sh usage.sh
#
declare -a tests
tests+=(incrementorTests)

incrementorTests() {
  local i

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
}
