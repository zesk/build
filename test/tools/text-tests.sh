#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# text-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testAlignRight() {
  assertEquals "$(textAlignRight 20 012345)" "              012345" || return $?
  assertEquals "$(textAlignRight 5 012345)" "012345" || return $?
  assertEquals "$(textAlignRight 0 012345)" "012345" || return $?
}

testPlural() {
  assertEquals "$(localePlural 0 singular plural)" "plural" || return $?
  assertExitCode --stderr-ok 2 localePlural X singular localePlural || return $?
  assertEquals "$(localePlural 1 singular plural)" "singular" || return $?
  assertEquals "$(localePlural 2 singular plural)" "plural" || return $?
  assertEquals "$(localePlural -1 singular plural)" "plural" || return $?
  assertEquals "$(localePlural -1 singular)" "singulars" || return $?
  assertEquals "$(localePlural 1 singular)" "singular" || return $?
  assertEquals "$(localePlural 1.0 singular)" "singular" || return $?
  assertEquals "$(localePlural 1.0000000000000 singular)" "singular" || return $?
  assertEquals "$(localePlural 1.1 singular)" "singulars" || return $?
}

testPluralWord() {
  assertEquals "$(localePluralWord 0 singular plural)" "0 plural" || return $?
  assertExitCode --stderr-ok 2 localePluralWord X singular localePlural || return $?
  assertEquals "$(localePluralWord 1 singular plural)" "1 singular" || return $?
  assertEquals "$(localePluralWord 2 singular plural)" "2 plural" || return $?
  assertEquals "$(localePluralWord -1 singular plural)" "-1 plural" || return $?
  assertEquals "$(localePluralWord -1 singular)" "-1 singulars" || return $?
  assertEquals "$(localePluralWord 1 singular)" "1 singular" || return $?
  assertEquals "$(localePluralWord 1.0 singular)" "1.0 singular" || return $?
  assertEquals "$(localePluralWord 1.0000000000000 singular)" "1.0000000000000 singular" || return $?
  assertEquals "$(localePluralWord 1.1 singular)" "1.1 singulars" || return $?
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
    assertEquals "$expected" "$(textTrimBoth <<<"$test")" || return $?
  done < <(__dataTrimBoth)
}

__dataTrimSpace() {
  cat <<'EOF'
textTrim| textTrim   |
|     |
a b c|  a b c        |
EOF
}

__dataTrimLeftSpace() {
  cat <<'EOF'
textTrim   | textTrim   |
|     |
a b c        |  a b c        |
EOF
}

__dataTrimRightSpace() {
  cat <<'EOF'
 textTrim| textTrim   |
|     |
  a b c|  a b c        |
EOF
}

testTrimSpace() {
  local expected test remainder
  while IFS="|" read -r expected test remainder; do
    assertEquals "$expected" "$(textTrim "$test")" || return $?
    assertEquals "$expected" "$(textTrim <<<"$test")" || return $?
    : "$remainder"
  done < <(__dataTrimSpace)
}

testTrimRightSpace() {
  local expected test remainder
  while IFS="|" read -r expected test remainder; do
    assertEquals "$expected" "$(textTrimRight "$test")" || return $?
    assertEquals "$expected" "$(textTrimRight <<<"$test")" || return $?
    : "$remainder"
  done < <(__dataTrimRightSpace)
}

testTrimLeftSpace() {
  local expected test remainder
  while IFS="|" read -r expected test remainder; do
    assertEquals "$expected" "$(textTrimLeft "$test")" || return $?
    assertEquals "$expected" "$(textTrimLeft <<<"$test")" || return $?
    : "$remainder"
  done < <(__dataTrimLeftSpace)
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
    assertEquals "$expected" "$(textReplace "$needle" "$replacement" "$haystack")" || return $?
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
    assertExitCode "$expected" stringFoundInsensitive "$haystack" "$@" || return $?
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
    assertExitCode --display "stringBeginsInsensitive \"$haystack\" \"$needle\"" "$exitCode" stringBeginsInsensitive "$haystack" "$needle" || return $?
  done < <(__dataStringBeginsInsensitive)
}

