#!/usr/bin/env bash
#
# ssh-tests.sh
#
# SSH tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

testBashBasics() {
  # Bizarro logic precedence

  # first section
  assertEquals --line "$LINENO" hitTheOr "$(false && true || printf hitTheOr)" || return $?
  assertEquals --line "$LINENO" hitTheOr "$(true && false || printf hitTheOr)" || return $?
  assertEquals --line "$LINENO" hitTheOr "$(false && false || printf hitTheOr)" || return $?
  assertEquals --line "$LINENO" "" "$(true && true || printf hitTheOr)" || return $?

  # Added && to end of first section
  assertEquals --line "$LINENO" hitTheOrhitTheAnd "$(false && true || printf hitTheOr && printf hitTheAnd)" || return $?
  assertEquals --line "$LINENO" hitTheOrhitTheAnd "$(true && false || printf hitTheOr && printf hitTheAnd)" || return $?
  assertEquals --line "$LINENO" hitTheOrhitTheAnd "$(false && false || printf hitTheOr && printf hitTheAnd)" || return $?
  assertEquals --line "$LINENO" "hitTheAnd" "$(true && true || printf hitTheOr && printf hitTheAnd)" || return $?

  # Added || to end of first section
  assertEquals --line "$LINENO" hitTheOr "$(false && true || printf hitTheOr || printf hitTheAnd)" || return $?
  assertEquals --line "$LINENO" hitTheOr "$(true && false || printf hitTheOr || printf hitTheAnd)" || return $?
  assertEquals --line "$LINENO" hitTheOr "$(false && false || printf hitTheOr || printf hitTheAnd)" || return $?
  assertEquals --line "$LINENO" "" "$(true && true || printf hitTheOr || printf hitTheAnd)" || return $?
}

testBashSourcePath() {
  local testPath

  testPath=$(__environment mktemp -d) || return $?

  assertNotExitCode --line "$LINENO" --stderr-match "Requires a directory" 0 bashSourcePath || return $?
  assertNotExitCode --line "$LINENO" --stderr-match "not directory" 0 bashSourcePath "$testPath/does-not-exist-i-hope"

  printf "%s\n" "#!/usr/bin/env bash" "rm \${BASH_SOURCE[0]%/*}/2.sh" >"$testPath/1.sh"
  printf "%s\n" "#!/usr/bin/env bash" "rm \${BASH_SOURCE[0]%/*}/1.sh" >"$testPath/2.sh"
  # Regardless of order someone will not exist

  assertNotExitCode --line "$LINENO" --stderr-match "not executable" 0 bashSourcePath "$testPath"
  __environment muzzle makeShellFilesExecutable "$testPath" || return $?
  assertNotExitCode --line "$LINENO" --stderr-match "not a bash source" 0 bashSourcePath "$testPath"

  __environment rm -rf "$testPath/"*.sh || return $?

  assertEquals "${ZESK_BUILD-}" "" || return $?
  printf "%s\n" "#!/usr/bin/env bash" "export ZESK_BUILD=true" >"$testPath/1.sh"
  printf "%s\n" "#!/usr/bin/env bash" "_testZeskBuildFunction() {" "    consoleGreen Not easy being green." "}" >"$testPath/2.sh"
  __environment muzzle makeShellFilesExecutable "$testPath" || return $?

  assertExitCode --line "$LINENO" 0 bashSourcePath "$testPath"

  assertEquals --line "$LINENO" "${ZESK_BUILD-}" "true" || return $?
  assertExitCode --line "$LINENO" 0 isFunction _testZeskBuildFunction || return $?

  unset ZESK_BUILD
}
