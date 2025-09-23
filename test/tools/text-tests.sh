#!/usr/bin/env bash
#
# text-tests.sh
#
# Text tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testAlignRight() {
  assertEquals "$(alignRight 20 012345)" "              012345" || return $?
  assertEquals "$(alignRight 5 012345)" "012345" || return $?
  assertEquals "$(alignRight 0 012345)" "012345" || return $?
}


testPlural() {
  assertEquals "$(plural 0 singular plural)" "plural" || return $?
  assertExitCode --stderr-ok 2 plural X singular plural || return $?
  assertEquals "$(plural 1 singular plural)" "singular" || return $?
  assertEquals "$(plural 2 singular plural)" "plural" || return $?
  assertEquals "$(plural -1 singular plural)" "plural" || return $?
  assertEquals "$(plural -1 singular)" "singulars" || return $?
  assertEquals "$(plural 1 singular)" "singular" || return $?
  assertEquals "$(plural 1.0 singular)" "singular" || return $?
  assertEquals "$(plural 1.0000000000000 singular)" "singular" || return $?
  assertEquals "$(plural 1.1 singular)" "singulars" || return $?
}

testPluralWord() {
  assertEquals "$(pluralWord 0 singular plural)" "0 plural" || return $?
  assertExitCode --stderr-ok 2 pluralWord X singular plural || return $?
  assertEquals "$(pluralWord 1 singular plural)" "1 singular" || return $?
  assertEquals "$(pluralWord 2 singular plural)" "2 plural" || return $?
  assertEquals "$(pluralWord -1 singular plural)" "-1 plural" || return $?
  assertEquals "$(pluralWord -1 singular)" "-1 singulars" || return $?
  assertEquals "$(pluralWord 1 singular)" "1 singular" || return $?
  assertEquals "$(pluralWord 1.0 singular)" "1.0 singular" || return $?
  assertEquals "$(pluralWord 1.0000000000000 singular)" "1.0000000000000 singular" || return $?
  assertEquals "$(pluralWord 1.1 singular)" "1.1 singulars" || return $?
}

testFileEndsWithNewline() {
  local handler="_return"

  local ff
  ff=$(fileTemporaryName "$handler") || return $?

  BUILD_DEBUG="" assertExitCode --stdout-match "file end with a newline" 0 fileEndsWithNewline --help || return $?
  assertExitCode --stderr-match "at least one" 2 fileEndsWithNewline || return $?
  assertExitCode --stderr-match "not a file" 2 fileEndsWithNewline ".not-a-file" || return $?

  assertExitCode 0 fileEndsWithNewline "$ff" || return $?

  __catchEnvironment "$handler" printf -- "\n" >"$ff" || return $?
  assertExitCode 0 fileEndsWithNewline "$ff" || return $?

  __catchEnvironment "$handler" printf -- "abc\n\n\n\n" >"$ff" || return $?
  assertExitCode 0 fileEndsWithNewline "$ff" || return $?

  __catchEnvironment "$handler" printf -- "abc\n\n\n\ndef" >"$ff" || return $?
  assertExitCode 1 fileEndsWithNewline "$ff" || return $?

  __catchEnvironment "$handler" rm -f "$ff" || return $?
}

__dataStringBegins() {
  cat <<EOF
0 Hello Hell No
1 Whatever WHAT hatever
0 Whatever What BBB CCC DDD
0 Whatever BBB CCC DDD What
1 Whatever BBB CCC DDD AAA
EOF
}

testStringBegins() {
  while read -r expected text remainder; do
    local args=()
    IFS=" " read -r -a args <<<"$remainder" || :
    assertExitCode "$expected" beginsWith "$text" "${args[@]+"${args[@]}"}" || return $?
  done < <(__dataStringBegins)
}

__dataIsPlain() {
  local dog
  dog="$(decorate red dog)"
  cat <<EOF
0 Hello Hell No
1 Whatever WHAT whatever $dog
0 !@#$%^&*()_+{}:"?><{}[]\
0 Zesk Build makes easier pipeline platform and project management.
1 Zesk Build makes easier pipeline platform and project management, $dog.
0
EOF
}

testIsPlain() {
  while read -r expected text; do
    assertExitCode "$expected" isPlain "$text" || return $?
  done < <(__dataIsPlain)
}

__dataTrimBoth() {
  cat <<EOF
this is a line|



this is a line



;single|


single;solo|solo



;
EOF
}

