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
  local installed

  IFS=$'\n' read -d '' -r -a installed < <(packageInstalledList) || :
  assertGreaterThan --line "$LINENO" "${#installed[@]}" 0 || return $?
  assertNotExitCode --line "$LINENO" 0 inArray "$ourTestPackage" "${installed[@]}" || return $?

  assertExitCode --dump --line "$LINENO" 0 packageWhich --force "$ourTestBinary" "$ourTestPackage" || return $?

  IFS=$'\n' read -d '' -r -a installed < <(packageInstalledList) || :
  assertGreaterThan --line "$LINENO" "${#installed[@]}" 0 || return $?
  assertExitCode --line "$LINENO" 0 inArray "$ourTestPackage" "${installed[@]}" || return $?

  assertExitCode --line "$LINENO" 0 packageManagerValid apk || return $?
  assertExitCode --line "$LINENO" 0 packageManagerValid apt || return $?
  assertExitCode --line "$LINENO" 0 packageManagerValid brew || return $?
  assertNotExitCode --line "$LINENO" 0 packageManagerValid apt-get || return $?
  assertExitCode --line "$LINENO" 0 packageManagerValid "$(packageManagerDefault)" || return $?
}
