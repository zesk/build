#!/usr/bin/env bash
#
# docker-compose-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testIsDockerComposeRunning() {
  local usage="_return"

  if whichExists docker; then
    local oldHome

    oldHome=$(__catch "$usage" buildHome) || return $?

    __mockValue BUILD_HOME

    export BUILD_HOME

    BUILD_HOME=$(fileTemporaryName "$usage" -d) || return $?

    __catchEnvironment "$usage" mkdir "$BUILD_HOME/bin" || return $?
    __catchEnvironment "$usage" cp -R "$oldHome/bin/build" "$BUILD_HOME/bin/build" || return $?
    __catchEnvironment "$usage" pushd "$BUILD_HOME" || return $?

    assertNotExitCode --stderr-match "Missing" --stderr-match ".STAGING.env" 0 dockerComposeIsRunning || return $?
    __catchEnvironment "$usage" touch "$BUILD_HOME/.STAGING.env" || return $?
    assertNotExitCode --stderr-match "Missing" --stderr-match "docker-compose.yml" 0 dockerComposeIsRunning || return $?

    __mockValueStop BUILD_HOME
  fi
}
