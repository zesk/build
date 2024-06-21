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

tests+=(testInstallInstallBuild)

testInstallInstallBuild() {
  local tempD
  export BUILD_COMPANY

  tempD=$(mktemp -d) || _environment mktemp || return $?

  __environment buildEnvironmentLoad BUILD_COMPANY || return $?
  __environment mkdir -p "$tempD/a/b/c/d/e/f" || return $?

  assertFileDoesNotExist "$tempD/a/b/c/d/e/f/install-bin-build.sh" || return $?
  assertExitCode --stdout-match '../../../../../..' 0 installInstallBuild "$tempD/a/b/c/d/e/f" "$tempD" || return $?
  assertFileExists "$tempD/a/b/c/d/e/f/install-bin-build.sh" || return $?
  assertFileContains "$tempD/a/b/c/d/e/f/install-bin-build.sh" "${BUILD_COMPANY}" || return $?

  rm -rf "$tempD" || :

  unset BUILD_COMPANY
}
