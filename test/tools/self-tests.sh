#!/usr/bin/env bash
#
# self-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testBuildRunner() {
  assertExitCode --stderr-match "Hello, world" --line "$LINENO" 1 Build --verbose _return 1 "Hello, world" || return $?
  assertExitCode --stderr-match "welcome our" --line "$LINENO" 99 Build --verbose _return 99 "I. for one, welcome our ..." || return $?
  assertExitCode --stderr-match "bad arg" --line "$LINENO" 2 Build --verbose _return "NaN" "bad arg" || return $?
}

testBinBuildRequires() {
  local home

  home=$(__environment buildHome) || return $?

  bashCheckRequires --ignore-prefix __decorateExtension --require --unused --report "$home/bin/build/install-bin-build.sh" || return $?
  bashCheckRequires --ignore-prefix __decorateExtension --require --unused --report "$home/bin/build/map.sh" || return $?
  bashCheckRequires --require --unused --report "$home/bin/build/need-bash.sh" || return $?
}

testBuildEnvironmentLoadAll() {
  local usage="_return"
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
    MARIADB_BINARY_DUMP
    OSTYPE
    PATH
  )

  home=$(__environment buildHome) || return $?
  tempFile=$(fileTemporaryName "$usage")

  find "$home" -type f -name '*.sh' -path '*/env/*' ! -path '*/test/*' ! -path '*/.*/*' -exec basename {} \; | cut -d . -f 1 | dumpPipe "All env files found"
  while read -r loadIt; do
    (
      local envFile
      export "${loadIt?}"
      buildEnvironmentLoad --print "$loadIt" >"$tempFile" || _environment "buildEnvironmentLoad $loadIt failed" return $?
      envFile="$(cat "$tempFile")"
      assertFileExists --line "$LINENO" "$envFile" || return $?

      # statusMessage decorate info Loaded "$loadIt=${!loadIt}"
      if inArray "$loadIt" "${nonBlankEnvs[@]}"; then
        assertNotEquals --line "$LINENO" --display "Loaded $loadIt is non-blank: \"${!loadIt}\"" "${!loadIt}" "" || return $?
      fi
      assertFileContains --line "$LINENO" "$envFile" "# Type:" "# Category:" || return $?

      local type
      type=$(grep -m 1 -e "^# Type:" "$envFile" | cut -f 2 -d : | trimSpace)

      validator="usageArgument$type"
      isFunction "$validator" || _environment "$type is not a known type in $(decorate file "$envFile")" || return $?
    ) || return $?
  done < <(find "$home" -type f -name '*.sh' -path '*/env/*' ! -path '*/test/*' ! -path '*/.*/*' -exec basename {} \; | cut -d . -f 1) || return $?
  __catchEnvironment "$usage" rm -rf "$tempFile" || return $?
}

testBuildFunctions() {
  local fun

  fun=$(__environment mktemp) || return $?
  buildFunctions >"$fun" || _environment "buildFunctions failed" || return $?

  assertFileContains "$fun" buildFunctions __environment _argument _environment __catch housekeeper || return $?

  __environment rm -f "$fun" || return $?
}

testInstallInstallBuildSelf() {
  local tempD
  export BUILD_COMPANY

  tempD=$(mktemp -d) || _environment mktemp || return $?

  __environment buildEnvironmentLoad BUILD_COMPANY || return $?
  __environment mkdir -p "$tempD/a/b/c/d/e/f" || return $?

  assertFileDoesNotExist "$tempD/a/b/c/d/e/f/install-bin-build.sh" || return $?
  assertExitCode --stdout-match '../../../../../..' 0 installInstallBuild "$tempD/a/b/c/d/e/f" "$tempD" || return $?
  assertFileExists "$tempD/a/b/c/d/e/f/install-bin-build.sh" || return $?
  assertFileContains "$tempD/a/b/c/d/e/f/install-bin-build.sh" "${BUILD_COMPANY}" || return $?

  rm -rf "$tempD" || :

  unset BUILD_COMPANY
}

# Test that urlFetch works for remote installs
testInstallBinBuildNetwork() {
  local testDir testBinBuild section home matches
  local handler=_return

  home=$(__catchEnvironment "$handler" buildHome) || return $?

  testDir=$(mktemp -d)
  testBinBuild="$testDir/bin/pipeline/install-bin-build.sh"
  __catchEnvironment "$handler" cd "$testDir" || return $?

  __catchEnvironment "$handler" mkdir -p bin/pipeline || return $?
  __catchEnvironment "$handler" cp "$home/bin/build/install-bin-build.sh" "$testBinBuild" || return $?
  __catchEnvironment "$handler" echo '# this make the file different' >>"$testBinBuild" || return $?

  assertDirectoryDoesNotExist --line "$LINENO" "$testDir/bin/build" || return $?
  assertFileDoesNotExist --line "$LINENO" "$testDir/bin/build/tools.sh" || return $?

  assertExitCode --line "$LINENO" 0 "$testBinBuild" --force --url 'https://github.com/zesk/build/archive/refs/tags/v0.21.0.tar.gz' || return $?
  assertDirectoryExists --line "$LINENO" "$testDir/bin/build" || return $?
  assertFileExists --line "$LINENO" "$testDir/bin/build/tools.sh" || return $?
}

