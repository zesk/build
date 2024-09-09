#!/usr/bin/env bash
#
# deploy-tests.sh
#
# Deploy tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
errorEnvironment=1

_testDeployApplicationSetup() {
  local home="$1" ts
  if ! d=$(mktemp -d); then
    return $errorEnvironment
  fi

  cd "$d" || exit
  # OLD METHOD
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
    tarCreate "$d/DEPLOY/$t/app.tar.gz" .deploy bin public timestamp.txt .env || return $?
    ts=$((ts + 1))
  done
  cd .. || return $?
  rm -rf app || return $?
  printf "%s" "$d"
}

_deployShowFiles() {
  find "$1" ! -path '*/bin/build/*' | wrapLines "$(consoleCode "DEPLOY root files:    ")$(consoleMagenta)" "$(consoleReset)"
  return $errorEnvironment
}

_testAssertDeploymentLinkages() {
  local d="$1"

  consoleInfo _testAssertDeploymentLinkages deployPreviousVersion tests
  assertEquals "O66" "$(deployPreviousVersion "$d/DEPLOY" "1a")" deployPreviousVersion "$d/DEPLOY" "1a" || return $?
  assertEquals "1a" "$(deployPreviousVersion "$d/DEPLOY" "2b")" deployPreviousVersion "$d/DEPLOY" "2b" || return $?
  assertEquals "2b" "$(deployPreviousVersion "$d/DEPLOY" "3c")" deployPreviousVersion "$d/DEPLOY" "3c" || return $?
  assertEquals "3c" "$(deployPreviousVersion "$d/DEPLOY" "4d")" deployPreviousVersion "$d/DEPLOY" "4d" || return $?

  consoleInfo _testAssertDeploymentLinkages deployNextVersion tests
  assertEquals "2b" "$(deployNextVersion "$d/DEPLOY" "1a")" deployNextVersion "$d/DEPLOY" "1a" || return $?
  assertEquals "3c" "$(deployNextVersion "$d/DEPLOY" "2b")" deployNextVersion "$d/DEPLOY" "2b" || return $?
  assertEquals "4d" "$(deployNextVersion "$d/DEPLOY" "3c")" deployNextVersion "$d/DEPLOY" "3c" || return $?
  assertEquals "" "$(deployNextVersion "$d/DEPLOY" "4d")" deployNextVersion "$d/DEPLOY" "4d" || return $?
}

_waitForDeath() {
  while kill -0 "$1" 2>/dev/null; do
    sleep 1
    consoleInfo "Waiting for death of $1"
  done
}
export PHP_SERVER_PID
export PHP_SERVER_ROOT
PHP_SERVER_PID=
PHP_SERVER_PORT=6543
PHP_SERVER_HOST=127.0.0.1
PHP_SERVER_ROOT=

_simplePHPServer() {
  local decoration
  if [ "${1-}" = "--kill" ] && isInteger "$PHP_SERVER_PID"; then
    if kill -TERM "$PHP_SERVER_PID"; then
      _waitForDeath "$PHP_SERVER_PID"
    fi
    shift || :
  fi
  if [ -z "${PHP_SERVER_ROOT-}" ]; then
    consoleError "PHP_SERVER_ROOT is blank" 1>&2
    return $errorEnvironment
  fi
  if [ ! -d "${PHP_SERVER_ROOT-}" ]; then
    consoleError "PHP_SERVER_ROOT is not a directory" 1>&2
    return $errorEnvironment
  fi
  decoration="$(echoBar ':.')"
  printf "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n" \
    "$(consoleMagenta "$decoration")" "$(consoleBlue "$decoration")" \
    "$(consoleSuccess "Starting PHP Server")" \
    "$(consoleCyan "$decoration")" \
    "$(consoleNameValue 40 "Server Root" "$PHP_SERVER_ROOT")" \
    "$(consoleNameValue 40 "Server Host" "$PHP_SERVER_HOST:$PHP_SERVER_PORT")" \
    "$(consoleBlue "$decoration")" "$(consoleMagenta "$decoration")"

  php -S "$PHP_SERVER_HOST:$PHP_SERVER_PORT" -t "$PHP_SERVER_ROOT" &
  export PHP_SERVER_PID
  PHP_SERVER_PID=$!
  consoleInfo "Running PHP server $PHP_SERVER_PID"
}

