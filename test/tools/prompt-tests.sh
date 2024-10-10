#!/usr/bin/env bash
#
# prompt-tests.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

__testBashPromptA() {
  incrementor "${FUNCNAME[0]}"
}
__testBashPromptB() {
  incrementor "${FUNCNAME[0]}"
}
__testBashPromptC() {
  incrementor "${FUNCNAME[0]}"
}

testBashPrompt() {
  local matches leak leaks=(PS1 BUILD_PROMPT_COLORS PROMPT_COMMAND __BASH_PROMPT_MODULES) ll=()

  assertExitCode --line "$LINENO" 0 bashPrompt --help || return $?

  [ ! -t 0 ] || consoleInfo "console $(consoleBold)IS a terminal$(consoleInfo) so --skip-terminal test will be skipped"
  [ -t 0 ] || assertNotExitCode --stderr-match "Requires a terminal" --line "$LINENO" "${ll[@]}" "${matches[@]}" 0 bashPrompt --colors "::::" || return $?

  for leak in "${leaks[@]}"; do
    ll+=(--leak "$leak")
  done
  assertExitCode --line "$LINENO" "${ll[@]}" 0 bashPrompt --skip-terminal --colors "::::" || return $?
  matches=(--stdout-match __testBashPromptA --stdout-match __testBashPromptB --stdout-match __testBashPromptC)
  assertExitCode --line "$LINENO" "${ll[@]}" "${matches[@]}" 0 bashPrompt --skip-terminal --first __testBashPromptA __testBashPromptB __testBashPromptC __testBashPromptA __testBashPromptB __testBashPromptC --list || return $?

  # Remove A
  matches=(--stdout-no-match __testBashPromptA --stdout-match __testBashPromptB --stdout-match __testBashPromptC)
  assertExitCode --line "$LINENO" "${ll[@]}" "${matches[@]}" 0 bashPrompt --skip-terminal -__testBashPromptA --list || return $?

  # Remove C
  matches=(--stdout-no-match __testBashPromptA --stdout-match __testBashPromptB --stdout-no-match __testBashPromptC)
  assertExitCode --line "$LINENO" "${ll[@]}" "${matches[@]}" 0 bashPrompt --skip-terminal -__testBashPromptC --list || return $?

  # Remove J (?)
  matches=()
  matches+=(--stderr-match "__testBashPromptJ was not found in modules")
  assertNotExitCode --dump --line "$LINENO" "${ll[@]}" "${matches[@]}" 0 bashPrompt --skip-terminal -__testBashPromptJ --list || return $?

  # DEBUG LINE
  printf -- "%s:%s\n" "$(consoleCode "${BASH_SOURCE[0]}")" "$(consoleMagenta "$LINENO")" # DEBUG LINE

  # Remove B
  matches=(--stdout-no-match __testBashPromptA --stdout-no-match __testBashPromptB --stdout-no-match __testBashPromptC)
  assertExitCode --dump --line "$LINENO" "${ll[@]}" "${matches[@]}" 0 bashPrompt --skip-terminal -__testBashPromptB --list || return $?

  # DEBUG LINE
  printf -- "%s:%s\n" "$(consoleCode "${BASH_SOURCE[0]}")" "$(consoleMagenta "$LINENO")" # DEBUG LINE

  matches=(--stdout-no-match __testBashPromptA --stdout-no-match __testBashPromptB --stdout-no-match __testBashPromptC)
  matches+=(--stderr-match "__testBashPromptJ was not found in modules")
  # Remove J (?)
  assertNotExitCode --line "$LINENO" "${ll[@]}" "${matches[@]}" 0 bashPrompt --skip-terminal -__testBashPromptJ --list || return $?

  # DEBUG LINE
  printf -- "%s:%s\n" "$(consoleCode "${BASH_SOURCE[0]}")" "$(consoleMagenta "$LINENO")" # DEBUG LINE

  matches=(--stdout-no-match __testBashPromptA --stdout-no-match __testBashPromptB --stdout-no-match __testBashPromptC)
  matches+=(--stderr-match "__testBashPromptK was not found in modules")
  # Remove K (?)
  assertNotExitCode --line "$LINENO" "${ll[@]}" "${matches[@]}" 0 bashPrompt --skip-terminal -__testBashPromptK --list || return $?

  # DEBUG LINE
  printf -- "%s:%s\n" "$(consoleCode "${BASH_SOURCE[0]}")" "$(consoleMagenta "$LINENO")" # DEBUG LINE

  unset "${leaks[@]}"
}
