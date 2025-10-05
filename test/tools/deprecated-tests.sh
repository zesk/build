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
  mockEnvironmentStart __BUILD_DEPRECATED_EXTRAS

  assertOutputContains --line "$LINENO" documentation/source deprecatedIgnore || return $?
  assertOutputContains --line "$LINENO" deprecated.sh deprecatedIgnore || return $?

  mockEnvironmentStop __BUILD_DEPRECATED_EXTRAS
}

# Coverage: deprecatedFind
testDeprecatedFind() {
  local handler="returnMessage"
  local home

  home=$(catchReturn "$handler" buildHome) || return $?
  assertExitCode 0 deprecatedFind deprecatedIgnore --path "$home/test/example/deprecated/" oldFunction || return $?
  assertExitCode 1 deprecatedFind deprecatedIgnore --path "$home/test/example/deprecated/" newFunction || return $?
}

# Coverage: deprecatedCannon
testDeprecatedCannon() {
  local home tempDir handler="returnMessage"

  home=$(catchReturn "$handler" buildHome) || return $?
  tempDir=$(fileTemporaryName "$handler" -d) || return $?
  catchEnvironment "$handler" cp -R "$home/test/example/deprecated/" "$tempDir/deprecated" || return $?

  local target="$tempDir/deprecated/hello.txt"
  assertFileExists "$target" || return $?

  assertFileContains --line "$LINENO" "$target" "oldFunction" || return $?
  assertFileDoesNotContain --line "$LINENO" "$target" "newFunction" || return $?

  assertExitCode --stdout-match "Modified" --stdout-match "1 file" 1 deprecatedCannon --path "$tempDir" deprecatedIgnore oldFunction newFunction || return $?

  assertFileContains --line "$LINENO" "$target" "newFunction" || return $?
  assertFileDoesNotContain --line "$LINENO" "$target" "oldFunction" || return $?

  catchEnvironment "$handler" rm -rf "$tempDir" || return $?
}
