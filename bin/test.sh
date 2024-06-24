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
# Load zesk build and run command
__testLoader() {
  # shellcheck source=/dev/null
  if source "$(dirname "${BASH_SOURCE[0]}")/../bin/build/ops.sh"; then
    # shellcheck source=/dev/null
    source ./test/test-tools.sh || _environment "test-tools.sh" || return $?
    "$@" || return $?
  else
    exec 1>&2 && printf 'FAIL: %s\n' "$@"
    return 42 # The meaning of life
  fi
}

messyTestCleanup() {
  local fn exitCode=$?

  export cleanExit
  cleanExit="${cleanExit-}"
  if ! test "$cleanExit"; then
    consoleInfo -n "Stack:"
    for fn in "${FUNCNAME[@]}"; do
      printf " %s" "$(consoleWarning "$fn")"
    done
    printf "\n"
    consoleError "$(basename "${BASH_SOURCE[0]}") FAILED $exitCode: TRACE $testTracing"
  fi
  if test "$messyOption"; then
    consoleInfo "Messy ... no cleanup"
    return 0
  fi
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
__buildTestSuite() {
  local quietLog allTests runTests shortTest startTest
  local usage __argument
  local continueFile continueFlag

  usage="_${FUNCNAME[0]}"

  quietLog="$(buildQuietLog "${FUNCNAME[0]}")"

  export BUILD_COLORS_MODE
  export BUILD_HOME
  export cleanExit=
  export testTracing

  BUILD_COLORS_MODE=$(consoleConfigureColorMode)

  __environment buildEnvironmentLoad BUILD_HOME || return $?

  printf "%s %s\n" "$(consoleInfo "Color mode is")" "$(consoleCode "$BUILD_COLORS_MODE")"

  testTracing=initialization
  trap messyTestCleanup EXIT QUIT TERM

  messyOption=
  allTests=(sugar colors console debug git decoration url ssh log version type process os hook pipeline identical)
  # Strange quoting for a s s e r t is to hide it from findUncaughtAssertions
  allTests+=(text float utilities self markdown documentation "ass""ert" usage docker api tests aws php bin deploy deployment)
  allTests+=(sysvinit daemontools)
  while read -r shortTest; do
    if ! inArray "$shortTest" "${allTests[@]}"; then
      consoleError "MISSING $shortTest in allTests"
      allTests+=("$shortTest")
    fi
  done < <(shortTestCodes)
  runTests=()

  continueFile="$BUILD_HOME/.last-run-test"
  continueFlag=false
  testTracing=options
  printf "%s\n" "$testTracing" >>"$quietLog"
  while [ $# -gt 0 ]; do
    __argument="$1"
    case "$__argument" in
      --show)
        printf "%s\n" "${allTests[@]}"
        _textExit 0
        ;;
      --continue)
        continueFlag=true
        ;;
      --one)
        shift || __failArgument "$usage" "missing $(consoleLabel "$__argument") argument" || return $?
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
        __failArgument "$usage" "unknown argument: $(consoleValue "$__argument")" || return $?
        ;;
    esac
    shift || __failArgument "$usage" "shift argument $(consoleLabel "$__argument")" || return $?
  done

  $continueFlag || [ ! -f "$continueFile" ] || __usageEnvironment "$usage" rm "$continueFile" || return $?

  if [ ${#runTests[@]} -eq 0 ]; then
    runTests=("${allTests[@]}")
  fi
  # tests-tests.sh has side-effects - installs shellcheck
  # aws-tests.sh testAWSIPAccess has side-effects, installs AWS
  # bin-tests has side effects - installs OS software
  startTest=
  if $continueFlag; then
    startTest="$([ ! -f "$continueFile" ] || cat "$continueFile")"
  fi
  for shortTest in "${runTests[@]}"; do
    testTracing="test: $shortTest"
    __environment requireFileDirectory "$quietLog" || return $?
    printf "%s\n" "$testTracing" >>"$quietLog" || _environment "Failed to write $quietLog" || return $?
    if [ -n "$startTest" ]; then
      if [ "$shortTest" = "$startTest" ]; then
        startTest=
        clearLine
        consoleWarning "Continuing at test $(consoleCode "$shortTest") ..."
      else
        statusMessage consoleWarning "Skipping $(consoleCode "$shortTest") ..."
        continue
      fi
    fi
    if $continueFlag; then
      printf "%s\n" "$shortTest" >"$continueFile"
    fi
    requireTestFiles "$quietLog" "$shortTest-tests.sh" || return $?
  done

  cleanExit=1

  printf "%s\n" "$testTracing" >>"$quietLog"
  testTracing=cleanup
  messyTestCleanup

  printf "%s\n" "$(bigText --bigger Passed)" | wrapLines "" "    " | wrapLines --fill "*" "$(consoleSuccess)    " "$(consoleReset)"
  if [ -n "$continueFile" ]; then
    printf "%s\n" "PASSED" >"$continueFile"
  fi
  consoleReset
}
___buildTestSuite() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__testLoader __buildTestSuite "$@"