_simplePHPRequest() {
  local indexFile
  local indexValue

  indexFile="$(buildCacheDirectory PHP_REQUEST_INDEX)"
  indexValue="$([ -f "$indexFile" ] && cat "$indexFile" || printf 0)"
  indexValue=$((indexValue + 1))
  curl -s "http://$PHP_SERVER_HOST:$PHP_SERVER_PORT/index.php?request=$indexValue"
  printf %d $indexValue >"$indexFile"
}
_warmupServer() {
  local start delta value

  start=$(beginTiming)
  statusMessage consoleInfo "Warming server ... "
  while ! value="$(_simplePHPRequest)" || [ -z "$value" ]; do
    sleep 1
    delta=$(($(beginTiming) - start))
    if [ "$delta" -gt 5 ]; then
      consoleError "_warmupServer failed"
      return "$errorEnvironment"
    fi
    printf "%s" "$(consoleGreen .)"
  done
  clearLine
  printf "%s %s\n" "$(consoleInfo "Server warmed up with value:")" "$(consoleCode "$value")"
}

errorTimeout=20

_waitForValueTimeout() {
  local start delta value

  start=$(beginTiming)
  statusMessage consoleInfo "Waiting for value $1 ... "
  while true; do
    if ! value="$(_simplePHPRequest)"; then
      _environment "request failed" || return $?
    fi
    clearLine
    if [ -z "$value" ] || [ "$value" != "$1" ]; then
      printf "%s %s %s %s\n" "$(consoleCode "Waiting for")" "$(consoleCode "$1")" "$(consoleInfo ", received")" "$(consoleRed "$value")"
      sleep 1
      delta=$(($(beginTiming) - start))
      if [ "$delta" -gt 1 ]; then
        printf "Timeout\n"
        return "$errorTimeout"
      fi
      printf "%s" "$(consoleGreen .)"
    else
      break
    fi
  done
  clearLine
  printf "%s %s\n" "$(consoleInfo "Server found value:")" "$(consoleCode "$value")"
}

_waitForValue() {
  local exitCode
  _waitForValueTimeout "$@"
  exitCode=$?
  if [ "$exitCode" = "0" ]; then
    consoleSuccess "*** Found it first round ***"
  elif [ "$exitCode" = "$errorTimeout" ]; then
    consoleWarning "Timed out ... restarting server and trying again"
    _simplePHPServer --kill
    _waitForValueTimeout "$@"
    exitCode=$?
    if [ "$exitCode" = "0" ]; then
      consoleSuccess "*** Restarting server worked! ***"
    fi
    consoleWarning "_waitForValueTimeout failed exitCode=$exitCode"
  fi
  return $exitCode
}

