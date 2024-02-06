#!/usr/bin/env bash
#
# deploy-tests.sh
#
# Deploy tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -e

declare -a tests
tests+=(deployApplicationTest)

deployApplicationTest() {
  local d

  home=$(pwd)
  d=$(mktemp -d)

  cd "$d" || exit
  consoleNameValue 20 "Deploy Root" "$d"
  mkdir live-app || return $?
  mkdir -p app/.deploy || return $?
  mkdir -p app/bin/build || return $?
  echo "Hello, world" >app/index.php
  cp -R "$home/bin/build" "app/bin"
  cd app || exit
  for t in 1a 2b 3c 4d; do
    printf %s "$t" | tee .deploy/APPLICATION_ID >.deploy/APPLICATION_TAG
    echo "APPLICATION_ID=$t" >.env
    echo "APPLICATION_TAG=$t" >>.env
    mkdir -p "$d/DEPLOY/$t"
    tar cfz "$d/DEPLOY/$t/app.tar.gz" .deploy bin index.php .env
  done
  cd ..
  rm -rf app

  for t in 1a 2b 3c 4d; do
    assertExitCode 0 deployHasVersion "$d/DEPLOY" $t || return $?
    assertExitCode 0 deployApplication "$d/DEPLOY" "$t" app.tar.gz "$d/live-app" || return $?
    assertEquals "$t" "$(getApplicationDeployVersion "$d/live-app")" || return $?
  done

  assertNotExitCode 0 deployHasVersion "$d/DEPLOY" "2a" || return $?

  assertEquals "" "$(deployPreviousVersion "$d/DEPLOY" "1a")" || return $?
  assertEquals "1a" "$(deployPreviousVersion "$d/DEPLOY" "2b")" deployPreviousVersion "$d/DEPLOY" "2b" || return $?
  assertEquals "2b" "$(deployPreviousVersion "$d/DEPLOY" "3c")" || return $?
  assertEquals "3c" "$(deployPreviousVersion "$d/DEPLOY" "4d")" || return $?

  assertEquals "2b" "$(deployNextVersion "$d/DEPLOY" "1a")" deployNextVersion "$d/DEPLOY" "1a" || return $?
  assertEquals "3c" "$(deployNextVersion "$d/DEPLOY" "2b")" deployNextVersion "$d/DEPLOY" "2b" || return $?
  assertEquals "4d" "$(deployNextVersion "$d/DEPLOY" "3c")" deployNextVersion "$d/DEPLOY" "3c" || return $?
  assertEquals "" "$(deployNextVersion "$d/DEPLOY" "4d")" deployNextVersion "$d/DEPLOY" "4d" || return $?

  undoDeployApplication "$d/DEPLOY" "4d" app.tar.gz "$d/live-app" || return $?
  deployApplication "$d/DEPLOY" "1a" app.tar.gz "$d/live-app" || return $?
  deployApplication "$d/DEPLOY" "3c" app.tar.gz "$d/live-app" || return $?

  assertNotExitCode 0 deployApplication "$d/DEPLOY" "3g" app.tar.gz "$d/live-app" || return $?

  assertEquals "" "$(deployPreviousVersion "$d/DEPLOY" "1a")" || return $?
  assertEquals "1a" "$(deployPreviousVersion "$d/DEPLOY" "2b")" || return $?
  assertEquals "2b" "$(deployPreviousVersion "$d/DEPLOY" "3c")" || return $?
  assertEquals "3c" "$(deployPreviousVersion "$d/DEPLOY" "4d")" || return $?

  assertEquals "2b" "$(deployNextVersion "$d/DEPLOY" "1a")" || return $?
  assertEquals "3c" "$(deployNextVersion "$d/DEPLOY" "2b")" || return $?
  assertEquals "4d" "$(deployNextVersion "$d/DEPLOY" "3c")" || return $?
  assertEquals "" "$(deployNextVersion "$d/DEPLOY" "4d")" || return $?

  cd "$d" || return 1

  # find . -type f

  cd "$home"
}
