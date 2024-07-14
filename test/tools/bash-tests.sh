#!/usr/bin/env bash
#
# ssh-tests.sh
#
# SSH tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
declare -a tests

tests+=(testBashBasics)
testBashBasics() {
  # Bizarro logic precedence

  # first section
  assertEquals --line "$LINENO" hitTheOr "$(false && true || printf hitTheOr)" || return $?
  assertEquals --line "$LINENO" hitTheOr "$(true && false || printf hitTheOr)" || return $?
  assertEquals --line "$LINENO" hitTheOr "$(false && false || printf hitTheOr)" || return $?
  assertEquals --line "$LINENO" "" "$(true && true || printf hitTheOr)" || return $?

  # Added && to end of first section
  assertEquals --line "$LINENO" hitTheOrhitTheAnd "$(false && true || printf hitTheOr && printf hitTheAnd)" || return $?
  assertEquals --line "$LINENO" hitTheOrhitTheAnd "$(true && false || printf hitTheOr && printf hitTheAnd)" || return $?
  assertEquals --line "$LINENO" hitTheOrhitTheAnd "$(false && false || printf hitTheOr && printf hitTheAnd)" || return $?
  assertEquals --line "$LINENO" "hitTheAnd" "$(true && true || printf hitTheOr && printf hitTheAnd)" || return $?

  # Added || to end of first section
  assertEquals --line "$LINENO" hitTheOr "$(false && true || printf hitTheOr || printf hitTheAnd)" || return $?
  assertEquals --line "$LINENO" hitTheOr "$(true && false || printf hitTheOr || printf hitTheAnd)" || return $?
  assertEquals --line "$LINENO" hitTheOr "$(false && false || printf hitTheOr || printf hitTheAnd)" || return $?
  assertEquals --line "$LINENO" "" "$(true && true || printf hitTheOr || printf hitTheAnd)" || return $?
}
