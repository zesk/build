#!/usr/bin/env bash
#
# colors-tests.sh
#
# Colors tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testColorSampleCodes() {
  assertExitCode 0 colorSampleCodes || return $?
  assertNotExitCode --stderr-match "Only argument allowed is" --stderr-match "--help" 0 colorSampleCodes --no-arguments-really-allowed || return $?
}
testColorSampleStyles() {
  assertExitCode 0 colorSampleStyles || return $?
  assertNotExitCode --stderr-match "Only argument allowed is" --stderr-match "--help" 0 colorSampleStyles --no-arguments-really-allowed || return $?
}
testSemanticColorSampleStyles() {
  local mode
  export BUILD_COLORS_MODE
  for mode in light dark; do
    BUILD_COLORS_MODE=$mode colorSampleSemanticStyles
  done
  unset BUILD_COLORS_MODE
}

testSimpleMarkdownToConsole() {
  local actual expected testString
  local this=${FUNCNAME[0]}

  export BUILD_COLORS

  mockEnvironmentStart BUILD_COLORS

  BUILD_COLORS=true

  # shellcheck disable=SC2016
  testString='`Code` text is *italic* and **bold**'

  expected="$(printf "%s text is %s and %s" "$(decorate code Code)" "$(decorate cyan italic)" "$(decorate red bold)")"

  actual="$(printf "%s" "$testString" | simpleMarkdownToConsole)"

  if ! assertEquals "$expected" "$actual" "$this:$LINENO"; then
    printf "%s\n" "$expected" | dumpBinary "Expected"
    printf "%s\n" "$actual" | dumpBinary "Actual"
    return 1
  fi

  BUILD_COLORS=false
  actual="$(printf "%s" "$testString" | simpleMarkdownToConsole)"

  mockEnvironmentStop BUILD_COLORS

  expected="Code text is italic and bold"
  assertEquals "$actual" "$expected" || return $?
}

testColorSampleCombinations() {
  echo "NOT BOLD"
  colorSampleCombinations " ZESK "
  echo "BOLD"
  colorSampleCombinations --bold " ZESK "
}

__dataColorFormatDefault() {
  cat <<'EOF'
000000 0 0 0
010203 1 2 3
45472A 69 71 42
FFFFFF 255 255 255
EOF
}

__dataColorFormat() {
  cat <<'EOF'
0;0;0 %d;%d;%d 0 0 0
1;2;3 %d;%d;%d 1 2 3
255;255;255 %d;%d;%d 255 255 255
ffffff %0.2x%0.2x%0.2x 255 255 255
45472a %0.2x%0.2x%0.2x 69 71 42
EOF
}

testColorFormat() {
  local expected format r g b

  # Empty format argument
  while read -r expected r g b; do
    assertEquals "$expected" "$(colorFormat "" "$r" "$g" "$b")" || return $?
  done < <(__dataColorFormatDefault)
  # Empty format argument
  while read -r expected r g b; do
    assertEquals "$expected" "$(printf "%d\n" "$r" "$g" "$b" | colorFormat "")" || return $?
  done < <(__dataColorFormatDefault)
  # No arguments - read stdin
  while read -r expected r g b; do
    assertEquals "$expected" "$(printf "%d\n" "$r" "$g" "$b" | colorFormat)" || return $?
  done < <(__dataColorFormatDefault)

  while read -r expected format r g b; do
    assertEquals "$expected" "$(colorFormat "$format" "$r" "$g" "$b")" || return $?
  done < <(__dataColorFormat)
  while read -r expected format r g b; do
    assertEquals "$expected" "$(printf "%d\n" "$r" "$g" "$b" | colorFormat "$format")" || return $?
  done < <(__dataColorFormat)
}

testColorScheme() {
  local handler="returnMessage"

  mockEnvironmentStart __BUILD_COLORS
  mockEnvironmentStart __BUILD_TERM_COLORS
  mockEnvironmentStart __BASH_PROMPT_PREVIOUS

  local home
  home=$(catchReturn "$handler" buildHome) || return $?

  assertExitCode --skip-plumber 0 colorScheme <"$home/etc/term-colors.conf" || return $?

  mockEnvironmentStop __BUILD_COLORS
  mockEnvironmentStop __BUILD_TERM_COLORS
  mockEnvironmentStop __BASH_PROMPT_PREVIOUS

}
