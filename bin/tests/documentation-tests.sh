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
tests+=(testMarkdownFormatList)

assertMarkdownFormatList() {
    assertEquals "$1" "$(printf %s "$2" | markdownFormatList)" "markdownFormatList \"$2\" !== \"$1\""
}
testMarkdownFormatList() {
    # shellcheck disable=SC2016
    assertMarkdownFormatList '- `dude` - Hello' 'dude - Hello' || return $?
    # shellcheck disable=SC2016
    assertMarkdownFormatList '- `--extension extension` - A description of extension' '--extension extension - A description of extension' || return $?
    # shellcheck disable=SC2016
    assertMarkdownFormatList '- `expected` - Expected string' '- `expected` - Expected string' || return $?

    assertMarkdownFormatList '- Hello' '- Hello' || return $?
    assertMarkdownFormatList '- Hello' 'Hello' || return $?
    # shellcheck disable=SC2016
    assertMarkdownFormatList '- `--arg1` - Argument One' '--arg1 - Argument One' || return $?
}

tests+=(testDocumentation)
testDocumentation() {
    local testOutput
    local summary description

    testOutput=$(mktemp)
    assertExitCode 0 inArray "summary" summary usage argument example reviewed

    bashExtractDocumentation "$(bashFindFunctionFile . assertNotEquals)" assertNotEquals >"$testOutput" || return $?
    set -a
    # shellcheck source=/dev/null
    . "$testOutput"
    set +a
    assertEquals "Assert two strings are not equal" "${summary}" || return $?
    assertEquals $'Assert two strings are not equal.\n\nIf this fails it will output an error and exit.' "${description}" || return $?

    bashExtractDocumentation "$(bashFindFunctionFile . assertEquals)" assertEquals >"$testOutput" || return $?
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
