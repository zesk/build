#!/usr/bin/env bash
#
# self-tests.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

testBuildEnvironmentLoadAll() {
  local home loadIt nonBlankEnvs=(
    APACHE_HOME
    APPLICATION_BUILD_DATE
    APPLICATION_CODE
    APPLICATION_CODE
    APPLICATION_NAME
    BUILD_CACHE
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

  while read -r loadIt; do
    (
      export "${loadIt?}"
      buildEnvironmentLoad "$loadIt" || _environment "buildEnvironmentLoad $loadIt failed" return $?
      # statusMessage decorate info Loaded "$loadIt=${!loadIt}"
      if inArray "$loadIt" "${nonBlankEnvs[@]}"; then
        assertNotEquals --line "$LINENO" --display "Loaded $loadIt is non-blank: \"${!loadIt}\"" "${!loadIt}" "" || return $?
      fi
    ) || return $?
  done < <(find "$home" -type f -name '*.sh' -path '*/env/*' ! -path '*/test/*' -exec basename {} \; | cut -d . -f 1) || return $?
}

testBuildFunctions() {
  local fun

  fun=$(__environment mktemp) || return $?
  buildFunctions >"$fun" || _environment "buildFunctions failed" || return $?

  assertFileContains "$fun" buildFunctions assertExitCode __environment _argument _environment _command _format __usage housekeeper || return $?

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

#
# fn: {base}
# Usage: {fn} buildHome
#
testInstallBinBuild() {
  local usage="_${FUNCNAME[0]}"
  local testDir testBinBuild section buildHome matches

  export BUILD_HOME
  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_HOME || return $?
  buildHome="${BUILD_HOME-}"
  assertDirectoryExists "$BUILD_HOME" || return $?
  section=0
  testDir=$(mktemp -d)
  testBinBuild="$testDir/bin/pipeline/install-bin-build.sh"
  __usageEnvironment "$usage" cd "$testDir" || return $?

  __usageEnvironment "$usage" mkdir -p bin/pipeline || return $?
  __usageEnvironment "$usage" cp "$buildHome/bin/build/install-bin-build.sh" "$testBinBuild" || return $?
  __usageEnvironment "$usage" echo '# this make the file different' >>"$testBinBuild" || return $?

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

  assertExitCode --dump --line "$LINENO" "${matches[@]}" 0 "$testDir/bin/pipeline/install-bin-build.sh" --mock "$buildHome/bin/build" || return $?
  assertFileDoesNotContain --line "$LINENO" "$testBinBuild" "make the file different" || return $?
  assertFileContains --line "$LINENO" "$testBinBuild" "__installPackageConfiguration ../.. " || return $?

  rm -rf bin/build || return $?

  decorate success Success

  # --------------------------------------------------------------------------------
  #
  clearLine
  __usageEnvironment "$usage" cp "$buildHome/bin/build/install-bin-build.sh" "$testBinBuild" || return $?
  boxedHeading "Has gitignore (missing), missing, different name"
  section=$((section + 1))
  bigText "Section #$section"

  #  ▞▀▖      ▐  ▗           ▞▀▖
  #  ▚▄ ▞▀▖▞▀▖▜▀ ▄ ▞▀▖▛▀▖ ▟▟▖ ▗▘
  #  ▖ ▌▛▀ ▌ ▖▐ ▖▐ ▌ ▌▌ ▌ ▟▟▖▗▘
  #  ▝▀ ▝▀▘▝▀  ▀ ▀▘▝▀ ▘ ▘ ▝▝ ▀▀▘

  assertDirectoryDoesNotExist --line "$LINENO" bin/build || return $?

  touch .gitignore || return $?
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

  # pause "$(pwd)/bin/pipeline/we-like-head-rubs.sh --mock $buildHome/bin/build"
  # assertExitCode --dump --line "$LINENO" "${matches[@]}" 0 bin/pipeline/we-like-head-rubs.sh  || return $?
  assertExitCode --dump --line "$LINENO" "${matches[@]}" 0 bin/pipeline/we-like-head-rubs.sh --mock "$buildHome/bin/build" || return $?

  __usageEnvironment "$usage" cp "$buildHome/bin/build/install-bin-build.sh" "$testBinBuild" || return $?
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
    --stdout-match "we-like-head-rubs.sh"
    --stdout-no-match "install-bin-build.sh"

    --stdout-no-match "Installed"
    --stdout-match "already installed"

    --stdout-match "does not ignore"
    --stdout-match ".gitignore"
  )
  assertExitCode --dump --line "$LINENO" "${matches[@]}" 0 "$testBinBuild" || return $?
  assertDirectoryExists --line "$LINENO" bin/build || return $?

  __usageEnvironment "$usage" cp "$buildHome/bin/build/install-bin-build.sh" "$testBinBuild" || return $?
  boxedHeading "Has gitignore (correct), bin/build exists, different name"
  section=$((section + 1))
  bigText "Section #$section"

  # Change
  echo "/bin/build/" >>.gitignore

  # .gitignore errors reversed
  matches=(
    --stdout-match "we-like-head-rubs.sh"
    --stdout-no-match "install-bin-build.sh"

    --stdout-no-match "Installed"
    --stdout-match "already installed"

    --stdout-no-match "does not ignore"
    --stdout-no-match ".gitignore"
  )
  assertExitCode --dump --line "$LINENO" "${matches[@]}" 0 bin/pipeline/we-like-head-rubs.sh --mock "$buildHome/bin/build" || return $?
  # Check

  rm -rf "$testDir" || :

  decorate success Success
}
_testInstallBinBuild() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

testBuildEnvironmentLoad() {
  local tempDir target

  tempDir=$(__environment mktemp -d) || return $?

  target="$tempDir/FOO.sh"
  BUILD_ENVIRONMENT_PATH="$tempDir" assertNotExitCode --stderr-match Missing --line "$LINENO" 0 buildEnvironmentLoad FOO || return $?
  __environment touch "$target" || return $?
  BUILD_ENVIRONMENT_PATH="$tempDir" assertNotExitCode --stderr-match Missing --line "$LINENO" 0 buildEnvironmentLoad FOO || return $?
  printf "%s\n" "#!/usr/bin/env bash" >"$target"
  BUILD_ENVIRONMENT_PATH="$tempDir" assertNotExitCode --stderr-match Missing --line "$LINENO" 0 buildEnvironmentLoad FOO || return $?
  __environment chmod +x "$target" || return $?
  BUILD_ENVIRONMENT_PATH="$tempDir" assertExitCode --line "$LINENO" 0 buildEnvironmentLoad FOO || return $?

  assertEquals --line "$LINENO" "${FOO-}" "" || return $?

  printf "%s\n" "export FOO" "FOO=hello" >>"$target"
  BUILD_ENVIRONMENT_PATH="$tempDir" assertExitCode --leak FOO --line "$LINENO" 0 buildEnvironmentLoad FOO || return $?

  assertEquals --line "$LINENO" "${FOO-}" "hello" || return $?

  unset FOO
}

testBuildEnvironmentGet() {
  local tempDir target

  tempDir=$(__environment mktemp -d) || return $?

  target="$tempDir/FOO.sh"
  BUILD_ENVIRONMENT_PATH="$tempDir" assertNotExitCode --stderr-match Missing --line "$LINENO" 0 buildEnvironmentGet FOO || return $?
  __environment touch "$target" || return $?
  BUILD_ENVIRONMENT_PATH="$tempDir" assertNotExitCode --stderr-match Missing --line "$LINENO" 0 buildEnvironmentGet FOO || return $?
  printf "%s\n" "#!/usr/bin/env bash" >"$target"
  BUILD_ENVIRONMENT_PATH="$tempDir" assertNotExitCode --stderr-match Missing --line "$LINENO" 0 buildEnvironmentGet FOO || return $?
  __environment chmod +x "$target" || return $?
  BUILD_ENVIRONMENT_PATH="$tempDir" assertExitCode --line "$LINENO" 0 buildEnvironmentGet FOO || return $?

  assertEquals --line "$LINENO" "${FOO-}" "" || return $?

  printf "%s\n" "export FOO" "FOO=hello" >>"$target"
  BUILD_ENVIRONMENT_PATH="$tempDir" assertExitCode --leak FOO --line "$LINENO" --stdout-match "hello" 0 buildEnvironmentGet FOO || return $?

  assertEquals --line "$LINENO" "${FOO-}" "hello" || return $?

  unset FOO
}

testUnderscoreUnderscoreBuild() {
  local testPath home

  home=$(__environment buildHome) || return $?
  testPath=$(__environment mktemp -d) || return $?
  __environment cp -R "$home/test/example/simple-php" "$testPath/app" || return $?
  assertExitCode --line "$LINENO" 0 installInstallBuild --local "$testPath/app/bin" "$testPath/app" || return $?
  __environment cp -R "$home/bin/build" "$testPath/app/bin/build" || return $?

  APPLICATION_ID=testID.$$ assertExitCode --dump --line "$LINENO" 0 "$testPath/app/bin/build.sh" || return $?
}
