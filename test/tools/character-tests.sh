#!/usr/bin/env bash
#
# character-tests.sh
#
# character tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

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
  local temp home handler="returnMessage"

  home=$(catchReturn "$handler" buildHome) || return $?
  temp=$(fileTemporaryName "$handler") || return $?
  __testIsCharacterClass | tee "$temp" || return $?
  if ! diff -q "$temp" "$home/test/example/isCharacterClass.txt"; then
    decorate error "Classifications changed:"
    diff "$temp" "$home/test/example/isCharacterClass.txt"
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
  assertEquals l "$(characterFromInteger "$(returnCode leak)")" || return $?
  assertEquals a "$(characterFromInteger "$(returnCode assert)")" || return $?
}

# Tag: slow-non-critical slow
testCharacterClassReport() {
  characterClassReport --class
  characterClassReport --char
}

testCharacterClasses() {
  assertOutputContains alpha characterClasses || return $?
  assertOutputContains xdigit characterClasses || return $?
}

testIsCharacterClass() {
  local className
  while read -r className; do
    assertExitCode 0 isCharacterClass "$className" || return $?
  done < <(characterClasses)
}
