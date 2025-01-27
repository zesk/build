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
    assertExitCode --line "$LINENO" 0 alpineContainer echo "FOO=\"foo\"" || return $?
    local value
    value=$(trimSpace "$(alpineContainer echo "FOO=\"foo\"")")
    assertEquals --line "$LINENO" "$value" "FOO=\"foo\"" || return $?
  fi
  return 0
}

testDebugAlpineContainer() {
  if whichExists docker; then
    # __echo alpineContainer echo "FOO=\"foo\"" # TODO - parse error: Invalid numeric literal at line 2, column 0 on BitBucket pipelines
    # WTF? Where is this coming from?
    alpineContainer echo "FOO=\"foo\"" || :
    echo "${BASH_SOURCE[0]}:$LINENO"
    buildEnvironmentLoad LC_TERMINAL TERM || :
    echo "${BASH_SOURCE[0]}:$LINENO"
    # shellcheck disable=SC2016
    dockerLocalContainer --image alpine:latest --path /root/build --env LC_TERMINAL="$LC_TERMINAL" --env TERM="$TERM" /root/build/bin/build/need-bash.sh Alpine apk add bash ncurses -- echo '$(uname)' || :
    echo "${BASH_SOURCE[0]}:$LINENO"
    dockerImages --filter alpine:latest
    echo "${BASH_SOURCE[0]}:$LINENO"
    docker images --format json
    echo "${BASH_SOURCE[0]}:$LINENO"
    docker images --format json --filter "reference=alpine:latest"
    echo "${BASH_SOURCE[0]}:$LINENO"
    docker images --format json --filter "reference=alpine:latest" | jq -r '.Repository + ":" + .Tag'
    echo "${BASH_SOURCE[0]}:$LINENO"
  fi
}
