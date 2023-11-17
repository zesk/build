#!/usr/bin/env bash
#
# documentation-tests.sh
#
# documentation.sh tests
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eou pipefail

declare -a tests
tests+=(testFormatArguments)

assertBashDocumentFormatArguments() {
    assertEquals "$1" "$(printf %s "$2" | _bashDocumentFunction_argumentFormat)" || return $?
}
testFormatArguments() {
    # shellcheck disable=SC2016
    assertBashDocumentFormatArguments '- `dude` - Hello' 'dude - Hello' || return $?
    # shellcheck disable=SC2016
    assertBashDocumentFormatArguments '- `expected` - Expected string' '- `expected` - Expected string' || return $?

    assertBashDocumentFormatArguments '- Hello' '- Hello' || return $?
    assertBashDocumentFormatArguments '- Hello' 'Hello' || return $?
}

tests+=(testDocumentation)
testDocumentation() {
    local testOutput exitCode=0
    local short_description description

    testOutput=$(mktemp)
    assertExitCode 0 inArray "short_description" short_description usage argument example reviewed

    bashFindFunctionDocumentation . assertNotEquals >"$testOutput" || return $?
    set -a
    # shellcheck source=/dev/null
    . "$testOutput"
    set +a
    assertEquals "Assert two strings are not equal" "${short_description}" || return $?
    assertEquals $'Assert two strings are not equal.\n\nIf this fails it will output an error and exit.' "${description}" || return $?

    bashFindFunctionDocumentation . assertEquals >"$testOutput" || return $?
    set -a
    # shellcheck source=/dev/null
    . "$testOutput" || return $?
    set +a
    assertEquals $'Assert two strings are equal.\n\nIf this fails it will output an error and exit.' "${description}" || return $?
    desc=($'Well, Assert two strings are equal.' '' 'If this fails it will output an error and exit.')
    assertEquals "Well, Assert two strings are equal." "$(trimWords 10 "${desc[0]}")" || return $?
    assertEquals "Assert two strings are equal." "${short_description}" || return $?

    rm "$testOutput"
}
