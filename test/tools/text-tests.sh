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
testTrimHeadTail() {
  local topSpace bottomSpace

  topSpace=$(printf "\n\n\n\n\n\n\nip")
  bottomSpace=$(printf "ip\n\n\n\n\n\n\n")

  assertEquals "$(printf "%s" "$topSpace" | trimHead)" "ip" || return $?
  assertEquals "$(printf "%s" "$topSpace" | trimTail)" "$topSpace" || return $?
  assertEquals "$(printf "%s" "$bottomSpace" | trimHead)" "$bottomSpace" || return $?
  assertEquals "$(printf "%s" "$bottomSpace" | trimTail)" "ip" || return $?
}

tests+=(testSingleBlankLines)
testSingleBlankLines() {
  local topSpace bottomSpace middleSpace

  topSpace=$(printf "\n\n\n\n\n\n\nip")
  bottomSpace=$(printf "ip\n\n\n\n\n\n\n")
  middleSpace=$(printf "\n\n\nip\n\n\n\n\n\n\n")

  assertEquals "$(printf "\nip")" "$(printf "%s\n" "$topSpace" | singleBlankLines)" || return $?
  assertEquals "$(printf "ip\n")" "$(printf "%s\n" "$bottomSpace" | singleBlankLines)" || return $?
  assertEquals "$(printf "\nip\n")" "$(printf "%s\n" "$middleSpace" | singleBlankLines)" || return $?
}

tests+=(testText)
testText() {
  assertOutputContains Hello boxedHeading Hello || return $?
}

tests+=(testEscapeSingleQuotes)
testEscapeSingleQuotes() {
  assertEquals "Ralph \"Dude\" Brown" "$(escapeSingleQuotes "Ralph \"Dude\" Brown")" || return $?
  # shellcheck disable=SC1003
  assertEquals 'Dude\'"'"'s place' "$(escapeSingleQuotes "Dude's place")" || return $?
}
testEscapeDoubleQuotes() {
  assertEquals "Ralph \\\"Dude\\\" Brown" "$(escapeDoubleQuotes "Ralph \"Dude\" Brown")" || return $?

  assertEquals "Dude's place" "$(escapeDoubleQuotes "Dude's place")" || return $?
}

tests+=(testQuoteSedPattern)
testQuoteSedPattern() {
  local value mappedValue
  assertEquals "\\&" "$(quoteSedPattern "&")" || return $?
  assertEquals "\\[" "$(quoteSedPattern "[")" || return $?
  assertEquals "\\]" "$(quoteSedPattern "]")" || return $?
  # shellcheck disable=SC1003
  assertEquals '\\' "$(quoteSedPattern '\')" || return $?
  assertEquals "\\/" "$(quoteSedPattern "/")" || return $?
  # Fails in code somewhere
  read -d"" -r value <<'EOF' || :
  __                  _   _
 / _|_   _ _ __   ___| |_(_) ___  _ __  ___
| |_| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
|  _| |_| | | | | (__| |_| | (_) | | | \__ \
|_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
EOF

  mappedValue="$(printf %s "{name}" | name=$value mapEnvironment)"
  assertEquals "$mappedValue" "$value" || return $?
}

tests+=(testMapValue)
testMapValue() {
  local tempEnv

  tempEnv=$(mktemp)

  assertEquals "{foo}" "$(mapValue "$tempEnv" "{foo}")" || return $?

  printf "%s=%s\n" "foo" "bar" >>"$tempEnv"

  assertEquals "bar" "$(mapValue "$tempEnv" "{foo}")" || return $?

  rm "$tempEnv"
}

tests+=(testLowercase)
testLowercase() {
  assertOutputEquals lowercase lowercase LoWerCaSe || return $?
}

_uptoDateTest() {
  local pass=$1

  shift
  if [ "$pass" = "1" ]; then
    if ! isUpToDate "$@"; then
      _environment "isUpToDate $* should be up to date" || return $?
    fi
  else
    if isUpToDate "$@"; then
      _environment  "isUpToDate $* should NOT be up to date" || return $?
    fi
  fi
}

tests+=(testIsUpToDate)
testIsUpToDate() {
  local thisYear thisMonth expirationDays start testDate

  start=$(beginTiming)
  testSection "isUpToDate testing"
  thisYear=$(($(date +%Y) + 0))
  thisMonth="$(date +%m)"
  _uptoDateTest 0 || return $?
  _uptoDateTest 0 "" || return $?
  _uptoDateTest 0 99999 || return $?

  testDate=2020-01-01

  consoleInfo "2020: $testDate"

  _uptoDateTest 0 $testDate 10 || return $?
  testDate="$thisYear-01-01"

  testSection "ThisYear-01-01: $testDate"

  expirationDays=367
  _uptoDateTest 0 "$testDate" "$expirationDays" || return $?
  expirationDays=366
  _uptoDateTest 1 "$testDate" "$expirationDays" || return $?
  expirationDays=365
  _uptoDateTest 1 "$testDate" "$expirationDays" || return $?

  testSection "ThisYear-ThisMonth-01: $testDate"

  testDate="$thisYear-$thisMonth-01"
  expirationDays=60

  _uptoDateTest 1 "$testDate" "$expirationDays" || return $?

  testDate=$(todayDate)

  testSection "todayDate: $testDate"

  expirationDays=0
  _uptoDateTest 1 "$testDate" "$expirationDays" || return $?
  expirationDays=1
  _uptoDateTest 1 "$testDate" "$expirationDays" || return $?
  expirationDays=2
  _uptoDateTest 1 "$testDate" "$expirationDays" || return $?

  testDate=$(yesterdayDate)

  testSection "yesterdayDate: $testDate"

  expirationDays=0
  _uptoDateTest 0 "$testDate" "$expirationDays" || return $?
  expirationDays=1
  _uptoDateTest 1 "$testDate" "$expirationDays" || return $?
  expirationDays=2
  _uptoDateTest 1 "$testDate" "$expirationDays" || return $?

  testDate=$(tomorrowDate)

  testSection "tomorrowDate: $testDate"

  expirationDays=0
  _uptoDateTest 1 "$testDate" "$expirationDays" || return $?
  expirationDays=1
  _uptoDateTest 1 "$testDate" "$expirationDays" || return $?
  expirationDays=2
  _uptoDateTest 1 "$testDate" "$expirationDays" || return $?

  reportTiming "$start" Done
}

tests+=(testIsCharacterClass)
testIsCharacterClass() {
  local first header c characters=(0 1 2 3 4 5 6 7 8 9 a b c d e f g h w x y z A B C D E F G W X Y Z ' ' '!' '%' "'" @ ^ - '=')
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
  testIsCharacterClass >"$temp" || return $?
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
