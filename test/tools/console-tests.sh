#!/usr/bin/env bash
#
# console-tests.sh
#
# Console tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
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
    assertEquals "$expected" "$(echo "$r $g $b" | colorBrightness)" "echo $r $g $b \| colorBrightness failed to be $expected" || return $?
    assertEquals "$expected" "$(colorBrightness "$r" "$g" "$b")" "colorBrightness $r $g $b failed to be $expected" || return $?
  done
  _colorBrightnessBadValues | while read -r expected r g b; do
    assertNotExitCode --stderr-ok 0 colorBrightness "$r" "$g" "$b" || return $?
  done
}

testConsoleFileLink() {
  bigText consoleFileLink
  __environment consoleFileLink "${BASH_SOURCE[0]}" || return $?
  assertExitCode 0 consoleLink https://example.com/ Hello || return $?
  assertExitCode 0 consoleFileLink "${BASH_SOURCE[0]}" || return $?
}
