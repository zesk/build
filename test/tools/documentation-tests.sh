#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# documentation-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testDocumentationIndexes() {
  local handler="returnMessage"
  local home

  home=$(catchReturn "$handler" buildHome) || return $?

  assertExitCode 0 markdownCheckIndex "$home/documentation/source/index.md" || return $?
  assertExitCode 0 markdownCheckIndex "$home/documentation/source/guide/index.md" || return $?
  assertExitCode 0 markdownCheckIndex "$home/documentation/source/tools/index.md" || return $?
  assertExitCode 0 markdownCheckIndex "$home/documentation/source/env/index.md" || return $?

}
testBashFunctionComment() {
  local handler="returnMessage"
  local home
  local matches=(
    --stdout-match "Prompts can be formatted"
    --stdout-match "--help"
    --stdout-match "--order order"
    --stdout-match "--skip-prompt"
  )

  home=$(catchReturn "$handler" buildHome) || return $?

  assertExitCode "${matches[@]}" 0 bashFunctionComment "$home/bin/build/tools/prompt.sh" bashPrompt || return $?
}

testDocumentation() {
  local testOutput
  local summary description
  local handler="returnMessage"

  # export BUILD_DEBUG="fast-usage,usage"
  local home
  home=$(catchReturn "$handler" buildHome) || return $?

  testOutput=$(fileTemporaryName "$handler") || return $?
  assertExitCode 0 inArray "summary" summary usage argument example reviewed || return $?
  (
    __documentationLoader returnMessage printf "" || return $?
    local fn

    fn="ass""ertNotEquals" # "" hides from findUncaughtAssertions
    bashDocumentationExtract "$fn" < <(bashFunctionComment "$(__bashDocumentation_FindFunctionDefinition "$home" "$fn")" "$fn") >"$testOutput" || return $?
    set -a # UNDO ok
    # shellcheck source=/dev/null
    source "$testOutput" > >(outputTrigger --name "$testOutput" --verbose) || return $?
    set +a
    assertEquals "Assert two strings are not equal"$'\n' "${summary}" || return $?
    assertEquals $'Assert two strings are not equal.\n\nIf this fails it will output an error and exit.\n' "${description}" || return $?

    fn="ass""ertEquals" # "" hides from findUncaughtAssertions
    bashDocumentationExtract "$fn" < <(bashFunctionComment "$(__bashDocumentation_FindFunctionDefinition "$home" "$fn")" "$fn") >"$testOutput" || return $?
    set -a # UNDO ok
    # shellcheck source=/dev/null
    source "$testOutput" > >(outputTrigger --name "$testOutput" --verbose) || return $?
    set +a
    echoBar '='
    assertEquals $'Assert two strings are equal.\n\nIf this fails it will output an error and exit.\n\n\n' "${description}" || return $?
    echoBar -
    desc=($'Well, Assert two strings are equal.' '' 'If this fails it will output an error and exit.')
    assertEquals "Well, Assert two strings are equal." "$(trimWords 10 "${desc[0]}")" || return $?
    echoBar '='
    assertEquals "Assert two strings are equal." "${summary}" || return $?
  ) || return $?
  catchEnvironment "$handler" rm "$testOutput" || return $?
}

__isolateTest() {
  local testOutput="$1"
  local handler="returnMessage"

  local home
  home=$(catchReturn "$handler" buildHome) || return $?
  local fn

  fn="ass""ertNotEquals" # "" hides from findUncaughtAssertions

  bashDocumentationExtract "$fn" < <(bashFunctionComment "$(__bashDocumentation_FindFunctionDefinition "$home" "$fn")" "$fn") >"$testOutput" || return $?
  set -a # UNDO ok
  # shellcheck source=/dev/null
  source "$testOutput" > >(outputTrigger --name "$testOutput" --verbose) || return $?
  set +a
  assertEquals "Assert two strings are not equal"$'\n' "${summary}" || return $?
  assertEquals $'Assert two strings are not equal.\n\nIf this fails it will output an error and exit.\n\n' "${description}" || return $?

  fn="ass""ertEquals" # "" hides from findUncaughtAssertions
  bashDocumentationExtract "$fn" < <(bashFunctionComment "$(__bashDocumentation_FindFunctionDefinition "$home" "$fn")" "$fn") >"$testOutput" || return $?
  set -a # UNDO ok
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
