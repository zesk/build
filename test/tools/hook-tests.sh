#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# hook-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

_hookTestFailed() {
  printf "%s\n" "Listing $1/bin/hooks"
  ls -la "$1/bin/hooks"
  return 1
}

testWhichHook() {
  local handler="returnMessage"
  local home

  home=$(catchReturn "$handler" buildHome) || return $?
  assertEquals "$home/bin/build/hooks/version-current.sh" "$(whichHook version-current)" || return $?
}

testVersionLive() {
  assertExitCode 0 hookRun version-live || return $?
}

# Tag: slow
testHookSystem() {
  local handler="returnMessage"
  local testDir savedHome randomApp randomDefault path
  local hook exitCode f

  savedHome=$(catchReturn "$handler" buildHome) || return $?

  export BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_HOME

  mockEnvironmentStart BUILD_HOOK_EXTENSIONS
  mockEnvironmentStart BUILD_HOOK_DIRS
  mockEnvironmentStart BUILD_HOME

  unset BUILD_HOOK_DIRS

  catchReturn "$handler" buildEnvironmentLoad BUILD_HOOK_DIRS BUILD_HOOK_EXTENSIONS || return $?

  decorate pair BUILD_HOOK_EXTENSIONS "$BUILD_HOOK_EXTENSIONS"
  decorate pair BUILD_HOOK_DIRS "$BUILD_HOOK_DIRS"

  testDir=$(fileTemporaryName "$handler" -d) || return $?

  randomApp=$(randomString)
  randomDefault=$(randomString)

  cd "$testDir" || return $?
  mkdir -p "$testDir/bin/hooks"
  cp -R "$savedHome/bin/build" "$testDir/bin/build"
  BUILD_HOME="$testDir"

  for f in test0.sh test1.sh test3.bash noExtension noExtension.bash; do
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
    chmod -x "$path"
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

  for f in test0.bash test1.bash; do
    path="$testDir/bin/hooks/$f"
    printf "%s\n%s" "#!/usr/bin/env bash" "echo \"$f-\${BASH_SOURCE[0]}-$randomApp\"" >"$path"
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

  statusMessage decorate info "hasHook test3"
  assertNotExitCode 0 hasHook --application "$testDir" test3 || _hookTestFailed "$testDir" || return $?

  statusMessage decorate info "hasHook nonZero"
  assertExitCode 0 hasHook --application "$testDir" nonZero || _hookTestFailed "$testDir" || return $?

  statusMessage decorate info "hasHook noExtension"
  assertNotExitCode 0 hasHook --application "$testDir" noExtension || _hookTestFailed "$testDir" || return $?

  statusMessage decorate info "hasHook nonZeroNoExt"
  assertNotExitCode 0 hasHook --application "$testDir" nonZeroNoExt || _hookTestFailed "$testDir" || return $?

  statusMessage decorate info "hasHook result"
  assertExitCode 0 hasHook --application "$testDir" result || _hookTestFailed "$testDir" || return $?

  statusMessage decorate info "hasHook reflect"
  assertExitCode 0 hasHook --application "$testDir" reflect || _hookTestFailed "$testDir" || return $?

  # If not -x, then ignored
  statusMessage decorate info "hasHook nonX"
  assertExitCode --stderr-ok 1 hasHook --application "$testDir" nonX || _hookTestFailed "$testDir" || return $?
  statusMessage decorate info "hasHook nonXNoExt"
  assertExitCode 1 hasHook --application "$testDir" nonXNoExt || _hookTestFailed "$testDir" || return $?

  # No hook
  statusMessage decorate info "hasHook test3"
  assertNotExitCode 0 hasHook test3 || _hookTestFailed "$testDir" || return $?

  # Exit codes
  statusMessage decorate info "hookRun test0"
  assertExitCode --leak BUILD_DEBUG 0 hookRun --application "$testDir" test0 || _hookTestFailed "$testDir" || return $?
  statusMessage decorate info "hookRun test1"
  assertExitCode --leak BUILD_DEBUG 0 hookRun --application "$testDir" test1 || _hookTestFailed "$testDir" || return $?
  statusMessage decorate info "hookRun noExtension"
  assertNotExitCode --stderr-ok 0 hookRun --application "$testDir" noExtension || _hookTestFailed "$testDir" || return $?
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

  assertOutputContains --leak BUILD_DEBUG "$randomApp" hookRun --application "$testDir" test0 || _hookTestFailed "$testDir" || return $?
  assertOutputDoesNotContain --leak BUILD_DEBUG "build/hooks" hookRun --application "$testDir" test0 || _hookTestFailed "$testDir" || return $?
  assertOutputContains --leak BUILD_DEBUG "$randomApp" hookRun --application "$testDir" test1 || _hookTestFailed "$testDir" || return $?
  assertOutputDoesNotContain --leak BUILD_DEBUG --line "$LINENO" "build/hooks" hookRun --application "$testDir" test1 || _hookTestFailed "$testDir" || return $?
  assertOutputContains --leak BUILD_DEBUG --line "$LINENO" "$randomDefault" hookRun --application "$testDir" test2 || _hookTestFailed "$testDir" || return $?
  assertOutputContains --leak BUILD_DEBUG --line "$LINENO" "build/hooks" hookRun --application "$testDir" test2 || _hookTestFailed "$testDir" || return $?

  export BUILD_HOOK_EXTENSIONS="sh:bash:"
  decorate pair BUILD_HOOK_EXTENSIONS "$BUILD_HOOK_EXTENSIONS"

  local matches=(--stdout-match "$randomApp")

  assertExitCode 0 hasHook --application "$testDir" test3 || _hookTestFailed "$testDir" || return $?
  assertExitCode "${matches[@]}" --stdout-match "test0.sh" --stdout-no-match ".bash" 0 hookRun --application "$testDir" test0 || _hookTestFailed "$testDir" || return $?
  assertExitCode "${matches[@]}" --stdout-match "test1.sh" --stdout-no-match ".bash" 0 hookRun --application "$testDir" test1 || _hookTestFailed "$testDir" || return $?
  assertExitCode --stdout-match "$randomDefault" --stdout-match "test2.sh" --stdout-no-match ".bash" 0 hookRun --application "$testDir" test2 || _hookTestFailed "$testDir" || return $?
  assertExitCode 0 hasHook --application "$testDir" test3 || _hookTestFailed "$testDir" || return $?
  assertExitCode "${matches[@]}" --stdout-match "test3.bash" 0 hookRun --application "$testDir" test3 || _hookTestFailed "$testDir" || return $?
  assertExitCode "${matches[@]}" --stdout-match "noExtension.bash" 0 hookRun --application "$testDir" noExtension || _hookTestFailed "$testDir" || return $?
  statusMessage decorate info "hookRun nonXNoExt"
  # Argument error - argument is a non-executable
  assertExitCode --stderr-match "Hook not found" 2 hookRun --application "$testDir" nonXNoExt || _hookTestFailed "$testDir" || _hookTestFailed "$testDir" || return $?

  export BUILD_HOOK_EXTENSIONS=":bash:sh"
  decorate pair BUILD_HOOK_EXTENSIONS "$BUILD_HOOK_EXTENSIONS"

  assertExitCode "${matches[@]}" --stdout-match "noExtension" --stdout-no-match ".bash" 0 hookRun --application "$testDir" noExtension || _hookTestFailed "$testDir" || return $?
  assertExitCode --stderr-match "but is not executable" 2 hookRun --application "$testDir" nonXNoExt || _hookTestFailed "$testDir" || _hookTestFailed "$testDir" || return $?

  export BUILD_HOOK_EXTENSIONS="bash:sh"
  decorate pair BUILD_HOOK_EXTENSIONS "$BUILD_HOOK_EXTENSIONS"

  assertExitCode 0 hasHook --application "$testDir" test3 || _hookTestFailed "$testDir" || return $?
  assertExitCode "${matches[@]}" --stdout-match "test0.bash" --stdout-no-match ".sh" 0 hookRun --application "$testDir" test0 || _hookTestFailed "$testDir" || return $?
  assertExitCode "${matches[@]}" --stdout-match "test1.bash" --stdout-no-match ".sh" 0 hookRun --application "$testDir" test1 || _hookTestFailed "$testDir" || return $?
  assertExitCode --stdout-match "$randomDefault" --stdout-match "test2.sh" --stdout-no-match ".bash" 0 hookRun --application "$testDir" test2 || _hookTestFailed "$testDir" || return $?
  assertExitCode "${matches[@]}" --stdout-match "test3.bash" 0 hookRun --application "$testDir" test3 || _hookTestFailed "$testDir" || return $?
  assertExitCode "${matches[@]}" --stdout-match "noExtension.bash" --stdout-no-match ".sh" 0 hookRun --application "$testDir" noExtension || _hookTestFailed "$testDir" || return $?

  catchReturn "$handler" rm -rf "$testDir" || return $?

  catchEnvironment "$handler" cd "$savedHome" || return $?

  mockEnvironmentStop BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_HOME
}

testHooksWhichSeemBenign() {
  local handler="returnMessage"
  local cache home hook

  home="$(catchReturn "$handler" buildHome)" || return $?
  cache=$(catchReturn "$handler" __gitPreCommitCache true) || return $?
  find "$home/test/example" -type f ! -path "*/.*/*" | extensionLists --clean "$cache"

  assertExitCode --stdout-match "html" --stdout-match "json" --stdout-match "@" --stdout-match "php" --stdout-match "sql" 0 gitPreCommitExtensionList || return $?

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
