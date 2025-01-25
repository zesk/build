#!/usr/bin/env bash
#
# test-tools.sh
#
# Test tools
#
# Copyright &copy; 2025 Market Acumen, Inc.
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
# Argument: --verbose - Optional. Flag. Be verbose.
# Argument: --coverage - Optional. Flag. Feature in progress - generate a coverage file for tests.
# Argument: --no-stats - Optional. Flag. Do not generate a test.stats file showing test timings when completed.
# Argument: --list - Optional. Flag. List all test names (which match if applicable).
# Argument: --messy - Optional. Do not delete test artifact files afterwards.
# Argument: --fail executor - Optional. Callable. One or more programs to run on the failed test files.
# Argument: --env-file environmentFile - Optional. EnvironmentFile. Load one ore more environment files prior to running tests
# Argument: testFunctionPattern - Optional. String. Test function (or substring of function name) to run.
# Hook: bash-test-start
# Hook: bash-test-pass
# Hook: bash-test-fail
# Requires: head tee printf trap
# Requires: decorate loadAverage consoleConfigureColorMode
# Requires: buildEnvironmentLoad usageArgumentString __catchEnvironment
# Requires: bashCoverage TODO
testSuite() {
  local usage="_${FUNCNAME[0]}"
  local quietLog allTests checkTests item startTest matchTests foundTests tests filteredTests failExecutors sectionName sectionFile sectionNameHeading
  # Avoid conflict with __argument
  local __ARGUMENT start mode
  local statsFile allTestStart testStart testPaths runner startString continueFile verboseMode=false load
  local listFlag=false runner=() testPaths=() messyOption="" checkTests=() continueFlag=false matchTests=() failExecutors=() doStats=true showFlag=false

  startString="$(__catchEnvironment "$usage" date +"%F %T")" || return $?
  load=$(decorate value "(Load $(loadAverage | head -n 1))")
  export BUILD_COLORS BUILD_COLORS_MODE BUILD_HOME FUNCNEST TERM BUILD_DEBUG

  export cleanExit=
  export testTracing

  cleanExit=false
  FUNCNEST=200

  allTestStart=$(__catchEnvironment "$usage" beginTiming) || return $?

  quietLog="$(__catchEnvironment "$usage" buildQuietLog "$usage")" || return $?
  __catchEnvironment "$usage" printf -- "%s started on %s %s\n" "${usage#_}" "$startString" "$load" | tee "$quietLog" || return $?
  start=$(__catchEnvironment "$usage" beginTiming) || return $?
  BUILD_COLORS_MODE=$(__catchEnvironment "$usage" consoleConfigureColorMode)
  BUILD_DEBUG="${BUILD_DEBUG-},fast-usage"
  BUILD_DEBUG="${BUILD_DEBUG#,}"
  __catchEnvironment "$usage" buildEnvironmentLoad BUILD_HOME BUILD_COLORS || return $?

  mode="$BUILD_COLORS_MODE"
  [ -n "$mode" ] || mode=none

  testTracing=initialization
  trap '__testCleanupMess' EXIT QUIT TERM
  bashDebugInterruptFile

  printf "%s\n" "$testTracing" >>"$quietLog"
  while [ $# -gt 0 ]; do
    __ARGUMENT="$1"
    case "$__ARGUMENT" in
      -l | --show)
        showFlag=true
        ;;
      --verbose)
        verboseMode=true
        ;;
      --env-file)
        shift
        muzzle usageArgumentLoadEnvironmentFile "$usage" "envFile" "${1-}" || return $?
        decorate info "Loaded environment file $(decorate code "$1")"
        ;;
      --tests)
        shift
        testPaths+=("$(usageArgumentDirectory "$usage" "$__ARGUMENT" "${1-}")") || return $?
        ;;
      --coverage)
        decorate warning "Will collect coverage statistics ..."
        runner=(bashCoverage)
        ;;
      --no-stats)
        doStats=false
        ;;
      -c | --continue)
        continueFlag=true
        ;;
      -1 | --one)
        shift
        checkTests+=("$(usageArgumentString "$usage" "$argument" "${1-}")") || return $?
        printf "%s %s\n" "$(decorate warning "Adding one suite:")" "$(decorate bold-red "$1")"
        ;;
      -h | --help)
        "$usage" 0
        _textExit 0
        ;;
      --list)
        verboseMode=false
        listFlag=true
        ;;
      --fail)
        shift
        failExecutors+=("$(usageArgumentCallable "$usage" "failExecutor" "${1-}")") || return $?
        ;;
      --clean)
        statusMessage decorate warning "Cleaning tests and exiting ... "
        cleanExit=true
        __testCleanup || return $?
        statusMessage reportTiming "$start" "Cleaned in"
        printf "\n"
        return 0
        ;;
      --messy)
        trap '__testCleanupMess true' EXIT QUIT TERM
        ;;
      *)
        matchTests+=("$(usageArgumentString "$usage" "match" "$1")")
        ;;
    esac
    shift || __throwArgument "$usage" "shift argument $(decorate label "$__ARGUMENT")" || return $?
  done

  [ "${#testPaths[@]}" -gt 0 ] || __throwArgument "$usage" "Need at least one --tests directory" || return $?

  if $verboseMode; then
    hasColors || printf "%s" "No colors available in TERM ${TERM-}\n"
    printf "%s started on %s (%s)\n" "$(decorate bold-red "${usage#_}")" "$(decorate value "$startString")" "$(decorate code "$mode")"
  fi

  allTests=()
  while read -r item; do
    allTests+=("$item")
  done < <(__testFiles "${testPaths[@]}" | sort -u)

  if $showFlag; then
    __testCode "${allTests[@]}"
    _textExit 0
  fi

  continueFile="$BUILD_HOME/.last-run-test"
  $continueFlag || [ ! -f "$continueFile" ] || __catchEnvironment "$usage" rm "$continueFile" || return $?

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
  testFunctions=$(fileTemporaryName "$usage") || return $?
  tests=()
  __bashCoverageStart "$home/test.stats"
  for item in "${checkTests[@]}"; do
    if ! __testLoad "$item" >"$testFunctions"; then
      __throwEnvironment "$usage" "Can not load $item" || return $?
    fi
    foundTests=()
    while read -r foundTest; do
      if [ -n "$foundTest" ]; then
        if isCallable "$foundTest"; then
          foundTests+=("$foundTest")
        else
          decorate error "Invalid test $foundTest is not callable" 1>&2
        fi
      fi
    done < <(sort -u "$testFunctions")
    testCount="${#foundTests[@]}"
    if [ "$testCount" -gt 0 ]; then
      ! $verboseMode || statusMessage decorate success "$item: Loaded $testCount $(plural "$testCount" test tests)"
      tests+=("#$item" "${foundTests[@]+"${foundTests[@]}"}")
    else
      decorate error "No tests found in $item" 1>&2
      dumpPipe testFunctions <"$testFunctions" 1>&2
    fi
  done
  __bashCoverageEnd
  ! $doStats || statsFile=$(__environment mktemp) || return $?
  rm -f "$testFunctions" || :
  [ "${#tests[@]}" -gt 0 ] || __throwEnvironment "$usage" "No tests found" || return $?
  filteredTests=()
  for item in "${tests[@]}"; do
    if [ "$item" = "${item#\#}" ]; then
      if [ -n "$startTest" ]; then
        if [ "$item" = "$startTest" ]; then
          startTest=
          clearLine
          decorate warning "Continuing at test $(decorate code "$item") ..."
        else
          statusMessage decorate warning "Skipping $(decorate code "$item") ..."
          continue
        fi
      fi
      if [ "${#matchTests[@]}" -gt 0 ]; then
        if ! __testMatches "$item" "${matchTests[@]}"; then
          continue
        fi
        statusMessage decorate success "Matched $(decorate value "$item")"
      fi
    fi
    filteredTests+=("$item")
  done

  if $listFlag; then
    sectionName=
    for item in "${filteredTests[@]}"; do
      if [ "$item" != "${item#\#}" ]; then
        sectionFile="${item#\#}"
        sectionName=$(__testCode "$sectionFile")
        printf -- "# %s\n" "$sectionName"
        continue
      fi
      printf "%s\n" "$item"
    done
    cleanExit=true
    return 0
  fi

  local runTime
  if [ ${#filteredTests[@]} -gt 0 ]; then
    testTracing=options
    sectionName=
    sectionNameHeading=
    for item in "${filteredTests[@]}"; do
      if [ "$item" != "${item#\#}" ]; then
        sectionFile="${item#\#}"
        sectionName=$(__testCode "$sectionFile")
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
      __catchEnvironment "$usage" hookRunOptional bash-test-start "$sectionName" "$item" || __throwEnvironment "$usage" "... continuing" || :
      "${runner[@]+"${runner[@]}"}" __testRun "$quietLog" "$item" || __testSuiteExecutor "$item" "$sectionFile" "${failExecutors[@]+"${failExecutors[@]}"}" || __testFailed "$sectionName" "$item" || return $?
      runTime=$(($(date +%s) - testStart))
      ! $doStats || printf "%d %s\n" "$runTime" "$item" >>"$statsFile"
      __catchEnvironment "$usage" hookRunOptional bash-test-pass "$sectionName" "$item" || __throwEnvironment "$usage" "... continuing" || :
    done
    bigText --bigger Passed | wrapLines "" "    " | wrapLines --fill "*" "$(decorate success)    " "$(decorate reset)"
    if $continueFlag; then
      printf "%s\n" "PASSED" >"$continueFile"
    fi
  else
    __throwEnvironment "$usage" "No tests match: $(decorate value "${matchTests[*]}")"
  fi
  [ -z "$statsFile" ] || __testStats "$statsFile"
  reportTiming "$allTestStart" "Completed in"

  _textExit 0
}
_testSuite() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__testFunctionWasTested() {
  local assertedFunctions verboseMode=false

  assertedFunctions=$(__environment __assertedFunctions) || return $?
  local __fns=()
  while [ $# -gt 0 ]; do
    if [ "$1" = "--verbose" ]; then
      verboseMode=true
      shift
    fi
    local argument
    argument="$(usageArgumentFunction "$usage" function "$1")" || return $?
    if ! muzzle grep -q -e "^$(quoteGrepPattern "$argument")\$" "$assertedFunctions"; then
      return 1
    fi
    __fns+=("$argument")
    shift
  done
  ! $verboseMode || statusMessage decorate info "$(plural "${#__fns[@]}" "Function" "Functions") were tested: $(decorate code "${__fns[@]}")"
}

__testStats() {
  local statsFile="$1" targetFile zeroTests
  targetFile="$(buildHome)/test.stats"
  sort -rn <"$statsFile" >"$targetFile"
  rm -rf "$statsFile" || :
  boxedHeading "Slowest tests"
  head -n 50 <"$targetFile"
  boxedHeading "Fastest tests"
  grep -v -e '^0 ' "$targetFile" | tail -n 20
  boxedHeading "Zero-second tests"
  IFS=$'\n' read -d '' -r -a zeroTests < <(grep -e '^0 ' "$targetFile" | awk '{ print $2 }')
  printf -- "%s " "${zeroTests[@]+"${zeroTests[@]}"}"
  printf -- "\n"
  boxedHeading "Functions asserted"
  cat "$(__assertedFunctions)"
  lines=$(($(wc -l <"$(__assertedFunctions)") + 0))
  decorate info "$lines $(plural "$lines" "function" "functions")"
  printf -- "\n"
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
  __throwArgument "$usage" "No such suite $lookup" || return $?
}

__testGetLine() {
  local line

  line=$(grep -n "$1() {" | cut -d : -f 1)
  if isPositiveInteger "$line"; then
    printf "%d\n" "$line"
  fi
  return 1
}

__testSuiteExecutor() {
  local item="${1-}" line
  local file="${2-}"
  local executorArgs

  shift 2 || _argument "Missing item or section" || return $?

  line=$(__testGetLine "$item" <"$file") || :
  [ -z "$line" ] || line=":$line"

  statusMessage decorate error "Test $item failed in $file" || :
  while [ $# -gt 0 ]; do
    read -r -a executorArgs < <(printf "%s\n" "$1") || :
    statusMessage decorate info "Running" "${executorArgs[@]}" "$file$line"
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
  decorate code "$(decorate orange "$(echoBar '*')")"
  printf "%s" "$(decorate code)$(clearLine)"
  bigText "$@" | wrapLines --fill " " "$(decorate code)    " "$(decorate reset)"
  decorate code "$(decorate orange "$(echoBar '=')")"
}

__testDebugTermDisplay() {
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
  local tests
  local __test __tests tests __errors

  export DEBUGGING_TEST_LOAD

  __beforeFunctions=$(fileTemporaryName "$usage") || return $?
  __testFunctions="$__beforeFunctions.after"
  __errors="$__beforeFunctions.error"
  __testFunctions="$__beforeFunctions.after"
  __tests=()
  while [ "$#" -gt 0 ]; do
    __catchEnvironment "$usage" isExecutable "$1" || _clean $? "$__beforeFunctions" "$__testFunctions" || return $?

    declare -pF | awk '{ print $3 }' | grep -e '^test' | sort >"$__beforeFunctions"
    tests=()
    set -a
    # shellcheck source=/dev/null
    source "$1" >"$__errors" 2>&1 || __throwEnvironment source "$1" || _clean $? "$__beforeFunctions" "$__testFunctions" || return $?
    isEmptyFile "$__errors" || __throwEnvironment "produced output: $(dumpPipe "source $1" <"$__errors")"
    set +a
    if [ "${#tests[@]}" -gt 0 ]; then
      for __test in "${tests[@]}"; do
        [ "$__test" = "${__test#"test"}" ] || decorate error "$1 - no longer need tests+=(\"$__test\")" 1>&2
      done
      __tests+=("${tests[@]}")
    fi
    # diff outputs ("-" and "+") prefixes or ("< " and "> ")
    declare -pF | awk '{ print $3 }' | grep -e '^test' | sort | diff -U 0 "$__beforeFunctions" - | grep 'test' | cut -c 2- | trimSpace >"$__testFunctions" || :
    while read -r __test; do
      ! inArray "$__test" "${__tests[@]+"${__tests[@]}"}" || {
        clearLine
        decorate error "$1 - Duplicated: $(decorate code "$__test")"
      } 1>&2
      __tests+=("$__test")
    done <"$__testFunctions"
    shift
  done
  rm -rf "$__beforeFunctions" "$__testFunctions" || :
  [ "${#__tests[@]}" -gt 0 ] || return 0
  printf "%s\n" "${__tests[@]}"
}
___testLoad() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__testRunShellInitialize() {
  shopt -s shift_verbose failglob
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
  local __test __tests tests __testStart
  local __beforeFunctions errorTest

  export testTracing
  export resultReason

  __testRunShellInitialize

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
    printf "%s %s ...\n" "$(decorate info "Running")" "$(decorate code "$__test")"

    printf "%s\n" "Running $__test" >>"$quietLog"
    resultCode=0
    testTracing="$__test"
    __testStart=$(beginTiming)
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
    __catchEnvironment "_${FUNCNAME[0]}" cd "$__testDirectory" || return $?
    local timingText
    timingText="$(reportTiming "$__testStart")"
    if [ "$resultCode" = "$(_code leak)" ]; then
      resultCode=0
      printf "%s %s %s ...\n" "$(decorate code "$__test")" "$(decorate warning "passed with leaks")" "$timingText"
    elif [ "$resultCode" -eq 0 ]; then
      printf "%s %s %s ...\n" "$(decorate code "$__test")" "$(decorate success "passed")" "$timingText"
    else
      printf "[%d] %s %s %s\n" "$resultCode" "$(decorate code "$__test")" "$(decorate error "FAILED")" "$timingText" 1>&2
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
    printf "%s %s\n" "$(decorate label "Reason:")" "$(decorate magenta "$resultReason")"
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
  local errorCode name sectionName="$1" item="$2"

  __catchEnvironment "$usage" hookRunOptional bash-test-pass "$sectionName" "$item" || __throwEnvironment "$usage" "... continuing" || :

  errorCode="$(_code test)"
  export IFS
  printf "%s: %s - %s %s (%s)\n" "$(decorate error "Exit")" "$(decorate bold-red "$errorCode")" "$(decorate error "Failed running")" "$(decorate info "$item")" "$(decorate magenta "$sectionName")"
  for name in IFS HOME LINES COLUMNS OSTYPE PPID PID PWD TERM; do
    printf "%s=%s\n" "$(decorate label "$name")" "$(decorate value "${!name-}")"
  done
  decorate info "$(decorate magenta "$sectionName") $(decorate code "$item") failed on $(decorate value "$(date +"%F %T")")"
  export globalTestFailure="$*"
  return "$errorCode"
}

#
# Usage: {fn}
#
__testCleanup() {
  local home cache
  home=$(__environment buildHome) || return $?
  cache=$(__environment buildCacheDirectory) || return $?
  shopt -u failglob
  __environment rm -rf "$home/vendor/" "$home/node_modules/" "$home/composer.json" "$home/composer.lock" "$home/test."*/ "$home/.test"*/ "./aws" || return $?
  if [ -d "$cache" ]; then
    # __environment find "$cache" -type f ! -path '*/.build/.*/*'
    __environment find "$cache" -type f ! -path '*/.build/.*/*' -delete || return $?
    # Delete empty directories
    __environment find "$cache" -depth -type d -empty -delete || return $?
  fi
}

__testCleanupMess() {
  local fn exitCode=$? messyOption="${1-}"

  export cleanExit

  cleanExit="${cleanExit-}"
  if [ "$cleanExit" != "true" ]; then
    printf -- "%s\n" "Stack:"
    for fn in "${FUNCNAME[@]}"; do
      printf -- "#%d %s\n" "$(incrementor "${FUNCNAME[0]}")" "$fn"
    done
    printf "\n%s\n" "$(basename "${BASH_SOURCE[0]}") FAILED $exitCode: TRACE $testTracing"
  fi
  if [ "$messyOption" = "true" ]; then
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

# TODO: https://github.com/Perl-Toolchain-Gang/Test-Harness/blob/master/reference/Test-Harness-2.64/lib/Test/Harness/TAP.pod#php
# Argument: --tap - Optional. Flag. TAP output instead of console output.
#
# TAP's general format is:
#
#    1..N
#    ok 1 Description # Directive
#    not ok 2 Something
#    # Diagnostic
#    ....
#    ok 47 Description
#    ok 48 Description
#    more tests....
#
# TAP syntax:
#
#     1..N
#
# N is number of tests
#
# Directives for comments in descriptions:
#
#     not ok 2 # skip No processor installed.
#     not ok 3 # SKIP Note case does not matter
#
# Terminate testing:
#
#     Bail out!
#
# Test may pass or fail:
#
#     not ok 2 # TO DO This test may pass when Intel ships ARM chips
#
# Not the words TO and DO are together but are not here to avoid having this show up as a thing to do in the IDE.
#
