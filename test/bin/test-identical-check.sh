#!/bin/bash
#
# Test identical-check.sh script
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

testIdenticalChecks() {

  identicalCheckArgs=(--cd test/example --extension 'txt')

  consoleInfo "same file match"
  assertOutputDoesNotContain --stderr 'Token code changed' ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '# eIDENTICAL' || return $?

  consoleInfo "same file mismatch"
  assertOutputContains --stderr --exit 100 'Token code changed' ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '# fIDENTICAL' || return $?

  consoleInfo "overlap failure"
  assertOutputContains --stderr --exit 100 'overlap' ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '# aIDENTICAL' || return $?

  consoleInfo "bad number failure"
  assertOutputContains --stderr --exit 100 'not a number' ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '# bIDENTICAL' || return $?
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

testIdenticalChecks
