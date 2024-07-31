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

__testCleanupMess() {
  local fn exitCode=$?

  export cleanExit

  cleanExit="${cleanExit-}"
  if [ "$cleanExit" != "true" ]; then
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
  __testCleanup
}

_textExit() {
  export cleanExit
  if [ "${1-}" = 0 ]; then
    cleanExit=true
  fi
  exit "$@"
}

#
# fn: {base}
# Usage: {fn} [ --one suiteName | -1 suiteName ] [ --show ] [ --help ] [ --clean ] [ --messy ] [ --continue | -c ] [ testFunctionPattern ... ]
# Run Zesk Build test suites
#
# Argument: --one test - Optional. Add one test suite to run.
# Argument: --show - Optional. Flag. List all test suites.
# Argument: -l - Optional. Flag. List all test suites.
# Argument: --help - Optional. This help.
# Argument: --clean - Optional. Delete test artifact files and exit. (No tests run)
# Argument: --continue - Optional. Flag. Continue from last successful test.
# Argument: -c - Optional. Flag. Continue from last successful test.
# Argument: --messy - Optional. Do not delete test artifact files afterwards.
# Argument: --fail executor - Optional. Callable. One or more programs to run on the failed test files.
# Argument: testFunctionPattern - Optional. String. Test function (or substring of function name) to run.
#
__buildTestSuite() {
  local usage="_${FUNCNAME[0]}"
  local here="${BASH_SOURCE[0]%/*}"
  local testFile quietLog allTests checkTests item startTest matchTests foundTests tests filteredTests failExecutors sectionName sectionNameHeading
  # Avoid conflict with __argument
  local __ARGUMENT start
  local continueFile continueFlag

  export BUILD_COLORS BUILD_COLORS_MODE BUILD_HOME FUNCNEST TERM

  export cleanExit=
  export testTracing

  cleanExit=false
  FUNCNEST=200

  hasColors || printf "%s" "No colors available in TERM ${TERM-}\n"
  # shellcheck source=/dev/null
  source "$here/../test/test-tools.sh" || __failEnvironment "$usage" "test-tools.sh" || return $?

  quietLog="$(__usageEnvironment "$usage" buildQuietLog "${FUNCNAME[0]}")" || return $?
  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  BUILD_COLORS_MODE=$(__usageEnvironment "$usage" consoleConfigureColorMode)

  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_HOME BUILD_COLORS || return $?

  printf "%s started on %s (color %s %s)\n" "$(consoleBoldRed "${BASH_SOURCE[0]}")" "$(consoleValue "$(date +"%F %T")")" "${BUILD_COLORS-no colors}" "$(consoleCode "$BUILD_COLORS_MODE")"

  testTracing=initialization
  trap __testCleanupMess EXIT QUIT TERM

  messyOption=
  allTests=()
  while read -r item; do
    allTests+=("$item")
  done < <(__testCodes | sort -u)

  checkTests=()
  continueFile="$BUILD_HOME/.last-run-test"
  continueFlag=false
  testTracing=options
  matchTests=()
  failExecutors=()
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
        checkTests+=("$1")
        ;;
      -h | --help)
        "$usage" 0
        _textExit 0
        ;;
      --fail)
        shift
        failExecutors+=("$(usageArgumentCallable "$usage" "failExecutor" "${1-}")") || return $?
        ;;
      --clean)
        statusMessage consoleWarning "Cleaning tests and exiting ... "
        cleanExit=true
        __testCleanup || return $?
        statusMessage reportTiming "$start" "Cleaned in"
        printf "\n"
        return 0
        ;;
      --messy)
        messyOption=1
        ;;
      *)
        matchTests+=("$(usageArgumentString "$usage" "match" "$1")")
        ;;
    esac
    shift || __failArgument "$usage" "shift argument $(consoleLabel "$__ARGUMENT")" || return $?
  done

  $continueFlag || [ ! -f "$continueFile" ] || __usageEnvironment "$usage" rm "$continueFile" || return $?

  if [ ${#checkTests[@]} -eq 0 ]; then
    checkTests=("${allTests[@]}")
  fi
  # tests-tests.sh has side-effects - installs shellcheck
  # aws-tests.sh testAWSIPAccess has side-effects, installs AWS
  # bin-tests has side effects - installs OS software
  startTest=
  if $continueFlag; then
    startTest="$([ ! -f "$continueFile" ] || cat "$continueFile")"
  fi
  __environment requireFileDirectory "$quietLog" || return $?
  testFunctions=$(__usageEnvironment "$usage" mktemp) || return $?
  tests=()
  for item in "${checkTests[@]}"; do
    testFile="$item-tests.sh"
    if ! __testLoad "$testFile" >"$testFunctions"; then
      __failEnvironment "$usage" "Can not load $testFile" || return $?
    fi
    foundTests=()
    while read -r foundTest; do
      if [ -n "$foundTest" ]; then
        if isCallable "$foundTest"; then
          foundTests+=("$foundTest")
        else
          consoleError "Invalid test $foundTest is not callable"
        fi
      fi
    done < <(sort -u "$testFunctions")
    testCount="${#foundTests[@]}"
    if [ "$testCount" -gt 0 ]; then
      statusMessage consoleSuccess "$item: Loaded $testCount $(plural "$testCount" test tests)"
      tests+=("#$item" "${foundTests[@]+"${foundTests[@]}"}")
    else
      consoleError "No tests found in $testFile" 1>&2
    fi
  done
  rm -f "$testFunctions" || :
  [ "${#tests[@]}" -gt 0 ] || __failEnvironment "$usage" "No tests found" || return $?
  filteredTests=()
  for item in "${tests[@]}"; do
    if [ "$item" = "${item#\#}" ]; then
      if [ -n "$startTest" ]; then
        if [ "$item" = "$startTest" ]; then
          startTest=
          clearLine
          consoleWarning "Continuing at test $(consoleCode "$item") ..."
        else
          statusMessage consoleWarning "Skipping $(consoleCode "$item") ..."
          continue
        fi
      fi
      if [ "${#matchTests[@]}" -gt 0 ]; then
        if ! __testMatches "$item" "${matchTests[@]}"; then
          continue
        fi
        statusMessage consoleSuccess "Matched $(consoleValue "$item")"
      fi
    fi
    filteredTests+=("$item")
  done
  if [ ${#filteredTests[@]} -gt 0 ]; then
    sectionName=
    sectionNameHeading=
    for item in "${filteredTests[@]}"; do
      if [ "$item" != "${item#\#}" ]; then
        sectionName="${item#\#}"
        continue
      fi
      if $continueFlag; then
        printf "%s\n" "$item" >"$continueFile"
      fi
      if [ "$sectionName" != "$sectionNameHeading" ]; then
        clearLine
        __testHeading "$sectionName"
        sectionNameHeading="$sectionName"
      fi
      __testRun "$quietLog" "$item" || __buildTestSuiteExecutor "$item" "$sectionName" "${failExecutors[@]+"${failExecutors[@]}"}" || __testFailed "$item" || return $?
    done
    bigText --bigger Passed | wrapLines "" "    " | wrapLines --fill "*" "$(consoleSuccess)    " "$(consoleReset)"
    if $continueFlag; then
      printf "%s\n" "PASSED" >"$continueFile"
    fi
  else
    __failEnvironment "$usage" "No tests match: $(consoleValue "${matchTests[*]}")"
  fi
  _textExit 0
}
___buildTestSuite() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__buildTestGetLine() {
  local line

  line=$(grep -n "$1() {" | cut -d : -f 1)
  if _integer "$line"; then
    printf "%d\n" "$line"
  fi
  return 1
}

__buildTestSuiteExecutor() {
  local here="${BASH_SOURCE[0]%/*}"
  local item="${1-}" section="${2-}" line
  local file="$here/../test/tools/$section-tests.sh"
  local executorArgs

  shift 2 || _argument "Missing item or section" || return $?

  line=$(__buildTestGetLine "$item" <"$file") || :
  [ -z "$line" ] || line=":$line"

  statusMessage consoleError "Test $item failed in $file" || :
  while [ $# -gt 0 ]; do
    read -r -a executorArgs < <(printf "%s\n" "$1")
    statusMessage consoleInfo "Running" "${executorArgs[@]}" "$file$line"
    "${executorArgs[@]}" "$file$line"
    shift
  done
  clearLine
  return 1
}

__tools .. __buildTestSuite "$@"
