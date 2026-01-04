#!/usr/bin/env bash
#
# package-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Tag: package-install
testPackageAPI() {
  local ourTestBinary=ronn ourTestPackage=ronn

  assertNotExitCode 0 packageNeedRestartFlag || return $?
  assertExitCode 0 packageUpdate --force || return $?
  assertExitCode 0 packageUpgrade || return $?
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

testPackageAvailableList() {
  local handler="returnMessage"

  local temp

  temp=$(fileTemporaryName "$handler") || return $?
  catchEnvironment "$handler" packageAvailableList >"$temp" || return $?
  assertFileContains "$temp" mariadb mysql php python toilet || return $?
  catchEnvironment "$handler" rm -f "$temp" || return $?
}

# Tag: package-install
testPackageBasics() {
  assertExitCode 0 packageInstall zip || return $?
  assertExitCode 0 packageIsInstalled zip || return $?
  assertExitCode 0 packageUninstall zip || return $?
  assertNotExitCode 0 packageIsInstalled zip || return $?
  assertExitCode 0 packageGroupInstall mariadb || return $?
  assertExitCode 0 whichExists mariadb || return $?
  assertExitCode 0 packageGroupUninstall mariadb || return $?
  assertNotExitCode 0 whichExists mariadb || return $?

  assertOutputContains mariadb packageMapping mariadb || return $?
}

testPackageDefault() {
  assertExitCode --stderr-match "Need at least one name" 2 packageDefault || return $?
  assertExitCode --stdout-match mariadb 0 packageDefault mysql || return $?
  assertExitCode --stdout-match mariadb 0 packageDefault mariadb || return $?
}

# Tag: package-install
testPackageGroupWhich() {
  local binary
  binary=$(pcregrepBinary)
  assertExitCode 0 packageGroupWhich "$binary" pcregrep || return $?
}
