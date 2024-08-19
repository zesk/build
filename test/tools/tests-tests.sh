#!/usr/bin/env bash
#
# tests-tests.sh
#
# Tests tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

testWrapperShellScripts() {
  local quietLog
  local findArgs=(! -path '*/vendor/*' ! -path "*/.*/*")
  local thisYear

  quietLog=$1
  shift
  export BUILD_COMPANY

  buildEnvironmentLoad BUILD_COMPANY || return $?
  if ! thisYear=$(date +%Y); then
    return 1
  fi
  if ! find . -name '*.sh' "${findArgs[@]}" | bashLintFiles >>"$quietLog"; then
    return 1
  fi
  if ! validateFileExtensionContents sh -- "Copyright &copy; $thisYear" "$BUILD_COMPANY" -- "${findArgs[@]}" >>"$quietLog"; then
    unset BUILD_COMPANY
    return 1
  fi
  unset BUILD_COMPANY
}
