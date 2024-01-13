#!/usr/bin/env bash
#
# test.sh
#
# Testing
#
# Copyright &copy; 2024 Market Acumen, Inc.
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
cleanExit=
export testTracing
testTracing=initialization

# shellcheck source=/dev/null
. ./bin/tests/test-tools.sh

#
# fn: {base}
# Usage: {fn} [ --help ] [ --clean ] [ --messy ]
# Run Zesk Build tests
#
# Argument: --help - Optional. This help.
# Argument: --clean - Optional. Delete test artifact files before starting.
# Argument: --messy - Optional. Do not delete test artifact files afterwards.
#
_testUsage() {
  usageDocument "bin/$me" _testUsage "$@"
  return "$?"
}

messyTestCleanup() {
  local exitCode=$?
  if ! test "$cleanExit"; then
    consoleError "$(basename "${BASH_SOURCE[0]}") FAILED $exitCode: TRACE $testTracing"
  fi
  if test "$messyOption"; then
    return 0
  fi
  cd "$top"
  testCleanup
}

messyOption=

while [ $# -gt 0 ]; do
  case $1 in
    --help)
      _testUsage 0
      exit $?
      ;;
    --clean)
      consoleWarning -n "Cleaning ... "
      testCleanup
      consoleSuccess "done"
      ;;
    --messy)
      messyOption=1
      ;;
    *)
      _testUsage "$errorArgument" "Unknown argument $1"
      exit $?
      ;;
  esac
  shift
done

trap messyTestCleanup EXIT QUIT TERM

# Types
requireTestFiles "$quietLog" type-tests.sh

# debugTermDisplay
requireTestFiles "$quietLog" colors-tests.shi

requireTestFiles "$quietLog" pipeline-tests.sh


#
# Unusual quoting here is to avoid matching the word uh, IDENTICAL with the comment here
#
testTracing=identical-check.sh
./bin/build/identical-check.sh --extension sh --prefix '# ''IDENTICAL'

requireTestFiles "$quietLog" aws-tests.sh
requireTestFiles "$quietLog" text-tests.sh
requireTestFiles "$quietLog" deploy-tests.sh
requireTestFiles "$quietLog" documentation-tests.sh
requireTestFiles "$quietLog" os-tests.sh
requireTestFiles "$quietLog" assert-tests.sh
requireTestFiles "$quietLog" usage-tests.sh
requireTestFiles "$quietLog" docker-tests.sh
requireTestFiles "$quietLog" api-tests.sh

# tests-tests.sh has side-effects - installs shellcheck
requireTestFiles "$quietLog" tests-tests.sh

# aws-tests.sh testAWSIPAccess has side-effects, installs AWS
requireTestFiles "$quietLog" aws-tests.sh

# Side effects - install the software
requireTestFiles "$quietLog" bin-tests.sh

cd "$top" || return $?
cleanExit=1
testTracing=cleanup
messyTestCleanup

bigText Passed | prefixLines "$(consoleSuccess)"
consoleReset