testTrimBoth() {
  local expected test
  while IFS="|" read -d ';' -r expected test; do
    assertEquals "$expected" "$(trimBoth <<<"$test")" || return $?
  done < <(__dataTrimBoth)
}

__dataTrimSpace() {
  cat <<'EOF'
trimSpace| trimSpace   |
|     |
a b c|  a b c        |
EOF
}

testTrimSpace() {
  local expected test remainder
  while IFS="|" read -r expected test remainder; do
    assertEquals "$expected" "$(trimSpace "$test")" || return $?
    assertEquals "$expected" "$(trimSpace <<<"$test")" || return $?
    : "$remainder"
  done < <(__dataTrimSpace)
}

__dataStringReplace() {
  cat <<EOF
Redundant|871|un|Red871dant
1A11LE|Z|1|ZAZZLE
zAzzLE|Z|1|zAzzLE
EOF
}

testStringReplace() {
  while IFS="|" read -r expected needle replacement haystack; do
    assertEquals "$expected" "$(stringReplace "$needle" "$replacement" "$haystack")" || return $?
  done < <(__dataStringReplace)
}
testIsSubstringInsensitive() {
  assertExitCode 1 isSubstringInsensitive "abc" "ABd" "bcd" "abed" || return $?
  assertExitCode 0 isSubstringInsensitive ";Build-Home:true;" ";Build-Home:true;" || return $?
  assertExitCode 0 isSubstringInsensitive ";Build-Home:true;" ";build-home:true;" || return $?
  assertExitCode 0 isSubstringInsensitive ";build-home:true;" ";Build-Home:true;" || return $?
}

testSubstringFound() {
  assertExitCode 0 stringContains haystack needle needle needle needle needle aystac needle || return $?
  assertExitCode 0 stringContains haystack needle needle needle needle needle haystac needle || return $?
  assertExitCode 0 stringContains haystack needle needle needle needle needle aystack needle || return $?
  assertNotExitCode 0 stringContains haystack needle needle needle needle needle Haystack needle || return $?
}

__testIsSubstringData() {
  cat <<'EOF'
0 foo food
0 a ambulance
0 a dora
1 a DORA
1 X ABCDEFGHIJKLMNOPQRSTUVWYZ
0 X ABCDEFGHIJKLMNOPQRSTUVWXYZ
EOF
}

testIsSubstring() {
  local exitCode needle haystack
  __testIsSubstringData | while read -r exitCode needle haystack; do
    assertExitCode "$exitCode" isSubstring "$needle" "$haystack" || return $?
  done
}

testTrimHeadTail() {
  local topSpace bottomSpace

  topSpace=$(printf "\n\n\n\n\n\n\nip")
  bottomSpace=$(printf "ip\n\n\n\n\n\n\n")

  assertEquals "$(printf "%s" "$topSpace" | trimHead)" "ip" || return $?
  assertEquals "$(printf "%s" "$topSpace" | trimTail)" "$topSpace" || return $?
  assertEquals "$(printf "%s" "$bottomSpace" | trimHead)" "$bottomSpace" || return $?
  assertEquals "$(printf "%s" "$bottomSpace" | trimTail)" "ip" || return $?
}

testSingleBlankLines() {
  local topSpace bottomSpace middleSpace

  topSpace=$(printf "\n\n\n\n\n\n\nip")
  bottomSpace=$(printf "ip\n\n\n\n\n\n\n")
  middleSpace=$(printf "\n\n\nip\n\n\n\n\n\n\n")

  assertEquals "$(printf "\nip")" "$(printf "%s\n" "$topSpace" | singleBlankLines)" || return $?
  assertEquals "$(printf "ip\n")" "$(printf "%s\n" "$bottomSpace" | singleBlankLines)" || return $?
  assertEquals "$(printf "\nip\n")" "$(printf "%s\n" "$middleSpace" | singleBlankLines)" || return $?
}

testText() {
  assertOutputContains Hello boxedHeading Hello || return $?
}

testLowercase() {
  assertOutputEquals lowercase lowercase LoWerCaSe || return $?
}

testPrintfOutput() {
  assertEquals "$(echo "ab" | printfOutputPrefix "c")" "cab" || return $?
  assertEquals "$(printf "" | printfOutputPrefix "c")" "" || return $?
  assertEquals "$(echo "ab" | printfOutputSuffix "c")" "ab"$'\n'"c" || return $?
  assertEquals "$(printf "" | printfOutputSuffix "c")" "" || return $?
}
