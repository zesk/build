#!/usr/bin/env bash
#
# tests-tests.sh
#
# Tests tests
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
declare -a tests

tests+=(testWrapperShellScripts)
testWrapperShellScripts() {
  local quietLog
  # shellcheck disable=SC2034
  quietLog=$1
  shift
  testShellScripts "$@"
}
