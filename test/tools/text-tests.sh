#!/usr/bin/env bash
#
# text-tests.sh
#
# Text tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

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

testEscapeSingleQuotes() {
  assertEquals "Ralph \"Dude\" Brown" "$(escapeSingleQuotes "Ralph \"Dude\" Brown")" || return $?
  # shellcheck disable=SC1003
  assertEquals 'Dude\'"'"'s place' "$(escapeSingleQuotes "Dude's place")" || return $?
}
testEscapeDoubleQuotes() {
  assertEquals "Ralph \\\"Dude\\\" Brown" "$(escapeDoubleQuotes "Ralph \"Dude\" Brown")" || return $?

  assertEquals "Dude's place" "$(escapeDoubleQuotes "Dude's place")" || return $?
}

__testQuoteSedPatternData() {
  cat <<'EOF'
  __                  _   _
 / _|_   _ _ __   ___| |_(_) ___  _ __  ___
| |_| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
|  _| |_| | | | | (__| |_| | (_) | | | \__ \
|_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
EOF
}

testQuoteSedPattern() {
  local value mappedValue
  assertEquals "\\[" "$(quoteSedPattern "[")" || return $?
  assertEquals "\\]" "$(quoteSedPattern "]")" || return $?
  # shellcheck disable=SC1003
  assertEquals '\\' "$(quoteSedPattern '\')" || return $?
  assertEquals "\\/" "$(quoteSedPattern "/")" || return $?
  # Fails in code somewhere
  read -d "" -r value < <(__testQuoteSedPatternData)

  mappedValue="$(printf %s "{name}" | name=$value mapEnvironment)"
  assertEquals "$mappedValue" "$value" || return $?
}

testQuoteSedReplacement() {
  local value mappedValue
  assertEquals "\\&" "$(quoteSedReplacement "&")" || return $?
  # shellcheck disable=SC1003
  assertEquals '\\' "$(quoteSedReplacement '\')" || return $?
  # shellcheck disable=SC1003
  assertEquals '\\' "$(quoteSedReplacement '\' '~')" || return $?
  assertEquals "\\/" "$(quoteSedReplacement "/")" || return $?
  assertEquals "/" "$(quoteSedReplacement "/" "~")" || return $?
  # Fails in code somewhere
  read -d "" -r value < <(__testQuoteSedPatternData)

  mappedValue="$(printf %s "{name}" | name=$value mapEnvironment)"
  assertEquals "$mappedValue" "$value" || return $?
}

testLowercase() {
  assertOutputEquals lowercase lowercase LoWerCaSe || return $?
}

__testIsCharacterClass() {
  local first header c characters=(0 1 2 7 8 9 a b c x y z A B C X Y Z ' ' '!' '%' "'" @ ^ - '=')
  local class line temp token firstColumnWidth=7
  local sep="" cellWidth=2
  header=
  first=1
  for class in alnum alpha ascii blank cntrl digit graph lower print punct space upper word xdigit; do
    line=
    for c in "${characters[@]}"; do
      if test $first; then
        header="$header$(alignRight "$cellWidth" "$c")$sep"
      fi
      if isCharacterClass "$class" "$c"; then
        token="Y"
      else
        #temp="$(repeat "${#temp}" " ")"
        token="."
      fi
      line="${line}$(alignRight "$cellWidth" "$token")$sep"
    done

    if test $first; then
      printf "$(alignLeft "$firstColumnWidth" "class")%s|%s%s\n" "$sep" "$sep" "$header"
      printf "%s%s+%s%s\n" "$(repeat "$firstColumnWidth" "-")" "$sep" "$sep" "$(repeat "${#header}" "-")"
    fi
    first=
    printf "%s%s|%s%s\n" "$(alignLeft "$firstColumnWidth" "$class")" "$sep" "$sep" "$line"
  done
}

testValidateCharacterClass() {
  local temp

  temp=$(mktemp) || return $?
  __testIsCharacterClass | tee "$temp" || return $?
  if ! diff -q "$temp" "./test/example/isCharacterClass.txt"; then
    decorate error "Classifications changed:"
    diff "$temp" "./test/example/isCharacterClass.txt"
    return 1
  fi
  rm "$temp" || :
}

testStringValidate() {
  assertExitCode 0 stringValidate string alpha || return $?
  assertExitCode 0 stringValidate string alnum || return $?
  assertNotExitCode 0 stringValidate str0ng alpha || return $?
  assertExitCode 0 stringValidate str0ng alnum || return $?
  assertExitCode 0 stringValidate string alpha alnum || return $?
  assertExitCode 0 stringValidate string alpha digit || return $?
  assertExitCode 0 stringValidate string digit alpha || return $?
  assertExitCode 0 stringValidate A_B_C upper _ || return $?
  assertExitCode 1 stringValidate A_B_C lower _ || return $?
}

testCharacterFromInteger() {
  assertEquals l "$(characterFromInteger "$(_code leak)")" || return $?
  assertEquals a "$(characterFromInteger "$(_code assert)")" || return $?
}

testPrintfOutput() {
  assertEquals "$(echo "ab" | printfOutputPrefix "c")" "cab" || return $?
  assertEquals "$(printf "" | printfOutputPrefix "c")" "" || return $?
  assertEquals "$(echo "ab" | printfOutputSuffix "c")" "ab"$'\n'"c" || return $?
  assertEquals "$(printf "" | printfOutputSuffix "c")" "" || return $?
}

testUnquote() {
  __testUnquoteData | while read -r quote quoted unquoted; do
    assertEquals "$(unquote "$quote" "$quoted")" "$unquoted" --message "unquote \"$quote\" \"$quoted\"" || return $?
  done
}

__testUnquoteData() {
  cat <<'EOF'
' 'Hello' Hello
' 'Hello 'Hello
' Hello' Hello'
" "Hello" Hello
" "Hello "Hello
" Hello" Hello"
" "12345"""67890" 12345"""67890
boo booLoveboo Love
EOF
}

__dataQuoteGrepPattern() {
  cat <<'EOF'
# This is a quote (hello)^# This is a quote (hello)
This | or | that.^This \| or \| that\.
[Bob]^\[Bob\]
\.*+?^\\.*+?
\"quotes\"^\\"quotes\\"
EOF
}

testQuoteGrepPattern() {
  local usage="_return"

  temp=$(fileTemporaryName "$usage") || return $?

  local value mappedValue
  while IFS='^' read -r text expected; do
    assertEquals "$expected" "$(quoteGrepPattern "$text")" || return $?
    printf "%s\n" "$text" >"$temp"
    assertExitCode 0 grep -q -e "$(quoteGrepPattern "$text")" <"$temp" || return $?
  done < <(__dataQuoteGrepPattern)

  __catchEnvironment "$usage" rm -rf "$temp" || return $?
}
