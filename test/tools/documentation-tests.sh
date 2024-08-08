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
  assertExitCode 0 inArray "summary" summary usage argument example reviewed || return $?

  (
    bashDocumentation_Extract "$(bashDocumentation_FindFunctionDefinition . assertNotEquals)" assertNotEquals >"$testOutput" || return $?
    set -a
    # shellcheck source=/dev/null
    source "$testOutput" > >(outputTrigger --name "$testOutput" --verbose) || return $?
    set +a
    assertEquals "Assert two strings are not equal"$'\n' "${summary}" || return $?
    assertEquals $'Assert two strings are not equal.\n\nIf this fails it will output an error and exit.\n\n' "${description}" || return $?

    bashDocumentation_Extract "$(bashDocumentation_FindFunctionDefinition . assertEquals)" assertEquals >"$testOutput" || return $?
    set -a
    # shellcheck source=/dev/null
    source "$testOutput" > >(outputTrigger --name "$testOutput" --verbose) || return $?
    set +a
    echoBar '='
    assertEquals $'Assert two strings are equal.\n\nIf this fails it will output an error and exit.\n\n\n' "${description}" || return $?
    echoBar -
    desc=($'Well, Assert two strings are equal.' '' 'If this fails it will output an error and exit.')
    assertEquals "Well, Assert two strings are equal." "$(trimWords 10 "${desc[0]}")" || return $?
    echoBar '='
    assertEquals $'Assert two strings are equal.\n' "${summary}" || return $?

    rm "$testOutput" || :
  ) || _environment "subshell failed" || return $?
}

tests+=(testDocSections)
testDocSections() {
  local doc

  doc=$(__environment mktemp) || return $?
  __environment bashDocumentFunction bin/build/tools/git.sh gitMainly bin/build/tools/documentation/__function.md >"$doc" || return $?
  assertFileContains --line "$LINENO" "$doc" 'No arguments' || return $?

  __environment bashDocumentFunction bin/build/tools/git.sh gitCommit bin/build/tools/documentation/__function.md >"$doc" || return $?
  assertFileContains --line "$LINENO" "$doc" '#### Arguments' '--help' || return $?
}
