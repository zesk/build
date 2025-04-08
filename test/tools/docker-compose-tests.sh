#!/usr/bin/env bash
#
# docker-compose-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testIsDockerComposeRunning() {
  if whichExists docker; then
    assertNotExitCode --stderr-match "Missing" --stderr-match "docker-compose.yml" 0 dockerComposeIsRunning || return $?
  fi
}
