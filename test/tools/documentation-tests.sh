#!/usr/bin/env bash
#
# documentation-tests.sh
#
# documentation.sh tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testBashFunctionComment() {
  local handler="_return"
  local home
  local matches=(
    --stdout-match "Stop watching changes"
    --stdout-match "--help"
    --stdout-match "--source source"
    --stdout-match "--name name"
  )

  home=$(__catch "$handler" buildHome) || return $?

  assertExitCode "${matches[@]}" 0 bashFunctionComment "$home/bin/build/tools/prompt/reload-changes.sh" reloadChanges || return $?
}

testDocumentation() {
  local testOutput
  local summary description
  local handler="_return"

  local home
  home=$(__catch "$handler" buildHome) || return $?

  testOutput=$(fileTemporaryName "$handler") || return $?
  assertExitCode 0 inArray "summary" summary usage argument example reviewed || return $?
  (
    bashDocumentation_Extract "$(bashDocumentation_FindFunctionDefinition "$home" assertNotEquals)" assertNotEquals >"$testOutput" || return $?
    set -a
    # shellcheck source=/dev/null
    source "$testOutput" > >(outputTrigger --name "$testOutput" --verbose) || return $?
    set +a
    assertEquals "Assert two strings are not equal"$'\n' "${summary}" || return $?
    assertEquals $'Assert two strings are not equal.\n\nIf this fails it will output an error and exit.\n' "${description}" || return $?

    bashDocumentation_Extract "$(bashDocumentation_FindFunctionDefinition "$home" assertEquals)" assertEquals >"$testOutput" || return $?
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
  ) || return $?
  __catchEnvironment "$handler" rm "$testOutput" || return $?
}

__isolateTest() {
  local testOutput="$1"
  local handler="_return"

  local home
  home=$(__catch "$handler" buildHome) || return $?

  bashDocumentation_Extract "$(bashDocumentation_FindFunctionDefinition "$home" assertNotEquals)" assertNotEquals >"$testOutput" || return $?
  set -a
  # shellcheck source=/dev/null
  source "$testOutput" > >(outputTrigger --name "$testOutput" --verbose) || return $?
  set +a
  assertEquals "Assert two strings are not equal"$'\n' "${summary}" || return $?
  assertEquals $'Assert two strings are not equal.\n\nIf this fails it will output an error and exit.\n\n' "${description}" || return $?

  bashDocumentation_Extract "$(bashDocumentation_FindFunctionDefinition "$home" assertEquals)" assertEquals >"$testOutput" || return $?
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
}

# Running testDocSections ...
# /tmp/tmp.cyPkWgkK5a: line 2: fg: no job control
# ✅ : assertFileContains Line 49: /tmp/tmp.nzr2txaaOC contains strings: ("No arguments" ) [5 seconds]
# /tmp/tmp.wRninBVNxi: line 2: fg: no job control
# ✅ : assertFileContains Line 52: /tmp/tmp.nzr2txaaOC contains strings: ("#### Arguments" "--help" ) [4 seconds]

testDocSections() {
  local handler="_return"
  local doc home

  home=$(__catch "$handler" buildHome) || return $?
  doc=$(fileTemporaryName "$handler") || return $?
  __environment bashDocumentFunction "$home/bin/build/tools/git.sh" gitMainly "$home/bin/build/tools/documentation/__function.md" >"$doc" || return $?
  assertFileContains "$doc" '- none' || return $?

  __environment bashDocumentFunction "$home/bin/build/tools/git.sh" gitCommit "$home/bin/build/tools/documentation/__function.md" >"$doc" || return $?
  assertFileContains "$doc" '### Arguments' '--help' || return $?
}
