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
  mkdir live-app || return $?
  mkdir -p app/.deploy || return $?
  mkdir -p app/bin/build || return $?
  cp -R "$home/bin/build" "app/bin" || return $?
  mkdir -p "app/public"
  printf "%s\n%s\n" "<?php" "echo php_uname('n') . ' ' . file_get_contents(dirname(__DIR__) . '/timestamp.txt');" >"app/public/index.php"

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
  find "$1" -type f ! -path '*/bin/build/*' -or -type d | prefixLines "$(consoleCode "DEPLOY root files:    ")$(consoleMagenta)"
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

testDeployApplication() {
  local d

  set -eou pipefail

  home=$(pwd)

  if ! d="$(_testDeployApplicationSetup "$home")"; then
    consoleError _testDeployApplicationSetup failed
    return "$errorEnvironment"
  fi
  consoleNameValue 20 "Deploy Root" "$d"

  for t in 1a 2b 3c 4d; do
    consoleInfo deployHasVersion $t test 1
    assertExitCode 0 deployHasVersion "$d/DEPLOY" "$t" || return $?
  done

  _deployShowFiles "$d" || :
  lastOne=
  firstArgs=(--first)
  for t in 1a 2b 3c 4d; do
    assertExitCode 0 deployHasVersion "$d/DEPLOY" $t || return $?
    assertExitCode 0 deployApplication "${firstArgs[@]+${firstArgs[@]}}" "$d/DEPLOY" "$t" "$d/live-app" || _deployShowFiles "$d" || return $?
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

  for t in 4d 3c 2b; do
    consoleRed "undoDeployApplication $t"
    assertEquals "$t" "$(deployApplicationVersion "$d/live-app")" || return $?
    undoDeployApplication "$d/DEPLOY" "$t" "$d/live-app" || return $?

    _testAssertDeploymentLinkages "$d" || return $?
  done

  assertEquals "1a" "$(deployApplicationVersion "$d/live-app")" || return $?

  consoleInfo No previous version
  assertExitCodeNotZero undoDeployApplication "$d/DEPLOY" "1a" "$d/live-app"

  consoleInfo Jump versions to end
  deployApplication "$d/DEPLOY" "4d" "$d/live-app" || return $?

  _testAssertDeploymentLinkages "$d" || return $?

  consoleInfo deployApplication fail tests
  assertNotExitCode 0 deployApplication "$d/DEPLOY" "3g" "$d/live-app" || return $?

  _testAssertDeploymentLinkages "$d" || return $?

  cd "$d" || return 1

  # find . -type f

  cd "$home"
}
