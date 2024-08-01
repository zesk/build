#!/usr/bin/env bash
#
# test-tools.sh
#
# Test tools
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

export testTracing
export globalTestFailure=

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
testSuite() {
  local usage="_${FUNCNAME[0]}"
  local testFile quietLog allTests checkTests item startTest matchTests foundTests tests filteredTests failExecutors sectionName sectionNameHeading
  # Avoid conflict with __argument
  local __ARGUMENT start showFlag
  local continueFile continueFlag doStats statsFile allTestStart testStart testPaths

  export BUILD_COLORS BUILD_COLORS_MODE BUILD_HOME FUNCNEST TERM

  export cleanExit=
  export testTracing

  cleanExit=false
  FUNCNEST=200

  allTestStart=$(__usageEnvironment "$usage" beginTiming) || return $?

  hasColors || printf "%s" "No colors available in TERM ${TERM-}\n"

  quietLog="$(__usageEnvironment "$usage" buildQuietLog "${FUNCNAME[0]}")" || return $?
  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  BUILD_COLORS_MODE=$(__usageEnvironment "$usage" consoleConfigureColorMode)

  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_HOME BUILD_COLORS || return $?

  printf "%s started on %s (color %s %s)\n" "$(consoleBoldRed "${FUNCNAME[0]}")" "$(consoleValue "$(date +"%F %T")")" "${BUILD_COLORS-no colors}" "$(consoleCode "$BUILD_COLORS_MODE")"

  testTracing=initialization
  trap __testCleanupMess EXIT QUIT TERM

  messyOption=
  checkTests=()
  continueFile="$BUILD_HOME/.last-run-test"
  continueFlag=false
  testTracing=options
  matchTests=()
  failExecutors=()
  doStats=true
  showFlag=false
  testPaths=()
  printf "%s\n" "$testTracing" >>"$quietLog"
  while [ $# -gt 0 ]; do
    __ARGUMENT="$1"
    case "$__ARGUMENT" in
      -l | --show)
        showFlag=true
        ;;
      --tests)
        shift
        testPaths+=("$(usageArgumentDirectory "$usage" "$argument" "${1-}")") || return $?
        ;;
      --no-stats)
        doStats=false
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

  [ "${#testPaths[@]}" -gt 0 ] || __failArgument "$usage" "Need at least one --tests directory" || return $?

  allTests=()
  while read -r item; do
    allTests+=("$item")
  done < <(__testFiles "${testPaths[@]}" | sort -u)

  if $showFlag; then
    __testCode "${allTests[@]}"
    _textExit 0
  fi

  $continueFlag || [ ! -f "$continueFile" ] || __usageEnvironment "$usage" rm "$continueFile" || return $?

  if [ ${#checkTests[@]} -eq 0 ]; then
    checkTests=("${allTests[@]}")
  else
    foundTests=()
    for item in "${checkTests[@]}"; do
      foundTests+=("$(__testLookup "$usage" "$item" "${allTests[@]}")") || return $?
    done
    checkTests=("${foundTests[@]+"${foundTests[@]}"}")
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
    if ! __testLoad "$item" >"$testFunctions"; then
      __failEnvironment "$usage" "Can not load $item" || return $?
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
      tests+=("#$(__testCode "$item")" "${foundTests[@]+"${foundTests[@]}"}")
    else
      consoleError "No tests found in $testFile" 1>&2
    fi
  done
  ! $doStats || statsFile=$(__environment mktemp) || return $?
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
      testStart=$(__environment date +%s) || return $?
      __testRun "$quietLog" "$item" || __testSuiteExecutor "$item" "$sectionName" "${failExecutors[@]+"${failExecutors[@]}"}" || __testFailed "$item" || return $?
      ! $doStats || printf "%d %s\n" $(($(date +%s) - testStart)) "$item" >>"$statsFile"
    done
    bigText --bigger Passed | wrapLines "" "    " | wrapLines --fill "*" "$(consoleSuccess)    " "$(consoleReset)"
    if $continueFlag; then
      printf "%s\n" "PASSED" >"$continueFile"
    fi
  else
    __failEnvironment "$usage" "No tests match: $(consoleValue "${matchTests[*]}")"
  fi
  [ -z "$statsFile" ] || __testStats "$statsFile"
  reportTiming "$allTestStart" "Completed in"

  _textExit 0
}
_testSuite() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__testStats() {
  local statsFile="$1" targetFile zeroTests
  targetFile="$(buildHome)/test.stats"
  sort -rn <"$statsFile" >"$targetFile"
  rm -rf "$statsFile" || :
  boxedHeading "Slowest tests"
  head -n 20 <"$targetFile"
  boxedHeading "Fastest tests"
  grep -v -e '^0 ' "$targetFile" | tail -n 20
  boxedHeading "Zero-second tests"
  IFS=$'\n' read -d '' -r -a zeroTests < <(grep -e '^0 ' "$targetFile" | awk '{ print $2 }')
  printf "%s " "${zeroTests[@]+"${zeroTests[@]}"}"
  printf "\n"
}

__testLookup() {
  local usage="$1" lookup="$2"

  shift 2
  while [ $# -gt 0 ]; do
    if [ "$lookup" = "$(__testCode "$1")" ]; then
      printf "%s\n" "$1"
      return 0
    fi
    shift
  done
  __failArgument "$usage" "No such suite $lookup" || return $?
}

__testGetLine() {
  local line

  line=$(grep -n "$1() {" | cut -d : -f 1)
  if _integer "$line"; then
    printf "%d\n" "$line"
  fi
  return 1
}

__testSuiteExecutor() {
  local item="${1-}" line
  local file="$item"
  local executorArgs

  shift 2 || _argument "Missing item or section" || return $?

  line=$(__testGetLine "$item" <"$file") || :
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

__testCode() {
  local testPath
  while [ "$#" -gt 0 ]; do
    testPath="$(basename "$1")"
    testPath="${testPath%-*}"
    printf "%s\n" "$testPath"
    shift
  done
}

__testFiles() {
  while [ "$#" -gt 0 ]; do
    find "$1" -type f -name '*-tests.sh'
    shift
  done
}

__testDidAnythingFail() {
  export globalTestFailure

  globalTestFailure=${globalTestFailure:-}
  if test "$globalTestFailure"; then
    printf %s "$globalTestFailure"
    return 0
  fi
  return 1
}

__testSection() {
  [ -n "$*" ] || _argument "Blank argument $(debuggingStack)"
  clearLine
  boxedHeading --size 0 "$@"
}

__testHeading() {
  whichApt toilet toilet 2>/dev/null 1>&2 || _environment "Unable to install toilet" || return $?
  consoleCode "$(consoleOrange "$(echoBar '*')")"
  printf "%s" "$(consoleCode)$(clearLine)"
  bigText "$@" | wrapLines --fill " " "$(consoleCode)    " "$(consoleReset)"
  consoleCode "$(consoleOrange "$(echoBar '=')")"
}

debugTermDisplay() {
  printf "TERM: %s DISPLAY: %s\n" "${TERM-none}" "${DISPLAY-none} hasColors: $(
    hasColors
    printf %d $?
  )"
}

#
# Load one or more test files and run the tests defined within
#
# Usage: {fn} filename [ ... ]
# Argument: filename - File. Required. File located at `./test/tools/` and must be a valid shell file.
#
__testLoad() {
  local usage="_${FUNCNAME[0]}"
  local tests __testDirectory resultCode stickyCode resultReason
  local __test __tests tests

  __beforeFunctions=$(__usageEnvironment "$usage" mktemp) || return $?
  __testFunctions="$__beforeFunctions.after"
  __tests=()
  while [ "$#" -gt 0 ]; do
    __usageEnvironment "$usage" isExecutable "$1" || _clean $? "$__beforeFunctions" "$__testFunctions" || return $?

    declare -pF | removeFields 2 | grep -e '^test' >"$__beforeFunctions"
    tests=()
    set -a
    # shellcheck source=/dev/null
    source "$1" 1>&2 || __failEnvironment source "./test/tools/$1" || _clean $? "$__beforeFunctions" "$__testFunctions" || return $?
    set +a

    declare -pF | removeFields 2 | grep -e '^test' | diff "$__beforeFunctions" - | grep -e '^[<>]' | cut -c 3- >"$__testFunctions" || :
    [ "${#tests[@]}" -gt 0 ] || break
    __tests+=("${tests[@]}")
    while read -r __test; do
      inArray "$__test" "${tests[@]}" || consoleError "$(clearLine)Test defined but not run: $(consoleCode "$__test")" 1>&2
      __tests+=("$__test")
    done <"$__testFunctions"
    shift
  done
  rm -rf "$__beforeFunctions" "$__testFunctions" || :
  printf "%s\n" "${__tests[@]}"
}
___testLoad() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Load one or more test files and run the tests defined within
#
# Usage: {fn} filename [ ... ]
# Argument: filename - File. Required. File located at `./test/tools/` and must be a valid shell file.
#
__testRun() {
  local usage="_${FUNCNAME[0]}"
  local quietLog="$1"
  local tests testName __testDirectory resultCode stickyCode resultReason
  local __test __tests tests
  local __beforeFunctions errorTest

  export testTracing
  export resultReason

  errorTest=$(_code test)
  stickyCode=0
  shift || :

  # Renamed to avoid clobbering by tests
  __testDirectory=$(pwd)

  resultReason=AOK
  while [ $# -gt 0 ]; do
    __test="$1"
    shift
    # Test
    __testSection "$__test" || :
    printf "%s %s ...\n" "$(consoleInfo "Running")" "$(consoleCode "$__test")"

    printf "%s\n" "Running $__test" >>"$quietLog"
    resultCode=0
    testTracing="$__test"
    if plumber "$__test" "$quietLog"; then
      printf "%s\n" "SUCCESS $__test" >>"$quietLog"
    else
      resultCode=$?
      printf "%s\n" "FAILED $__test" >>"$quietLog"
      stickyCode=$errorTest
    fi

    # So, `usage` can be overridden if it is made global somehow, declare -r prevents changing here
    # documentation-tests.sh change this apparently
    # Instead of preventing this usage, just work around it
    __usageEnvironment "_${FUNCNAME[0]}" cd "$__testDirectory" || return $?

    if [ "$resultCode" = "$(_code leak)" ]; then
      resultCode=0
      printf "%s %s ...\n" "$(consoleCode "$__test")" "$(consoleWarning "passed with leaks")"
    elif [ "$resultCode" -eq 0 ]; then
      printf "%s %s ...\n" "$(consoleCode "$__test")" "$(consoleGreen "passed")"
    else
      printf "[%d] %s %s\n" "$resultCode" "$(consoleCode "$__test")" "$(consoleError "FAILED")" 1>&2
      buildFailed "$quietLog" || :
      resultReason="test $__test failed"
      stickyCode=$errorTest
      break
    fi
  done
  if [ "$stickyCode" -eq 0 ] && resultReason=$(__testDidAnythingFail); then
    # Should probably reset test status but ...
    stickyCode=$errorTest
  fi
  if [ "$stickyCode" -ne 0 ]; then
    printf "%s %s\n" "$(consoleLabel "Reason:")" "$(consoleMagenta "$resultReason")"
  fi
  return "$stickyCode"
}
___testRun() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__testMatches() {
  local testName match

  testName=$(lowercase "$1")
  shift
  while [ "$#" -gt 0 ]; do
    match=$(lowercase "$1")
    if [ "${testName#*"$match"}" != "$testName" ]; then
      return 0
    fi
    shift
  done
  return 1
}

__testFailed() {
  local errorCode name

  errorCode="$(_code test)"
  export IFS
  printf "%s: %s - %s %s\n" "$(consoleError "Exit")" "$(consoleBoldRed "$errorCode")" "$(consoleError "Failed running")" "$(consoleInfo "$*")"
  for name in IFS HOME LINES COLUMNS OSTYPE PPID PID; do
    printf "%s=%s\n" "$(consoleLabel "$name")" "$(consoleValue "${!name-}")"
  done
  export globalTestFailure="$*"
  return "$errorCode"
}

#
# Usage: {fn}
#
__testCleanup() {
  __environment rm -rf ./vendor/ ./node_modules/ ./composer.json ./composer.lock ./test.*/ ./aws "$(buildCacheDirectory)" || :
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
