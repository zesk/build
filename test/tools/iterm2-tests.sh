#!/usr/bin/env bash
#
# iterm2-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testIterm2() {
  mockEnvironmentStart __BASH_PROMPT_MARKERS
  mockEnvironmentStart __BASH_PROMPT_MODULES
  mockEnvironmentStart __BASH_PROMPT_PREVIOUS
  mockEnvironmentStart LC_TERMINAL
  mockEnvironmentStart BUILD_HOOK_DIRS
  mockEnvironmentStart TERM

  export LC_TERMINAL
  export TERM

  unset BUILD_HOOK_DIRS
  buildEnvironmentLoad BUILD_HOOK_DIRS

  LC_TERMINAL=wrong
  assertExitCode --stderr-match "Not iTerm2" 1 iTerm2Init || return $?
  assertNotExitCode 0 isiTerm2 || return $?
  assertNotExitCode --stderr-match "Not iTerm2" 0 iTerm2Badge "foo" || return $?
  assertExitCode 0 iTerm2Badge -i "foo" || return $?
  assertExitCode 0 iTerm2Badge --ignore "foo" || return $?
  assertExitCode 0 iTerm2Badge --help || return $?

  LC_TERMINAL=iTerm2
  TERM=xterm

  assertExitCode 0 isiTerm2 || return $?
  assertExitCode --stdout-match "Zm9v" 0 iTerm2Badge "foo" </dev/null || return $?
  if [ -t 0 ]; then
    # TODO How to test this in pipeline with no terminal. Fake one?
    assertExitCode 0 iTerm2Init || return $?
  else
    assertExitCode 0 iTerm2Init --ignore || return $?
  fi
  mockEnvironmentStop LC_TERMINAL
  mockEnvironmentStop BUILD_HOOK_DIRS
  mockEnvironmentStop TERM
  mockEnvironmentStop __BASH_PROMPT_MARKERS
  mockEnvironmentStop __BASH_PROMPT_MODULES
  mockEnvironmentStop __BASH_PROMPT_PREVIOUS
}
