#!/usr/bin/env bash
#
# prompt-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
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
  local matches leak leaks=(PS1 BUILD_PROMPT_COLORS PROMPT_COMMAND __BASH_PROMPT_MODULES __BASH_PROMPT_PREVIOUS) ll=()

  assertExitCode 0 bashPrompt --help || return $?

  [ ! -t 0 ] || decorate info "console $(decorate bold --)IS a terminal$(decorate info --) so --skip-terminal test will be skipped"
  [ -t 0 ] || assertNotExitCode --stderr-match "Requires a terminal" "${ll[@]}" "${matches[@]}" 0 bashPrompt --colors "::::" || return $?

  for leak in "${leaks[@]}"; do
    ll+=(--leak "$leak")
  done

  bashPrompt --skip-terminal --colors "::::"
  assertExitCode "${ll[@]}" 0 bashPrompt --skip-terminal --colors "::::" || return $?
  matches=(--stdout-match __testBashPromptA --stdout-match __testBashPromptB --stdout-match __testBashPromptC)
  bashPrompt --skip-terminal --first __testBashPromptA __testBashPromptB __testBashPromptC __testBashPromptA __testBashPromptB __testBashPromptC --list
  assertExitCode "${ll[@]}" "${matches[@]}" 0 bashPrompt --skip-terminal --first __testBashPromptA __testBashPromptB __testBashPromptC __testBashPromptA __testBashPromptB __testBashPromptC --list || return $?

  # Remove A
  matches=(--stdout-no-match __testBashPromptA --stdout-match __testBashPromptB --stdout-match __testBashPromptC)
  assertExitCode "${ll[@]}" "${matches[@]}" 0 bashPrompt --skip-terminal --remove __testBashPromptA --list || return $?

  # Remove C
  matches=(--stdout-no-match __testBashPromptA --stdout-match __testBashPromptB --stdout-no-match __testBashPromptC)
  assertExitCode "${ll[@]}" "${matches[@]}" 0 bashPrompt --skip-terminal --remove __testBashPromptC --list || return $?

  # Remove J (?)
  matches=()
  matches+=(--stderr-match "__testBashPromptJ was not found in modules")
  assertNotExitCode "${ll[@]}" "${matches[@]}" 0 bashPrompt --skip-terminal --remove __testBashPromptJ --list || return $?

  # bashPrompt --skip-terminal --remove __testBashPromptB --list || return $?
  # Remove B
  matches=(--stdout-no-match __testBashPromptA --stdout-no-match __testBashPromptB --stdout-no-match __testBashPromptC)
  assertExitCode "${ll[@]}" "${matches[@]}" 0 bashPrompt --skip-terminal --remove __testBashPromptB --list || return $?

  matches=(--stdout-no-match __testBashPromptA --stdout-no-match __testBashPromptB --stdout-no-match __testBashPromptC)
  matches+=(--stderr-match "__testBashPromptJ was not found in modules")
  # Remove J (?)
  assertNotExitCode "${ll[@]}" "${matches[@]}" 0 bashPrompt --skip-terminal --remove __testBashPromptJ --list || return $?

  matches=(--stdout-no-match __testBashPromptA --stdout-no-match __testBashPromptB --stdout-no-match __testBashPromptC)
  matches+=(--stderr-match "__testBashPromptK was not found in modules")
  # Remove K (?)
  assertNotExitCode "${ll[@]}" "${matches[@]}" 0 bashPrompt --skip-terminal --remove __testBashPromptK --list || return $?

  unset "${leaks[@]}"
}
