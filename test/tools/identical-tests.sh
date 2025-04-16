#!/usr/bin/env bash
#
# identical-tests.sh
#
# identical tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testIdenticalEofWithBracket() {
  local temp home

  home=$(__environment buildHome) || return $?
  temp=$(__environment mktemp -d) || return $?
  __environment cp -R "$home/test/example/similar" "$temp/similar" || return $?
  assertDirectoryExists "$temp/similar" "$temp/similar/fix" || return $?
  assertExitCode 0 identicalCheck --repair "$temp/similar/fix" --prefix '# ''IDENTICAL' --extension txt --cd "$temp/similar" || return $?
  assertFileContains "$temp/similar/eofbug-target.txt" "}" || return $?
}

testIdenticalCheckAndRepairMap() {
  local testPath home name


  home=$(__environment buildHome) || return $?
  testPath=$(__environment mktemp -d) || return $?
  decorate info "HOME is $home"
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
}

testIdenticalRepair() {
  local output source token target expectedTarget testPath prefix

  testPath="test/example"

  for token in eoftarget foetarget maptarget; do
    prefix="${token%target}"
    source="$testPath/identical-$prefix-source.txt"
    target="$testPath/identical-$prefix-target.txt"
    output="$testPath/ACTUAL-$token-$(basename "$target")"
    expectedTarget="$testPath/$token-$(basename "$target")"
    assertFileExists "$expectedTarget" || return $?
    __environment cp "$target" "$output" || return $?
    assertExitCode 0 identicalRepair --prefix '# ''IDENTICAL' --token "$token" "$source" "$output" || return $?
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
    assertExitCode 0 diff "$output" "$(dirname $target)/$token-$(basename $target)" || return $?
    rm "$output" || :
  done
}

testIdenticalLineParsing() {
  assertEquals "$(__identicalLineParse foo '<!-- IDENTICAL' '3:<!-- IDENTICAL header 4 5 -->')" "3 header 1" || return $?
  assertEquals "$(__identicalLineParse foo '<!-- IDENTICAL' '3:<!-- IDENTICAL header 4 FOO -->')" "3 header 4" || return $?
  assertEquals "$(__identicalLineParse foo '<!-- IDENTICAL' '31:<!-- IDENTICAL header 2 -->')" "31 header 2" || return $?
}

# Tag: slow
testIdenticalChecks() {
  local identicalCheckArgs identicalError

  identicalError=$(_code identical)
  identicalCheckArgs=(--cd "test/example" --extension 'txt')

  clearLine && decorate info "same file match"
  assertExitCode --stdout-match Verified 0 identicalCheck "${identicalCheckArgs[@]}" --prefix '# eIDENTICAL' || return $?

  clearLine && decorate info "same file mismatch"
  assertExitCode --dump --stderr-match 'Token code changed' "$identicalError" identicalCheck "${identicalCheckArgs[@]}" --prefix '# fIDENTICAL' || return $?

  clearLine && decorate info "overlap failure"
  assertExitCode --stderr-match 'overlap' "$identicalError" identicalCheck "${identicalCheckArgs[@]}" --prefix '# aIDENTICAL' || return $?

  clearLine && decorate info "bad number failure"
  assertExitCode --stderr-match 'invalid count: NAN' "$identicalError" identicalCheck "${identicalCheckArgs[@]}" --prefix '# bIDENTICAL' || return $?

  clearLine && decorate info "single instance failure"
  assertExitCode --stderr-match 'Single token' "$identicalError" identicalCheck "${identicalCheckArgs[@]}" --prefix '# cIDENTICAL' || return $?
  assertExitCode --stderr-match 'Single token' "$identicalError" identicalCheck "${identicalCheckArgs[@]}" --prefix '# xIDENTICAL' || return $?

  clearLine && decorate info "$(pwd) passing 3 files"
  assertExitCode --dump 0 identicalCheck "${identicalCheckArgs[@]}" --prefix '# dIDENTICAL' || return $?

  clearLine && decorate info "slash slash"
  assertExitCode --stderr-match 'Token code changed' "$identicalError" identicalCheck "${identicalCheckArgs[@]}" --prefix '// Alternate heading is identical ' || return $?

  clearLine && decorate info "slash slash prefix mismatch is OK"
  assertExitCode 0 identicalCheck "${identicalCheckArgs[@]}" --prefix '// IDENTICAL' || return $?

  clearLine && decorate info "case match"
  assertExitCode 0 identicalCheck "${identicalCheckArgs[@]}" --prefix '// Identical' || return $?

  assertNotExitCode --dump --stderr-match overlap 0 identicalCheck "${identicalCheckArgs[@]}" --prefix '# OVERLAP_IDENTICAL' || return $?
}

testIdenticalCheckSingles() {
  local identicalCheckArgs identicalError singles

  identicalError=$(_code identical)

  assertEquals 105 "$identicalError" || return $?

  #
  # Unusual quoting here is to avoid matching the word uh, IDENTICAL with the comment here
  #
  identicalCheckArgs=(--cd "test/example" --extension 'txt' --prefix '# ''singleIDENTICAL')

  singles=()
  assertExitCode --stderr-match single1 --stderr-match single2 "$identicalError" identicalCheck "${identicalCheckArgs[@]}" "${singles[@]+"${singles[@]}"}" || return $?

  singles=(--single single1)
  assertExitCode --stderr-no-match single1 --stderr-match single2 "$identicalError" identicalCheck "${identicalCheckArgs[@]}" "${singles[@]+"${singles[@]}"}" || return $?

  singles=(--single single1 --single single2)
  assertExitCode "0" identicalCheck "${singles[@]+"${singles[@]}"}" --extension txt --prefix '# ''singleIDENTICAL' || return $?
}

# Simple case when an identical directory exists and is supplied but contains no matching files
testIdenticalCheckRepairWithEmptyDir() {
  local temp

  temp=$(__environment mktemp -d) || return $?

  mkdir -p "$temp/foo/identical/"
  mkdir -p "$temp/bar/identical/"
  touch "$temp/hey.sh"
  assertExitCode 0 identicalCheck --cd "$temp" --repair "$temp/foo/identical/" --repair "$temp/bar/identical/" --prefix '# ''IDENTICAL' --extension sh || return $?
}
