#!/usr/bin/env bash
#
# daemontools-tests.sh
#
# daemontools tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

declare -a tests

tests+=(daemontoolsTests)

daemontoolsTests() {
  local logPath

  __environment aptInstall daemontools || return $?

  logPath=$(mktemp -d)
  assertExitCode 0 daemontoolsInstallService --log "$logPath" "./test/example/lemon.sh" || return $?

  assertFileExists "/etc/service/lemon/run" || return $?
  assertFileExists "/etc/service/lemon/log/run" || return $?

  assertExitCode 0 daemontoolsRemoveService --log "$logPath" "./test/example/lemon.sh" || return $?

  daemontoolsRemoveService lemon

  assertFileDoesNotExist "/etc/service/lemon/run" || return $?
  assertFileDoesNotExist "/etc/service/lemon/log/run" || return $?
}