#
# fn: {base}
# Usage: {fn} buildHome
#
testInstallBinBuild() {
  local handler="_${FUNCNAME[0]}"
  local testDir testBinBuild section home matches

  home=$(__catchEnvironment "$handler" buildHome) || return $?
  assertDirectoryExists "$BUILD_HOME" || return $?
  section=0
  testDir=$(mktemp -d)
  testBinBuild="$testDir/bin/pipeline/install-bin-build.sh"
  __catchEnvironment "$handler" cd "$testDir" || return $?

  __catchEnvironment "$handler" mkdir -p bin/pipeline || return $?
  __catchEnvironment "$handler" cp "$home/bin/build/install-bin-build.sh" "$testBinBuild" || return $?
  __catchEnvironment "$handler" printf -- '%s\n' '# this make the file different' >>"$testBinBuild" || return $?

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

  assertDirectoryDoesNotExist --line "$LINENO" "$testDir/bin/build" || return $?

  assertFileContains --line "$LINENO" "$testBinBuild" "make the file different" || return $?

  matches=(
    --stdout-match "install-bin-build.sh"
    --stdout-no-match "rubs.sh"
    --stdout-no-match "already installed"
    --stdout-no-match "does not ignore"
    --stdout-match "Installed"
  )

  assertExitCode --dump --line "$LINENO" "${matches[@]}" 0 "$testDir/bin/pipeline/install-bin-build.sh" --mock "$home/bin/build" || return $?
  assertFileDoesNotContain --line "$LINENO" "$testBinBuild" "make the file different" || return $?
  assertFileContains --line "$LINENO" "$testBinBuild" "__installPackageConfiguration ../.. " || return $?

  rm -rf bin/build || return $?

  decorate success Success

  # --------------------------------------------------------------------------------
  #
  clearLine
  __catchEnvironment "$handler" cp "$home/bin/build/install-bin-build.sh" "$testBinBuild" || return $?
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

  __catchEnvironment "$handler" cp "$home/bin/build/install-bin-build.sh" "$testBinBuild" || return $?
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

  __catchEnvironment "$handler" cp "$home/bin/build/install-bin-build.sh" "$testBinBuild" || return $?
  boxedHeading "Has gitignore (correct), bin/build exists, different name"
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

  rm -rf "$testDir" || :

  decorate success Success
}
_testInstallBinBuild() {
  handlerDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

testBuildEnvironmentLoad() {
  local tempDir target

  tempDir=$(__environment mktemp -d) || return $?

  target="$tempDir/FOO.sh"
  BUILD_ENVIRONMENT_DIRS="$tempDir" assertNotExitCode --stderr-match Missing --line "$LINENO" 0 buildEnvironmentLoad FOO || return $?
  __environment touch "$target" || return $?
  BUILD_ENVIRONMENT_DIRS="$tempDir" assertNotExitCode --stderr-match Missing --line "$LINENO" 0 buildEnvironmentLoad FOO || return $?
  printf "%s\n" "#!/usr/bin/env bash" >"$target"
  BUILD_ENVIRONMENT_DIRS="$tempDir" assertNotExitCode --stderr-match Missing --line "$LINENO" 0 buildEnvironmentLoad FOO || return $?
  __environment chmod +x "$target" || return $?
  BUILD_ENVIRONMENT_DIRS="$tempDir" assertExitCode --line "$LINENO" 0 buildEnvironmentLoad FOO || return $?

  assertEquals --line "$LINENO" "${FOO-}" "" || return $?

  printf "%s\n" "export FOO" "FOO=hello" >>"$target"
  BUILD_ENVIRONMENT_DIRS="$tempDir" assertExitCode --leak FOO --line "$LINENO" 0 buildEnvironmentLoad FOO || return $?

  assertEquals --line "$LINENO" "${FOO-}" "hello" || return $?

  unset FOO
}

testBuildEnvironmentGet() {
  local tempDir target

  tempDir=$(__environment mktemp -d) || return $?

  target="$tempDir/FOO.sh"
  BUILD_ENVIRONMENT_DIRS="$tempDir" assertNotExitCode --stderr-match Missing --line "$LINENO" 0 buildEnvironmentGet FOO || return $?
  __environment touch "$target" || return $?
  BUILD_ENVIRONMENT_DIRS="$tempDir" assertNotExitCode --stderr-match Missing --line "$LINENO" 0 buildEnvironmentGet FOO || return $?
  printf "%s\n" "#!/usr/bin/env bash" >"$target"
  BUILD_ENVIRONMENT_DIRS="$tempDir" assertNotExitCode --stderr-match Missing --line "$LINENO" 0 buildEnvironmentGet FOO || return $?
  __environment chmod +x "$target" || return $?
  BUILD_ENVIRONMENT_DIRS="$tempDir" assertExitCode --line "$LINENO" 0 buildEnvironmentGet FOO || return $?

  assertEquals --line "$LINENO" "${FOO-}" "" || return $?

  printf "%s\n" "export FOO" "FOO=hello" >>"$target"
  BUILD_ENVIRONMENT_DIRS="$tempDir" assertExitCode --leak FOO --line "$LINENO" --stdout-match "hello" 0 buildEnvironmentGet FOO || return $?

  assertEquals --line "$LINENO" "${FOO-}" "hello" || return $?

  unset FOO
}

# Tag: package-install php-install simple-php
testUnderscoreUnderscoreBuild() {
  local testPath home

  home=$(__environment buildHome) || return $?
  testPath=$(__environment mktemp -d) || return $?
  __environment cp -R "$home/test/example/simple-php" "$testPath/app" || return $?
  assertExitCode --line "$LINENO" 0 installInstallBuild --local "$testPath/app/bin" "$testPath/app" || return $?
  __environment cp -R "$home/bin/build" "$testPath/app/bin/build" || return $?

  APPLICATION_ID=testID.$$ assertExitCode --dump --line "$LINENO" 0 "$testPath/app/bin/build.sh" || return $?
}
