#!/usr/bin/env bash
#
# api-tests.sh
#
# API tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testSysvInitScript() {
  sysvInitScriptUninstall install-bin-build.sh || :

  assertFileDoesNotExist --line "$LINENO" /etc/init.d/install-bin-build.sh || return $?
  assertExitCode --line "$LINENO" 0 sysvInitScriptInstall bin/build/install-bin-build.sh || return $?
  assertFileExists --line "$LINENO" /etc/init.d/install-bin-build.sh || return $?

  assertExitCode --line "$LINENO" 0 sysvInitScriptUninstall install-bin-build.sh || return $?
  assertFileDoesNotExist --line "$LINENO" /etc/init.d/install-bin-build.sh || return $?
}
