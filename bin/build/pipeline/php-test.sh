#!/usr/bin/env bash
#
# Test a docker-based PHP application
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL bashHeader 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

init=$(beginTiming)

#    __                  _   _
#   / _|_   _ _ __   ___| |_(_) ___  _ __  ___
#  | |_| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
#  |  _| |_| | | | | (__| |_| | (_) | | | \__ \
#  |_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
#
usageHooks() {
  echo "test-setup Move or copy files prior to docker-compose build to build test container"
  echo "test-runner Run PHP Unit and any other tests inside the container"
  echo "test-cleanup Reverse of test-setup hook actions"
}
usage() {
  local rs="$1"

  shift

  exec 1>&2
  if [ -n "$*" ]; then
    consoleError "$@"
    echo
  fi
  consoleInfo "$(basename "${BASH_SOURCE[0]}") [ production | develop ]"
  echo
  consoleInfo "Test a docker-based PHP application during build"
  echo
  consoleInfo "Uses hooks:"
  consoleValue "    test-setup test-runner test-cleanup"
  echo
  usageHooks | usageGenerator 16
  echo
  exit "$rs"
}

envRenameHide() {
  renameFiles "" ".$$.backup" hiding .env .env.local
}
envRenameUndo() {
  renameFiles ".$$.backup" "" restoring .env .env.local
}

testCleanup() {
  local i
  for i in .env .env.local ./vendor; do
    if [ -f "$i" ] || [ -d "$i" ]; then
      rm -rf "$i"
    fi
  done
}

#                   _
#   _ __ ___   __ _(_)_ __
#  | '_ ` _ \ / _` | | '_ \
#  | | | | | | (_| | | | | |
#  |_| |_| |_|\__,_|_|_| |_|
#
quietLog=$(buildQuietLog "$(basename "${BASH_SOURCE[0]}")")

buildDebugStart

dockerComposeInstall
./bin/build/pipeline/composer.sh

consoleInfo "Building test container"

start=$(beginTiming)

envRenameHide
trap envRenameUndo EXIT TERM QUIT

runOptionalHook test-setup

export DOCKER_BUILDKIT=0
if ! docker-compose -f "./docker-compose.yml" build >>"$quietLog"; then
  buildFailed "$quietLog"
fi
reportTiming "$start" Done

consoleInfo "Bringing up containers ..."
start=$(beginTiming)
if ! docker-compose up -d >>"$quietLog" 2>&1; then
  buildFailed "$quietLog"
fi
reportTiming "$start" Done

runHook test-runner

consoleInfo "Bringing down containers ..."
docker-compose down 2>/dev/null
reportTiming "$start" Done

consoleInfo "Testing completed"

runOptionalHook test-cleanup
testCleanup

envRenameUndo

buildDebugStop

reportTiming "$init" "PHP Test completed in"
