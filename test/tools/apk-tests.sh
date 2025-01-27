#!/usr/bin/env bash
#
# apk-tests.sh
#
# Alpine tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testIsAlpine() {
  isAlpine --help >/dev/null || return $?

  __mockValue BUILD_DEBUG

  assertExitCode --line "$LINENO" --stdout-match "an Alpine system" 0 isAlpine --help || return $?

  __mockValue BUILD_DEBUG "" --end
}

testIsApkInstalled() {
  apkIsInstalled --help >/dev/null || return $?
  assertExitCode 0 muzzle apkIsInstalled --help || return $?
  if isAlpine; then
    assertExitCode --line "$LINENO" 0 apkIsInstalled || return $?
  fi
}

testAlpineContainer() {
  if whichExists docker; then
    __echo alpineContainer echo "FOO=\"foo\"" # TODO - parse error: Invalid numeric literal at line 2, column 0 on BitBucket pipelines
    assertExitCode --line "$LINENO" 0 alpineContainer echo "FOO=\"foo\"" || return $?
    assertEquals --line "$LINENO" "$(alpineContainer echo "FOO=\"foo\"")" "FOO=\"foo\"" || return $?
  fi
}
