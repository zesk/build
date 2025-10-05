#!/usr/bin/env bash
#
# docker-compose-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Tag: docker
testIsDockerComposeRunning() {
  local handler="returnMessage"

  if whichExists docker; then
    local oldHome

    oldHome=$(catchReturn "$handler" buildHome) || return $?

    mockEnvironmentStart BUILD_HOME

    export BUILD_HOME

    local newHome
    newHome=$(fileTemporaryName "$handler" -d) || return $?

    BUILD_HOME=$newHome
    catchEnvironment "$handler" mkdir "$BUILD_HOME/bin" || return $?
    catchEnvironment "$handler" cp -R "$oldHome/bin/build" "$BUILD_HOME/bin/build" || return $?
    catchEnvironment "$handler" pushd "$BUILD_HOME" || return $?

    assertNotExitCode --stderr-match "Missing" --stderr-match ".STAGING.env" 0 dockerComposeIsRunning || return $?
    catchEnvironment "$handler" touch "$BUILD_HOME/.STAGING.env" || return $?
    assertNotExitCode --stderr-match "Missing" --stderr-match "docker-compose.yml" 0 dockerComposeIsRunning || return $?

    catchEnvironment "$handler" rm -rf "$newHome" || return $?
    mockEnvironmentStop BUILD_HOME
  fi
}
