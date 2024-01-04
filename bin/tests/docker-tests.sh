#!/usr/bin/env bash
#
# docker-tests.sh
#
# docker tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

declare -a tests
tests+=(testCheckDockerEnvFile)

testCheckDockerEnvFile() {
  local testFile=./bin/tests/example/bad.env
  assertExitCode 1 checkDockerEnvFile $testFile
  assertOutputContains --exit 1 HELLO checkDockerEnvFile $testFile
  assertOutputContains --exit 1 TEST_AWS_SECURITY_GROUP checkDockerEnvFile $testFile
  assertOutputContains --exit 1 DOLLAR checkDockerEnvFile $testFile
  assertOutputDoesNotContain --exit 1 GOOD checkDockerEnvFile $testFile
}
