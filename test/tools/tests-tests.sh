#!/usr/bin/env bash
#
# tests-tests.sh
#
# Tests tests
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Tag: slow
testWrapperShellScripts() {
  local handler="returnMessage"
  local findArgs=(! -path '*/vendor/*' ! -path "*/.*/*")
  local thisYear

  packageWhich shellcheck || return $?
  export BUILD_COMPANY

  catchReturn "$handler" buildEnvironmentLoad BUILD_COMPANY || return $?
  thisYear=$(catchEnvironment "$handler" date +%Y) || return $?
  home=$(catchReturn "$handler" buildHome) || return $?
  # Part of commit check - keep it quick
  if ! find "$home/bin/build" -name '*.sh' "${findArgs[@]}" -exec "shellcheck" '{}' ';'; then
    catchEnvironment "$handler" "shellcheck failed" || return $?
  fi
  catchEnvironment "$handler" muzzle pushd "$home" || return $?
  if ! validateFileExtensionContents sh -- "Copyright &copy; $thisYear" "$BUILD_COMPANY" -- "${findArgs[@]}"; then
    unset BUILD_COMPANY
    catchEnvironment "$handler" "validateFileExtensionContents failed" || return $?
  fi
  unset BUILD_COMPANY
  catchEnvironment "$handler" muzzle popd || return $?
}

testTestSuite() {
  local home

  home=$(catchReturn "$handler" buildHome) || return $?
  # env -i is to avoid having our functions inherited to parent and no tests found in test/tools when loaded by __testLoad
  assertExitCode --stdout-match testWrapperShellScripts --stdout-match "${FUNCNAME[0]}" 0 env -i "$home/bin/test.sh" --list || return $?
}
