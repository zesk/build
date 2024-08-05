#!/usr/bin/env bash
#
# text-tests.sh
#
# Text tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

declare -a tests

tests+=(testTrimHeadTail)
tests+=(testSingleBlankLines)
tests+=(testText)
tests+=(testEscapeSingleQuotes)
tests+=(testEscapeDoubleQuotes)
tests+=(testSubstringFound)
tests+=(testIsSubstring)

testSubstringFound() {
  assertExitCode 0 substringFound haystack needle needle needle needle needle aystac needle || return $?
  assertExitCode 0 substringFound haystack needle needle needle needle needle haystac needle || return $?
  assertExitCode 0 substringFound haystack needle needle needle needle needle aystack needle || return $?
  assertNotExitCode 0 substringFound haystack needle needle needle needle needle Haystack needle || return $?
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
tests+=(testQuoteSedPattern)
testQuoteSedPattern() {
  local value mappedValue
  assertEquals --line "$LINENO" "\\&" "$(quoteSedPattern "&")" || return $?
  assertEquals --line "$LINENO" "\\[" "$(quoteSedPattern "[")" || return $?
  assertEquals --line "$LINENO" "\\]" "$(quoteSedPattern "]")" || return $?
  # shellcheck disable=SC1003
  assertEquals --line "$LINENO" '\\' "$(quoteSedPattern '\')" || return $?
  assertEquals --line "$LINENO" "\\/" "$(quoteSedPattern "/")" || return $?
  # Fails in code somewhere
  read -d"" -r value < <(__testQuoteSedPatternData)

  mappedValue="$(printf %s "{name}" | name=$value mapEnvironment)"
  assertEquals --line "$LINENO" "$mappedValue" "$value" || return $?
}

tests+=(testMapValue)
testMapValue() {
  local tempEnv

  tempEnv=$(__environment mktemp) || return $?

  assertEquals --line "$LINENO" "{foo}" "$(mapValue "$tempEnv" "{foo}")" || return $?

  printf "%s=%s\n" "foo" "bar" >>"$tempEnv"

  assertEquals --line "$LINENO" "bar" "$(mapValue "$tempEnv" "{foo}")" || return $?

  __environment rm "$tempEnv" || return $?
}

tests+=(testLowercase)
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

tests+=(testValidateCharacterClass)
testValidateCharacterClass() {
  local temp

  temp=$(mktemp) || return $?
  __testIsCharacterClass | tee "$temp" || return $?
  if ! diff -q "$temp" "./test/example/isCharacterClass.txt"; then
    consoleError "Classifications changed:"
    diff "$temp" "./test/example/isCharacterClass.txt"
    return 1
  fi
  rm "$temp" || :
}

tests+=(testStringValidate)
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

tests=(testListTokens "${tests[@]}")
testListTokens() {
  local COLUMNS LINES

  echo | assertExitCode 0 listTokens || return $?
  assertEquals "" "$(echo | listTokens)" || return $?
  assertEquals "$(printf "%s\n" a b c)" "$(echo '{a}{b}{c}' | listTokens)" || return $?
  assertEquals "$(printf "%s\n" confirmYesNo copyFileWouldChange copyFile 'args[@]' 'args[@]')" "$(listTokens <"./test/example/listTokensBad.md")" || return $?
}

tests+=(testCharacterFromInteger)
testCharacterFromInteger() {
  assertEquals l "$(characterFromInteger "$(_code leak)")" || return $?
  assertEquals a "$(characterFromInteger "$(_code assert)")" || return $?
}
