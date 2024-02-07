#!/usr/bin/env bash
#
# deploy-tests.sh
#
# Deploy tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
errorEnvironment=1

declare -a tests
tests+=(testDeployApplication)

_testDeployApplicationSetup() {
  local home="$1" ts
  if ! d=$(mktemp -d); then
    return $errorEnvironment
  fi

  cd "$d" || exit
  mkdir -p live-app/public || return $?
  echo "start" >live-app/public/index.php

  # app
  mkdir -p app/.deploy || return $?
  mkdir -p app/bin/build || return $?
  cp -R "$home/bin/build" "app/bin" || return $?
  mkdir -p "app/public"
  printf '%s\n%s\n' "<?php" 'echo file_get_contents(dirname(__DIR__) . "/.deploy/APPLICATION_ID");' >./app/public/index.php

  cd app || return $?
  ts=$(date +%s)
  for t in 1a 2b 3c 4d; do
    printf %s "$ts" >timestamp.txt
    printf %s "$t" | tee .deploy/APPLICATION_ID >.deploy/APPLICATION_TAG
    echo "APPLICATION_ID=$t" >.env
    echo "APPLICATION_TAG=$t" >>.env
    mkdir -p "$d/DEPLOY/$t" || return $?
    tar cfz "$d/DEPLOY/$t/app.tar.gz" .deploy bin public timestamp.txt .env || return $?
    ts=$((ts + 1))
  done
  cd .. || return $?
  rm -rf app || return $?
  printf "%s" "$d"
}

_deployShowFiles() {
  find "$1" ! -path '*/bin/build/*' | prefixLines "$(consoleCode "DEPLOY root files:    ")$(consoleMagenta)"
  return $errorEnvironment
}

_testAssertDeploymentLinkages() {
  local d="$1"

  consoleInfo _testAssertDeploymentLinkages deployPreviousVersion tests
  assertEquals "" "$(deployPreviousVersion "$d/DEPLOY" "1a")" deployPreviousVersion "$d/DEPLOY" "1a" || return $?
  assertEquals "1a" "$(deployPreviousVersion "$d/DEPLOY" "2b")" deployPreviousVersion "$d/DEPLOY" "2b" || return $?
  assertEquals "2b" "$(deployPreviousVersion "$d/DEPLOY" "3c")" deployPreviousVersion "$d/DEPLOY" "3c" || return $?
  assertEquals "3c" "$(deployPreviousVersion "$d/DEPLOY" "4d")" deployPreviousVersion "$d/DEPLOY" "4d" || return $?

  consoleInfo _testAssertDeploymentLinkages deployNextVersion tests
  assertEquals "2b" "$(deployNextVersion "$d/DEPLOY" "1a")" deployNextVersion "$d/DEPLOY" "1a" || return $?
  assertEquals "3c" "$(deployNextVersion "$d/DEPLOY" "2b")" deployNextVersion "$d/DEPLOY" "2b" || return $?
  assertEquals "4d" "$(deployNextVersion "$d/DEPLOY" "3c")" deployNextVersion "$d/DEPLOY" "3c" || return $?
  assertEquals "" "$(deployNextVersion "$d/DEPLOY" "4d")" deployNextVersion "$d/DEPLOY" "4d" || return $?
}

_simplePHPServer() {
  local quietLog
  quietLog="$(buildQuietLog php-server)"
  php -S 127.0.0.1:6543 -t "$1/public/" >>"$quietLog" 2>&1 &
  printf %d $!
}

_simplePHPRequest() {
  curl -s "http://127.0.0.1:6543/index.php"
}
_warmupServer() {
  local start delta value

  start=$(beginTiming)
  consoleInfo -n "Warming server ..."
  while ! value="$(_simplePHPRequest)" || [ -z "$value" ]; do
    sleep 1
    delta=$(($(beginTiming) - start))
    if [ "$delta" -gt 5 ]; then
      consoleError "_warmupServer failed"
      return "$errorEnvironment"
    fi
    consoleGreen -n .
  done
  clearLine
  printf "%s %s\n" "$(consoleInfo "Server warmed up with value:")" "$(consoleCode "$value")"
}

