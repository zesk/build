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
tests+=(testMarkdownListify)

assertMarkdownListify() {
    assertEquals "$1" "$(printf %s "$2" | markdownListify)" "markdownListify \"$2\" !== \"$1\""
}
testMarkdownListify() {
    # shellcheck disable=SC2016
    assertMarkdownListify '- `dude` - Hello' 'dude - Hello' || return $?
    # shellcheck disable=SC2016
    assertMarkdownListify '- `--extension extension` - A description of extension' '--extension extension - A description of extension' || return $?
    # shellcheck disable=SC2016
    assertMarkdownListify '- `expected` - Expected string' '- `expected` - Expected string' || return $?

    assertMarkdownListify '- Hello' '- Hello' || return $?
    assertMarkdownListify '- Hello' 'Hello' || return $?
    # shellcheck disable=SC2016
    assertMarkdownListify '- `--arg1` - Argument One' '--arg1 - Argument One' || return $?
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
