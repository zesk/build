#!/usr/bin/env bash
#
# self-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testBuildRunner() {
  assertExitCode --stderr-match "Hello, world" 1 Build --verbose returnMessage 1 "Hello, world" || return $?
  assertExitCode --stderr-match "welcome our" 99 Build --verbose returnMessage 99 "I. for one, welcome our ..." || return $?
  assertExitCode --stderr-match "bad arg" 2 Build --verbose returnMessage "NaN" "bad arg" || return $?
}

testBinBuildRequires() {
  local home

  home=$(catchReturn "$handler" buildHome) || return $?

  assertExitCode 0 bashCheckRequires --require --unused --report "$home/bin/build/install.sample.sh" || return $?
  assertExitCode 0 bashCheckRequires --require --unused --report "$home/bin/build/install-bin-build.sh" || return $?
  assertExitCode 0 bashCheckRequires --ignore catchReturn --ignore-prefix returnEnvironment --ignore-prefix __decorateExtension --require --unused --report "$home/bin/build/map.sh" || return $?
  assertExitCode 0 bashCheckRequires --require --unused --report "$home/bin/build/need-bash.sh" || return $?
}

testBuildApplicationTools() {
  local handler="returnMessage"
  local testApp

  testApp=$(fileTemporaryName "$handler" -d) || return $?

  muzzle directoryRequire "$testApp/bin" || return $?
  muzzle directoryRequire "$testApp/docs/release" || return $?
  muzzle directoryRequire "$testApp/bin/tools" || return $?

  catchEnvironment "$handler" touch "$testApp/docs/release/v1.2.3.md" || return $?
  assertExitCode 0 installInstallBuild "$testApp/bin" "$testApp" || return $?
  catchEnvironment "$handler" cp "$(buildHome)/bin/build/application.sh" "$testApp/bin/tools.sh" || return $?

  catchEnvironment "$handler" muzzle pushd "$testApp" || return $?

  catchEnvironment "$handler" chmod +x "$testApp/bin/tools.sh" || return $?
  assertEquals "$("$testApp/bin/tools.sh" hookVersionCurrent --application "$testApp")" "v1.2.3" || return $?
  catchEnvironment "$handler" muzzle popd || return $?

  catchReturn "$handler" rm -rf "$testApp" || return $?
}

# Tag: slow slow-non-critical
testBuildEnvironmentLoadAll() {
  local handler="returnMessage"
  local home loadIt nonBlankEnvs=(
    APACHE_HOME
    APPLICATION_BUILD_DATE
    APPLICATION_CODE
    APPLICATION_CODE
    APPLICATION_NAME
    BUILD_CACHE_HOME
    BUILD_COMPANY
    BUILD_COMPANY_LINK
    BUILD_DOCKER_BITBUCKET_IMAGE
    BUILD_DOCKER_BITBUCKET_PATH
    BUILD_DOCKER_IMAGE
    BUILD_DOCKER_PATH
    BUILD_DOCUMENTATION_SOURCE_LINK_PATTERN
    BUILD_HOME
    BUILD_INSTALL_URL
    BUILD_INTERACTIVE_REFRESH
    BUILD_MAINTENANCE_MESSAGE_VARIABLE
    BUILD_MAINTENANCE_VARIABLE
    BUILD_MAXIMUM_TAGS_PER_VERSION
    BUILD_RELEASE_NOTES
    BUILD_TARGET
    BUILD_TIMESTAMP
    DAEMONTOOLS_HOME
    GIT_REMOTE
    HOME
    OSTYPE
    PATH
  )

  home=$(catchReturn "$handler" buildHome) || return $?
  tempFile=$(fileTemporaryName "$handler")

  find "$home" -type f -name '*.sh' -path '*/env/*' ! -path '*/test/*' ! -path '*/.*/*' -exec basename {} \; | cut -d . -f 1 | dumpPipe "All env files found"
  while read -r loadIt; do
    (
      local envFile
      export "${loadIt?}"
      buildEnvironmentLoad --print "$loadIt" >"$tempFile" || returnEnvironment "buildEnvironmentLoad $loadIt failed" return $?
      envFile="$(cat "$tempFile")"
      assertFileExists "$envFile" || return $?

      # statusMessage decorate info Loaded "$loadIt=${!loadIt}"
      if inArray "$loadIt" "${nonBlankEnvs[@]}"; then
        assertNotEquals --display "Loaded $loadIt is non-blank: \"${!loadIt}\"" "${!loadIt}" "" || return $?
      fi
      assertFileContains "$envFile" "# Type:" "# Category:" || return $?

      local type
      type=$(grep -m 1 -e "^# Type:" "$envFile" | cut -f 2 -d : | trimSpace)

      validator="usage""Argument$type"
      isFunction "$validator" || returnEnvironment "$type is not a known type in $(decorate file "$envFile")" || return $?
    ) || return $?
  done < <(find "$home" -type f -name '*.sh' -path '*/env/*' ! -path '*/test/*' ! -path '*/.*/*' -exec basename {} \; | cut -d . -f 1) || return $?
  catchEnvironment "$handler" rm -f "$tempFile" || return $?
}

