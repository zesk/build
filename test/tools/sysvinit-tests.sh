#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# sysvinit-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testSysvInitScript() {
  local handler="returnMessage"
  local home

  home=$(catchReturn "$handler" buildHome) || return $?
  sysvInitScriptUninstall install-bin-build.sh || :

  assertFileDoesNotExist --line "$LINENO" /etc/init.d/install-bin-build.sh || return $?
  assertExitCode 0 sysvInitScriptInstall "$home/bin/build/install-bin-build.sh" || return $?
  assertFileExists /etc/init.d/install-bin-build.sh || return $?

  assertExitCode 0 sysvInitScriptUninstall install-bin-build.sh || return $?
  assertFileDoesNotExist --line "$LINENO" /etc/init.d/install-bin-build.sh || return $?
}
