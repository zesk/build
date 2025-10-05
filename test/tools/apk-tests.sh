#!/usr/bin/env bash
#
# apk-tests.sh
#
# Alpine tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
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
  #  echo "${BASH_SOURCE[0]}:$LINENO"
  assertExitCode 0 apkIsInstalled --help || return $?
  #  echo "${BASH_SOURCE[0]}:$LINENO"
  if isAlpine; then
    #    echo "${BASH_SOURCE[0]}:$LINENO"
    assertExitCode 0 apkIsInstalled || return $?
    #    echo "${BASH_SOURCE[0]}:$LINENO"
  fi
  #  echo "${BASH_SOURCE[0]}:$LINENO"

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