testBuildFunctions() {
  local handler="returnMessage"
  local fun

  fun=$(fileTemporaryName "$handler") || return $?
  buildFunctions >"$fun" || returnEnvironment "buildFunctions failed" || return $?

  assertFileContains "$fun" buildFunctions catchEnvironment "$handler" returnArgument returnEnvironment catchReturn housekeeper || return $?

  catchEnvironment "$handler" rm -f "$fun" || return $?
}

testInstallInstallBuildSelf() {
  local handler="returnMessage"
  local tempD
  export BUILD_COMPANY

  tempD=$(fileTemporaryName "$handler" -d) || return $?

  catchReturn "$handler" buildEnvironmentLoad BUILD_COMPANY || return $?
  catchEnvironment "$handler" mkdir -p "$tempD/a/b/c/d/e/f" || return $?

  assertFileDoesNotExist "$tempD/a/b/c/d/e/f/install-bin-build.sh" || return $?
  assertExitCode --stdout-match '../../../../../..' 0 installInstallBuild "$tempD/a/b/c/d/e/f" "$tempD" || return $?
  assertFileExists "$tempD/a/b/c/d/e/f/install-bin-build.sh" || return $?
  assertFileContains "$tempD/a/b/c/d/e/f/install-bin-build.sh" "${BUILD_COMPANY}" || return $?

  unset BUILD_COMPANY

  catchReturn "$handler" rm -rf "$tempD" || return $?

}

# Test that urlFetch works for remote installs
testInstallBinBuildNetwork() {
  local testDir testBinBuild section home matches
  local handler=returnMessage

  home=$(catchReturn "$handler" buildHome) || return $?

  testDir=$(fileTemporaryName "$handler" -d)
  testBinBuild="$testDir/bin/pipeline/install-bin-build.sh"
  catchEnvironment "$handler" muzzle pushd "$testDir" || return $?

  catchEnvironment "$handler" mkdir -p bin/pipeline || return $?
  catchEnvironment "$handler" cp "$home/bin/build/install-bin-build.sh" "$testBinBuild" || return $?
  catchEnvironment "$handler" echo '# this make the file different' >>"$testBinBuild" || return $?

  assertDirectoryDoesNotExist "$testDir/bin/build" || return $?
  assertFileDoesNotExist "$testDir/bin/build/tools.sh" || return $?

  assertExitCode 0 "$testBinBuild" --force --url 'https://github.com/zesk/build/archive/refs/tags/v0.21.0.tar.gz' || return $?
  assertDirectoryExists "$testDir/bin/build" || return $?
  assertFileExists "$testDir/bin/build/tools.sh" || return $?

  catchEnvironment "$handler" muzzle popd || return $?
  catchReturn "$handler" rm -rf "$testDir" || return $?
}

