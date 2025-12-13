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
    catchEnvironment "$handler" muzzle pushd "$BUILD_HOME" || return $?

    assertNotExitCode --stderr-match "Missing" --stderr-match "docker-compose.yml" 0 dockerComposeIsRunning || return $?
    catchEnvironment "$handler" touch "$BUILD_HOME/docker-compose.yml" || return $?

    assertNotExitCode --stderr-match "empty compose file" 0 dockerComposeIsRunning || return $?

    local lines=(
      "services:"
      "  web:"
      "    build:"
      "      context: ./"
      "      dockerfile: ./Dockerfile"
      "    ports:"
      "      - 4000:80"
    )
    catchEnvironment "$handler" printf "%s\n" "${lines[@]}" >"$BUILD_HOME/docker-compose.yml" || return $?
    dumpPipe docker-compose.yml <"$BUILD_HOME/docker-compose.yml"
    catchEnvironment "$handler" printf "%s\n" "FROM php:8.3-apache" >"$BUILD_HOME/Dockerfile" || return $?

    assertExitCode 1 dockerComposeIsRunning || return $?

    catchEnvironment "$handler" muzzle popd || return $?
    catchEnvironment "$handler" rm -rf "$newHome" || return $?
    catchEnvironment "$handler" cd "$oldHome" || return $?
    mockEnvironmentStop BUILD_HOME
  fi
}
