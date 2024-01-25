#!/usr/bin/env bash
#
# tests-tests.sh
#
# Tests tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
declare -a tests

tests+=(testWrapperShellScripts)
testWrapperShellScripts() {
  local quietLog
  local findArgs=(! -path '*/vendor/*')
  local thisYear

  quietLog=$1
  shift

  thisYear=$(date +%Y)
  if ! find . -name '*.sh' "${findArgs[@]}" | validateShellScripts >>"$quietLog"; then
    return $?
  fi
  if ! validateFileExtensionContents sh -- "Copyright &copy; $thisYear" -- "${findArgs[@]}" >>"$quietLog"; then
    return $?
  fi
  printf "\n"
}
