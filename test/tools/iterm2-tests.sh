#!/usr/bin/env bash
#
# iterm2-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testIterm2() {
  __mockValue LC_TERMINAL

  export LC_TERMINAL

  LC_TERMINAL=wrong
  assertExitCode --stderr-match "Not iTerm2" --line "$LINENO" 1 iTerm2Init || return $?
  assertNotExitCode --line "$LINENO" 0 isiTerm2 || return $?
  assertNotExitCode --line "$LINENO" --stderr-match "does not support" 0 iTerm2Badge "foo" || return $?
  assertExitCode --line "$LINENO" 0 iTerm2Badge -i "foo" || return $?
  assertExitCode --line "$LINENO" 0 iTerm2Badge --ignore "foo" || return $?
  assertExitCode --line "$LINENO" 0 iTerm2Badge --help || return $?

  LC_TERMINAL=iTerm2
  assertExitCode --line "$LINENO" 0 isiTerm2 || return $?
  assertExitCode --dump-binary --line "$LINENO" --stdout-match "Zm9v" 0 iTerm2Badge "foo" </dev/null || return $?
  assertExitCode --line "$LINENO" 0 iTerm2Init || return $?

  __mockValue LC_TERMINAL "" --end
}
