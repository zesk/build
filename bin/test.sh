#!/usr/bin/env bash
#
# test.sh
#
# Testing
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Test locally:
# bin/local-container.sh
# . bin/test-reset.sh; bin/test.sh

# IDENTICAL errorArgument 1
errorArgument=2

set -eou pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."
top=$(pwd)

# shellcheck source=/dev/null
. ./bin/build/tools.sh

me=$(basename "$0")
quietLog=$(buildQuietLog "$me")

# shellcheck source=/dev/null
. ./bin/tests/test-tools.sh

usageOptions() {
  cat <<EOF
--help This help
--clean Delete test artifact files before starting
--messy Do not delete test artifact files afterwards
EOF
}

usage() {
  usageMain "$me" "$@"
  exit "$?"
}

messyTestCleanup() {
  if test "$messyOption"; then
    return 0
  fi
  cd "$top"
  testCleanup
}

messyOption=

while [ $# -gt 0 ]; do
  case $1 in
    --clean)
      consoleWarning -n "Cleaning ... "
      testCleanup
      consoleSuccess "done"
      ;;
    --messy)
      messyOption=1
      ;;
    *)
      usage "$errorArgument" "Unknown argument $1"
      ;;
  esac
  shift
done

trap messyTestCleanup EXIT QUIT TERM

# debugTermDisplay
requireTestFiles "$quietLog" colors-tests.sh

requireTestFiles "$quietLog" pipeline-tests.sh

#
# Unusual quoting here is to avoid matching the word uh, IDENTICAL with the comment here
#
./bin/build/identical-check.sh --extension sh --prefix '# ''IDENTICAL'

requireTestFiles "$quietLog" aws-tests.sh
requireTestFiles "$quietLog" text-tests.sh
requireTestFiles "$quietLog" deploy-tests.sh
requireTestFiles "$quietLog" documentation-tests.sh
requireTestFiles "$quietLog" os-tests.sh
requireTestFiles "$quietLog" assert-tests.sh
requireTestFiles "$quietLog" usage-tests.sh
requireTestFiles "$quietLog" docker-tests.sh api-tests.sh

# tests-tests.sh has side-effects - installs shellcheck
requireTestFiles "$quietLog" tests-tests.sh

# aws-tests.sh testAWSIPAccess has side-effects, installs AWS
requireTestFiles "$quietLog" aws-tests.sh

# Side effects - install the software
requireTestFiles "$quietLog" bin-tests.sh

for binTest in ./bin/tests/bin/*.sh; do
  testHeading "$(cleanTestName "$(basename "$binTest")")"
  if ! "$binTest" "$(pwd)"; then
    testFailed "$binTest" "$(pwd)"
  fi
done

cd "$top" || return $?
messyTestCleanup

bigText Passed | prefixLines "$(consoleSuccess)"
consoleReset
