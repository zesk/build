#!/usr/bin/env bash
#
# deploy-tests.sh
#
# Deploy tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

_testDeployApplicationSetup() {
  local home="$1" ts
  d=$(__environment mktemp -d) || return $?

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
  local message
  message=$(find "$1" ! -path '*/bin/build/*' | wrapLines "$(decorate code "DEPLOY root files:    ")$(decorate magenta)" "$(decorate reset)")
  _environment "$message" || return $?
}

_testAssertDeploymentLinkages() {
  local d="$1"

  decorate info _testAssertDeploymentLinkages deployPreviousVersion tests
  assertEquals "O66" "$(deployPreviousVersion "$d/DEPLOY" "1a")" deployPreviousVersion "$d/DEPLOY" "1a" || return $?
  assertEquals "1a" "$(deployPreviousVersion "$d/DEPLOY" "2b")" deployPreviousVersion "$d/DEPLOY" "2b" || return $?
  assertEquals "2b" "$(deployPreviousVersion "$d/DEPLOY" "3c")" deployPreviousVersion "$d/DEPLOY" "3c" || return $?
  assertEquals "3c" "$(deployPreviousVersion "$d/DEPLOY" "4d")" deployPreviousVersion "$d/DEPLOY" "4d" || return $?

  decorate info _testAssertDeploymentLinkages deployNextVersion tests
  assertEquals "2b" "$(deployNextVersion "$d/DEPLOY" "1a")" deployNextVersion "$d/DEPLOY" "1a" || return $?
  assertEquals "3c" "$(deployNextVersion "$d/DEPLOY" "2b")" deployNextVersion "$d/DEPLOY" "2b" || return $?
  assertEquals "4d" "$(deployNextVersion "$d/DEPLOY" "3c")" deployNextVersion "$d/DEPLOY" "3c" || return $?
  assertEquals "" "$(deployNextVersion "$d/DEPLOY" "4d")" deployNextVersion "$d/DEPLOY" "4d" || return $?
}

_waitForDeath() {
  local start delta wait=5
  decorate info "Waiting for death of process $1 for $wait seconds"
  start=$(date +%s)
  while kill -0 "$1" 2>/dev/null; do
    sleep 0.1s
    delta=$(($(date +%s) - start))
    if [ "$delta" -ge "$wait" ]; then
      _environment "${FUNCNAME[0]} failed after $wait seconds" || return $?
    fi
  done
  delta=$(($(date +%s) - start))
  decorate notice "Process $1 terminated after $delta seconds."
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
    _environment "PHP_SERVER_ROOT is blank" || return $?
  fi
  if [ ! -d "${PHP_SERVER_ROOT-}" ]; then
    _environment "PHP_SERVER_ROOT is not a directory" || return $?
  fi
  decoration="$(echoBar ':.')"
  printf "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n" \
    "$(decorate magenta "$decoration")" "$(decorate blue "$decoration")" \
    "$(decorate success "Starting PHP Server")" \
    "$(decorate cyan "$decoration")" \
    "$(decorate pair 40 "Server Root" "$PHP_SERVER_ROOT")" \
    "$(decorate pair 40 "Server Host" "$PHP_SERVER_HOST:$PHP_SERVER_PORT")" \
    "$(decorate blue "$decoration")" "$(decorate magenta "$decoration")"

  php -S "$PHP_SERVER_HOST:$PHP_SERVER_PORT" -t "$PHP_SERVER_ROOT" &
  export PHP_SERVER_PID
  PHP_SERVER_PID=$!
  decorate info "Running PHP server $PHP_SERVER_PID"
  printf "%d\n" "$PHP_SERVER_PID" >"$PHP_SERVER_ROOT/.pid"
}

_isSimplePHPServerRunning() {
  [ -f "$PHP_SERVER_ROOT/.pid" ] && kill -0 "$(cat "$PHP_SERVER_ROOT/.pid")" || return 1
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
  statusMessage decorate info "Warming server ... "
  while ! value="$(_simplePHPRequest)" || [ -z "$value" ]; do
    sleep 1
    delta=$(($(beginTiming) - start))
    if [ "$delta" -gt 5 ]; then
      _environment "_warmupServer failed" || return $?
    fi
    printf "%s" "$(decorate green .)"
  done
  clearLine
  printf "%s %s\n" "$(decorate info "Server warmed up with value:")" "$(decorate code "$value")"
}

