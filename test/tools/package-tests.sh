#!/usr/bin/env bash
#
# package-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testPackageAPI() {
  local ourTestBinary=ronn ourTestPackage=ronn

  assertNotExitCode 0 packageNeedRestartFlag || return $?
  assertExitCode 0 packageUpdate --force || return $?
  assertExitCode 0 packageNeedRestartFlag yes || return $?
  assertExitCode 0 packageNeedRestartFlag || return $?
  assertExitCode 0 packageNeedRestartFlag "" || return $?
  assertNotExitCode 0 packageNeedRestartFlag || return $?

  assertExitCode 0 packageWhichUninstall "$ourTestBinary" "$ourTestPackage" || return $?
  local installed

  IFS=$'\n' read -d '' -r -a installed < <(packageInstalledList) || :
  assertGreaterThan --line "$LINENO" "${#installed[@]}" 0 || return $?
  assertNotExitCode 0 inArray "$ourTestPackage" "${installed[@]}" || return $?

  assertExitCode 0 packageWhich --force "$ourTestBinary" "$ourTestPackage" || return $?

  IFS=$'\n' read -d '' -r -a installed < <(packageInstalledList) || :
  assertGreaterThan --line "$LINENO" "${#installed[@]}" 0 || return $?
  assertExitCode 0 inArray "$ourTestPackage" "${installed[@]}" || return $?

  assertExitCode 0 packageManagerValid apk || return $?
  assertExitCode 0 packageManagerValid apt || return $?
  assertExitCode 0 packageManagerValid brew || return $?
  assertNotExitCode 0 packageManagerValid apt-get || return $?
  assertExitCode 0 packageManagerValid "$(packageManagerDefault)" || return $?
}
