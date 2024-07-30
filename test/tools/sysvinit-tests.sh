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
  sysvInitScriptUninstall install-bin-build.sh || :

  assertFileDoesNotExist --line "$LINENO" /etc/init.d/install-bin-build.sh || return $?
  assertExitCode --dump --line "$LINENO" 0 sysvInitScriptInstall bin/build/install-bin-build.sh || return $?
  assertFileExists --line "$LINENO" /etc/init.d/install-bin-build.sh || return $?

  assertExitCode --line "$LINENO" 0 sysvInitScriptUninstall install-bin-build.sh || return $?
  assertFileDoesNotExist --line "$LINENO" /etc/init.d/install-bin-build.sh || return $?
}
