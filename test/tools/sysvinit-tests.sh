#!/usr/bin/env bash
#
# api-tests.sh
#
# API tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# errorEnvironment=1

declare -a tests

tests+=(testSysvInitScript)
testSysvInitScript() {
  assertFileDoesNotExist /etc/init.d/install-bin-build.sh || return $?
  assertExitCode 0 sysvInitScript bin/build/install-bin-build.sh || return $?
  assertFileExists /etc/init.d/install-bin-build.sh || return $?

  assertExitCode 0 sysvInitScript --remove install-bin-build.sh || return $?
  assertFileDoesNotExist /etc/init.d/install-bin-build.sh || return $?
}
