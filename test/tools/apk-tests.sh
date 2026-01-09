#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# apk-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testIsAlpine() {
  isAlpine --help >/dev/null || return $?

  mockEnvironmentStart BUILD_DEBUG

  assertExitCode --stdout-match "an Alpine system" 0 isAlpine --help || return $?

  mockEnvironmentStop BUILD_DEBUG
}

testIsApkInstalled() {
  mockEnvironmentStart BUILD_DEBUG

  apkIsInstalled --help || return $?
  assertExitCode 0 apkIsInstalled --help || return $?
  if isAlpine; then
    assertExitCode 0 apkIsInstalled || return $?
  fi

  mockEnvironmentStop BUILD_DEBUG

}

testAlpineContainer() {
  if whichExists docker; then

    mockEnvironmentStart BUILD_DOCKER_IMAGE
    mockEnvironmentStart BUILD_DOCKER_PATH
    mockEnvironmentStart BUILD_DOCKER_PLATFORM
    mockEnvironmentStart LC_TERMINAL

    local handler="returnMessage" home

    home=$(catchReturn "$handler" buildHome) || return $?
    catchEnvironment "$handler" muzzle pushd "$home" || return $?

    # In BitBucket pipelines, only location you can run Alpine volume shares are within the initial build directory

    assertExitCode 0 alpineContainer echo "FOO=\"foo\"" || return $?
    local value

    value=$(trimSpace "$(alpineContainer echo "FOO=\"foo\"")")

    assertEquals "$value" "FOO=\"foo\"" || return $?

    catchEnvironment "$handler" muzzle popd || return $?

    mockEnvironmentStop BUILD_DOCKER_IMAGE
    mockEnvironmentStop BUILD_DOCKER_PATH
    mockEnvironmentStop BUILD_DOCKER_PLATFORM
    mockEnvironmentStop LC_TERMINAL

  fi
  return 0
}

# Test-Platform: alpine
testAlpineOnly() {
  assertExitCode 0 isAlpine || return $?
}

# Test-Platform: !darwin
# Test-Platform: !linux
testAlpineOnlyTheOtherWay() {
  assertExitCode 0 isAlpine || return $?
}
