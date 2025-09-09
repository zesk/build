#!/usr/bin/env bash
#
# identical-tests.sh
#
# identical tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testIdenticalCheckHelpKeepsWords() {
  __mockValue BUILD_DEBUG

  export BUILD_DEBUG
  BUILD_DEBUG=

  assertExitCode --stdout-match '# IDENTICAL' 0 identicalCheck --help || return $?

  __mockValueStop BUILD_DEBUG
}

testIdenticalEofWithBracket() {
  local handler="_return"
  local temp home

  home=$(__environment buildHome) || return $?
  temp=$(fileTemporaryName "$handler" -d) || return $?
  __environment cp -R "$home/test/example/similar" "$temp/similar" || return $?
  assertDirectoryExists "$temp/similar" "$temp/similar/fix" || return $?
  assertExitCode 0 identicalCheck --repair "$temp/similar/fix" --prefix '# ''IDENTICAL' --extension txt --cd "$temp/similar" || return $?
  assertFileContains "$temp/similar/eofbug-target.txt" "}" || return $?

  __catch "$handler" rm -rf "$temp" || return $?
}

testIdenticalCheckAndRepairMap() {
  local handler="_return"
  local testPath home name

  home=$(__environment buildHome) || return $?
  testPath=$(fileTemporaryName "$handler" -d) || return $?
  decorate info "HOME is $home"
  decorate info "testPath is $testPath"
  __environment mkdir -p "$testPath/identical" || return $?
  __environment mkdir -p "$testPath/tests" || return $?
  __environment mkdir -p "$testPath/alternate" || return $?
  __environment cp "$home/test/example/repair.txt" "$testPath/identical" || return $?
  for name in dog cat bird forest snake duck leopard; do
    __environment cp "$home/test/example/repair-target.txt" "$testPath/tests/$name.txt" || return $?
    __environment cp "$home/test/example/repair-target.txt" "$testPath/alternate/$name.txt" || return $?
  done

  assertExitCode --stderr-ok 0 identicalCheck --cd "$testPath" --repair "$testPath/identical" --extension "txt" --prefix '-- IDENTICAL' || return $?

  for name in dog cat bird forest snake duck leopard; do
    assertFileDoesNotContain "$testPath/tests/$name.txt" __EXTENSION__ __FILE__ __DIRECTORY__ __BASE__ || return $?
    assertFileDoesNotContain "$testPath/alternate/$name.txt" __EXTENSION__ __FILE__ __DIRECTORY__ __BASE__ || return $?
    assertFileContains "$testPath/tests/$name.txt" "- EXTENSION txt" || return $?
    assertFileContains "$testPath/tests/$name.txt" "- DIRECTORY" "tests/" || return $?
    assertFileContains "$testPath/tests/$name.txt" "- FILE" "tests/$name.txt" || return $?
    assertFileContains "$testPath/tests/$name.txt" "- BASE $name.txt" || return $?
    assertFileContains "$testPath/alternate/$name.txt" "- EXTENSION txt" || return $?
    assertFileContains "$testPath/alternate/$name.txt" "- DIRECTORY" "alternate/" || return $?
    assertFileContains "$testPath/alternate/$name.txt" "- FILE" "alternate/$name.txt" || return $?
    assertFileContains "$testPath/alternate/$name.txt" "- BASE $name.txt" || return $?
  done

  __catch "$handler" rm -rf "$testPath" || return $?
}

testIdenticalRepair() {
  local handler="_return"

  local home
  home=$(__catch "$handler" buildHome) || return $?

  local output source token target expectedTarget testPath prefix

  testPath="$home/test/example"

  for token in eoftarget foetarget maptarget; do
    prefix="${token%target}"
    source="$testPath/identical-$prefix-source.txt"
    target="$testPath/identical-$prefix-target.txt"
    output="$testPath/ACTUAL-$token-$(basename "$target")"
    expectedTarget="$testPath/$token-$(basename "$target")"
    assertFileExists "$expectedTarget" || return $?
    __environment cp "$target" "$output" || return $?
    assertExitCode 0 identicalRepair --prefix '# ''IDENTICAL' --token "$token" "$source" "$output" || r eturn $?
    assertExitCode 0 diff "$output" "$expectedTarget" || return $?
    assertFileDoesNotContain "$output" EOF || return $?
    rm "$output" || :
  done

  source="$testPath/identical-source.txt"
  target="$testPath/identical-target.txt"
  for token in testToken test10; do
    output="$testPath/ACTUAL-$token-$(basename "$target")"
    expectedTarget="$testPath/$token-$(basename "$target")"
    assertFileExists "$expectedTarget" || return $?
    __environment cp "$target" "$output" || return $?
    assertExitCode 0 identicalRepair --prefix '# ''SAME-SAME' --token "$token" "$source" "$output" || return $?
    assertExitCode 0 diff "$output" "$(dirname "$target")/$token-$(basename "$target")" || return $?
    rm "$output" || :
  done
}