errorTimeout=20

_waitForValueTimeout() {
  local start delta value

  start=$(beginTiming)
  statusMessage decorate info "Waiting for value $1 ... "
  while true; do
    if ! value="$(_simplePHPRequest)"; then
      _environment "request failed" || return $?
    fi
    clearLine
    if [ -z "$value" ] || [ "$value" != "$1" ]; then
      printf "%s %s %s %s\n" "$(decorate code "Request for")" "$(decorate code "$1")" "$(decorate info ", received")" "$(decorate red "$value")"
      return "$errorTimeout"
    else
      break
    fi
  done
  clearLine
  printf "%s %s\n" "$(decorate info "Server found value:")" "$(decorate code "$value")"
}

_waitForValue() {
  local exitCode

  _simplePHPServer --kill
  _waitForValueTimeout "$@"
  exitCode=$?
  if [ "$exitCode" = "0" ]; then
    decorate success "*** Found it first round ***"
  elif [ "$exitCode" = "$errorTimeout" ]; then
    decorate warning "Timed out ... restarting server and trying again"
    _simplePHPServer --kill
    _waitForValueTimeout "$@"
    exitCode=$?
    if [ "$exitCode" = "0" ]; then
      decorate success "*** Restarting server worked! ***"
    fi
    decorate warning "_waitForValueTimeout failed exitCode=$exitCode"
  fi
  return $exitCode
}

