#!/usr/bin/env bash
#
# package-tests.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

testPackageAPI() {
  local ourTestBinary=ronn ourTestPackage=ronn

  assertNotExitCode --line "$LINENO" 0 packageNeedRestartFlag || return $?
  assertExitCode --line "$LINENO" 0 packageUpdate --force || return $?
  assertExitCode --line "$LINENO" 0 packageNeedRestartFlag yes || return $?
  assertExitCode --line "$LINENO" 0 packageNeedRestartFlag || return $?
  assertExitCode --line "$LINENO" 0 packageNeedRestartFlag "" || return $?
  assertNotExitCode --line "$LINENO" 0 packageNeedRestartFlag || return $?

  assertExitCode --line "$LINENO" 0 packageWhichUninstall "$ourTestBinary" "$ourTestPackage" || return $?
  assertOutputNotContains --line "$LINENO" "$ourTestPackage" packageInstalledList || return $?
  assertExitCode --line "$LINENO" 0 packageWhich --force "$ourTestBinary" "$ourTestPackage" || return $?
  assertOutputContains --line "$LINENO" "$ourTestPackage" packageInstalledList || return $?
  assertExitCode --line "$LINENO" 0 packageManagerValid apk || return $?
  assertExitCode --line "$LINENO" 0 packageManagerValid apt || return $?
  assertExitCode --line "$LINENO" 0 packageManagerValid brew || return $?
  assertNotExitCode --line "$LINENO" 0 packageManagerValid apt-get || return $?
  assertExitCode --line "$LINENO" 0 packageManagerValid "$(packageManagerDefault)" || return $?
}
