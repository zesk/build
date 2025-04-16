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

  assertExitCode --stdout-match "an Alpine system" 0 isAlpine --help || return $?

  __mockValue BUILD_DEBUG "" --end
}

testIsApkInstalled() {
  __mockValue BUILD_DEBUG

  apkIsInstalled --help || return $?
  #  echo "${BASH_SOURCE[0]}:$LINENO"
  assertExitCode 0 apkIsInstalled --help || return $?
  #  echo "${BASH_SOURCE[0]}:$LINENO"
  if isAlpine; then
    #    echo "${BASH_SOURCE[0]}:$LINENO"
    assertExitCode 0 apkIsInstalled || return $?
    #    echo "${BASH_SOURCE[0]}:$LINENO"
  fi
  #  echo "${BASH_SOURCE[0]}:$LINENO"

  __mockValue BUILD_DEBUG "" --end

}

testAlpineContainer() {
  if whichExists docker; then
    assertExitCode 0 alpineContainer echo "FOO=\"foo\"" || return $?
    local value

    value=$(trimSpace "$(alpineContainer echo "FOO=\"foo\"")")

    assertEquals "$value" "FOO=\"foo\"" || return $?
  fi
  return 0
}
