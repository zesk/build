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

set -eou pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."
top=$(pwd)

# shellcheck source=/dev/null
. ./bin/build/ops.sh

# shellcheck source=/dev/null
__environment source ./test/test-tools.sh || return $?

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

#
# fn: {base}
# Usage: {fn} [ --help ] [ --clean ] [ --messy ]
# Run Zesk Build test suites
#
# Argument: --one test - Optional. Add one test suite to run.
# Argument: --show - Optional. Flag. List all test suites.
# Argument: --help - Optional. This help.
# Argument: --clean - Optional. Delete test artifact files before starting.
# Argument: --messy - Optional. Do not delete test artifact files afterwards.
#
buildTestSuite() {
  local quietLog allTests runTests shortTest
  # IDENTICAL this_usage 4
  local this usage

  this="${FUNCNAME[0]}"
  usage="_$this"

  quietLog="$(buildQuietLog "${FUNCNAME[0]}")"

  export BUILD_COLORS_MODE
  export cleanExit=
  export testTracing

  BUILD_COLORS_MODE=$(consoleConfigureColorMode)

  printf "%s %s\n" "$(consoleInfo "Color mode is")" "$(consoleCode "$BUILD_COLORS_MODE")"

  testTracing=initialization
  trap messyTestCleanup EXIT QUIT TERM

  messyOption=
  allTests=(sugar colors console debug git decoration url ssh log version type process os hook pipeline identical)
  # Strange quoting for a s s e r t is to hide it from findUncaughtAssertions
  allTests+=(text float markdown documentation "ass""ert" usage docker api tests aws php bin deploy deployment)
  allTests+=(sysvinit daemontools)
  while read -r shortTest; do
    if ! inArray "$shortTest" "${allTests[@]}"; then
      consoleError "MISSING $shortTest in allTests"
      allTests+=("$shortTest")
    fi
  done < <(shortTestCodes)
  runTests=()

  testTracing=options
  printf "%s\n" "$testTracing" >>"$quietLog"
  while [ $# -gt 0 ]; do
    argument="$1"
    case "$argument" in
      --show)
        printf "%s\n" "${allTests[@]}"
        _textExit 0
        ;;
      --one)
        shift || __failArgument "Missing $argument argument" || return $?
        printf "%s %s\n" "$(consoleWarning "Adding one suite:")" "$(consoleBoldRed "$1")"
        runTests+=("$1")
        ;;
      --help)
        "$usage" 0
        _textExit 0
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
        __failArgument "$usage" "Unknown argument $1" || _textExit $? || return $?
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
    __environment requireFileDirectory "$quietLog" || return $?
    printf "%s\n" "$testTracing" >>"$quietLog" || _environment "Failed to write $quietLog" || return $?
    requireTestFiles "$quietLog" "$shortTest-tests.sh" || return $?
  done

  cd "$top" || return $?
  cleanExit=1

  printf "%s\n" "$testTracing" >>"$quietLog"
  testTracing=cleanup
  messyTestCleanup

  bigText Passed | wrapLines "$(consoleSuccess)" "$(consoleReset)"
  consoleReset
}
_buildTestSuite() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

buildTestSuite "$@"
