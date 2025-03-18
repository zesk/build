#!/usr/bin/env bash
#
# deprecated-tests.sh
#
# Deploy tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Coverage: deprecatedIgnore
testDeprecatedIgnore() {
  assertOutputContains --line "$LINENO" documentation/source deprecatedIgnore || return $?
  assertOutputContains --line "$LINENO" deprecated.sh deprecatedIgnore || return $?
}

# Coverage: deprecatedFind
testDeprecatedFind() {
  local home

  home=$(__environment buildHome) || return $?
  assertExitCode --line "$LINENO" 0 deprecatedFind deprecatedIgnore --path "$home/test/example/deprecated/" oldFunction || return $?
  assertExitCode --line "$LINENO" 1 deprecatedFind deprecatedIgnore --path "$home/test/example/deprecated/" newFunction || return $?
}

# Coverage: deprecatedCannon
testDeprecatedCannon() {
  local home tempDir usage="_return"

  home=$(__environment buildHome) || return $?
  tempDir=$(fileTemporaryName "$usage" -d) || return $?
  __environment cp -R "$home/test/example/deprecated/" "$tempDir/deprecated" || return $?

  local target="$tempDir/deprecated/hello.txt"
  assertFileExists --line "$LINENO" "$target" || return $?

  assertFileContains --line "$LINENO" "$target" "oldFunction" || return $?
  assertFileDoesNotContain --line "$LINENO" "$target" "newFunction" || return $?

  assertExitCode --line "$LINENO" 1 deprecatedCannon --path "$tempDir" deprecatedIgnore oldFunction newFunction || return $?

  assertFileContains --line "$LINENO" "$target" "newFunction" || return $?
  assertFileDoesNotContain --line "$LINENO" "$target" "oldFunction" || return $?

  __environment rm -rf "$tempDir" || return $?
}
