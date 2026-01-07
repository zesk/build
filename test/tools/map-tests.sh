#!/usr/bin/env bash
#
# map-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
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
  local handler="returnMessage" home

  local COLUMNS LINES
  home=$(catchReturn "$handler" buildHome) || return $?

  echo | assertExitCode 0 mapTokens || return $?
  assertEquals "" "$(echo | mapTokens)" || return $?
  assertEquals "$(printf "%s\n" a b c)" "$(echo '{a}{b}{c}' | mapTokens)" || return $?
  assertEquals "$(printf "%s\n" confirmYesNo fileCopyWouldChange fileCopy 'args[@]' 'args[@]')" "$(mapTokens <"$home/test/example/mapTokensBad.md")" || return $?
}

testMapPrefixSuffix() {
  local itemIndex=1 binary aa=()

  for binary in mapEnvironment "$(buildHome)/bin/build/map.sh"; do
    aa=(--display "$binary")

    assertEquals "${aa[@]}" "Hello, world." "$(echo "[NAME], [PLACE]." | NAME=Hello PLACE=world "$binary" --prefix '[' --suffix ']')" "#$itemIndex failed" || return $?
    itemIndex=$((itemIndex + 1))
    assertEquals "${aa[@]}" "Hello, world." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world "$binary")" "#$itemIndex failed" || return $?
    itemIndex=$((itemIndex + 1))
    assertEquals "${aa[@]}" "Hello, world." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world "$binary" NAME PLACE)" "#$itemIndex failed" || return $?
    itemIndex=$((itemIndex + 1))
    assertEquals "${aa[@]}" "Hello, {PLACE}." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world "$binary" NAME)" "#$itemIndex failed" || return $?
    itemIndex=$((itemIndex + 1))
    assertEquals "${aa[@]}" "{NAME}, world." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world "$binary" PLACE)" "#$itemIndex failed" || return $?
    itemIndex=$((itemIndex + 1))
    assertEquals "${aa[@]}" "{NAME}, {PLACE}." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world "$binary" NAM PLAC)" "#$itemIndex failed" || return $?
    itemIndex=$((itemIndex + 1))
    assertEquals "${aa[@]}" "{NAME}, {PLACE}." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world "$binary" AME LACE)" "#$itemIndex failed" || return $?
    itemIndex=$((itemIndex + 1))
  done
}

testMapValue() {
  local tempEnv
  local handler="returnMessage"

  tempEnv=$(fileTemporaryName "$handler") || return $?

  assertEquals "{foo}" "$(mapValue "$tempEnv" "{foo}")" || return $?

  printf "%s=%s\n" "foo" "bar" >>"$tempEnv"

  assertEquals "bar" "$(mapValue "$tempEnv" "{foo}")" || return $?

  catchReturn "$handler" rm -f "$tempEnv" || return $?
}

testMapEnvironmentBadNames() {
  assertEquals "Lovely" "$(A=L B=v C=y D=l E=e o=o mapEnvironment A B C D E o " " "   " "--bad--" <<<"{A}{o}{B}{E}{D}{C}")" || return $?
}

testCannon() {
  local handler="returnMessage"

  local testHome
  testHome=$(fileTemporaryName "$handler" -d) || return $?

  catchEnvironment "$handler" printf "%s\n" "dog" "cat" "owl" "cheetah" >"$testHome/one.md" || return $?
  catchEnvironment "$handler" printf "%s\n" "owl" "lizard" "newt" "rat" "cat" >"$testHome/two.sh" || return $?
  catchEnvironment "$handler" printf "%s\n" "when" "what" "where" "why" >"$testHome/three.md" || return $?

  assertFileContains "$testHome/two.sh" "lizard" || return $?

  assertExitCode --stderr-match "directory" 2 cannon --path "$testHome/not-a-path" dog friend || return $?
  assertExitCode --stderr-match "blank" 2 cannon --path "$testHome" "" friend || return $?
  assertExitCode 3 cannon --path "$testHome" dog friend || return $?
  assertExitCode 3 cannon --path "$testHome" cat hairball || return $?
  assertExitCode 0 cannon --path "$testHome" lizard "" ! -name '*.sh' || return $?
  assertFileContains "$testHome/two.sh" "lizard" "owl" "newt" "rat" "hairball" || return $?
  assertExitCode 3 cannon --path "$testHome" lizard "" || return $?
  assertFileDoesNotContain "$testHome/two.sh" "lizard" || return $?
  assertFileContains "$testHome/two.sh" "owl" "newt" "rat" "hairball" || return $?
  assertExitCode 3 cannon --path "$testHome" newt "" || return $?
  assertFileDoesNotContain "$testHome/two.sh" "newt" "lizard" || return $?
  assertFileContains "$testHome/three.md" "when" "what" "where" "why" || return $?
  catchEnvironment "$handler" rm -rf "$testHome" || return $?
}

__dataConvertValue() {
  cat <<EOF
0
a a
a a a
b a a b
b a a b b c c d d e
b a d e c d b c a b
A a a A b B c C d D e E
B b a A b B c C d D e E
C c a A b B c C d D e E
D d a A b B c C d D e E
E e a A b B c C d D e E
f f a A b B c C d D e E
EOF
}
testConvertValue() {
  local expected arguments
  while read -r expected arguments; do
    local args=()
    IFS=" " read -d '' -r -a args <<<"$arguments"
    assertEquals "$expected" "$(convertValue "${args[@]+"${args[@]}"}")" || return $?
  done < <(__dataConvertValue)
}
