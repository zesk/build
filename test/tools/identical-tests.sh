#!/usr/bin/env bash
#
# identical-tests.sh
#
# identical tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

declare -a tests

tests+=(testIdenticalRepair)
tests+=(testIdenticalCheckSingles)
tests+=(testIdenticalLineParsing)
tests+=(testIdenticalChecks)

testIdenticalRepair() {
  local output source token target expectedTarget testPath prefix

  testPath="test/example"

  for token in eoftarget foetarget; do
    prefix="${token%target}"
    source="$testPath/identical-$prefix-source.txt"
    target="$testPath/identical-$prefix-target.txt"
    output="$testPath/ACTUAL-$token-$(basename "$target")"
    expectedTarget="$testPath/$token-$(basename "$target")"
    assertFileExists "$expectedTarget" || return $?
    __environment cp "$target" "$output" || return $?
    assertExitCode 0 identicalRepair --prefix '# ''IDENTICAL' "$token" "$source" "$output" || return $?
    assertExitCode --dump 0 diff "$output" "$expectedTarget" || return $?
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
    assertExitCode 0 identicalRepair --prefix '# ''SAME-SAME' "$token" "$source" "$output" || return $?
    assertExitCode --dump 0 diff "$output" "$(dirname $target)/$token-$(basename $target)" || return $?
    rm "$output" || :
  done

}

testIdenticalLineParsing() {
  assertEquals "$(__identicalLineParse foo '<!-- IDENTICAL' '3:<!-- IDENTICAL header 4 5 -->')" "3 header 1" || return $?
  assertEquals "$(__identicalLineParse foo '<!-- IDENTICAL' '3:<!-- IDENTICAL header 4 FOO -->')" "3 header 4" || return $?
  assertEquals "$(__identicalLineParse foo '<!-- IDENTICAL' '31:<!-- IDENTICAL header 2 -->')" "31 header 2" || return $?
}

testIdenticalChecks() {
  local identicalCheckArgs identicalError

  identicalError=$(_code identical)
  identicalCheckArgs=(--cd "test/example" --extension 'txt')

  clearLine && consoleInfo "same file match"
  assertExitCode --line "$LINENO" --stdout-match Verified 0 identicalCheck "${identicalCheckArgs[@]}" --prefix '# eIDENTICAL' || return $?

  clearLine && consoleInfo "same file mismatch"
  identicalCheck "${identicalCheckArgs[@]}" --prefix '# fIDENTICAL'
  echo "Exit code: $?"
  assertExitCode --dump --line "$LINENO" --stderr-match 'Token code changed' "$identicalError" identicalCheck "${identicalCheckArgs[@]}" --prefix '# fIDENTICAL' || return $?

  clearLine && consoleInfo "overlap failure"
  assertOutputContains --line "$LINENO" --stderr --exit "$identicalError" 'overlap' identicalCheck "${identicalCheckArgs[@]}" --prefix '# aIDENTICAL' || return $?

  clearLine && consoleInfo "bad number failure"
  assertOutputContains --line "$LINENO" --stderr --exit "$identicalError" 'invalid count: NAN' identicalCheck "${identicalCheckArgs[@]}" --prefix '# bIDENTICAL' || return $?

  clearLine && consoleInfo "single instance failure"
  assertOutputContains --line "$LINENO" --stderr --exit "$identicalError" 'Single instance of token found:' identicalCheck "${identicalCheckArgs[@]}" --prefix '# cIDENTICAL' || return $?
  assertOutputContains --line "$LINENO" --stderr --exit "$identicalError" 'Single instance of token found:' identicalCheck "${identicalCheckArgs[@]}" --prefix '# xIDENTICAL' || return $?

  clearLine && consoleInfo "$(pwd) passing 3 files"
  assertExitCode --line "$LINENO" --dump 0 identicalCheck "${identicalCheckArgs[@]}" --prefix '# dIDENTICAL' || return $?

  clearLine && consoleInfo "slash slash"
  assertOutputContains --line "$LINENO" --stderr --exit "$identicalError" 'Token code changed' identicalCheck "${identicalCheckArgs[@]}" --prefix '// Alternate heading is identical ' || return $?

  clearLine && consoleInfo "slash slash prefix mismatch is OK"
  assertExitCode --line "$LINENO" 0 identicalCheck "${identicalCheckArgs[@]}" --prefix '// IDENTICAL' || return $?

  clearLine && consoleInfo "case match"
  assertExitCode --line "$LINENO" 0 identicalCheck "${identicalCheckArgs[@]}" --prefix '// Identical' || return $?

  assertNotExitCode --dump --line "$LINENO" --stderr-match overlap 0 identicalCheck "${identicalCheckArgs[@]}" --prefix '# OVERLAP_IDENTICAL' || return $?
}

testIdenticalCheckSingles() {
  local identicalCheckArgs identicalError singles

  identicalError=$(_code identical)
  identicalCheckArgs=(--cd "test/example" --extension 'txt')
  #
  # Unusual quoting here is to avoid matching the word uh, IDENTICAL with the comment here
  #
  identicalCheckArgs=(--cd "test/example" --extension 'txt')

  singles=()
  assertExitCode --stderr-match single1 --stderr-match single2 "$identicalError" --line "$LINENO" identicalCheck "${singles[@]+"${singles[@]}"}" --extension txt --prefix '# ''singleIDENTICAL' || return $?

  singles=(--single single1)
  assertExitCode --stderr-no-match single1 --stderr-match single2 "$identicalError" --line "$LINENO" identicalCheck "${singles[@]+"${singles[@]}"}" --extension txt --prefix '# ''singleIDENTICAL' || return $?

  singles=(--single single1 --single single2)
  assertExitCode "0" --line "$LINENO" identicalCheck "${singles[@]+"${singles[@]}"}" --extension txt --prefix '# ''singleIDENTICAL' || return $?
}
