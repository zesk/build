#!/usr/bin/env bash
#
# iterm2-tests.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

testIterm2() {
  local saved_LC_TERMINAL saved_HOME

  saved_HOME=$HOME
  saved_LC_TERMINAL=${LC_TERMINAL+none}

  export LC_TERMINAL HOME ITERM2_SHELL_INTEGRATION_WORKS

  ITERM2_SHELL_INTEGRATION_WORKS=false

  HOME=$(__environment mktemp -d) || return $?
  printf "export ITERM2_SHELL_INTEGRATION_WORKS=true\n" >"$HOME/.iterm2_shell_integration.bash"
  __environment chmod +x "$HOME/.iterm2_shell_integration.bash" || return $?

  LC_TERMINAL=wrong
  assertExitCode --line "$LINENO" 0 iTerm2Init || return $?
  assertEquals --line "$LINENO" "$ITERM2_SHELL_INTEGRATION_WORKS" "false" || return $?
  assertNotExitCode --line "$LINENO" 0 isiTerm2 || return $?
  assertNotExitCode --line "$LINENO" --stderr-match "does not support" 0 iTerm2Badge "foo" || return $?

  LC_TERMINAL=iTerm2
  assertExitCode --line "$LINENO" 0 isiTerm2 || return $?
  assertExitCode --dump-binary --line "$LINENO" --stdout-match "Zm9v" 0 iTerm2Badge "foo" </dev/null || return $?
  assertExitCode --line "$LINENO" 0 iTerm2Init || return $?
  assertEquals --line "$LINENO" "$ITERM2_SHELL_INTEGRATION_WORKS" "true" || return $?

  if [ "$saved_LC_TERMINAL" = "none" ]; then
    unset LC_TERMINAL
  else
    LC_TERMINAL=$saved_LC_TERMINAL
  fi
  HOME=$saved_HOME
  unset ITERM2_SHELL_INTEGRATION_WORKS
}