__dataBeginsWith() {
  cat <<'EOF'
0 Hello Hell No
1 Whatever WHAT hatever
0 Whatever What BBB CCC DDD
0 Whatever BBB CCC DDD What
1 Whatever BBB CCC DDD AAA
EOF
}

testBeginsWith() {
  local expected text remainder
  while read -r expected text remainder; do
    local args=()
    IFS=" " read -r -a args <<<"$remainder" || :
    assertExitCode --display "stringBegins \"$text\" ${args[*]}" "$expected" stringBegins "$text" "${args[@]+"${args[@]}"}" || return $?
  done < <(__dataBeginsWith)
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
    assertExitCode --display "stringBegins \"$haystack\" \"$needle\"" "$exitCode" stringBegins "$haystack" "$needle" || return $?
  done < <(__dataStringBegins)
}

__dataStringContainsInsensitive() {
  cat <<'EOF'
0|Hello, world.|hello
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
0|Hello|Hello, world.
1|ello|Hello, world.
2|llo, |Hello, world.
3|lo, world.|Hello, world.
7|world|Hello, world.
8|orld.|Hello, world.
12|.|Hello, world.
EOF
}

testStringOffset() {
  local expected haystack needle
  while IFS="|" read -r expected needle haystack; do
    assertEquals "$expected" "$(stringOffset "$needle" "$haystack")" || return $?
  done < <(__dataStringOffset)
}

__dataStringOffsetInsensitive() {
  cat <<'EOF'
0|hello|Hello, world.
0|Hello|Hello, world.
1|ello|Hello, world.
2|Llo, |Hello, world.
3|lo, world.|Hello, World.
7|world|Hello, WORLD.
8|orld.|Hello, worlD.
12|.|Hello, world.
EOF
}

testStringOffsetInsensitive() {
  local expected haystack needle
  while IFS="|" read -r expected needle haystack; do
    assertEquals "$expected" "$(stringOffsetInsensitive "$needle" "$haystack")" || return $?
  done < <(__dataStringOffsetInsensitive)
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
  local expected value
  while IFS="|" read -r expected value; do
    assertExitCode "$expected" booleanParse "$value" || return $?
  done < <(__dataParseBoolean)
}

__dataShaPipe() {
  cat <<'EOF'
1d229271928d3f9e2bb0375bd6ce5db6c6d348d9|Hello
adc83b19e793491b1c6ea0fd8b46cd9f32e592fc|
36a657f07101da21abddf9b8ae339091073809fd|Zesk Build
EOF
}

testShaPipe() {
  local expected content
  while IFS="|" read -r expected content; do
    assertEquals --display "${content:-blank}" "$expected" "$(textSHA <<<"$content")" || return $?
  done < <(__dataShaPipe)
}

__dataPlainLength() {
  cat <<EOF
5|Hello
5|$(decorate bold Hello)
20|$(decorate file /var/never/README.md)
EOF
}

testPlainLength() {
  local expected content
  while IFS="|" read -r expected content; do
    assertEquals --display "consolePlainLength $content (${#content})" "$expected" "$(consolePlainLength "$content")" || return $?
    assertEquals --display "consolePlainLength <<< $content (${#content})" "$expected" "$(consolePlainLength <<<"$content")" || return $?
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
    assertExitCode "$exitCode" stringFound "$needle" "$haystack" || return $?
  done
}

testTrimHeadTail() {
  local topSpace bottomSpace

  topSpace=$(printf "\n\n\n\n\n\n\nip")
  bottomSpace=$(printf "ip\n\n\n\n\n\n\n")

  assertEquals "$(printf "%s" "$topSpace" | textTrimHead)" "ip" || return $?
  assertEquals "$(printf "%s" "$topSpace" | textTrimTail)" "$topSpace" || return $?
  assertEquals "$(printf "%s" "$bottomSpace" | textTrimHead)" "$bottomSpace" || return $?
  assertEquals "$(printf "%s" "$bottomSpace" | textTrimTail)" "ip" || return $?
}

