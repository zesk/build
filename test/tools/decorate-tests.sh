#!/usr/bin/env bash
#
# decorate-tests.sh
#
# Darwin tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testDecorateStdin() {
  assertExitCode 0 decorate green || return $?
  assertEquals "$(printf "%s\n" "Something notable and prescient" "Leader" | decorate quote)" "\"Something notable and prescient\""$'\n'"\"Leader\"" || return $?
}

testDecorateBasics() {
  local color actual expected inVersion

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
}

testDecorateArgs() {
  local reset

  reset=$(printf -- '\e[0m')
  assertEquals "$(decorate reset --)" "$reset" || return $?
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
  local results=() IFS

  while read -r size result; do
    assertEquals "$result" "$(decorate size "$size")" || return $?
    results+=("$result")
  done < <(__dataDecorateSize)

  IFS=" "
  assertEquals "${results[*]}" "$(__dataDecorateSize | awk '{ print $1 }' | decorate size)" || return $?
}
