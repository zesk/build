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

assertFormatArguments() {
    assertEquals "$1" "$(printf %s "$2" | _bashDocumentFunction_argumentFormat)"
}
testFormatArguments() {
    # shellcheck disable=SC2016
    assertFormatArguments '- `dude` - Hello' 'dude - Hello'
}
