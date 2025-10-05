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
  local handler="returnMessage"

  local ff
  ff=$(fileTemporaryName "$handler") || return $?

  BUILD_DEBUG="" assertExitCode --stdout-match "file end with a newline" 0 fileEndsWithNewline --help || return $?
  assertExitCode --stderr-match "at least one" 2 fileEndsWithNewline || return $?
  assertExitCode --stderr-match "not a file" 2 fileEndsWithNewline ".not-a-file" || return $?

  assertExitCode 0 fileEndsWithNewline "$ff" || return $?

  catchEnvironment "$handler" printf -- "\n" >"$ff" || return $?
  assertExitCode 0 fileEndsWithNewline "$ff" || return $?

  catchEnvironment "$handler" printf -- "abc\n\n\n\n" >"$ff" || return $?
  assertExitCode 0 fileEndsWithNewline "$ff" || return $?

  catchEnvironment "$handler" printf -- "abc\n\n\n\ndef" >"$ff" || return $?
  assertExitCode 1 fileEndsWithNewline "$ff" || return $?

  catchEnvironment "$handler" rm -f "$ff" || return $?
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
  local expected text
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
  local expected needle replacement haystack
  while IFS="|" read -r expected needle replacement haystack; do
    assertEquals "$expected" "$(stringReplace "$needle" "$replacement" "$haystack")" || return $?
  done < <(__dataStringReplace)
}

__dataIsSubstringInsensitive() {
  cat <<'EOF'
1|abc|ABd|bcd|abed
0|;Build-Home:true;|;Build-Home:true;
0|;Build-Home:true;|;build-home:true;
0|;build-home:true;|;Build-Home:true;
EOF
}
testIsSubstringInsensitive() {
  local testRow
  while IFS="|" read -r -a testRow; do
    set -- "${testRow[@]}"
    local expected="$1" haystack="$2" && shift 2
    assertExitCode "$expected" isSubstringInsensitive "$haystack" "$@" || return $?
  done < <(__dataIsSubstringInsensitive)
}

__dataStringBeginsInsensitive() {
  cat <<'EOF'
0|Hello, world.|hello
0|Hello, world.|Hello
0|Hello, world.|Hello, world.
1|Hello, world.|world
1|Hello, world.|World
EOF
}

testStringBeginsInsensitive() {
  local exitCode haystack needle
  while IFS="|" read -r exitCode haystack needle; do
    assertExitCode "$expected" "$(stringBeginsInsensitive "$haystack" "$needle")" || return $?
  done < <(__dataStringBeginsInsensitive)
}

__dataStringBegins2() {
  cat <<'EOF'
0 Hello Hell No
1 Whatever WHAT hatever
0 Whatever What BBB CCC DDD
0 Whatever BBB CCC DDD What
1 Whatever BBB CCC DDD AAA
EOF
}

testStringBegins2() {
  local expected text remainder
  while read -r expected text remainder; do
    local args=()
    IFS=" " read -r -a args <<<"$remainder" || :
    assertExitCode "$expected" beginsWith "$text" "${args[@]+"${args[@]}"}" || return $?
  done < <(__dataStringBegins2)
}

__dataStringBegins() {
  cat <<'EOF'
1|Hello, world.|hello
0|Hello, world.|Hello
0|Hello, world.|Hello, world.
1|Hello, world.|world
1|Hello, world.|World
EOF
}

testStringBegins() {
  local exitCode haystack needle
  while IFS="|" read -r exitCode haystack needle; do
    assertExitCode "$expected" "$(stringBegins "$haystack" "$needle")" || return $?
  done < <(__dataStringBeginsInsensitive)
}

__dataStringContainsInsensitive() {
  cat <<'EOF'
1|Hello, world.|hello
0|Hello, world.|Hello
0|Hello, world.|Hello, world.
0|Hello, world.|world
0|Hello, world.|World
0|haystack|needle|needle|needle|needle|needle|aystac|needle
0|haystack|needle|needle|needle|needle|needle|haystac|needle
0|haystack|needle|needle|needle|needle|needle|aystack|needle
0|haystack|needle|needle|needle|needle|needle|Haystack|needle
EOF
}

testStringContainsInsensitive() {
  local testRow
  while IFS="|" read -r -a testRow; do
    set -- "${testRow[@]}"
    local expected="$1" && shift
    assertExitCode "$expected" stringContainsInsensitive "$@" || return $?
  done < <(__dataStringContainsInsensitive)
}

