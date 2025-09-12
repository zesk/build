#!/usr/bin/env bash
#
# console-tests.sh
#
# Console tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
set -eou pipefail

_colorBrightnessValues() {
  cat <<EOF
  0 0 0 0
  100 255 255 255
  17 44 44 44
  11 0 0 255
  29 255 0 0
  58 0 255 0
  88 255 255 0
  41 255 0 255
  70 0 255 255
EOF
}

_colorBrightnessBadValues() {
  cat <<EOF
  0 0 x
  255 y 255
  z 44 44
  "" "" ""
EOF
}

testColorBrightness() {
  local expected r g b
  _colorBrightnessValues | while read -r expected r g b; do
    assertEquals "$expected" "$(printf "%d\n" "$r" "$g" "$b" | colorBrightness)" "echo $r $g $b \| colorBrightness failed to be $expected" || return $?
    assertEquals "$expected" "$(colorBrightness "$r" "$g" "$b")" "colorBrightness $r $g $b failed to be $expected" || return $?
  done
  _colorBrightnessBadValues | while read -r expected r g b; do
    assertNotExitCode --stderr-ok 0 colorBrightness "$r" "$g" "$b" || return $?
  done
}

testConsoleFileLink() {
  mockEnvironmentStart BITBUCKET_WORKSPACE
  mockEnvironmentStart CI
  mockEnvironmentStart BUILD_COLORS

  export BUILD_COLORS=true
  export CI=

  bigText consoleFileLink
  assertExitCode 0 consoleFileLink "${BASH_SOURCE[0]}" || return $?
  assertExitCode --stderr-match "non-plain" 2 consoleFileLink "$(decorate black "paint it")" || return $?
  assertExitCode 0 consoleLink https://example.com/ Hello || return $?
  assertExitCode 0 consoleFileLink "${BASH_SOURCE[0]}" || return $?

  mockEnvironmentStop BITBUCKET_WORKSPACE
  mockEnvironmentStop CI
  mockEnvironmentStop BUILD_COLORS
}

testStatusMessageLast() {
  local phrase

  phrase="Hello, world."

  statusMessage decorate warning "Mocking console animation (true)"
  mockConsoleAnimationStart true

  assertEquals 0 "$(statusMessage --first printf -- "%s" "$phrase" | fileLineCount)" || return $?
  assertEquals 0 "$(statusMessage printf -- "%s" "$phrase" | fileLineCount)" || return $?
  assertEquals 1 "$(statusMessage --last printf -- "%s" "$phrase" | fileLineCount)" || return $?

  statusMessage decorate warning "Ending mocked console animation"
  mockConsoleAnimationStop

  statusMessage decorate warning "Mocking console animation (false)"
  mockConsoleAnimationStart false

  assertEquals 0 "$(statusMessage --first printf -- "%s" "$phrase" | fileLineCount)" || return $?
  assertEquals 1 "$(statusMessage printf -- "%s" "$phrase" | fileLineCount)" || return $?
  assertEquals 1 "$(statusMessage --last printf -- "%s" "$phrase" | fileLineCount)" || return $?

  mockConsoleAnimationStop
  statusMessage decorate warning "Ending mocked console animation"
}