# Tag: slow deployment php-install
testDeployApplication() {
  local d quietLog migrateVersion startingValue firstArgs home lastOne t

  set -eou pipefail

  quietLog="$(buildQuietLog "${FUNCNAME[0]}")"
  if ! packageWhich curl curl; then
    _environment "Failed to install curl" || return $?
  fi
  assertExitCode --line "$LINENO" 0 phpInstall || return $?

  if ! home=$(pwd -P 2>/dev/null); then
    _environment "Unable to pwd" || return $?
  fi

  if ! d="$(_testDeployApplicationSetup "$home")"; then
    _environment _testDeployApplicationSetup failed || return $?
  fi
  decorate pair 20 "Deploy Root" "$d"

  export PHP_SERVER_ROOT
  PHP_SERVER_ROOT="$d/live-app/public"
  local start elapsed maxWaitTime=15

  start=$(beginTiming)
  if ! _simplePHPServer; then
    decorate error _simplePHPServer failed
    buildFailed "$quietLog" || return $?
  fi
  while ! _isSimplePHPServerRunning; do
    elapsed=$(($(beginTiming) - start))
    if [ "$elapsed" -gt "$maxWaitTime" ]; then
      __environment "Simple PHP Server not running after $maxWaitTime seconds, failing" || return $?
    fi
  done
  decorate pair 20 "PHP Process" "$PHP_SERVER_PID"

  decorate info _simplePHPServer started "$PHP_SERVER_PID"
  # shellcheck disable=SC2064
  trap "kill ${PHP_SERVER_PID-}" INT TERM
  startingValue=start

  if ! _waitForValueTimeout "$startingValue"; then
    _environment "Unable to find starting value $startingValue" || return $?
  fi

  decorate pair 40 _simplePHPRequest "$(_simplePHPRequest)"
  assertEquals "$startingValue" "$(_simplePHPRequest)" "initial state of PHP server" || return $?

  for t in 1a 2b 3c 4d; do
    decorate info deployHasVersion $t test 1
    assertExitCode 0 deployHasVersion "$d/DEPLOY" "$t" || return $?
  done

  lastOne=
  firstArgs=(--first)

  # ________________________________________________________________________________________________________________________________
  __testSection deployApplication fails on top of a directory
  t=1a
  assertNotExitCode --line "$LINENO" --dump --stderr-match "should be a link" 0 deployApplication "${firstArgs[@]+${firstArgs[@]}}" --application "$d/live-app" --home "$d/DEPLOY" --id "$t" || return $?
  _waitForValue "$startingValue" || return $?

  #
  # deployMigrateDirectoryToLink
  #

  # ________________________________________________________________________________________________________________________________
  __testSection deployMigrateDirectoryToLink fails on with no version in the application

  assertNotExitCode --line "$LINENO" --stderr-match "deployment version" 0 deployMigrateDirectoryToLink "$d/DEPLOY" "$d/live-app" || return $?
  _waitForValue "$startingValue" || return $?

  migrateVersion="O66"
  mkdir -p "$d/live-app/.deploy" || return $?
  printf "%s" "$migrateVersion" >"$d/live-app/.deploy/APPLICATION_ID" || return $?

  # ________________________________________________________________________________________________________________________________
  __testSection deployMigrateDirectoryToLink fails on with no version in the DEPLOYMENT directory

  assertNotExitCode --line "$LINENO" --stderr-match "not found in" 0 deployMigrateDirectoryToLink "$d/DEPLOY" "$d/live-app" || return $?
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

  assertExitCode --line "$LINENO" 0 test -d "$d/DEPLOY/O66/app" || return $?
  assertExitCode --line "$LINENO" 0 test -L "$d/live-app" || return $?

  #
  # Now that it's a link we have to restart our server
  #
  for t in 1a 2b 3c 4d; do
    assertExitCode 0 deployHasVersion "$d/DEPLOY" $t || return $?

    # ________________________________________________________________________________________________________________________________
    __testSection deployApplication "$t"
    if ! deployApplication "${firstArgs[@]+${firstArgs[@]}}" --application "$d/live-app" --id "$t" --home "$d/DEPLOY"; then
      decorate error "Deployment of $t failed"
      _deployShowFiles "$d" || return $?
    fi

    #    if ! _simplePHPServer --kill "$d/live-app"; then
    #      decorate error _simplePHPServer restart failed
    #      buildFailed "$quietLog" || return $?
    #    fi
    #
    decorate pair 40 _simplePHPRequest "$(_simplePHPRequest)"
    _waitForValue "$t" || return $?

    assertEquals "$t" "$(_simplePHPRequest)" "PHP application new version $t" || return $?
    clearLine
    # _deployShowFiles "$d" || :
    assertEquals "$t" "$(deployApplicationVersion "$d/live-app")" || return $?
    if [ -n "$lastOne" ]; then
      assertFileExists --line "$LINENO" "$d/DEPLOY/$t.previous" || _deployShowFiles "$d" || return $?
      assertFileExists --line "$LINENO" "$d/DEPLOY/$lastOne.next" || _deployShowFiles "$d" || return $?
    else
      # First one links back to bad version
      if [ "$t" = "1a" ]; then
        assertFileExists --line "$LINENO" "$d/DEPLOY/$t.previous" || _deployShowFiles "$d" || return $?
      else
        assertFileDoesNotExist --line "$LINENO" "$d/DEPLOY/$t.previous" || _deployShowFiles "$d" || return $?
      fi
      assertFileDoesNotExist --line "$LINENO" "$d/DEPLOY/$t.next" || _deployShowFiles "$d" || return $?
    fi
    lastOne="$t"
    firstArgs=()
  done

  for t in 1a 2b 3c 4d; do
    decorate info deployHasVersion $t test 2
    assertExitCode --line "$LINENO" 0 deployHasVersion "$d/DEPLOY" "$t" || return $?
  done
  for t in null "" 3g 999999 $'\n'; do
    decorate info deployHasVersion "$t" BAD test
    assertNotExitCode --line "$LINENO" --stderr-ok 0 deployHasVersion "$d/DEPLOY" "$t" || return $?
  done

  _testAssertDeploymentLinkages "$d" || return $?

  decorate info deployRevertApplication tests

  t=4d
  for t in 4d 3c 2b; do
    decorate pair 40 _simplePHPRequest "$(_simplePHPRequest)"
    _waitForValue "$t" || return $?

    assertEquals --line "$LINENO" "$t" "$(_simplePHPRequest)" "PHP application undo to new version $t failed" || return $?
    # ________________________________________________________________________________________________________________________________
    __testSection "deployApplication --revert $t"
    assertEquals --line "$LINENO" "$t" "$(deployApplicationVersion "$d/live-app")" || return $?
    deployApplication --revert --home "$d/DEPLOY" --id "$t" --application "$d/live-app" || return $?
    _testAssertDeploymentLinkages "$d" || return $?
  done

  t=1a
  assertEquals --line "$LINENO" "$t" "$(deployApplicationVersion "$d/live-app")" || return $?

  decorate pair 40 _simplePHPRequest "$(_simplePHPRequest)"
  _waitForValue "$t" || return $?

  assertEquals --line "$LINENO" "$t" "$(_simplePHPRequest)" "PHP application undo to new version $t failed" || return $?

  # ________________________________________________________________________________________________________________________________
  __testSection No previous version
  assertNotExitCode --stderr-ok 0 deployApplication --revert --home "$d/DEPLOY" --id "1a" --application "$d/live-app" || return $?

  # ________________________________________________________________________________________________________________________________
  t=4dshellcheck bin/build/hooks/maintenance.sh
  __testSection Jump versions to end $t
  deployApplication --home "$d/DEPLOY" --id "$t" --application "$d/live-app" || return $?

  decorate pair 40 _simplePHPRequest "$(_simplePHPRequest)"
  _waitForValue "$t" || return $?

  assertEquals "$t" "$(_simplePHPRequest)" "PHP application undo to new version $t failed" || return $?

  _testAssertDeploymentLinkages "$d" || return $?

  # ________________________________________________________________________________________________________________________________
  __testSection deployApplication fail bad version
  assertNotExitCode --line "$LINENO" --stderr-ok 0 deployApplication --home "$d/DEPLOY" --id "3g" --application "$d/live-app" || return $?

  _testAssertDeploymentLinkages "$d" || return $?

  # ________________________________________________________________________________________________________________________________
  t=1a
  __testSection deployApplication fail incorrect target $t
  assertNotExitCode --line "$LINENO" --stderr-ok 0 deployApplication --home "$d/DEPLOY" --id "$t" --application "$d/live-app" --target ap.tar.gz || return $?

  __testSection deployApplication fail missing or blank arguments $t
  assertNotExitCode --line "$LINENO" --stderr-ok 0 deployApplication --home "" --id "$t" --application "$d/live-app" || return $?
  assertNotExitCode --line "$LINENO" --stderr-ok 0 deployApplication --home "$d/DEPLOY" --id "" --application "$d/live-app" || return $?
  assertNotExitCode --line "$LINENO" --stderr-ok 0 deployApplication --home "$d/DEPLOY" --id "$t" --application "" || return $?
  assertNotExitCode --line "$LINENO" --stderr-ok 0 deployApplication --id "$t" --application "$d/live-app" || return $?
  assertNotExitCode --line "$LINENO" --stderr-ok 0 deployApplication --home "$d/DEPLOY" --application "$d/live-app" || return $?
  assertNotExitCode --line "$LINENO" --stderr-ok 0 deployApplication --home "$d/DEPLOY" --id "$t" || return $?

  _testAssertDeploymentLinkages "$d" || return $?

  # ________________________________________________________________________________________________________________________________
  echo "GOING TO: kill ::::$PHP_SERVER_PID:::: My PID is $$"
  kill -TERM "$PHP_SERVER_PID" || :
  PHP_SERVER_PID=
  _waitForDeath "$PHP_SERVER_PID"

  assertExitCode --line "$LINENO" 0 phpUninstall || return $?

  unset PHP_SERVER_ROOT
  unset PHP_SERVER_PID
  # decorate error "reset PHP_SERVER_ROOT PHP_SERVER_PID"

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
    decorate error "unset BUILD_TARGET"
    unset BUILD_TARGET
  fi
}

_exportWorksRight() {
  assertEquals "bummer-of-a-birthmark-hal.tar.gz" "$BUILD_TARGET" >/dev/null 2>&1 || return $?
  printf "%s" "$BUILD_TARGET"
}
