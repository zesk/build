#!/usr/bin/env bash
#
# documentation-tests.sh
#
# documentation.sh tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

declare -a tests
tests+=(testDocumentation)
testDocumentation() {
  local testOutput
  local summary description

  testOutput=$(mktemp)
  assertExitCode 0 inArray "summary" summary usage argument example reviewed

  bashDocumentation_Extract "$(bashDocumentation_FindFunctionDefinition . assertNotEquals)" assertNotEquals >"$testOutput" || return $?
  set -a
  # shellcheck source=/dev/null
  . "$testOutput"
  set +a
  assertEquals "Assert two strings are not equal" "${summary}" || return $?
  assertEquals $'Assert two strings are not equal.\n\nIf this fails it will output an error and exit.' "${description}" || return $?

  bashDocumentation_Extract "$(bashDocumentation_FindFunctionDefinition . assertEquals)" assertEquals >"$testOutput" || return $?
  set -a
  # shellcheck source=/dev/null
  . "$testOutput" || return $?
  set +a
  assertEquals $'Assert two strings are equal.\n\nIf this fails it will output an error and exit.' "${description}" || return $?
  desc=($'Well, Assert two strings are equal.' '' 'If this fails it will output an error and exit.')
  assertEquals "Well, Assert two strings are equal." "$(trimWords 10 "${desc[0]}")" || return $?
  assertEquals "Assert two strings are equal." "${summary}" || return $?

  rm "$testOutput"
}
