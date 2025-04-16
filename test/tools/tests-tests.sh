#!/usr/bin/env bash
#
# tests-tests.sh
#
# Tests tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testWrapperShellScripts() {
  local findArgs=(! -path '*/vendor/*' ! -path "*/.*/*")
  local thisYear

  packageWhich shellcheck || return $?
  export BUILD_COMPANY

  buildEnvironmentLoad BUILD_COMPANY || return $?
  if ! thisYear=$(date +%Y); then
    __environment "No year" || return $?
  fi
  home=$(__environment buildHome) || return $?
  # Part of commit check - keep it quick
  if ! find "$home/bin/build" -name '*.sh' "${findArgs[@]}" -exec "shellcheck" '{}' ';'; then
    __environment "shellcheck failed" || return $?
  fi
  if ! validateFileExtensionContents sh -- "Copyright &copy; $thisYear" "$BUILD_COMPANY" -- "${findArgs[@]}"; then
    unset BUILD_COMPANY
    __environment "validateFileExtensionContents failed" || return $?
  fi
  unset BUILD_COMPANY
  decorate success "${FUNCNAME[0]} success"
}

testTestSuite() {
  local home

  home=$(__environment buildHome) || return $?
  # env -i is to avoid having our functions inherited to parent and no tests found in test/tools when loaded by __testLoad
  assertExitCode --stdout-match testWrapperShellScripts --stdout-match "${FUNCNAME[0]}" 0 env -i "$home/bin/test.sh" --list || return $?
  decorate success "${FUNCNAME[0]} success"
}
