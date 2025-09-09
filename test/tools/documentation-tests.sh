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
    --stdout-match "Prompts can be formatted"
    --stdout-match "--help"
    --stdout-match "--order order"
    --stdout-match "--skip-prompt"
  )

  home=$(__catch "$handler" buildHome) || return $?

  assertExitCode "${matches[@]}" 0 bashFunctionComment "$home/bin/build/tools/prompt.sh" bashPrompt || return $?
}

testDocumentation() {
  local testOutput
  local summary description
  local handler="_return"

  # export BUILD_DEBUG="fast-usage,usage"
  local home
  home=$(__catch "$handler" buildHome) || return $?

  testOutput=$(fileTemporaryName "$handler") || return $?
  assertExitCode 0 inArray "summary" summary usage argument example reviewed || return $?
  (
    __documentationLoader _return printf ""
    bashDocumentation_Extract "$(__bashDocumentation_FindFunctionDefinition "$home" assertNotEquals)" assertNotEquals >"$testOutput" || return $?
    set -a
    # shellcheck source=/dev/null
    source "$testOutput" > >(outputTrigger --name "$testOutput" --verbose) || return $?
    set +a
    assertEquals "Assert two strings are not equal"$'\n' "${summary}" || return $?
    assertEquals $'Assert two strings are not equal.\n\nIf this fails it will output an error and exit.\n' "${description}" || return $?

    bashDocumentation_Extract "$(__bashDocumentation_FindFunctionDefinition "$home" assertEquals)" assertEquals >"$testOutput" || return $?
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

  bashDocumentation_Extract "$(__bashDocumentation_FindFunctionDefinition "$home" assertNotEquals)" assertNotEquals >"$testOutput" || return $?
  set -a
  # shellcheck source=/dev/null
  source "$testOutput" > >(outputTrigger --name "$testOutput" --verbose) || return $?
  set +a
  assertEquals "Assert two strings are not equal"$'\n' "${summary}" || return $?
  assertEquals $'Assert two strings are not equal.\n\nIf this fails it will output an error and exit.\n\n' "${description}" || return $?

  bashDocumentation_Extract "$(__bashDocumentation_FindFunctionDefinition "$home" assertEquals)" assertEquals >"$testOutput" || return $?
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
