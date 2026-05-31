#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# documentation-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testBashDocumentationMissing() {
  local home && home=$(catchReturn "$handler" buildHome) || return $?

  local templateSource="$home/documentation/template/docs"

  assertExitCode 0 bashDocumentationMissing --index "$home/documentation/template/index" --source "$home/bin" --documentation "$home/documentation/source" --target "$templateSource" || return $?
}

testBashDocumentationMarkdownTests() {
  local mm=(
    --stdout-match "\`BUILD_DEBUG\`"
    --stdout-match "Constant for turning debugging on during build to find errors"
  )
  assertExitCode "${mm[@]}" 0 bashDocumentationAllEnvironment || return $?
  local mm=(
    --stdout-match "- [bashLint]"
    --stdout-match "Check bash files for common errors"
  )
  assertExitCode "${mm[@]}" 0 bashDocumentationAllFunctions < <(printf "%s\n" "bashLint") || return $?
}

testDocumentationFunctionsCompile() {
  assertExitCode 0 documentationFunctionsCompile --source "$home/bin/build/tools" --documentation "$home/documentation/source" --target "$home/bin/build/documentation" --key "buildFunctions" --fingerprint || return $?
}

testDocumentationEnvironmentFileParse() {
  local home && home=$(catchReturn "$handler" buildHome) || return $?

  local mm=(
    --stdout-match "base=\"APPLICATION_CODE.sh\""
    --stdout-match "category=\"Application\""
    --stdout-match "env=\"APPLICATION_CODE\""
    --stdout-match "envMarker=\"application_code\""
    --stdout-match "type=\"String\""
  )

  assertExitCode "${mm[@]}" 0 documentationEnvironmentFileParse "$home/bin/build/env/APPLICATION_CODE.sh" || return $?
}

testDocumentationFunctionSimple() {
  local handler="returnMessage"
  local home && home=$(catchReturn "$handler" buildHome) || return $?

  local ccFlags=(--documentation "$home/documentation/source" --source "$home/bin/build/tools")
  assertExitCode 0 documentationFunctionCompile "${ccFlags[@]}" assertExitCode || return $?
  assertFileExists "$home/bin/build/documentation/assertExitCode.sh" "$home/bin/build/documentation/assertExitCode.md" "$home/bin/build/documentation/SEE/assertExitCode.md" || return $?
  assertExitCode 0 documentationFunctionRemove --verbose < <(printf "%s\n" assertExitCode) || return $?
  assertFileDoesNotExist "$home/bin/build/documentation/assertExitCode.sh" "$home/bin/build/documentation/assertExitCode.md" "$home/bin/build/documentation/SEE/assertExitCode.md" || return $?
  assertExitCode 0 documentationFunctionCompile "${ccFlags[@]}" < <(printf "%s\n" assertExitCode) || return $?
  assertFileExists "$home/bin/build/documentation/assertExitCode.sh" "$home/bin/build/documentation/assertExitCode.md" "$home/bin/build/documentation/SEE/assertExitCode.md" || return $?
}

testDocumentationIndexes() {
  local handler="returnMessage"
  local home && home=$(catchReturn "$handler" buildHome) || return $?

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

    fn="ass""ertNotEquals" # "" hides from bashFindUncaughtAssertions
    local sourceFile
    sourceFile=$(__bashDocumentation_FindFunctionDefinition "$home" "$fn") || return $?
    bashDocumentationExtract --function "$fn" "$sourceFile" < <(bashFunctionComment "$sourceFile" "$fn") >"$testOutput" || return $?
    set -a # UNDO ok
    # shellcheck source=/dev/null
    source "$testOutput" > >(outputTrigger --name "$testOutput" --verbose) || return $?
    set +a
    assertEquals "Assert two strings are not equal" "${summary}" || return $?
    assertEquals $'Assert two strings are not equal.\n\nIf this fails it will output an error and exit.\n\n' "${description}" || return $?

    fn="ass""ertEquals" # "" hides from bashFindUncaughtAssertions
    sourceFile=$(__bashDocumentation_FindFunctionDefinition "$home" "$fn") || return $?
    bashDocumentationExtract --function "$fn" "$sourceFile" < <(bashFunctionComment "$sourceFile" "$fn") >"$testOutput" || return $?
    set -a # UNDO ok
    # shellcheck source=/dev/null
    source "$testOutput" > >(outputTrigger --name "$testOutput" --verbose) || returnUndo $? set +a || return $?
    set +a
    consoleLine '='
    assertEquals $'Assert two strings are equal.\n\nIf this fails it will output an error and exit.\n\n' "${description}" || return $?
    consoleLine -
    desc=($'Well, Assert two strings are equal.' '' 'If this fails it will output an error and exit.')
    assertEquals "Well, Assert two strings are equal." "$(stringTrimWords 10 "${desc[0]}")" || return $?
    consoleLine '='
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

  fn="ass""ertNotEquals" # "" hides from bashFindUncaughtAssertions
  local sourceFile
  sourceFile=$(__bashDocumentation_FindFunctionDefinition "$home" "$fn") || return $?
  bashDocumentationExtract --function "$fn" "$sourceFile" < <(bashFunctionComment "$sourceFile" "$fn") >"$testOutput" || return $?
  set -a # UNDO ok
  # shellcheck source=/dev/null
  source "$testOutput" > >(outputTrigger --name "$testOutput" --verbose) || return $?
  set +a
  assertEquals "Assert two strings are not equal"$'\n' "${summary}" || return $?
  assertEquals $'Assert two strings are not equal.\n\nIf this fails it will output an error and exit.\n\n' "${description}" || return $?

  fn="ass""ertEquals" # "" hides from bashFindUncaughtAssertions
  sourceFile=$(__bashDocumentation_FindFunctionDefinition "$home" "$fn") || return $?
  bashDocumentationExtract --function "$fn" "$sourceFile" < <(bashFunctionComment "$sourceFile" "$fn") >"$testOutput" || return $?
  set -a # UNDO ok
  # shellcheck source=/dev/null
  source "$testOutput" > >(outputTrigger --name "$testOutput" --verbose) || return $?
  set +a
  consoleLine '='
  assertEquals $'Assert two strings are equal.\n\nIf this fails it will output an error and exit.\n\n\n' "${description}" || return $?
  consoleLine -
  desc=($'Well, Assert two strings are equal.' '' 'If this fails it will output an error and exit.')
  assertEquals "Well, Assert two strings are equal." "$(stringTrimWords 10 "${desc[0]}")" || return $?
  consoleLine '='
  assertEquals $'Assert two strings are equal.\n' "${summary}" || return $?
}