__dataStringContains() {
  cat <<'EOF'
1|Hello, world.|hello
0|Hello, world.|Hello
0|Hello, world.|Hello, world.
0|Hello, world.|world
1|Hello, world.|World
0|haystack|needle|needle|needle|needle|needle|aystac|needle
0|haystack|needle|needle|needle|needle|needle|haystac|needle
0|haystack|needle|needle|needle|needle|needle|aystack|needle
1|haystack|needle|needle|needle|needle|needle|Haystack|needle
EOF
}

testStringContains() {
  local testRow
  while IFS="|" read -r -a testRow; do
    set -- "${testRow[@]}"
    local expected="$1" haystack="$2" && shift 2
    assertExitCode "$expected" stringContains "$haystack" "$@" || return $?
  done < <(__dataStringContains)
}

__dataStringOffset() {
  cat <<'EOF'
-1|hello|Hello, world.
0|ello|Hello, world.
1|llo, |Hello, world.
2|lo, world.|Hello, world.
7|world|Hello, world.
8|orld.|Hello, world.
15|.|Hello, world.
EOF
}

testStringOffset() {
  local expected haystack needle
  while IFS="|" read -r expected haystack needle; do
    assertEquals "$expected" "$(stringOffset "$needle" "$haystack")" || return $?
  done < <(__dataStringOffset)
}

__dataParseBoolean() {
  cat <<'EOF'
0|yes
0|Y
0|true
0|TRUE
0|TrUe
1|false
1|n
1|fAlSe
1|no
2|not
2|maybe
2|nein
2|non
2|nyet
2|ja
2|oui
2|si
EOF
}

testParseBoolean() {
  local expected haystack needle
  while IFS="|" read -r expected value; do
    assertExitCode "$expected" parseBoolean "$value" || return $?
  done < <(__dataParseBoolean)
}

__dataShaPipe() {
  cat <<'EOF'
1d229271928d3f9e2bb0375bd6ce5db6c6d348d9|Hello
da39a3ee5e6b4b0d3255bfef95601890afd80709|
9a87e2256c7b6ff46b155e90fbf0d1f0f83aab1b|Zesk Build
EOF
}

testShaPipe() {
  local expected content
  while IFS="|" read -r expected content; do
    assertEquals "$expected" "$(shaPipe <<<"$content")" || return $?
  done < <(__dataShaPipe)
}

__dataPlainLength() {
  cat <<EOF
5|Hello
5|$(decorate bold Hello)
9|$(decorate file README.md)
EOF
}

testPlainLength() {
  local expected content
  while IFS="|" read -r expected content; do
    assertEquals --display "plainLength $content (${#content})" "$expected" "$(plainLength "$content")" || return $?
    assertEquals --display "plainLength <<< $content (${#content})" "$expected" "$(plainLength <<<"$content")" || return $?
  done < <(__dataPlainLength)
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

__maxLineLengthFile() {
  repeat "$1" _
  printf "%s\n" "$(randomString)"
}

testMaximumLineLength() {
  for n in 54 94 112 199; do
    assertEquals "$n" "$(__maxLineLengthFile "$n" | maximumLineLength)" || return $?
  done
}

__maxFieldLengthFile() {
  cat <<'EOF'
Name,Department,Age,Salary,Notes
Juan,Accounting,25,98023,Is actually from another planet.
Michelle,HR,29,87099,Eats lunch at 4PM
Randy,DevTeam,36,75000,Does not speak.
EOF
}

testMaximumFieldLength() {
  assertEquals 8 "$(maximumFieldLength 1 , <__maxFieldLengthFile)" || return $?
  assertEquals 10 "$(maximumFieldLength 2 , <__maxFieldLengthFile)" || return $?
  assertEquals 2 "$(maximumFieldLength 3 , <__maxFieldLengthFile)" || return $?
  assertEquals 5 "$(maximumFieldLength 4 , <__maxFieldLengthFile)" || return $?
  assertEquals 5 "$(maximumFieldLength 5 , <__maxFieldLengthFile)" || return $?
  assertEquals 32 "$(maximumFieldLength 6 , <__maxFieldLengthFile)" || return $?
  assertEquals 0 "$(maximumFieldLength 7 , <__maxFieldLengthFile)" || return $?
  assertEquals 0 "$(maximumFieldLength 99 , <__maxFieldLengthFile)" || return $?
}