testDeployApplication() {
  local d quietLog migrateVersion startingValue firstArgs home lastOne t

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

  if ! home=$(pwd -P 2>/dev/null); then
    consoleError "Unable to pwd" 1>&2
    return $errorEnvironment
  fi

  if ! d="$(_testDeployApplicationSetup "$home")"; then
    consoleError _testDeployApplicationSetup failed
    return "$errorEnvironment"
  fi
  consoleNameValue 20 "Deploy Root" "$d"

  export PHP_SERVER_ROOT
  PHP_SERVER_ROOT="$d/live-app/public"

  if ! _simplePHPServer; then
    consoleError _simplePHPServer failed
    buildFailed "$quietLog" || return $?
  fi
  consoleNameValue 20 "PHP Process" "$PHP_SERVER_PID"

  consoleInfo _simplePHPServer started "$PHP_SERVER_PID"
  # shellcheck disable=SC2064
  trap "kill ${PHP_SERVER_PID-}" INT TERM
  startingValue=start

  if ! _waitForValueTimeout "$startingValue"; then
    consoleError "Unable to find starting value $startingValue"
    return $errorEnvironment
  fi

  consoleNameValue 40 _simplePHPRequest "$(_simplePHPRequest)"
  assertEquals "$startingValue" "$(_simplePHPRequest)" "initial state of PHP server" || return $?

  for t in 1a 2b 3c 4d; do
    consoleInfo deployHasVersion $t test 1
    assertExitCode 0 deployHasVersion "$d/DEPLOY" "$t" || return $?
  done

  _deployShowFiles "$d" || :
  lastOne=
  firstArgs=(--first)

  # ________________________________________________________________________________________________________________________________
  __testSection deployApplication fails on top of a directory
  t=1a
  assertNotExitCode --stderr-match "should be a link" 0 deployApplication "${firstArgs[@]+${firstArgs[@]}}" --application "$d/live-app" --home "$d/DEPLOY" --id "$t" || return $?
  _waitForValue "$startingValue" || return $?

  #
  # deployMigrateDirectoryToLink
  #

  # ________________________________________________________________________________________________________________________________
  __testSection deployMigrateDirectoryToLink fails on with no version in the application

  assertNotExitCode --stderr-match "deployment version" 0 deployMigrateDirectoryToLink "$d/DEPLOY" "$d/live-app" || return $?
  _waitForValue "$startingValue" || return $?

  migrateVersion="O66"
  mkdir -p "$d/live-app/.deploy" || return $?
  printf "%s" "$migrateVersion" >"$d/live-app/.deploy/APPLICATION_ID" || return $?

  # ________________________________________________________________________________________________________________________________
  __testSection deployMigrateDirectoryToLink fails on with no version in the DEPLOYMENT directory

  assertNotExitCode --stderr-match "not found in" 0 deployMigrateDirectoryToLink "$d/DEPLOY" "$d/live-app" || return $?
  _waitForValue "$startingValue" || return $?

  mkdir -p "$d/DEPLOY/$migrateVersion"
  assertExitCode 0 test -d "$d/DEPLOY/$migrateVersion" || return $?
  # Create tar file BUT it's corrupt!
  touch "$d/DEPLOY/$migrateVersion/$(deployPackageName)"

  # ________________________________________________________________________________________________________________________________
  __testSection deployMigrateDirectoryToLink succeeds - now deployApplication should work - does not check old TAR

  if ! deployMigrateDirectoryToLink "$d/DEPLOY" "$d/live-app"; then
    _deployShowFiles "$d" || return $?
  fi
  _waitForValue "$startingValue" || return $?

  assertExitCode 0 test -d "$d/DEPLOY/O66/app" || return $?
  assertExitCode 0 test -L "$d/live-app" || return $?

  #
  # Now that it's a link we have to restart our server
  #
  for t in 1a 2b 3c 4d; do
    assertExitCode 0 deployHasVersion "$d/DEPLOY" $t || return $?

    # ________________________________________________________________________________________________________________________________
    __testSection deployApplication "$t"
    if ! deployApplication "${firstArgs[@]+${firstArgs[@]}}" --application "$d/live-app" --id "$t" --home "$d/DEPLOY"; then
      consoleError "Deployment of $t failed"
      _deployShowFiles "$d" || return $?
    fi

    #    if ! _simplePHPServer --kill "$d/live-app"; then
    #      consoleError _simplePHPServer restart failed
    #      buildFailed "$quietLog"
    #      return "$errorEnvironment"
    #    fi
    #
    consoleNameValue 40 _simplePHPRequest "$(_simplePHPRequest)"
    _waitForValue "$t" || return $?

    assertEquals "$t" "$(_simplePHPRequest)" "PHP application new version $t" || return $?
    clearLine
    _deployShowFiles "$d" || :
    assertEquals "$t" "$(deployApplicationVersion "$d/live-app")" || return $?
    if [ -n "$lastOne" ]; then
      assertFileExists "$d/DEPLOY/$t.previous" || _deployShowFiles "$d" || return $?
      assertFileExists "$d/DEPLOY/$lastOne.next" || _deployShowFiles "$d" || return $?
    else
      # First one links back to bad version
      if [ "$t" = "1a" ]; then
        assertFileExists "$d/DEPLOY/$t.previous" || _deployShowFiles "$d" || return $?
      else
        assertFileDoesNotExist "$d/DEPLOY/$t.previous" || _deployShowFiles "$d" || return $?
      fi
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
    assertNotExitCode --stderr-ok 0 deployHasVersion "$d/DEPLOY" "$t" || return $?
  done

  _testAssertDeploymentLinkages "$d" || return $?

  consoleInfo deployRevertApplication tests

  t=4d
  for t in 4d 3c 2b; do
    consoleNameValue 40 _simplePHPRequest "$(_simplePHPRequest)"
    _waitForValue "$t" || return $?

    assertEquals "$t" "$(_simplePHPRequest)" "PHP application undo to new version $t failed" || return $?
    # ________________________________________________________________________________________________________________________________
    __testSection "deployApplication --revert $t"
    assertEquals "$t" "$(deployApplicationVersion "$d/live-app")" || return $?
    deployApplication --revert --home "$d/DEPLOY" --id "$t" --application "$d/live-app" || return $?
    _testAssertDeploymentLinkages "$d" || return $?
  done

  t=1a
  assertEquals "$t" "$(deployApplicationVersion "$d/live-app")" || return $?

  consoleNameValue 40 _simplePHPRequest "$(_simplePHPRequest)"
  _waitForValue "$t" || return $?

  assertEquals "$t" "$(_simplePHPRequest)" "PHP application undo to new version $t failed" || return $?

  # ________________________________________________________________________________________________________________________________
  __testSection No previous version
  assertNotExitCode --stderr-ok 0 deployApplication --revert --home "$d/DEPLOY" --id "1a" --application "$d/live-app" || return $?

  # ________________________________________________________________________________________________________________________________
  t=4dshellcheck bin/build/hooks/maintenance.sh
  __testSection Jump versions to end $t
  deployApplication --home "$d/DEPLOY" --id "$t" --application "$d/live-app" || return $?

  consoleNameValue 40 _simplePHPRequest "$(_simplePHPRequest)"
  _waitForValue "$t" || return $?

  assertEquals "$t" "$(_simplePHPRequest)" "PHP application undo to new version $t failed" || return $?

  _testAssertDeploymentLinkages "$d" || return $?

  # ________________________________________________________________________________________________________________________________
  __testSection deployApplication fail bad version
  assertNotExitCode --stderr-ok 0 deployApplication --home "$d/DEPLOY" --id "3g" --application "$d/live-app" || return $?

  _testAssertDeploymentLinkages "$d" || return $?

  # ________________________________________________________________________________________________________________________________
  t=1a
  __testSection deployApplication fail incorrect target $t
  assertNotExitCode --stderr-ok 0 deployApplication --home "$d/DEPLOY" --id "$t" --application "$d/live-app" --target ap.tar.gz || return $?

  __testSection deployApplication fail missing or blank arguments $t
  assertNotExitCode --stderr-ok 0 deployApplication --home "" --id "$t" --application "$d/live-app" || return $?
  assertNotExitCode --stderr-ok 0 deployApplication --home "$d/DEPLOY" --id "" --application "$d/live-app" || return $?
  assertNotExitCode --stderr-ok 0 deployApplication --home "$d/DEPLOY" --id "$t" --application "" || return $?
  assertNotExitCode --stderr-ok 0 deployApplication --id "$t" --application "$d/live-app" || return $?
  assertNotExitCode --stderr-ok 0 deployApplication --home "$d/DEPLOY" --application "$d/live-app" || return $?
  assertNotExitCode --stderr-ok 0 deployApplication --home "$d/DEPLOY" --id "$t" || return $?

  _testAssertDeploymentLinkages "$d" || return $?

  # ________________________________________________________________________________________________________________________________
  echo "GOING TO: kill ::::$PHP_SERVER_PID:::: My PID is $$"
  kill -TERM "$PHP_SERVER_PID" || :
  PHP_SERVER_PID=
  _waitForDeath "$PHP_SERVER_PID"

  unset PHP_SERVER_ROOT
  unset PHP_SERVER_PID
  # consoleError "reset PHP_SERVER_ROOT PHP_SERVER_PID"

  export PHP_SERVER_ROOT
  export PHP_SERVER_PID
  PHP_SERVER_ROOT=
  PHP_SERVER_PID=
  unset BUILD_DEBUG
}