testSingleBlankLines() {
  local topSpace bottomSpace middleSpace

  topSpace=$(printf "\n\n\n\n\n\n\nip")
  bottomSpace=$(printf "ip\n\n\n\n\n\n\n")
  middleSpace=$(printf "\n\n\nip\n\n\n\n\n\n\n")

  assertEquals "$(printf "\nip")" "$(printf "%s\n" "$topSpace" | textSingleBlankLines)" || return $?
  assertEquals "$(printf "ip\n")" "$(printf "%s\n" "$bottomSpace" | textSingleBlankLines)" || return $?
  assertEquals "$(printf "\nip\n")" "$(printf "%s\n" "$middleSpace" | textSingleBlankLines)" || return $?
}

testText() {
  assertOutputContains Hello decorate box Hello || return $?
}

testLowercase() {
  assertOutputEquals stringLowercase stringLowercase LoWerCaSe || return $?
}

testPrintfOutputPrefix() {
  assertEquals "" "$(printf "" | printfOutputPrefix "c")" || return $?
  assertEquals "" "$(printf "" | printfOutputSuffix "c")" || return $?
  assertEquals "c"$'\n' "$(printf "\n" | printfOutputPrefix "c")" || return $?
  assertEquals "cab" "$(echo "ab" | printfOutputPrefix "c")" || return $?
  assertEquals "cab"$'\n' "$(echo "ab" | printfOutputPrefix "c")" || return $?
  assertEquals "gab"$'\n'"cd"$'\n'"ef"$'\n' "$(printf "%s\n" "ab" "cd" "ef" | printfOutputPrefix "g")" || return $?
}

testPrintfOutputSuffix() {
  assertEquals "" "$(printf "" | printfOutputSuffix "c")" || return $?
  assertEquals "" "$(printf "" | printfOutputSuffix "c")" || return $?
  assertEquals $'\n'"c" "$(printf "\n" | printfOutputSuffix "c")" || return $?
  assertEquals "ab"$'\n'"c" "$(echo "ab" | printfOutputSuffix "c")" || return $?
  assertEquals "ab"$'\n'"cd"$'\n'"ef"$'\n'"g" "$(printf "%s\n" "ab" "cd" "ef" | printfOutputSuffix "g")" || return $?
}

testPrintfOutputEmpty() {
  assertEquals "c" "$(printf "" | printfOutputEmpty "c")" || return $?
  assertEquals "c" "$(printf "" | printfOutputEmpty "c")" || return $?
  # newlines are stripped from the quoted "$(printf "\n\n\n")"
  assertEquals "" "$(printf "\n\n\n")" || return $?
  assertEquals "" "$(printf "\n" | printfOutputEmpty "c")" || return $?
  assertEquals "ab"$'\n' "$(echo "ab" | printfOutputEmpty "c")" || return $?
  assertEquals "ab"$'\n' "$(echo "ab" | printfOutputEmpty "c")" || return $?
  assertEquals "ab"$'\n'"cd"$'\n'"ef"$'\n' "$(printf "%s\n" "ab" "cd" "ef" | printfOutputEmpty "g")" || return $?
}

__maxLineLengthFile() {
  textRepeat "$1" _
  printf "\n%s\n" "$(stringRandom)"
}

testMaximumLineLength() {
  local n
  for n in 54 94 112 199; do
    assertEquals "$n" "$(__maxLineLengthFile "$n" | fileLineMaximum)" || return $?
  done
}

__maxFieldLengthFile() {
  # Name,Department,Age,Salary,Notes
  cat <<'EOF'
Juan,Accounting,25,98023,Is actually from another planet.
Michelle,HR,29,87099,Eats lunch at 4PM
Randy,DevTeam,36,75000,Does not speak.
EOF
}

__maxFieldResults() {
  cat <<'EOF'
8 1
10 2
2 3
5 4
32 5
0 6
0 7
0 99
EOF
}

testMaximumFieldLength() {
  local expectedLength fieldIndex
  while read -r expectedLength fieldIndex; do
    assertEquals --display "Field $fieldIndex" "$expectedLength" "$(__maxFieldLengthFile | fileFieldMaximum "$fieldIndex" ,)" || return $?
  done < <(__maxFieldResults)
}
