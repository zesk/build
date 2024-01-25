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

# IDENTICAL errorEnvironment 1
errorEnvironment=1

set -eou pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."
top=$(pwd)

# shellcheck source=/dev/null
. ./bin/build/tools.sh

# shellcheck source=/dev/null
if ! . ./test/test-tools.sh; then
  consoleError "Unable to load test tools library" 1>&2
  return $errorEnvironment
fi

messyTestCleanup() {
  local fn exitCode=$?
  if ! test "$cleanExit"; then
    consoleInfo -n "Stack:"
    for fn in "${FUNCNAME[@]}"; do
      printf " %s" "$(consoleWarning "$fn")"
    done
    printf "\n"
    consoleError "$(basename "${BASH_SOURCE[0]}") FAILED $exitCode: TRACE $testTracing"
  fi
  if test "$messyOption"; then
    return 0
  fi
  cd "$top"
  testCleanup
}

_textExit() {
  export cleanExit=1
  exit "$@"
}

_testUsage() {
  usageDocument "bin/$(basename "${BASH_SOURCE[0]}")" buildTestSuite "$@"
  return "$?"
}

#
# fn: {base}
# Usage: {fn} [ --help ] [ --clean ] [ --messy ]
# Run Zesk Build tests
#
# Argument: --one test - Optional. Add one test to run.
# Argument: --show - Optional. Flag. List all tests.
# Argument: --help - Optional. This help.
# Argument: --clean - Optional. Delete test artifact files before starting.
# Argument: --messy - Optional. Do not delete test artifact files afterwards.
#
buildTestSuite() {
  local quietLog allTests runTests shortTest

  quietLog=$(buildQuietLog "$(basename "${BASH_SOURCE[0]}")")

  export cleanExit=
  export testTracing

  testTracing=initialization
  trap messyTestCleanup EXIT QUIT TERM

  messyOption=
  allTests=(log version colors type os pipeline identical aws text deploy markdown documentation assert usage docker api tests aws bin)
  while read -r shortTest; do
    if ! inArray "$shortTest" "${allTests[@]}"; then
      consoleError "MISSING $shortTest in allTests"
      allTests+=("$shortTest")
    fi
  done < <(shortTestCodes)
  runTests=()

  testTracing=options
  while [ $# -gt 0 ]; do
    case $1 in
      --show)
        printf "%s\n" "${allTests[@]}"
        _textExit 0
        ;;
      --one)
        shift || return $?
        printf "%s %s\n" "$(consoleWarning "Adding one test:")" "$(consoleBoldRed "$1")"
        runTests+=("$1")
        ;;
      --help)
        _testUsage 0
        _textExit $?ƒ
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
        _textExit $?
        ;;
    esac
    shift
  done

  if [ ${#runTests[@]} -eq 0 ]; then
    runTests=("${allTests[@]}")
  fi
  # tests-tests.sh has side-effects - installs shellcheck
  # aws-tests.sh testAWSIPAccess has side-effects, installs AWS
  # bin-tests has side effects - installs OS software

  for shortTest in "${runTests[@]}"; do
    testTracing="test: $shortTest"
    requireTestFiles "$quietLog" "$shortTest-tests.sh" || return $?
  done

  cd "$top" || return $?
  cleanExit=1
  testTracing=cleanup
  messyTestCleanup

  bigText Passed | prefixLines "$(consoleSuccess)"
  consoleReset
}

buildTestSuite "$@"
