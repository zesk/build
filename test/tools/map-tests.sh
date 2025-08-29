#!/usr/bin/env bash
#
# map-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__testIsMappableData() {
  cat <<'EOF'
0 {alphabet}
0 {a}
0 {name-and-value}
0 {name_and_value}
0 {name_and_value:123}
0 {name_and_value:123}
1 []
1 [abc]
1 [abc][abc]
1 {}
1 alphabet
1 {alphabet
1 alphabet}
EOF
}

__testIsMappableDataBracket() {
  cat <<'EOF'
1 {alphabet}
1 {a}
1 {name-and-value}
1 {name_and_value}
1 {name_and_value:123}
1 {name_and_value:123}
1 []
0 [abc]
0 [abc][abc]
1 {}
1 alphabet
1 {alphabet
1 alphabet}
EOF
}

testIsMappable() {
  local exitCode token
  while read -r exitCode token; do
    assertExitCode "$exitCode" isMappable "$token" || return $?
  done < <(__testIsMappableData)
  while read -r exitCode token; do
    assertExitCode "$exitCode" isMappable --prefix '[' --suffix ']' "$token" || return $?
  done < <(__testIsMappableDataBracket)
}

testMapTokens() {
  local handler="_return" home

  local COLUMNS LINES
  home=$(__catch "$handler" buildHome) || return $?

  echo | assertExitCode 0 mapTokens || return $?
  assertEquals "" "$(echo | mapTokens)" || return $?
  assertEquals "$(printf "%s\n" a b c)" "$(echo '{a}{b}{c}' | mapTokens)" || return $?
  assertEquals "$(printf "%s\n" confirmYesNo fileCopyWouldChange fileCopy 'args[@]' 'args[@]')" "$(mapTokens <"$home/test/example/mapTokensBad.md")" || return $?
}

testMapPrefixSuffix() {
  local itemIndex=1 binary

  for binary in mapEnvironment "$(buildHome)/bin/build/map.sh"; do
    assertEquals "Hello, world." "$(echo "[NAME], [PLACE]." | NAME=Hello PLACE=world "$binary" --prefix '[' --suffix ']')" "#$itemIndex failed" || return $?
    itemIndex=$((itemIndex + 1))
    assertEquals "Hello, world." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world "$binary")" "#$itemIndex failed" || return $?
    itemIndex=$((itemIndex + 1))
    assertEquals "Hello, world." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world "$binary" NAME PLACE)" "#$itemIndex failed" || return $?
    itemIndex=$((itemIndex + 1))
    assertEquals "Hello, {PLACE}." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world "$binary" NAME)" "#$itemIndex failed" || return $?
    itemIndex=$((itemIndex + 1))
    assertEquals "{NAME}, world." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world "$binary" PLACE)" "#$itemIndex failed" || return $?
    itemIndex=$((itemIndex + 1))
    assertEquals "{NAME}, {PLACE}." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world "$binary" NAM PLAC)" "#$itemIndex failed" || return $?
    itemIndex=$((itemIndex + 1))
    assertEquals "{NAME}, {PLACE}." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world "$binary" AME LACE)" "#$itemIndex failed" || return $?
    itemIndex=$((itemIndex + 1))
  done
}

testMapValue() {
  local tempEnv
  local handler="_return"

  tempEnv=$(fileTemporaryName "$handler") || return $?

  assertEquals "{foo}" "$(mapValue "$tempEnv" "{foo}")" || return $?

  printf "%s=%s\n" "foo" "bar" >>"$tempEnv"

  assertEquals "bar" "$(mapValue "$tempEnv" "{foo}")" || return $?

  __catch "$handler" rm -f "$tempEnv" || return $?
}
