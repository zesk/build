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

    # shellcheck source=/dev/null
    source ./bin/build/env/BUILD_COMPANY.sh
  thisYear=$(date +%Y)
  if ! find . -name '*.sh' "${findArgs[@]}" | validateShellScripts >>"$quietLog"; then
    return $?
  fi
  if ! validateFileExtensionContents sh -- "Copyright &copy; $thisYear" "$BUILD_COMPANY" -- "${findArgs[@]}" >>"$quietLog"; then
    return $?
  fi
  printf "\n"
}