testIdenticalLineParsing() {
  local handler="_return"

  assertEquals "$(__identicalLineParse "$handler" foo '<!-- IDENTICAL' '3:<!-- IDENTICAL header 4 5 -->')" "3 header 1" || return $?
  assertEquals "$(__identicalLineParse "$handler" foo '<!-- IDENTICAL' '3:<!-- IDENTICAL header 4 FOO -->')" "3 header 4" || return $?
  assertEquals "$(__identicalLineParse "$handler" foo '<!-- IDENTICAL' '31:<!-- IDENTICAL header 2 -->')" "31 header 2" || return $?
}

# Tag: slow
testIdenticalChecks() {
  local handler="_return"
  local home

  home=$(__catch "$handler" buildHome) || return $?
  local identicalCheckArgs identicalError

  identicalError=$(returnCode identical)
  identicalCheckArgs=(--cd "$home/test/example" --extension 'txt')

  clearLine && decorate info "same file match"
  assertExitCode --stdout-match Verified 0 identicalCheck "${identicalCheckArgs[@]}" --prefix '# eIDENTICAL' || return $?

  clearLine && decorate info "same file mismatch"
  assertExitCode --stderr-match 'Token code changed' "$identicalError" identicalCheck "${identicalCheckArgs[@]}" --prefix '# fIDENTICAL' || return $?

  clearLine && decorate info "overlap failure"
  assertExitCode --stderr-match 'overlap' "$identicalError" identicalCheck "${identicalCheckArgs[@]}" --prefix '# aIDENTICAL' || return $?

  clearLine && decorate info "bad number failure"
  assertExitCode --stderr-match 'Invalid token count: NAN' "$identicalError" identicalCheck "${identicalCheckArgs[@]}" --prefix '# bIDENTICAL' || return $?

  clearLine && decorate info "single instance failure"
  assertExitCode --stderr-match 'Single token' "$identicalError" identicalCheck "${identicalCheckArgs[@]}" --prefix '# cIDENTICAL' || return $?
  assertExitCode --stderr-match 'Single token' "$identicalError" identicalCheck "${identicalCheckArgs[@]}" --prefix '# xIDENTICAL' || return $?

  clearLine && decorate info "$(pwd) passing 3 files"
  assertExitCode 0 identicalCheck "${identicalCheckArgs[@]}" --prefix '# dIDENTICAL' || return $?

  clearLine && decorate info "slash slash"
  assertExitCode --stderr-match 'Token code changed' "$identicalError" identicalCheck "${identicalCheckArgs[@]}" --prefix '// Alternate heading is identical' || return $?

  clearLine && decorate info "slash slash prefix mismatch is OK"
  assertExitCode 0 identicalCheck "${identicalCheckArgs[@]}" --prefix '// IDENTICAL' || return $?

  clearLine && decorate info "case match"
  assertExitCode 0 identicalCheck "${identicalCheckArgs[@]}" --prefix '// Identical' || return $?

  assertNotExitCode --stderr-match overlap 0 identicalCheck "${identicalCheckArgs[@]}" --prefix '# OVERLAP_IDENTICAL' || return $?
}

testIdenticalCheckSingles() {
  local handler="_return"
  local identicalCheckArgs identicalError singles

  local home
  home=$(__catch "$handler" buildHome) || return $?

  identicalError=$(returnCode identical)

  assertEquals 105 "$identicalError" || return $?

  export BUILD_DEBUG

  __mockValue BUILD_DEBUG

  # BUILD_DEBUG=temp - logs all fileTemporaryName calls and stack to app root

  #
  # Unusual quoting here is to avoid matching the word uh, IDENTICAL with the comment here
  #
  identicalCheckArgs=(--cd "$home/test/example" --extension 'txt' --prefix '# ''singleIDENTICAL')

  singles=()
  assertExitCode --stderr-match single1 --stderr-match single2 "$identicalError" identicalCheck "${identicalCheckArgs[@]}" "${singles[@]+"${singles[@]}"}" || return $?

  singles=(--single single1)
  assertExitCode --stderr-no-match single1 --stderr-match single2 "$identicalError" identicalCheck "${identicalCheckArgs[@]}" "${singles[@]+"${singles[@]}"}" || return $?

  singles=(--single single1 --single single2)
  assertExitCode "0" identicalCheck "${identicalCheckArgs[@]}" "${singles[@]+"${singles[@]}"}" || return $?

  __mockValueStop BUILD_DEBUG
}

