#!/usr/bin/env bash
#
# character-tests.sh
#
# character tests
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__testIsCharacterClass() {
  local first=true characters=(0 1 2 7 8 9 a b c x y z A B C X Y Z ' ' '!' '%' "'" @ ^ - '=')
  local line temp token firstColumnWidth=7

  local header
  header=$(listJoin " " "${characters[@]}")
  local class
  for class in alnum alpha ascii blank cntrl digit graph lower print punct space upper word xdigit; do
    local line=()
    local c
    for c in "${characters[@]}"; do
      if isCharacterClass "$class" "$c"; then
        token="Y"
      else
        #temp="$(repeat "${#temp}" " ")"
        token="."
      fi
      line+=("$token")
    done

    if $first; then
      printf "$(alignLeft "$firstColumnWidth" "class")| %s\n" "$header"
      printf "%s+%s\n" "$(repeat "$firstColumnWidth" "-")" "-$(repeat "${#header}" "-")"
      first=false
    fi
    printf "%s| %s\n" "$(alignLeft "$firstColumnWidth" "$class")" "${line[*]}"
  done
}

# Tag: slow
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

__dataIsCharacterClasses() {
  cat <<'EOF'
0|a|alpha|print|alnum
0|"|alpha|print
0|"|print|blank
0|"|punct|print
0|0|digit|alnum
0|0|digit|punct|alnum
1|0|punct|blank
1|"|blank|lower
EOF
}

testIsCharacterClasses() {
  local testRow=()
  while IFS="|" read -r -a testRow; do
    set -- "${testRow[@]}"
    local expected="$1" && shift
    assertExitCode "$expected" isCharacterClasses "$@" || return $?
  done < <(__dataIsCharacterClasses)
}