testDeployApplication() {
  local d phpPid quietLog

  quietLog="$(buildQuietLog "${FUNCNAME[0]}")"
  if ! whichApt curl curl; then
    consoleError "Failed to install curl" 1>&2
    return $errorEnvironment
  fi
  if ! phpInstall; then
    consoleError "Failed to install phpInstall" 1>&2
    return $errorEnvironment
  fi

  set -eou pipefail

  home=$(pwd)

  if ! d="$(_testDeployApplicationSetup "$home")"; then
    consoleError _testDeployApplicationSetup failed
    return "$errorEnvironment"
  fi
  consoleNameValue 20 "Deploy Root" "$d"

  if ! phpPid=$(_simplePHPServer "$d/live-app"); then
    consoleError _simplePHPServer failed
    buildFailed "$quietLog"
    return "$errorEnvironment"
  fi
  if ! _warmupServer; then
    return $errorEnvironment
  fi

  consoleInfo _simplePHPServer started "$phpPid"
  # shellcheck disable=SC2064
  trap "kill $phpPid" INT TERM

  consoleNameValue 40 _simplePHPRequest "$(_simplePHPRequest)"
  assertEquals "start" "$(_simplePHPRequest)" "initial state of PHP server" || return $?

  for t in 1a 2b 3c 4d; do
    consoleInfo deployHasVersion $t test 1
    assertExitCode 0 deployHasVersion "$d/DEPLOY" "$t" || return $?
  done

  _deployShowFiles "$d" || :
  lastOne=
  firstArgs=(--first)
  for t in 1a 2b 3c 4d; do
    assertExitCode 0 deployHasVersion "$d/DEPLOY" $t || return $?
    if ! deployApplication "${firstArgs[@]+${firstArgs[@]}}" "$d/DEPLOY" "$t" "$d/live-app"; then
      consoleError "Deployment of $t failed"
      _deployShowFiles "$d" || return $?
    fi

    sleep 1
    consoleNameValue 40 _simplePHPRequest "$(_simplePHPRequest)"

    assertEquals "$t" "$(_simplePHPRequest)" "PHP application new version $t" || return $?
    clearLine
    _deployShowFiles "$d" || :
    assertEquals "$t" "$(deployApplicationVersion "$d/live-app")" || return $?
    if [ -n "$lastOne" ]; then
      assertFileExists "$d/DEPLOY/$t.previous" || _deployShowFiles "$d" || return $?
      assertFileExists "$d/DEPLOY/$lastOne.next" || _deployShowFiles "$d" || return $?
    else
      assertFileDoesNotExist "$d/DEPLOY/$t.previous" || _deployShowFiles "$d" || return $?
      assertFileDoesNotExist "$d/DEPLOY/$t.next" || _deployShowFiles "$d" || return $?
    fi
    lastOne="$t"
    firstArgs=()
  done

  for t in 1a 2b 3c 4d; do
    consoleInfo deployHasVersion $t test 2
    assertExitCode 0 deployHasVersion "$d/DEPLOY" "$t" || return $?
  done
  for t in null "" 3g 999999 $'\n'; do
    consoleInfo deployHasVersion "$t" BAD test
    assertNotExitCode 0 deployHasVersion "$d/DEPLOY" "$t" || return $?
  done

  _testAssertDeploymentLinkages "$d" || return $?

  consoleInfo undoDeployApplication tests

  t=4d
  for t in 4d 3c 2b; do
    consoleNameValue 40 _simplePHPRequest "$(_simplePHPRequest)"

    assertEquals "$t" "$(_simplePHPRequest)" "PHP application undo to new version $t failed"

    consoleRed "undoDeployApplication $t"
    assertEquals "$t" "$(deployApplicationVersion "$d/live-app")" || return $?
    undoDeployApplication "$d/DEPLOY" "$t" "$d/live-app" || return $?
    _testAssertDeploymentLinkages "$d" || return $?

    sleep 1
  done

  t=1a
  assertEquals "$t" "$(deployApplicationVersion "$d/live-app")" || return $?

  consoleNameValue 40 _simplePHPRequest "$(_simplePHPRequest)"
  assertEquals "$t" "$(_simplePHPRequest)" "PHP application undo to new version $t failed"

  consoleInfo No previous version
  assertNotExitCode 0 undoDeployApplication "$d/DEPLOY" "1a" "$d/live-app"

  t=4d
  consoleInfo Jump versions to end $t
  deployApplication "$d/DEPLOY" "$t" "$d/live-app" || return $?

  consoleNameValue 40 _simplePHPRequest "$(_simplePHPRequest)"
  assertEquals "$t" "$(_simplePHPRequest)" "PHP application undo to new version $t failed"

  _testAssertDeploymentLinkages "$d" || return $?

  consoleInfo deployApplication fail tests
  assertNotExitCode 0 deployApplication "$d/DEPLOY" "3g" "$d/live-app" || return $?

  _testAssertDeploymentLinkages "$d" || return $?

  echo "GOING TO: kill ::::$phpPid:::: My PID is $$"
  kill -TERM "$phpPid" || :
}
