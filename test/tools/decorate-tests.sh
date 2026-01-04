#!/usr/bin/env bash
#
# decorate-tests.sh
#
# Darwin tests
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

#  decoratePath
testDecoratePath() {
  export TMPDIR HOME BUILD_HOME

  assertEquals "🏠/cation" "$(decoratePath "${HOME%/}/cation")" || return $?
  assertEquals "🍎/cation" "$(decoratePath "${BUILD_HOME%/}/cation")" || return $?
  assertEquals "💣/tempFile" "$(decoratePath "$TMPDIR/tempFile")" || return $?

  assertEquals "🏠/cation" "$(HOME="Yo" decoratePath "Yo/cation")" || return $?
  assertEquals "🍎/etc" "$(HOME="/usr/home/dude" BUILD_HOME="/usr/home/dude/dev/build" decoratePath "/usr/home/dude/dev/build/etc")" || return $?
  assertEquals "🏠/dev/build/etc" "$(HOME="/usr/home/dude" BUILD_HOME="/usr/home/dude/dev/build" decoratePath --no-app "/usr/home/dude/dev/build/etc")" || return $?
  assertEquals "🍎/cation" "$(BUILD_HOME="/var" decoratePath "/var/cation")" || return $?
  assertEquals "💣/tempFile" "$(TMPDIR="/you-guessed-it" decoratePath "/you-guessed-it/tempFile")" || return $?
}

testDecorateStyle() {
  mockEnvironmentStart BUILD_COLORS
  mockEnvironmentStart __BUILD_COLORS
  assertExitCode 0 __decorateStylesDefault || return $?

  assertEquals "1" "$(decorateStyle bold)" || return $?
  assertExitCode 0 decorateStyle bold 31 || return $?
  assertEquals "31" "$(decorateStyle bold)" || return $?
  mockEnvironmentStop BUILD_COLORS
  mockEnvironmentStop __BUILD_COLORS
}

testDecorateStdin() {
  mockEnvironmentStart BUILD_COLORS
  mockEnvironmentStart __BUILD_COLORS
  assertExitCode 0 decorate green || return $?
  assertEquals "$(printf "%s\n" "Something notable and prescient" "Leader" | decorate quote)" "\"Something notable and prescient\""$'\n'"\"Leader\"" || return $?
  mockEnvironmentStop BUILD_COLORS
  mockEnvironmentStop __BUILD_COLORS
}

testDecorateBasics() {
  local color actual expected inVersion

  mockEnvironmentStart BUILD_COLORS
  mockEnvironmentStart __BUILD_COLORS

  local phrase="Bird, bird. bird is the word."

  for color in red yellow green blue; do
    actual="$(decorate "$color" --)Bird, bird. bird is the word.$(decorate reset --)"
    expected="$(decorate "$color" "$phrase")"
    inVersion="$(decorate "$color" <<<"$phrase")"
    if ! assertEquals "$expected" "$actual"; then
      dumpBinary "Expected" <<<"$expected"
      dumpBinary "Actual" <<<"$actual"
      return 1
    fi
    if ! assertEquals "$expected" "$inVersion"; then
      dumpBinary "(stdin) Expected" <<<"$expected"
      dumpBinary "(stdin) Actual" <<<"$actual"
      return 1
    fi
  done

  mockEnvironmentStop BUILD_COLORS
  mockEnvironmentStop __BUILD_COLORS
}

testDecorateArgs() {
  local reset

  mockEnvironmentStart BUILD_COLORS
  mockEnvironmentStart __BUILD_COLORS

  reset=$(printf -- '\e[0m')
  assertEquals "$(decorate reset --)" "$reset" || return $?

  mockEnvironmentStop BUILD_COLORS
  mockEnvironmentStop __BUILD_COLORS
}

__dataDecorateSize() {
  cat <<EOF
0 0b
1 1b
4096 4k (4096)
5123012 4M (5123012)
491239123 468M (491239123)
55012031023 51G (55012031023)
EOF
}

testDecorateSize() {
  local results=() IFS sizes=()

  local size result
  while read -r size result; do
    assertEquals "$result" "$(decorate size "$size")" || return $?
    sizes+=("$size")
    results+=("$result")
  done < <(__dataDecorateSize)

  # Test size via args
  assertEquals "$(printf "%s\n" "${results[@]}")" "$(decorate size "${sizes[@]}")" || return $?

  # Test size via stdin
  assertEquals "$(printf "%s\n" "${results[@]}")" "$(printf "%s\n" "${sizes[@]}" | decorate size)" || return $?

  # Test each size via args
  assertEquals "${results[*]}" "$(decorate each size "${sizes[@]}")" || return $?
}

testDecorateWrapNone() {
  assertOutputDoesNotContain $'\1' decorate wrap "HELLO " < <(printf "%s\n" "Hi" "THERE") || return $?
  assertOutputDoesNotContain $'\1' decorate wrap < <(printf "%s\n" "Hi" "THERE") || return $?
  assertOutputContains "HELLO THERE" decorate wrap "HELLO " < <(printf "%s\n" "Hi" "THERE") || return $?
  assertOutputContains "THERE" decorate wrap < <(printf "%s\n" "Hi" "THERE") || return $?
}
