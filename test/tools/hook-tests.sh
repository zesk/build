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

testWhichHook() {
  local handler="_return"
  local home

  home=$(__catch "$handler" buildHome) || return $?
  assertEquals "$home/bin/build/hooks/version-current.sh" "$(whichHook version-current)" || return $?
}

testVersionLive() {
  assertExitCode 0 hookRun version-live || return $?
}

# Tag: slow
testHookSystem() {
  local usage="_return"
  local testDir here randomApp randomDefault path
  local hook exitCode f

  testDir=$(fileTemporaryName "$usage" -d) || return $?
  here=$(__catch "$usage" buildHome) || return $?

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

  statusMessage decorate info "hasHook test0"
  # Allowed hooks have .sh or no .sh but must be +x
  assertExitCode 0 hasHook --application "$testDir" test0 || _hookTestFailed "$testDir" || return $?

  statusMessage decorate info "hasHook test1"
  assertExitCode 0 hasHook --application "$testDir" test1 || _hookTestFailed "$testDir" || return $?

  statusMessage decorate info "hasHook test2"
  assertExitCode 0 hasHook --application "$testDir" test2 || _hookTestFailed "$testDir" || return $?

  statusMessage decorate info "hasHook nonZero"
  assertExitCode 0 hasHook --application "$testDir" nonZero || _hookTestFailed "$testDir" || return $?

  statusMessage decorate info "hasHook noExtension"
  assertExitCode 0 hasHook --application "$testDir" noExtension || _hookTestFailed "$testDir" || return $?

  statusMessage decorate info "hasHook nonZeroNoExt"
  assertExitCode 0 hasHook --application "$testDir" nonZeroNoExt || _hookTestFailed "$testDir" || return $?

  statusMessage decorate info "hasHook result"
  assertExitCode 0 hasHook --application "$testDir" result || _hookTestFailed "$testDir" || return $?

  statusMessage decorate info "hasHook reflect"
  assertExitCode 0 hasHook --application "$testDir" reflect || _hookTestFailed "$testDir" || return $?

  # If not -x, then ignored
  statusMessage decorate info "hasHook nonX"
  assertExitCode --stderr-ok 1 hasHook --application "$testDir" nonX || _hookTestFailed "$testDir" || return $?
  statusMessage decorate info "hasHook nonXNoExt"
  assertExitCode --stderr-ok 1 hasHook --application "$testDir" nonXNoExt || _hookTestFailed "$testDir" || return $?

  # No hook
  statusMessage decorate info "hasHook test3"
  assertNotExitCode 0 hasHook test3 || _hookTestFailed "$testDir" || return $?

  # Exit codes
  statusMessage decorate info "hookRun test0"
  assertExitCode --leak BUILD_DEBUG 0 hookRun --application "$testDir" test0 || _hookTestFailed "$testDir" || return $?
  statusMessage decorate info "hookRun test1"
  assertExitCode --leak BUILD_DEBUG 0 hookRun --application "$testDir" test1 || _hookTestFailed "$testDir" || return $?
  statusMessage decorate info "hookRun noExtension"
  assertExitCode --leak BUILD_DEBUG 0 hookRun --application "$testDir" noExtension || _hookTestFailed "$testDir" || return $?
  statusMessage decorate info "hookRun nonZero"

  assertExitCode 99 hookRun --application "$testDir" nonZero || _hookTestFailed "$testDir" || return $?
  statusMessage decorate info "hookRun nonX"
  assertExitCode --stderr-ok 2 hookRun --application "$testDir" nonX || _hookTestFailed "$testDir" || return $?
  statusMessage decorate info "hookRun nonXNoExt"
  assertExitCode --stderr-ok 2 hookRun --application "$testDir" nonXNoExt || _hookTestFailed "$testDir" || return $?
  statusMessage decorate info "hookRun test2"
  assertExitCode --leak BUILD_DEBUG 0 hookRun --application "$testDir" test2 || _hookTestFailed "$testDir" || return $?
  statusMessage decorate info "hookRun test3"
  assertExitCode --leak BUILD_DEBUG --stderr-ok 2 hookRun --application "$testDir" test3 || _hookTestFailed "$testDir" || return $?

  for hook in result reflect; do
    for exitCode in $(seq 0 17 245); do
      statusMessage decorate info "hookRun $hook $exitCode"
      assertExitCode --leak BUILD_DEBUG "$exitCode" hookRun --application "$testDir" "$hook" "$exitCode" || _hookTestFailed "$testDir" || return $?
    done
  done

  assertOutputContains --leak BUILD_DEBUG "$randomApp" hookRun --application "$testDir" test0 || return $?
  assertOutputDoesNotContain --leak BUILD_DEBUG "build/hooks" hookRun --application "$testDir" test0 || return $?
  assertOutputContains --leak BUILD_DEBUG "$randomApp" hookRun --application "$testDir" test1 || return $?
  assertOutputDoesNotContain --leak BUILD_DEBUG --line "$LINENO" "build/hooks" hookRun --application "$testDir" test1 || return $?
  assertOutputContains --leak BUILD_DEBUG --line "$LINENO" "$randomDefault" hookRun --application "$testDir" test2 || return $?
  assertOutputContains --leak BUILD_DEBUG --line "$LINENO" "build/hooks" hookRun --application "$testDir" test2 || return $?

  __catch "$usage" rm -rf "$testDir" || return $?

  unset BUILD_DEBUG
}

testHooksWhichSeemBenign() {
  local cache home hook

  home="$(__environment buildHome)" || return $?
  cache=$(__environment __gitPreCommitCache true) || return $?
  find "$home/test/example" -type f ! -path "*/.*/*" | extensionLists --clean "$cache"

  assertExitCode 0 gitPreCommitHeader || return $?
  for hook in application-environment application-id application-tag version-current; do
    APPLICATION_ID=abc APPLICATION_TAG=def assertExitCode 0 hookRun --application "$home" "$hook" || return $?
  done
  assertExitCode 0 gitPreCommitCleanup || return $?
}

#
# Test-Build-Home: true
#
testHooksWhichSeemBenignHome() {
  local hook

  for hook in application-environment application-id application-tag version-current; do
    APPLICATION_ID=abc APPLICATION_TAG=def assertExitCode 0 hookRun "$hook" || return $?
  done
}
