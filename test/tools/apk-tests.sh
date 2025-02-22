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
  __mockValue BUILD_DEBUG

  apkIsInstalled --help || return $?
  #  echo "${BASH_SOURCE[0]}:$LINENO"
  assertExitCode --line "$LINENO" 0 apkIsInstalled --help || return $?
  #  echo "${BASH_SOURCE[0]}:$LINENO"
  if isAlpine; then
    #    echo "${BASH_SOURCE[0]}:$LINENO"
    assertExitCode --line "$LINENO" 0 apkIsInstalled || return $?
    #    echo "${BASH_SOURCE[0]}:$LINENO"
  fi
  #  echo "${BASH_SOURCE[0]}:$LINENO"

  __mockValue BUILD_DEBUG "" --end

}

testAlpineContainer() {
  if whichExists docker; then
    assertExitCode --line "$LINENO" 0 alpineContainer echo "FOO=\"foo\"" || return $?
    local value

    echo "${BASH_SOURCE[0]}:$LINENO" 1>&2
    docker images --help 1>&2
    echo docker images 1>&2
    docker images 1>&2
    echo docker images --format json 1>&2
    docker images --format json 1>&2

    value=$(trimSpace "$(alpineContainer echo "FOO=\"foo\"")")

    assertEquals --line "$LINENO" "$value" "FOO=\"foo\"" || return $?
  fi
  return 0
}
