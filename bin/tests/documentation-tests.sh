#!/usr/bin/env bash
#
# documentation-tests.sh
#
# documentation.sh tests
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

declare -a tests
tests+=(testFormatArguments)

assertBashDocumentFormatArguments() {
    assertEquals "$1" "$(printf %s "$2" | _bashDocumentFunction_argumentFormat)"
}
testFormatArguments() {
    # shellcheck disable=SC2016
    assertBashDocumentFormatArguments '- `dude` - Hello' 'dude - Hello'
    # shellcheck disable=SC2016
    assertBashDocumentFormatArguments '- `expected` - Expected string' '- `expected` - Expected string'

    assertBashDocumentFormatArguments '- Hello' '- Hello'
    assertBashDocumentFormatArguments '- Hello' 'Hello'
}

tests+=(testDocumentation)
testDocumentation() {
    local testOutput

    testOutput=$(mktemp)
    assertExitCode 0 inArray "short_description" short_description usage argument example reviewed

    bashFindFunctionDocumentation . assertNotEquals >"$testOutput"
    (
        local short_description description
        set -a
        # shellcheck source=/dev/null
        . "$testOutput"
        set +a
        assertEquals "Assert two strings are not equal" "${short_description}"
        assertEquals $'Assert two strings are not equal.\n\nIf this fails it will output an error and exit.' "${description}"
    )

    rm "$testOutput"
}