#
# fn: {base}
# Usage: {fn} buildHome
#
testInstallBinBuild() {
  local handler="_${FUNCNAME[0]}"
  local testDir testBinBuild section home matches

  home=$(catchReturn "$handler" buildHome) || return $?
  assertDirectoryExists "$BUILD_HOME" || return $?
  section=0
  testDir=$(fileTemporaryName "$handler" -d)
  testBinBuild="$testDir/bin/pipeline/install-bin-build.sh"
  catchEnvironment "$handler" muzzle pushd "$testDir" || return $?

  catchEnvironment "$handler" mkdir -p bin/pipeline || return $?
  catchEnvironment "$handler" cp "$home/bin/build/install-bin-build.sh" "$testBinBuild" || return $?
  catchEnvironment "$handler" printf -- '%s\n' '# this make the file different' >>"$testBinBuild" || return $?

  # --------------------------------------------------------------------------------
  #
  clearLine
  boxedHeading "No .gitignore, was updated, same name"
  #
  section=$((section + 1))
  bigText "Section #$section"

  #  ▞▀▖      ▐  ▗           ▗▌
  #  ▚▄ ▞▀▖▞▀▖▜▀ ▄ ▞▀▖▛▀▖ ▟▟▖ ▌
  #  ▖ ▌▛▀ ▌ ▖▐ ▖▐ ▌ ▌▌ ▌ ▟▟▖ ▌
  #  ▝▀ ▝▀▘▝▀  ▀ ▀▘▝▀ ▘ ▘ ▝▝ ▝▀

  assertDirectoryDoesNotExist "$testDir/bin/build" || return $?

  assertFileContains "$testBinBuild" "make the file different" || return $?

  matches=(
    --stdout-match "install-bin-build.sh"
    --stdout-no-match "rubs.sh"
    --stdout-no-match "already installed"
    --stdout-no-match "does not ignore"
    --stdout-match "Installed"
  )

  assertExitCode --dump "${matches[@]}" 0 "$testDir/bin/pipeline/install-bin-build.sh" --mock "$home/bin/build" || return $?
  assertFileDoesNotContain --line "$LINENO" "$testBinBuild" "make the file different" || return $?
  assertFileContains --line "$LINENO" "$testBinBuild" "__installPackageConfiguration ../.. " || return $?

  catchReturn "$handler" rm -rf "$testDir/bin/build" || return $?

  # --------------------------------------------------------------------------------
  #
  clearLine
  catchEnvironment "$handler" cp "$home/bin/build/install-bin-build.sh" "$testBinBuild" || return $?
  boxedHeading "Has gitignore (missing), missing, different name"
  section=$((section + 1))
  bigText "Section #$section"

  #  ▞▀▖      ▐  ▗           ▞▀▖
  #  ▚▄ ▞▀▖▞▀▖▜▀ ▄ ▞▀▖▛▀▖ ▟▟▖ ▗▘
  #  ▖ ▌▛▀ ▌ ▖▐ ▖▐ ▌ ▌▌ ▌ ▟▟▖▗▘
  #  ▝▀ ▝▀▘▝▀  ▀ ▀▘▝▀ ▘ ▘ ▝▝ ▀▀▘

  assertDirectoryDoesNotExist --line "$LINENO" bin/build || return $?

  touch "$testDir/.gitignore" || return $?
  testBinBuild=bin/pipeline/we-like-head-rubs.sh
  assertExitCode 0 mv bin/pipeline/install-bin-build.sh "$testBinBuild" || return $?
  # Test
  matches=(
    --stdout-match "we-like-head-rubs.sh"
    --stdout-no-match "install-bin-build.sh"

    --stdout-match "Installed"
    --stdout-no-match "already installed"

    --stdout-match "does not ignore"
    --stdout-match ".gitignore"
  )
  clearLine

  # pause "$(pwd)/bin/pipeline/we-like-head-rubs.sh --mock $home/bin/build"
  # assertExitCode --dump --line "$LINENO" "${matches[@]}" 0 bin/pipeline/we-like-head-rubs.sh  || return $?
  assertExitCode --dump --line "$LINENO" "${matches[@]}" 0 bin/pipeline/we-like-head-rubs.sh --mock "$home/bin/build" || return $?

  catchEnvironment "$handler" cp "$home/bin/build/install-bin-build.sh" "$testBinBuild" || return $?
  clearLine
  boxedHeading "Has gitignore (missing), bin/build exists, different name"
  section=$((section + 1))
  bigText "Section #$section"

  #  ▞▀▖      ▐  ▗           ▞▀▖
  #  ▚▄ ▞▀▖▞▀▖▜▀ ▄ ▞▀▖▛▀▖ ▟▟▖ ▄▘
  #  ▖ ▌▛▀ ▌ ▖▐ ▖▐ ▌ ▌▌ ▌ ▟▟▖▖ ▌
  #  ▝▀ ▝▀▘▝▀  ▀ ▀▘▝▀ ▘ ▘ ▝▝ ▝▀

  # Change
  : Already installed

  matches=(
    --stdout-no-match "we-like-head-rubs.sh"
    --stdout-no-match "install-bin-build.sh"

    --stdout-match "Newest version installed"
    --stdout-no-match "already"

    --stdout-match "does not ignore"
    --stdout-match ".gitignore"
  )
  assertExitCode --dump --line "$LINENO" "${matches[@]}" 0 "$testBinBuild" || return $?
  assertDirectoryExists --line "$LINENO" bin/build || return $?

  catchEnvironment "$handler" cp "$home/bin/build/install-bin-build.sh" "$testBinBuild" || return $?
  boxedHeading "Has gitignore (correct), bin/build exists, different name"

  #  ▞▀▖      ▐  ▗           ▌ ▌
  #  ▚▄ ▞▀▖▞▀▖▜▀ ▄ ▞▀▖▛▀▖ ▟▟▖▚▄▌
  #  ▖ ▌▛▀ ▌ ▖▐ ▖▐ ▌ ▌▌ ▌ ▟▟▖  ▌
  #  ▝▀ ▝▀▘▝▀  ▀ ▀▘▝▀ ▘ ▘ ▝▝   ▘

  section=$((section + 1))
  bigText "Section #$section"

  # Change
  echo "/bin/build/" >>.gitignore

  # .gitignore errors reversed
  matches=(
    --stdout-match "Newest version installed"
    --stdout-no-match "install-bin-build.sh"

    --stdout-no-match "already"

    --stdout-no-match "does not ignore"
    --stdout-no-match ".gitignore"
  )
  assertExitCode --dump --line "$LINENO" "${matches[@]}" 0 bin/pipeline/we-like-head-rubs.sh --mock "$home/bin/build" || return $?
  # Check

  catchEnvironment "$handler" muzzle popd || return $?
  catchReturn "$handler" rm -rf "$testDir" || return $?
}
_testInstallBinBuild() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

