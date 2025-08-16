#!/usr/bin/env bash
#
# docker-compose-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Tag: docker
testIsDockerComposeRunning() {
  local handler="_return"

  if whichExists docker; then
    local oldHome

    oldHome=$(__catch "$handler" buildHome) || return $?

    __mockValue BUILD_HOME

    export BUILD_HOME

    local newHome
    newHome=$(fileTemporaryName "$handler" -d) || return $?

    BUILD_HOME=$newHome
    __catchEnvironment "$handler" mkdir "$BUILD_HOME/bin" || return $?
    __catchEnvironment "$handler" cp -R "$oldHome/bin/build" "$BUILD_HOME/bin/build" || return $?
    __catchEnvironment "$handler" pushd "$BUILD_HOME" || return $?

    assertNotExitCode --stderr-match "Missing" --stderr-match ".STAGING.env" 0 dockerComposeIsRunning || return $?
    __catchEnvironment "$handler" touch "$BUILD_HOME/.STAGING.env" || return $?
    assertNotExitCode --stderr-match "Missing" --stderr-match "docker-compose.yml" 0 dockerComposeIsRunning || return $?

    __catchEnvironment "$handler" rm -rf "$newHome" || return $?
    __mockValueStop BUILD_HOME
  fi
}
