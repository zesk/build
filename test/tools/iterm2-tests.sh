#!/usr/bin/env bash
#
# iterm2-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testIterm2() {
  __mockValue LC_TERMINAL
  __mockValue TERM

  export LC_TERMINAL
  export TERM

  LC_TERMINAL=wrong
  assertExitCode --stderr-match "Not iTerm2" --line "$LINENO" 1 iTerm2Init || return $?
  assertNotExitCode --line "$LINENO" 0 isiTerm2 || return $?
  assertNotExitCode --line "$LINENO" --stderr-match "Not iTerm2" 0 iTerm2Badge "foo" || return $?
  assertExitCode --line "$LINENO" 0 iTerm2Badge -i "foo" || return $?
  assertExitCode --line "$LINENO" 0 iTerm2Badge --ignore "foo" || return $?
  assertExitCode --line "$LINENO" 0 iTerm2Badge --help || return $?

  LC_TERMINAL=iTerm2
  TERM=xterm

  assertExitCode --line "$LINENO" 0 isiTerm2 || return $?
  assertExitCode --dump-binary --line "$LINENO" --stdout-match "Zm9v" 0 iTerm2Badge "foo" </dev/null || return $?
  if [ -t 0 ]; then
    # TODO How to test this in pipeline with no terminal. Fake one?
    assertExitCode --line "$LINENO" 0 iTerm2Init || return $?
  else
    assertExitCode --line "$LINENO" 0 iTerm2Init --ignore || return $?
  fi
  __mockValue LC_TERMINAL "" --end
  __mockValue TERM "" --end
}
