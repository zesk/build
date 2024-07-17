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

# IDENTICAL __tools 18
# Usage: {fn} [ relative [ command ... ] ]
# Load build tools and run command
# Argument: relative - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__tools() {
  local relative="${1:-".."}"
  local source="${BASH_SOURCE[0]}" internalError=253
  local here="${source%/*}"
  local tools="$here/$relative/bin/build"
  [ -d "$tools" ] || _return $internalError "$tools is not a directory" || return $?
  tools="$tools/tools.sh"
  [ -x "$tools" ] || _return $internalError "$tools not executable" "$@" || return $?
  # shellcheck source=/dev/null
  source "$tools" || _return $internalError source "$tools" "$@" || return $?
  shift
  [ $# -eq 0 ] && return 0
  "$@" || return $?
}

__messyTestCleanup() {
  local fn exitCode=$?

  export cleanExit
  cleanExit="${cleanExit-}"
  if ! test "$cleanExit"; then
    printf -- "%s\n" "Stack:"
    for fn in "${FUNCNAME[@]}"; do
      printf -- "#%d %s\n" "$(incrementor "${FUNCNAME[0]}")" "$fn"
    done
    printf "\n%s\n" "$(basename "${BASH_SOURCE[0]}") FAILED $exitCode: TRACE $testTracing"
  fi
  if test "$messyOption"; then
    printf "%s\n" "Messy ... no cleanup"
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
# Argument: -l - Optional. Flag. List all test suites.
# Argument: --help - Optional. This help.
# Argument: --clean - Optional. Delete test artifact files before starting.
# Argument: --continue - Optional. Flag. Continue from last successful test.
# Argument: -c - Optional. Flag. Continue from last successful test.
# Argument: --messy - Optional. Do not delete test artifact files afterwards.
#
__buildTestSuite() {
  local usage="_${FUNCNAME[0]}"

  local quietLog allTests runTests shortTest startTest matchTests
  # Avoid conflict with __argument
  local __ARGUMENT start
  local continueFile continueFlag

  export BUILD_COLORS_MODE
  export BUILD_HOME
  export cleanExit=
  export testTracing
  export FUNCNEST

  FUNCNEST=200

  # shellcheck source=/dev/null

  source ./test/test-tools.sh || __failEnvironment "$usage" "test-tools.sh" || return $?

  quietLog="$(__usageEnvironment "$usage" buildQuietLog "${FUNCNAME[0]}")" || return $?
  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  BUILD_COLORS_MODE=$(__usageEnvironment "$usage" consoleConfigureColorMode)

  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_HOME || return $?

  printf "%s started on %s (color %s)\n" "$(consoleBoldRed "${BASH_SOURCE[0]}")" "$(consoleValue "$(date +"%F %T")")" "$(consoleCode "$BUILD_COLORS_MODE")"

  testTracing=initialization
  trap __messyTestCleanup EXIT QUIT TERM

  messyOption=
  allTests=(sugar colors console debug git decoration url ssh log version type process os hook pipeline identical)
  # Strange quoting for a s s e r t is to hide it from findUncaughtAssertions
  allTests+=(text bash float utilities self markdown documentation "ass""ert" usage docker api tests aws php bin deploy deployment)
  allTests+=(sysvinit crontab daemontools)
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
  matchTests=()
  printf "%s\n" "$testTracing" >>"$quietLog"
  while [ $# -gt 0 ]; do
    __ARGUMENT="$1"
    case "$__ARGUMENT" in
      -l | --show)
        printf "%s\n" "${allTests[@]}"
        _textExit 0
        ;;
      -c | --continue)
        continueFlag=true
        ;;
      -1 | --one)
        shift || __failArgument "$usage" "missing $(consoleLabel "$__ARGUMENT") argument" || return $?
        printf "%s %s\n" "$(consoleWarning "Adding one suite:")" "$(consoleBoldRed "$1")"
        runTests+=("$1")
        ;;
      -h | --help)
        "$usage" 0
        _textExit 0
        ;;
      --clean)
        statusMessage consoleWarning "Cleaning tests and exiting ... "
        cleanExit=true
        testCleanup || return $?
        statusMessage reportTiming "$start" "Cleaned in"
        printf "\n"
        return 0
        ;;
      --messy)
        messyOption=1
        ;;
      *)
        matchTests+=("$1")
        ;;
    esac
    shift || __failArgument "$usage" "shift argument $(consoleLabel "$__ARGUMENT")" || return $?
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
    if [ "${#matchTests[@]}" -gt 0 ]; then
      matches=false
      for matchTest in "${matchTests[@]}"; do
        if [ "${shortTest#"*$matchTest"}" != "$shortTest" ]; then
          matches=true
        fi
      done
      $matches || continue
    fi
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
  statusMessage consoleInfo "All tests completed."
  cleanExit=1

  printf "%s\n" "$testTracing" >>"$quietLog"
  testTracing=cleanup
  __messyTestCleanup
  printf "\n"
  printf "%s\n" "$(bigText --bigger Passed)" | wrapLines "" "    " | wrapLines --fill "*" "$(consoleSuccess)    " "$(consoleReset)"
  if [ -n "$continueFile" ]; then
    printf "%s\n" "PASSED" >"$continueFile"
  fi
  consoleReset
}
___buildTestSuite() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools .. __buildTestSuite "$@"
