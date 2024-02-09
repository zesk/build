#!/usr/bin/env bash
#
# identical-tests.sh
#
# identical tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

declare -a tests
tests+=(testIdenticalCheck)

testIdenticalCheck() {
  #
  # Unusual quoting here is to avoid matching the word uh, IDENTICAL with the comment here
  #
  identicalCheck --extension sh --prefix '# ''IDENTICAL' || return $?
}