testDeployPackageName() {
  local saveTarget

  saveTarget=${BUILD_TARGET-NONE}

  assertExitCode --line "$LINENO" --leak BUILD_TARGET 0 deployPackageName || return $?
  assertEquals --line "$LINENO" "app.tar.gz" "$(deployPackageName)" || return $?

  # shellcheck source=/dev/null
  source bin/build/env/BUILD_TARGET.sh || return $?

  export BUILD_TARGET

  BUILD_TARGET="bummer-of-a-birthmark-hal.tar.gz"

  assertExitCode --line "$LINENO" 0 deployPackageName || return $?

  assertEquals --line "$LINENO" "bummer-of-a-birthmark-hal.tar.gz" "$BUILD_TARGET" || return $?
  assertEquals --line "$LINENO" "bummer-of-a-birthmark-hal.tar.gz" "$(deployPackageName)" || return $?
  assertEquals --line "$LINENO" "bummer-of-a-birthmark-hal.tar.gz" "$(_exportWorksRight)" || return $?

  unset BUILD_TARGET

  export BUILD_TARGET

  # shellcheck source=/dev/null
  __environment buildEnvironmentLoad BUILD_TARGET || return $?

  assertEquals --line "$LINENO" "app.tar.gz" "$(deployPackageName)" || return $?

  export BUILD_TARGET
  BUILD_TARGET="$saveTarget"
  if [ "$saveTarget" = "NONE" ]; then
    consoleError "unset BUILD_TARGET"
    unset BUILD_TARGET
  fi
}

_exportWorksRight() {
  assertEquals "bummer-of-a-birthmark-hal.tar.gz" "$BUILD_TARGET" >/dev/null 2>&1 || return $?
  printf "%s" "$BUILD_TARGET"
}
