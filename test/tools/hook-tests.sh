#!/usr/bin/env bash
#
# hook-tests.sh
#
# Hook tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

_hookTestFailed() {
  printf "%s\n" "Listing $1/bin/hooks"
  ls -la "$1/bin/hooks"
  return 1
}

testVersionLive() {
  assertExitCode --line "$LINENO" 0 hookRun version-live || return $?
}

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

  printf "%s %s\n" "$(decorate label "Current directory is")" "$(decorate value "$(pwd)")"

  decorate info "hasHook test0"
  # Allowed hooks have .sh or no .sh but must be +x
  assertExitCode --line "$LINENO" 0 hasHook test0 || _hookTestFailed "$testDir" || return $?

  decorate info "hasHook test1"
  assertExitCode --line "$LINENO" 0 hasHook test1 || _hookTestFailed "$testDir" || return $?

  decorate info "hasHook test2"
  assertExitCode --line "$LINENO" 0 hasHook test2 || _hookTestFailed "$testDir" || return $?

  decorate info "hasHook nonZero"
  assertExitCode --line "$LINENO" 0 hasHook nonZero || _hookTestFailed "$testDir" || return $?

  decorate info "hasHook noExtension"
  assertExitCode --line "$LINENO" 0 hasHook noExtension || _hookTestFailed "$testDir" || return $?

  decorate info "hasHook nonZeroNoExt"
  assertExitCode --line "$LINENO" 0 hasHook nonZeroNoExt || _hookTestFailed "$testDir" || return $?

  decorate info "hasHook result"
  assertExitCode --line "$LINENO" 0 hasHook result || _hookTestFailed "$testDir" || return $?

  decorate info "hasHook reflect"
  assertExitCode --line "$LINENO" 0 hasHook reflect || _hookTestFailed "$testDir" || return $?

  # If not -x, then ignored
  decorate info "hasHook nonX"
  assertExitCode --line "$LINENO" --stderr-ok 1 hasHook nonX || _hookTestFailed "$testDir" || return $?
  decorate info "hasHook nonXNoExt"
  assertExitCode --line "$LINENO" --stderr-ok 1 hasHook nonXNoExt || _hookTestFailed "$testDir" || return $?

  # No hook
  decorate info "hasHook test3"
  assertNotExitCode 0 hasHook test3 || _hookTestFailed "$testDir" || return $?

  # Exit codes
  decorate info "hookRun test0"
  assertExitCode --leak BUILD_DEBUG --line "$LINENO" 0 hookRun test0 || _hookTestFailed "$testDir" || return $?
  decorate info "hookRun test1"
  assertExitCode --leak BUILD_DEBUG --line "$LINENO" 0 hookRun test1 || _hookTestFailed "$testDir" || return $?
  decorate info "hookRun noExtension"
  assertExitCode --leak BUILD_DEBUG --line "$LINENO" 0 hookRun noExtension || _hookTestFailed "$testDir" || return $?
  decorate info "hookRun nonZero"

  assertExitCode --line "$LINENO" 99 hookRun nonZero || _hookTestFailed "$testDir" || return $?
  decorate info "hookRun nonZeroNoExt"
  assertExitCode 99 hookRun nonZeroNoExt || _hookTestFailed "$testDir" || return $?
  decorate info "hookRun nonX"
  assertExitCode --line "$LINENO" --stderr-ok 2 hookRun nonX || _hookTestFailed "$testDir" || return $?
  decorate info "hookRun nonXNoExt"
  assertExitCode --line "$LINENO" --stderr-ok 2 hookRun nonXNoExt || _hookTestFailed "$testDir" || return $?
  decorate info "hookRun test2"
  assertExitCode --leak BUILD_DEBUG --line "$LINENO" 0 hookRun test2 || _hookTestFailed "$testDir" || return $?
  decorate info "hookRun test3"
  assertExitCode --leak BUILD_DEBUG --line "$LINENO" --stderr-ok 2 hookRun test3 || _hookTestFailed "$testDir" || return $?

  for hook in result reflect; do
    for exitCode in $(seq 0 7 245); do
      decorate info "hookRun $hook $exitCode"
      assertExitCode --leak BUILD_DEBUG --line "$LINENO" "$exitCode" hookRun $hook "$exitCode" || _hookTestFailed "$testDir" || return $?
    done
  done

  assertOutputContains --leak BUILD_DEBUG --line "$LINENO" "$randomApp" hookRun test0 || return $?
  assertOutputDoesNotContain --leak BUILD_DEBUG --line "$LINENO" "build/hooks" hookRun test0 || return $?
  assertOutputContains --leak BUILD_DEBUG --line "$LINENO" "$randomApp" hookRun test1 || return $?
  assertOutputDoesNotContain --leak BUILD_DEBUG --line "$LINENO" "build/hooks" hookRun test1 || return $?
  assertOutputContains --leak BUILD_DEBUG --line "$LINENO" "$randomDefault" hookRun test2 || return $?
  assertOutputContains --leak BUILD_DEBUG --line "$LINENO" "build/hooks" hookRun test2 || return $?

  unset BUILD_DEBUG
}

testHooksWhichSeemBenign() {
  local cache home hook

  home="$(__environment buildHome)" || return $?
  cache=$(__environment __gitPreCommitCache true) || return $?
  find "$home/test/example" -type f ! -path "*/.*/*" | extensionLists --clean "$cache"

  assertExitCode 0 gitPreCommitHeader || return $?
  for hook in application-environment application-id application-tag pre-commit-php pre-commit-sh version-current; do
    APPLICATION_ID=abc APPLICATION_TAG=def assertExitCode 0 hookRun "$hook" || return $?
  done
  assertExitCode 0 gitPreCommitCleanup || return $?
}
