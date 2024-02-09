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
  local findArgs=(! -path '*/vendor/*' ! -path "*/.*")
  local thisYear

  quietLog=$1
  shift

  # shellcheck source=/dev/null
  source ./bin/build/env/BUILD_COMPANY.sh || return 1
  if ! thisYear=$(date +%Y); then
    return 1
  fi
  if ! find . -name '*.sh' "${findArgs[@]}" | validateShellScripts >>"$quietLog"; then
    return 1
  fi
  if ! validateFileExtensionContents sh -- "Copyright &copy; $thisYear" "$BUILD_COMPANY" -- "${findArgs[@]}" >>"$quietLog"; then
    return 1
  fi
  printf "\n"
}