testBuildEnvironmentLoad() {
  local handler="returnMessage"
  local tempDir target

  tempDir=$(fileTemporaryName "$handler" -d) || return $?

  target="$tempDir/FOO.sh"
  BUILD_ENVIRONMENT_DIRS="$tempDir" assertNotExitCode --stderr-match Missing --line "$LINENO" 0 buildEnvironmentLoad FOO || return $?
  catchEnvironment "$handler" touch "$target" || return $?
  BUILD_ENVIRONMENT_DIRS="$tempDir" assertNotExitCode --stderr-match Missing --line "$LINENO" 0 buildEnvironmentLoad FOO || return $?
  printf "%s\n" "#!/usr/bin/env bash" >"$target"
  BUILD_ENVIRONMENT_DIRS="$tempDir" assertNotExitCode --stderr-match Missing --line "$LINENO" 0 buildEnvironmentLoad FOO || return $?
  catchEnvironment "$handler" chmod +x "$target" || return $?
  BUILD_ENVIRONMENT_DIRS="$tempDir" assertExitCode 0 buildEnvironmentLoad FOO || return $?

  assertEquals "${FOO-}" "" || return $?

  printf "%s\n" "export FOO" "FOO=hello" >>"$target"
  BUILD_ENVIRONMENT_DIRS="$tempDir" assertExitCode --leak FOO --line "$LINENO" 0 buildEnvironmentLoad FOO || return $?

  assertEquals "${FOO-}" "hello" || return $?

  unset FOO

  catchReturn "$handler" rm -rf "$tempDir" || return $?
}

testBuildEnvironmentGet() {
  local handler="returnMessage"
  local tempDir target

  tempDir=$(fileTemporaryName "$handler" -d) || return $?

  target="$tempDir/FOO.sh"
  BUILD_ENVIRONMENT_DIRS="$tempDir" assertNotExitCode --stderr-match Missing --line "$LINENO" 0 buildEnvironmentGet FOO || return $?
  catchEnvironment "$handler" touch "$target" || return $?
  BUILD_ENVIRONMENT_DIRS="$tempDir" assertNotExitCode --stderr-match Missing --line "$LINENO" 0 buildEnvironmentGet FOO || return $?
  printf "%s\n" "#!/usr/bin/env bash" >"$target"
  BUILD_ENVIRONMENT_DIRS="$tempDir" assertNotExitCode --stderr-match Missing --line "$LINENO" 0 buildEnvironmentGet FOO || return $?
  catchEnvironment "$handler" chmod +x "$target" || return $?
  BUILD_ENVIRONMENT_DIRS="$tempDir" assertExitCode 0 buildEnvironmentGet FOO || return $?

  assertEquals "${FOO-}" "" || return $?

  printf "%s\n" "export FOO" "FOO=hello" >>"$target"
  BUILD_ENVIRONMENT_DIRS="$tempDir" assertExitCode --leak FOO --line "$LINENO" --stdout-match "hello" 0 buildEnvironmentGet FOO || return $?

  assertEquals "${FOO-}" "hello" || return $?

  unset FOO

  catchReturn "$handler" rm -rf "$tempDir" || return $?
}

# Tag: php-install simple-php
testUnderscoreUnderscoreBuild() {
  local handler="returnMessage"
  local testPath home

  home=$(catchReturn "$handler" buildHome) || return $?
  testPath=$(fileTemporaryName "$handler" -d) || return $?
  catchEnvironment "$handler" cp -R "$home/test/example/simple-php" "$testPath/app" || return $?
  assertExitCode 0 installInstallBuild --local "$testPath/app/bin" "$testPath/app" || return $?
  catchEnvironment "$handler" cp -R "$home/bin/build" "$testPath/app/bin/build" || return $?

  APPLICATION_ID=testID.$$ assertExitCode --dump --line "$LINENO" 0 "$testPath/app/bin/build.sh" || return $?

  catchEnvironment "$handler" rm -rf "$testPath" || return $?
}