# Simple case when an identical directory exists and is supplied but contains no matching files
testIdenticalCheckRepairWithEmptyDir() {
  local handler="_return"
  local temp

  temp=$(fileTemporaryName "$handler" -d) || return $?

  mkdir -p "$temp/foo/identical/"
  mkdir -p "$temp/bar/identical/"
  touch "$temp/hey.sh"
  assertExitCode 0 identicalCheck --cd "$temp" --repair "$temp/foo/identical/" --repair "$temp/bar/identical/" --prefix '# ''IDENTICAL' --extension sh || return $?

  __catch "$handler" rm -rf "$temp" || return $?
}

# Test identical EOF problem
#
# Treats an issue where when the replacement and the last line is a } right afterwards it gets stripped
#  ❌  assertFileContains Line 229: /root/.cache/.build/testSuite.513745/T/tmp.zcrEyCT4zl/2.txt does not contain string: }
#  /root/.cache/.build/testSuite.513745/T/tmp.zcrEyCT4zl/2.txt: 6 lines, 156 bytes (shown)
#  ===================================================================================================================================================================================
#  🐞 88eee1f9776549bd106bc41b2b303df7535bfafd
#  🐞 64448df376a00174610e1b629b413842ac30ca85
#  🐞 9140f0164d777926a5d43ac5ff7a81cf5e033976
#  🐞 {
#  🐞 # IDENTICAL foo 1
#  🐞 HELLO, WORLD
#
testIdenticalThingEOFProblem() {
  local handler="_return"

  local temp name="${FUNCNAME[0]}"

  temp=$(fileTemporaryName "$handler" -d) || return $?

  __catch "$handler" mkdir -p "$temp/identical/" || return $?

  printf "%s\n" "# IDENTICAL foo 1" "HELLO, WORLD" "" "" >"$temp/identical/master.txt"
  printf "%s\n" "$(randomString)" "$(randomString)" "$(randomString)" "" "# IDENTICAL foo 1" "Hello, WORLD" "" "" >"$temp/$(incrementor 0 "$name").txt"
  printf "%s\n" "$(randomString)" "$(randomString)" "$(randomString)" "{" "    # IDENTICAL foo 1" "    Hello, WORLD" "}" "" >"$temp/$(incrementor "$name").txt"
  printf "%s\n" "$(randomString)" "$(randomString)" "$(randomString)" "{" "    # IDENTICAL foo 1" "    Hello, WORLD" "}" >"$temp/$(incrementor "$name").txt"
  printf "%s\n" "$(randomString)" "$(randomString)" "$(randomString)" "{" "    # IDENTICAL foo 1" "    Hello, WORLD" "}" >"$temp/$(incrementor "$name").txt"
  local newline=$'\n'
  printf "%s" "$(randomString)$newline" "$(randomString)$newline" "$(randomString)$newline" "{$newline" "    # IDENTICAL foo 1$newline" "    HELLO, WORLD$newline" "}" >"$temp/$(incrementor "$name").txt"

  __catch "$handler" identicalCheck --cd "$temp" --repair "$temp/identical" --extension 'txt' --prefix '# IDENTICAL' || return $?

  assertFileContains "$temp/0.txt" "HELLO, WORLD" "# IDENTICAL foo 1" || return $?
  assertFileDoesNotContain "$temp/0.txt" "{" "}" || return $?

  assertFileContains "$temp/1.txt" "HELLO, WORLD" "# IDENTICAL foo 1" "{" "}" || return $?
  assertFileContains "$temp/2.txt" "HELLO, WORLD" "# IDENTICAL foo 1" "{" "}" || return $?
  assertFileContains "$temp/3.txt" "HELLO, WORLD" "# IDENTICAL foo 1" "{" "}" || return $?
  assertFileContains "$temp/4.txt" "HELLO, WORLD" "# IDENTICAL foo 1" "{" "}" || return $?

  __catchEnvironment "$handler" rm -rf "$temp" || return $?
}
