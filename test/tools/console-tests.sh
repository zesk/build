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
    assertEquals --line "$LINENO" "$expected" "$(printf "%d\n" "$r $g $b" | colorBrightness)" "echo $r $g $b \| colorBrightness failed to be $expected" || return $?
    assertEquals --line "$LINENO" "$expected" "$(colorBrightness "$r" "$g" "$b")" "colorBrightness $r $g $b failed to be $expected" || return $?
  done
  _colorBrightnessBadValues | while read -r expected r g b; do
    assertNotExitCode --line "$LINENO" --stderr-ok 0 colorBrightness "$r" "$g" "$b" || return $?
  done
}

testConsoleFileLink() {
  __mockValue BITBUCKET_WORKSPACE BACKUP_BITBUCKET_WORKSPACE "${BITBUCKET_WORKSPACE-}"
  __mockValue CI BACKUP_CI "${CI-}"

  bigText consoleFileLink
  __environment consoleFileLink "${BASH_SOURCE[0]}" || return $?
  assertExitCode 0 consoleLink https://example.com/ Hello || return $?
  assertExitCode 0 consoleFileLink "${BASH_SOURCE[0]}" || return $?

  __mockValue BITBUCKET_WORKSPACE BACKUP_BITBUCKET_WORKSPACE --end
  __mockValue CI BACKUP_CI --end
}

testStatusMessageLast() {
  local phrase

  phrase="Hello, world."

  statusMessage decorate warning "Mocking console animation (true)"
  __mockConsoleAnimation true

  assertEquals --line "$LINENO" 0 "$(($(statusMessage --first printf -- "%s" "$phrase" | wc -l) + 0))" || return $?
  assertEquals --line "$LINENO" 0 "$(($(statusMessage printf -- "%s" "$phrase" | wc -l) + 0))" || return $?
  assertEquals --line "$LINENO" 1 "$(($(statusMessage --last printf -- "%s" "$phrase" | wc -l) + 0))" || return $?

  statusMessage decorate warning "Ending mocked console animation"
  __mockConsoleAnimation --end

  statusMessage decorate warning "Mocking console animation (false)"
  __mockConsoleAnimation false

  assertEquals --line "$LINENO" 0 "$(($(statusMessage --first printf -- "%s" "$phrase" | wc -l) + 0))" || return $?
  assertEquals --line "$LINENO" 1 "$(($(statusMessage printf -- "%s" "$phrase" | wc -l) + 0))" || return $?
  assertEquals --line "$LINENO" 1 "$(($(statusMessage --last printf -- "%s" "$phrase" | wc -l) + 0))" || return $?

  __mockConsoleAnimation --end
  statusMessage decorate warning "Ending mocked console animation"
}
