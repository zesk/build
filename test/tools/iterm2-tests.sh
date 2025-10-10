#!/usr/bin/env bash
#
# iterm2-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Test-Plumber: false
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

test_iTerm2Attention() {
  local ii=()
  if ! isiTerm2; then
    ii+=(--ignore)
    assertNotExitCode --stderr-match "Not iTerm2" 0 iTerm2Attention "true" || return $?
  fi
  assertExitCode 0 iTerm2Attention "${ii[@]+"${ii[@]}"}" true || return $?
  assertExitCode 0 iTerm2Attention "${ii[@]+"${ii[@]}"}" false || return $?
  assertExitCode 0 iTerm2Attention "${ii[@]+"${ii[@]}"}" start || return $?
  assertExitCode 0 iTerm2Attention "${ii[@]+"${ii[@]}"}" stop || return $?
  assertExitCode 0 iTerm2Attention "${ii[@]+"${ii[@]}"}" fireworks || return $?
  assertExitCode 0 iTerm2Attention "${ii[@]+"${ii[@]}"}" ! || return $?
}

test_iTerm2Image() {
  local handler="returnMessage"
  local ii=()
  local home imageFile="$home/etc/zesk-build-icon.png"
  home=$(catchReturn "$handler" buildHome) || return $?
  if ! isiTerm2; then
    ii+=(--ignore)
    assertNotExitCode --stderr-match "Not iTerm2" 0 iTerm2Image "$imageFile" || return $?
  fi
  assertExitCode 0 iTerm2Image "${ii[@]+"${ii[@]}"}" "$imageFile" || return $?
}

test_iTerm2Version() {
  if isiTerm2; then
    iTerm2Version || return $?
  fi
}

__data_iTerm2IsColorName() {
  cat <<EOF
0 black
0 red
0 green
0 yellow
0 blue
0 magenta
0 cyan
0 white
1 orange
1 fuschia
EOF
}

test_iTerm2IsColorName() {
  local exitCode colorName
  while read -r exitCode colorName; do
    assertExitCode "$exitCode" iTerm2IsColorName "$colorName" || return $?
  done < <(__data_iTerm2IsColorName)
}

__data_iTerm2IsColorType() {
  cat <<EOF
0 fg
0 bg
0 selbg
0 selfg
0 curbg
0 curfg
0 br_black
0 br_red
0 br_green
0 br_yellow
0 br_blue
0 br_magenta
0 br_cyan
0 br_white
0 red
0 green
0 yellow
0 blue
0 magenta
0 cyan
0 bold
0 link
0 underline
0 tab
0 white
1 orange
1 br_orange
1 fuschia
1 random
1 port
EOF
}

test_iTerm2IsColorType() {
  local exitCode colorType
  while read -r exitCode colorType; do
    assertExitCode "$exitCode" iTerm2IsColorType "$colorType" || return $?
  done < <(__data_iTerm2IsColorType)
}

test_iTerm2Notify() {
  local handler="returnMessage"
  local ii=()
  local home
  home=$(catchReturn "$handler" buildHome) || return $?
  if ! isiTerm2; then
    ii+=(--ignore)
    assertNotExitCode --stderr-match "Not iTerm2" 0 iTerm2Notify "Hello, world" || return $?
  fi
  assertExitCode 0 iTerm2Notify "${ii[@]+"${ii[@]}"}" "Hello, world" || return $?
}

test_iTerm2SetColors() {
  local handler="returnMessage"
  local ii=()
  local home
  home=$(catchReturn "$handler" buildHome) || return $?
  if ! isiTerm2; then
    ii+=(--ignore)
    assertNotExitCode --stderr-match "Not iTerm2" 0 iTerm2SetColors "fg=FFF" "bg=000" || return $?
  fi
  assertExitCode 0 iTerm2SetColors "${ii[@]+"${ii[@]}"}" "fg=FFF" "bg=000" || return $?
  assertExitCode 0 iTerm2SetColors "${ii[@]+"${ii[@]}"}" "fg=000" "bg=FFF" || return $?
  iTerm2SetColors "${ii[@]+"${ii[@]}"}" "fg=FFF" "bg=000"
  iTerm2SetColors "${ii[@]+"${ii[@]}"}" "fg=000" "bg=FFF"
  iTerm2SetColors "${ii[@]+"${ii[@]}"}" "fg=FFF" "bg=000"
  iTerm2SetColors "${ii[@]+"${ii[@]}"}" "fg=000" "bg=FFF"
}

#  iTerm2Download
#  iTerm2PromptSupport
#  iTerm2SetColors
#
