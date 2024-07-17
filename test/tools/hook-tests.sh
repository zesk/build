#!/usr/bin/env bash
#
# hook-tests.sh
#
# Hook tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL errorEnvironment 1
errorEnvironment=1

declare -a tests

_hookTestFailed() {
  printf "%s\n" "Listing $1/bin/hooks"
  ls -la "$1/bin/hooks"
  return $errorEnvironment
}

tests+=(testHookSystem)
testHookSystem() {
  local testDir here randomApp randomDefault path
  local hook exitCode f

  if ! testDir=$(mktemp -d); then
    return 1
  fi
  if ! here=$(pwd); then
    return 1
  fi

  randomApp=$(randomString)
  randomDefault=$(randomString)

  cd "$testDir" || return $?
  mkdir -p "$testDir/bin/hooks"
  cp -R "$here/bin/build" "$testDir/bin/build"

  for f in test0.sh test1.sh noExtension; do
    path="$testDir/bin/hooks/$f"
    printf "%s\n%s" "#!/usr/bin/env bash" "echo \"$f-\${BASH_SOURCE[0]}-$randomApp\"" >"$path"
    chmod +x "$path"
  done
  for f in nonZero.sh nonZeroNoExt; do
    path="$testDir/bin/hooks/$f"
    printf "%s\n%s" "#!/usr/bin/env bash" "echo \"$f-\${BASH_SOURCE[0]}-$randomApp\"; exit 99" >"$path"
    chmod +x "$path"
  done
  for f in nonX.sh nonXNoExt; do
    path="$testDir/bin/hooks/$f"
    printf "%s\n%s" "#!/usr/bin/env bash" "echo \"$f-\${BASH_SOURCE[0]}-$randomApp\"; exit 1" >"$path"
  done
  for f in test1.sh test2.sh; do
    path="$testDir/bin/build/hooks/$f"
    printf "%s\n%s" "#!/usr/bin/env bash" "echo \"$f-\${BASH_SOURCE[0]}-$randomDefault\"" >"$path"
    chmod +x "$path"
  done
  for f in result.sh reflect.sh; do
    path="$testDir/bin/hooks/$f"
    printf "%s\n%s" "#!/usr/bin/env bash" "exit \${1-0}" >"$path"
    chmod +x "$path"
  done

  printf "%s %s\n" "$(consoleLabel "Current directory is")" "$(consoleValue "$(pwd)")"

  consoleInfo "hasHook test0"
  # Allowed hooks have .sh or no .sh but must be +x
  assertExitCode --line "$LINENO" 0 hasHook test0 || _hookTestFailed "$testDir" || return $?

  consoleInfo "hasHook test1"
  assertExitCode --line "$LINENO" 0 hasHook test1 || _hookTestFailed "$testDir" || return $?

  consoleInfo "hasHook test2"
  assertExitCode --line "$LINENO" 0 hasHook test2 || _hookTestFailed "$testDir" || return $?

  consoleInfo "hasHook nonZero"
  assertExitCode --line "$LINENO" 0 hasHook nonZero || _hookTestFailed "$testDir" || return $?

  consoleInfo "hasHook noExtension"
  assertExitCode --line "$LINENO" 0 hasHook noExtension || _hookTestFailed "$testDir" || return $?

  consoleInfo "hasHook nonZeroNoExt"
  assertExitCode --line "$LINENO" 0 hasHook nonZeroNoExt || _hookTestFailed "$testDir" || return $?

  consoleInfo "hasHook result"
  assertExitCode --line "$LINENO" 0 hasHook result || _hookTestFailed "$testDir" || return $?

  consoleInfo "hasHook reflect"
  assertExitCode --line "$LINENO" 0 hasHook reflect || _hookTestFailed "$testDir" || return $?

  # If not -x, then ignored
  consoleInfo "hasHook nonX"
  assertExitCode --line "$LINENO" --stderr-ok 1 hasHook nonX || _hookTestFailed "$testDir" || return $?
  consoleInfo "hasHook nonXNoExt"
  assertExitCode --line "$LINENO" --stderr-ok 1 hasHook nonXNoExt || _hookTestFailed "$testDir" || return $?

  # No hook
  consoleInfo "hasHook test3"
  assertNotExitCode 0 hasHook test3 || _hookTestFailed "$testDir" || return $?

  # Exit codes
  consoleInfo "runHook test0"
  assertExitCode --leak BUILD_DEBUG --line "$LINENO" 0 runHook test0 || _hookTestFailed "$testDir" || return $?
  consoleInfo "runHook test1"
  assertExitCode --leak BUILD_DEBUG --line "$LINENO" 0 runHook test1 || _hookTestFailed "$testDir" || return $?
  consoleInfo "runHook noExtension"
  assertExitCode --leak BUILD_DEBUG --line "$LINENO" 0 runHook noExtension || _hookTestFailed "$testDir" || return $?
  consoleInfo "runHook nonZero"
  assertExitCode 99 runHook nonZero || _hookTestFailed "$testDir" || return $?
  consoleInfo "runHook nonZeroNoExt"
  assertExitCode 99 runHook nonZeroNoExt || _hookTestFailed "$testDir" || return $?
  consoleInfo "runHook nonX"
  assertExitCode --line "$LINENO" --stderr-ok 2 runHook nonX || _hookTestFailed "$testDir" || return $?
  consoleInfo "runHook nonXNoExt"
  assertExitCode --line "$LINENO" --stderr-ok 2 runHook nonXNoExt || _hookTestFailed "$testDir" || return $?
  consoleInfo "runHook test2"
  assertExitCode --leak BUILD_DEBUG --line "$LINENO" 0 runHook test2 || _hookTestFailed "$testDir" || return $?
  consoleInfo "runHook test3"
  assertExitCode --leak BUILD_DEBUG --line "$LINENO" --stderr-ok 2 runHook test3 || _hookTestFailed "$testDir" || return $?

  for hook in result reflect; do
    for exitCode in $(seq 0 7 245); do
      consoleInfo "runHook $hook $exitCode"
      assertExitCode --leak BUILD_DEBUG --line "$LINENO" "$exitCode" runHook $hook "$exitCode" || _hookTestFailed "$testDir" || return $?
    done
  done

  assertOutputContains --leak BUILD_DEBUG --line "$LINENO" "$randomApp" runHook test0 || return $?
  assertOutputDoesNotContain --leak BUILD_DEBUG --line "$LINENO" "build/hooks" runHook test0 || return $?
  assertOutputContains --leak BUILD_DEBUG --line "$LINENO" "$randomApp" runHook test1 || return $?
  assertOutputDoesNotContain --leak BUILD_DEBUG --line "$LINENO" "build/hooks" runHook test1 || return $?
  assertOutputContains --leak BUILD_DEBUG --line "$LINENO" "$randomDefault" runHook test2 || return $?
  assertOutputContains --leak BUILD_DEBUG --line "$LINENO" "build/hooks" runHook test2 || return $?
}
