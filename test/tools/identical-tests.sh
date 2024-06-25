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

tests+=(testIdenticalChecks)
testIdenticalChecks() {
  local identicalCheckArgs

  identicalCheckArgs=(--cd "test/example" --extension 'txt')

  consoleInfo "same file match"
  assertOutputDoesNotContain --stderr 'Token code changed' ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '# eIDENTICAL' || return $?

  consoleInfo "same file mismatch"
  assertOutputContains --stderr --exit 100 'Token code changed' ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '# fIDENTICAL' || return $?

  consoleInfo "overlap failure"
  assertOutputContains --stderr --exit 100 'overlap' ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '# aIDENTICAL' || return $?

  consoleInfo "bad number failure"
  assertOutputContains --stderr --exit 100 'counts do not match' ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '# bIDENTICAL' || return $?

  consoleInfo "single instance failure"
  assertOutputContains --stderr --exit 100 'Single instance of token found:' ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '# cIDENTICAL' || return $?
  assertOutputContains --stderr --exit 100 'Single instance of token found:' ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '# xIDENTICAL' || return $?

  consoleInfo "passing 3 files"
  assertExitCode 0 ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '# dIDENTICAL' || return $?

  consoleInfo "slash slash"
  assertOutputContains --stderr --exit 100 'Token code changed' ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '// Alternate heading is identical ' || return $?

  consoleInfo "slash slash prefix mismatch is OK"
  assertExitCode 0 ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '// IDENTICAL' || return $?

  consoleInfo "case match"
  assertExitCode 0 ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '// Identical' || return $?

  assertNotExitCode --stderr-match overlap 0 identicalCheck "${identicalCheckArgs[@]}" --prefix '# OVERLAP_IDENTICAL' || return $?
}

tests+=(testIdenticalRepair)
testIdenticalRepair() {
  local output source token

  source="test/example/identical-source.txt"
  target="test/example/identical-target.txt"
  for token in testToken test10; do
    output="$(dirname $target)/ACTUAL-$token-$(basename $target)"
    __environment identicalRepair --stdout --prefix '# ''SAME-SAME' "$token" "$source" "$target" >"$output" || return $?
    assertExitCode --dump 0 diff "$output" "$(dirname $target)/$token-$(basename $target)" || return $?
    rm -rf "$output"
  done
}

tests+=(testIdenticalCheck)
testIdenticalCheck() {
  #
  # Unusual quoting here is to avoid matching the word uh, IDENTICAL with the comment here
  #

  local single singles
  singles=()
  while read -r single; do
    single="${single#"${single%%[![:space:]]*}"}"
    single="${single%"${single##*[![:space:]]}"}"
    if [ "${single###}" = "${single}" ]; then
      singles+=(--single "$single")
    fi
  done <./etc/identical-check-singles.txt

  # shellcheck disable=SC2059
  printf "SINGLES: $(consoleCode "%s")\n" "${singles[@]}"
  identicalCheck "${singles[@]+"${singles[@]}"}" --extension sh --prefix '# ''IDENTICAL' || return $?
}
