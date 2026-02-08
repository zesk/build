#!/usr/bin/env bash
# test-tools.sh
#
# Test tools
#
# Copyright &copy; 2026 Market Acumen, Inc.

# TODO: bashCoverage support
# TODO: results.xml output (hooks?)
__testSuite() {
  local handler="$1" && shift

  local tags=() skipTags=() runner=()
  local beQuiet=false listFlag=false verboseMode=false continueFlag=false doStats=true showFlag=false showTags=false cleanFlag=false
  local cdAway=false stopFlag=false
  local testPaths=() messyOption="" runTestSuites=() matchTests=() failExecutors=() hookArgs=()
  local startTest="" df=()

  set -eou pipefail

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    -l | --show)
      showFlag=true
      beQuiet=true
      ;;
    --debugger)
      bashDebuggerEnable
      ;;
    --stop)
      stopFlag=true
      ;;
    --verbose)
      verboseMode=true
      ;;
    --show-tags)
      beQuiet=true
      showTags=true
      ;;
    --junit | --tap)
      local hookPath && hookPath="bin/build/tools/test/${argument#--}/hooks"
      [ -d "$home/$hookPath" ] || throwEnvironment "$handler" "$hookPath must exist for $argument" || return $?
      export BUILD_HOOK_DIRS
      catchReturn "$handler" buildEnvironmentLoad BUILD_HOOK_DIRS || return $?
      BUILD_HOOK_DIRS="$hookPath:${BUILD_HOOK_DIRS-}"
      shift && hookArgs+=("$argument" "$(validate "$handler" FileDirectory "$argument" "${1-}")") || return $?
      ;;
    --tag)
      shift
      tags+=("$(validate "$handler" String "$argument" "${1-}")") || return $?
      ;;
    --skip-tag)
      shift
      skipTags+=("$(validate "$handler" String "$argument" "${1-}")") || return $?
      ;;
    --env-file)
      shift
      muzzle validate "$handler" LoadEnvironmentFile "envFile" "${1-}" || return $?
      decorate info "Loaded environment file $(decorate code "$1")"
      ;;
    --cd-away)
      cdAway=true
      ;;
    --tests)
      shift
      testPaths+=("$(validate "$handler" Directory "$argument" "${1-}")") || return $?
      ;;
    --coverage)
      $beQuiet || decorate warning "Will collect coverage statistics ..."
      runner=(bashCoverage)
      ;;
    --no-stats)
      doStats=false
      ;;
    -c | --continue)
      continueFlag=true
      ;;
    --start)
      [ -z "$startTest" ] || throwArgument "$handler" "$argument supplied twice" || return $?
      shift
      startTest="$(validate "$handler" String "$argument" "$1")" || return $?
      continueFlag=true
      ;;
    -1 | --one | --suite)
      shift
      runTestSuites+=("$(validate "$handler" String "$argument" "${1-}")") || return $?
      ;;
    --list)
      verboseMode=false
      beQuiet=true
      listFlag=true
      ;;
    --fail)
      shift && failExecutors+=("$(validate "$handler" Callable "failExecutor" "${1-}")") || return $?
      # shellcheck disable=SC2015
      while [ $# -gt 0 ]; do [ "$1" != "--" ] && failExecutors+=("$1") && shift || break; done
      failExecutors+=("--")
      ;;
    --clean)
      cleanFlag=true
      ;;
    --delete)
      shift
      dd+=("$(validate "$handler" FileDirectory "$argument" "${1-}")") || return $?
      ;;
    --delete-common)
      dd+=("$(buildHome)/vendor") || return $?
      dd+=("$(buildHome)/node_modules") || return $?
      dd+=("$(buildHome)/.composer") || return $?
      ;;
    --messy)
      trap '__testCleanupMess true' EXIT QUIT TERM
      ;;
    --debug-filter) df=(--debug) ;;
    -*)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    *)
      matchTests+=("$(validate "$handler" String "match" "$1")") || return $?
      ;;
    esac
    shift
  done

  export TERM

  # Test internal exports
  export __TEST_SUITE_CLEAN_EXIT __TEST_SUITE_TRACE __TEST_SUITE_CLEAN_DIRS

  __testSuiteInitialize "$beQuiet"

  if $cleanFlag; then
    $beQuiet || statusMessage decorate warning "Cleaning tests and exiting ... "
    __TEST_SUITE_CLEAN_EXIT=true
    __testCleanup || return $?
    statusMessage timingReport "$allTestStart" "Cleaned in"
    printf "\n"
    return 0
  fi

  catchReturn "$handler" buildEnvironmentLoad BUILD_COLORS XDG_CACHE_HOME XDG_STATE_HOME HOME || return $?

  local load home testTemporaryHome testTemporaryInternal testTemporaryTest clean=()

  testTemporaryHome=$(catchReturn "$handler" buildCacheDirectory "testSuite.$$") || return $?

  clean+=("$testTemporaryHome")
  export TMPDIR

  testTemporaryTest=$(catchReturn "$handler" directoryRequire "$testTemporaryHome/T") || returnClean $? "${clean[@]}" || return $?
  testTemporaryInternal=$(catchReturn "$handler" directoryRequire "$testTemporaryHome/internal") || returnClean $? "${clean[@]}" || return $?

  TMPDIR="$testTemporaryInternal"

  load=$(decorate value "(Load $(loadAverage | head -n 1))")

  local startString allTestStart

  startString="$(catchEnvironment "$handler" date +"%F %T")" || returnClean $? "${clean[@]}" || return $?
  allTestStart=$(timingStart) || returnClean $? "${clean[@]}" || return $?

  local quietLog && quietLog="$(fileTemporaryName "$handler")" || returnClean $? "${clean[@]}" || return $?

  # Start tracing
  catchEnvironment "$handler" printf -- "%s\n" "$__TEST_SUITE_TRACE" >>"$quietLog" || returnClean $? "${clean[@]}" || return $?
  # QUIET LOG =============== QUIET LOG =============== QUIET LOG =============== QUIET LOG ===============

  # Color mode
  decorateInitialized || muzzle consoleConfigureDecorate || :

  [ "${#testPaths[@]}" -gt 0 ] || throwArgument "$handler" "Need at least one --tests directory ($(decorate each quote "${__saved[@]}"))" || returnClean $? "${clean[@]}" || return $?

  #
  # Intro statement to console
  #
  if ! $beQuiet; then
    if [ ${#runTestSuites[@]} -gt 0 ]; then
      printf "%s %s\n" "$(decorate warning "Adding ${#runTestSuites[@]} $(plural ${#runTestSuites[@]} suite suites):")" "$(decorate BOLD red "${runTestSuites[@]}")"
    fi
    local intro
    intro=$(printf -- "%s started on %s %s\n" "$(decorate BOLD magenta "${handler#_}")" "$startString" "$load")
    if "$verboseMode"; then
      consoleHasColors || printf "%s" "No colors available in TERM ${TERM-}\n"
      statusMessage printf -- "%s" "$intro"
    fi
    catchEnvironment "$handler" printf -- "%s\n" "$intro" >>"$quietLog" || returnClean $? "${clean[@]}" || return $?
    # QUIET LOG =============== QUIET LOG =============== QUIET LOG =============== QUIET LOG ===============
  fi

  #
  # Load all tests
  #
  local allSuites=()
  while read -r item; do
    allSuites+=("$item")
  done < <(__testSuitesNames "${testPaths[@]}" | sort -u)

  #
  # Showing them? Great. We're done.
  #
  if $showFlag; then
    __testSuitePathToCode "${allSuites[@]}"
    catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
    _textExit 0
  fi

  # Determine the list of tests to run from the list of suites (or all suites)
  if [ ${#runTestSuites[@]} -eq 0 ]; then
    runTestSuites=("${allSuites[@]}")
  else
    foundTests=()
    for item in "${runTestSuites[@]}"; do
      foundTests+=("$(__testLookup "$handler" "$item" "${allSuites[@]}")") || returnClean $? "${clean[@]}" || return $?
    done
    runTestSuites=("${foundTests[@]+"${foundTests[@]}"}")
  fi

  local testFunctions
  testFunctions=$(fileTemporaryName "$handler") || returnClean $? "${clean[@]}" || return $?

  local tests=() item
  for item in "${runTestSuites[@]}"; do
    if ! __testLoad "$item" >"$testFunctions"; then
      throwEnvironment "$handler" "Can not load $item" || returnClean $? "${clean[@]}" || return $?
    fi
    local foundTests=()
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

  local statsFile=""
  ! $doStats || statsFile=$(fileTemporaryName "$handler") || returnClean $? "${clean[@]}" || return $?
  catchEnvironment "$handler" rm -f "$testFunctions" || returnClean $? "${clean[@]}" || return $?

  # Set up continue file if needed (remove it if we are *NOT* continuing)
  local continueFile="$BUILD_HOME/.last-run-test"
  # Are we continuing? -> Do nothing. Continue file may or may not be there.
  # Otherwise, we are NOT continuing. Does the continue file NOT exist? -> No need to delete.
  # Otherwise, delete the continue file.

  if $continueFlag; then
    if [ "${#matchTests[@]}" -gt 0 ]; then
      ! $verboseMode || statusMessage decorate info "Continue is ignored when a match test is specified: ${matchTests[*]}"
    elif [ -z "$startTest" ]; then
      # If the continue file exists, the file contains the next test name on line 1
      startTest="$([ ! -f "$continueFile" ] || head -n 1 "$continueFile")"
      if [ "$startTest" = "PASSED" ]; then
        statusMessage --last decorate success "All tests passed successfully. Next test run will start from the beginning."
        catchEnvironment "$handler" rm -rf "$continueFile" || returnClean $? "${clean[@]}" || return $?
        catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
        __TEST_SUITE_CLEAN_EXIT=true
        return 0
      fi
    fi
  fi

  [ "${#tests[@]}" -gt 0 ] || throwEnvironment "$handler" "No tests found" || returnClean $? "${clean[@]}" || return $?
  local filteredTests=() item actualTest=""
  for item in "${tests[@]}"; do
    if [ "$item" = "${item#\#}" ]; then
      if [ -n "$startTest" ]; then
        if [ "$item" = "$startTest" ]; then
          startTest=
          actualTest="-"
          consoleLineFill
          $beQuiet || decorate warning "Continuing at test $(decorate code "$item") ..."
        else
          $beQuiet || statusMessage decorate warning "Skipping $(decorate code "$item") ..."
          continue
        fi
      fi
      if [ "${#matchTests[@]}" -gt 0 ]; then
        if ! __testMatches "$item" "${matchTests[@]}"; then
          continue
        fi
        $beQuiet || statusMessage decorate success "Matched $(decorate value "$item")"
      fi
      actualTest="$item"
    fi
    filteredTests+=("$item")
  done
  if [ -n "$startTest" ]; then
    statusMessage --last decorate warning "$continueFile contains an unknown test: $startTest, starting from beginning"
    filteredTests=("${tests[@]}")
    startTest=""
  else
    [ -n "$actualTest" ] || throwArgument "$handler" "No tests match $(decorate code "${matchTests[@]}")" || returnClean $? "${clean[@]}" || return $?
  fi

  # Filter by tags
  if [ ${#filteredTests[@]} -gt 0 ] && [ $((${#tags[@]} + ${#skipTags[@]})) -gt 0 ]; then
    local item tagFilteredTests=() beforeCount afterCount sectionStart

    ! $verboseMode || statusMessage decorate info "$(printf "%s %d %s and %d %s to skip" "Applying" "${#tags[@]}" "$(plural ${#tags[@]} tag tags)" "${#skipTags[@]}" "$(plural ${#skipTags[@]} tag tags)")"
    sectionStart=$(timingStart) || returnClean $? "${clean[@]}" || return $?
    while read -r item; do tagFilteredTests+=("$item"); done < <(__testSuiteFilterTags "$handler" "${df[@]+"${df[@]}"}" "${tags[@]+"${tags[@]}"}" -- "${skipTags[@]+"${skipTags[@]}"}" -- "${filteredTests[@]}") || returnClean $? "${clean[@]}" || return $?
    if $verboseMode; then
      beforeCount="$(decorate notice "${#filteredTests[@]} $(plural ${#filteredTests[@]} "test" "tests")")"
      afterCount="$(decorate value "${#tagFilteredTests[@]} $(plural ${#tagFilteredTests[@]} "test" "tests")")"
      statusMessage printf -- "%s %s -> %s (%s)" "$(decorate info Tags)" "$beforeCount" "$afterCount" "$(timingReport "$sectionStart")"
    fi
    filteredTests=("${tagFilteredTests[@]+"${tagFilteredTests[@]}"}")
  fi

  if $showTags; then
    __TEST_SUITE_TRACE="showing-tags"
    catchReturn "$handler" __testSuiteShowTags "${filteredTests[@]+"${filteredTests[@]}"}" || returnClean $? "${clean[@]}" || return $?
    __TEST_SUITE_CLEAN_EXIT=true
    return 0
  fi

  if $listFlag; then
    __TEST_SUITE_TRACE="listing"
    catchReturn "$handler" __testSuiteListTests "${filteredTests[@]+"${filteredTests[@]}"}" || returnClean $? "${clean[@]}" || return $?
    __TEST_SUITE_CLEAN_EXIT=true
    return 0
  fi

  $continueFlag || [ ! -f "$continueFile" ] || catchEnvironment "$handler" rm "$continueFile" || returnClean $? "${clean[@]}" || return $?

  #    ▀▛▘     ▐  ▗        ▜
  #     ▌▞▀▖▞▀▘▜▀ ▄ ▛▀▖▞▀▌ ▐ ▞▀▖▞▀▖▛▀▖
  #     ▌▛▀ ▝▀▖▐ ▖▐ ▌ ▌▚▄▌ ▐ ▌ ▌▌ ▌▙▄▘
  #     ▘▝▀▘▀▀  ▀ ▀▘▘ ▘▗▄▘  ▘▝▀ ▝▀ ▌
  local runTime testsRun=() finalReturnCode=0
  if [ ${#filteredTests[@]} -gt 0 ]; then
    local globalFlags && globalFlags=$(catchReturn "$handler" buildEnvironmentGet BUILD_TEST_FLAGS) || return $?
    local stateFile && stateFile="$(fileTemporaryName "$handler")" || return $?
    local clean=("$stateFile")
    {
      catchReturn "$handler" environmentValueWrite __count "$__count" || returnClean $? "${clean[@]}" || return $?
      catchReturn "$handler" environmentValueWriteArray __saved "${__saved[@]}" || returnClean $? "${clean[@]}" || return $?
      catchReturn "$handler" environmentValueWrite testNames "${filteredTests[@]}" || returnClean $? "${clean[@]}" || return $?
      catchReturn "$handler" environmentValueWriteArray tests "${#filteredTests[@]}" || returnClean $? "${clean[@]}" || return $?
      catchReturn "$handler" environmentValueWriteArray flags "$globalFlags" || returnClean $? "${clean[@]}" || return $?
      catchReturn "$handler" environmentValueWriteArray timestamp "$(date +'%FT%T')" || returnClean $? "${clean[@]}" || return $?
      catchReturn "$handler" environmentValueWriteArray platform "$(_testPlatform)" || returnClean $? "${clean[@]}" || return $?
    } >>"$stateFile" || returnClean $? "${clean[@]}" || return $?

    # ============================================================================================================
    # HOOK tests-start
    # ============================================================================================================
    hookRunOptional --handler "$handler" --application "$home" tests-start "$stateFile" "${hookArgs[@]+"${hookArgs[@]}"}" || returnClean $? "${clean[@]}" || return $?

    local undo=("hookRunOptional" "tests-end" "--failed" "undo called" "$stateFile" -- rm -rf "${clean[@]}")

    __TEST_SUITE_TRACE=options
    local suiteName="" suiteNameHeading="" sectionFile=""
    for item in "${filteredTests[@]}"; do
      local suiteUndo=()
      [ -z "$suiteName" ] || suiteUndo=(hookRunOptional --handler "$handler" --application "$home" testsuite-stop "$suiteName" "$stateFile")
      suiteUndo+=("${undo[@]}")
      if [ "$item" != "${item#\#}" ]; then
        sectionFile="${item#\#}"
        if [ -n "$suiteName" ]; then
          # ============================================================================================================
          # HOOK testsuite-stop
          # ============================================================================================================
          TEST_SUITE_NAME="$suiteName" hookRunOptional --handler "$handler" --application "$home" testsuite-stop "$suiteName" "$stateFile" || returnUndo $? "${suiteUndo[@]}" || return $?
        fi
        suiteName=$(__testSuitePathToCode "$sectionFile")
        # ============================================================================================================
        # HOOK testsuite-start
        # ============================================================================================================
        TEST_FILE=$sectionFile TEST_SUITE_NAME="$suiteName" hookRunOptional --handler "$handler" --application "$home" testsuite-start "$suiteName" "$stateFile" || returnUndo $? "${suiteUndo[@]}" || return $?
        continue
      fi
      if $continueFlag; then
        catchReturn "$handler" printf "%s\n" "$item" >"$continueFile" || returnUndo $? "${suiteUndo[@]}" || return $?
      fi
      if [ "$suiteName" != "$suiteNameHeading" ]; then
        consoleLineFill
        __testHeading "$suiteName"
        timingReport "$allTestStart" "elapsed"
        suiteNameHeading="$suiteName"
      fi

      local __testStart && __testStart=$(timingStart)

      #  ▛▀▖
      #  ▙▄▘▌ ▌▛▀▖▛▀▖▞▀▖▙▀▖
      #  ▌▚ ▌ ▌▌ ▌▌ ▌▛▀ ▌
      #  ▘ ▘▝▀▘▘ ▘▘ ▘▝▀▘▘

      local testLine && testLine=$(__testGetLine "$item" <"$sectionFile") || :
      local __flags && __flags=$(__testLoadFlags "$sectionFile" "$item")
      local rawFlags="$__flags;$globalFlags"

      ! $verboseMode || statusMessage decorate info "$item flags is $(decorate code "${rawFlags:-none specified}")" || returnClean $? "${clean[@]}" || return $?

      local testHome saveHome cleanTestOnly=()

      saveHome=$(pwd)

      # --cd-away handling
      if $cdAway; then
        local buildHomeRequired
        buildHomeRequired=$(__testFlagBoolean "Build-Home" "$__flags" false)

        # Force it off for functions which flag it
        if $buildHomeRequired; then
          testHome="$home"
        else
          testHome="$(fileTemporaryName "$handler" -d)" || returnClean $? "${clean[@]}" "${cleanTestOnly[@]+}" || return $?
          cleanTestOnly+=("$testHome")
        fi
      else
        testHome="$saveHome"
      fi
      testsRun+=("$item")
      catchEnvironment "$handler" cd "$testHome" || returnClean $? "${clean[@]}" "${cleanTestOnly[@]+}" || return $?

      ! $verboseMode || statusMessage --last decorate pair "Raw flags" "$rawFlags"

      #       ▐        ▐  ▛▀▖
      #       ▜▀ ▞▀▖▞▀▘▜▀ ▙▄▘▌ ▌▛▀▖
      #       ▐ ▖▛▀ ▝▀▖▐ ▖▌▚ ▌ ▌▌ ▌
      #  ▀▀▀▀▀▀▀ ▝▀▘▀▀  ▀ ▘ ▘▝▀▘▘ ▘
      local testReturnCode=0
      TEST_FILE=$sectionFile TEST_VERBOSE=$verboseMode TEST_LINE=$testLine TEST_FLAGS=$rawFlags TEST_SUITE_NAME="$suiteName" TEST_NAME=$item "${runner[@]+"${runner[@]}"}" __testRun "$handler" "$stateFile" "$quietLog" "$testTemporaryTest" "$item" "$rawFlags" || testReturnCode=$?
      if [ $testReturnCode -eq 0 ]; then
        passed=true
      else
        passed=false
        __testSuiteExecutor "$item" "$sectionFile" "$testLine" "${failExecutors[@]+"${failExecutors[@]}"}" || throwEnvironment "$handler" "failure executors failed" || :
        catchEnvironment "$handler" cd "$saveHome" || :
        __testFailed "$handler" "$testReturnCode" "$stateFile" "$suiteName" "$item" || finalReturnCode=$?
      fi

      catchEnvironment "$handler" cd "$saveHome" || returnClean $? "${clean[@]}" "${cleanTestOnly[@]+}" || return $?

      __testRunCleanup "$handler" "$stateFile" || return $?

      runTime=$(($(timingStart) - __testStart))
      ! $doStats || printf "%s %s\n" "$runTime" "$item" >>"$statsFile"

      [ "${#cleanTestOnly[@]}" -eq 0 ] || catchEnvironment "$handler" rm -rf "${cleanTestOnly[@]}" || returnClean $? "${clean[@]}" "${cleanTestOnly[@]+}" || return $?
      if ! $passed && $stopFlag; then
        break
      fi
    done
    if [ -n "$suiteName" ]; then
      # ============================================================================================================
      # HOOK testsuite-stop
      # ============================================================================================================
      TEST_SUITE_NAME="$suiteName" hookRunOptional --handler "$handler" --application "$home" testsuite-stop "$suiteName" "$stateFile" || returnUndo $? "${suiteUndo[@]}" || return $?
    fi

    # ============================================================================================================
    # HOOK tests-stop
    # ============================================================================================================
    hookRunOptional --handler "$handler" --application "$home" tests-stop "$stateFile" || returnClean $? "${clean[@]}" || return $?

    [ ${#matchTests[@]} -eq 0 ] || [ ${#testsRun[@]} -gt 0 ] || throwArgument "$handler" "Match not found: $(decorate each code "${matchTests[@]}")" || returnClean $? "${clean[@]}" || return $?
    bigText --bigger Passed | decorate wrap "" "    " | decorate success | decorate wrap --fill "*" "    "
    if $continueFlag; then
      printf "%s\n" "PASSED" >"$continueFile"
    fi
  else
    local message=()
    [ ${#matchTests[@]} -eq 0 ] || message+=("Match: $(decorate each code "${matchTests[@]}")")
    [ ${#tags[@]} -eq 0 ] || message+=("Tags: $(decorate each code "${tags[@]}")")
    [ ${#skipTags[@]} -eq 0 ] || message+=("Skip Tags: $(decorate each code "${skipTags[@]}")")
    throwEnvironment "$handler" "No tests match" "${message[@]}" || returnClean $? "${clean[@]}" || return $?
  fi

  local assertionFailures assertionSuccesses stats=()
  IFS=$'\n' read -r -d '' assertionFailures assertionSuccesses < <(_assertionStatistics)

  _assertionStatistics
  local failColor="error"
  [ "$assertionFailures" -ne 0 ] || failColor="info"

  stats+=("$(decorate "$failColor" "$(pluralWord "$assertionFailures" "failed assertion")")," "$(decorate success "$(pluralWord "$assertionSuccesses" "successful assertion")")")
  [ -z "$statsFile" ] || __testStats "$statsFile"

  [ ${#clean[@]} -eq 0 ] || catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?

  timingReport "$allTestStart" "Completed $(decorate orange "${stats[*]}") in"

  _textExit "$finalReturnCode"
}
_testSuite() {
  local defaultName
  defaultName=$(buildEnvironmentGet APPLICATION_NAME 2>/dev/null) || defaultName="any product"
  fn="${fn-"${FUNCNAME[0]#_}"}" name=${name-"$defaultName"} usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Set up test-related environment variables and traps
__testSuiteInitialize() {
  local beQuiet="$1"

  $beQuiet || statusMessage decorate info "Initializing test suite ..."

  # Add fast-usage to debugging TODO consider removing this now that usage is fast
  export BUILD_DEBUG
  BUILD_DEBUG="${BUILD_DEBUG-},fast-usage"
  BUILD_DEBUG="${BUILD_DEBUG#,}"

  # Stop at 200-depth stacks and fail
  export FUNCNEST
  FUNCNEST=200

  # Test internal exports
  export __TEST_SUITE_CLEAN_EXIT __TEST_SUITE_TRACE __TEST_SUITE_CLEAN_DIRS

  __TEST_SUITE_CLEAN_EXIT=false
  __TEST_SUITE_TRACE=initialization
  __TEST_SUITE_CLEAN_DIRS=()

  # Add a trap
  trap '__testCleanupMess' EXIT QUIT TERM ERR
  set -E

  # If someone interrupts find out where it was running
  bashDebugInterruptFile
}

# Display the tags
__testSuiteShowTags() {
  local sectionFile=""
  while [ $# -gt 0 ]; do
    local item="$1"
    if [ "$item" != "${item#\#}" ]; then
      sectionFile="${item#\#}"
    else
      [ -n "$sectionFile" ] || returnArgument "No sectionFile preceding test" || return $?
      bashFunctionComment "$sectionFile" "$item" | grep "Tag:" | removeFields 1 | tr ' ' '\n'
    fi
    shift
  done | sort -u
}

# Filters tests by tags
# Argument: includeTag ... - String. Optional. Tag(s) to include. Prefix a tag with `+` to force it AND previous tags.
# Argument: -- - Separator. Required. Delimits tags and exclusion tags. Prefix a tag with `+` to force it AND previous exclusion tags.
# Argument: excludeTag ...- String. Optional. Tag(s) to exclude.
# Argument: -- - Separator. Required. Delimits tags and exclusion tags.
# Argument: tests ... - String. Function. Test functions
__testSuiteFilterTags() {
  local handler="$1" && shift
  local current=() tags=() skipTags=() gotTags=false debugMode=false

  while [ $# -gt 0 ]; do
    case "$1" in
    --debug)
      debugMode=true
      ;;
    "--")
      if $gotTags; then
        skipTags=("${current[@]+"${current[@]}"}")
        shift
        break
      else
        gotTags=true
        tags=("${current[@]+"${current[@]}"}")
        current=()
      fi
      ;;
    *)
      current+=("$1")
      ;;
    esac
    shift
  done
  local lastSectionFile="" sectionFile
  local tempComment home filtersFile="/dev/null"

  home=$(catchReturn "$handler" buildHome) || return $?

  ! $debugMode || filtersFile="$home/${FUNCNAME[0]}.debug"

  ! $debugMode || printf "%s" "" >"$home/${FUNCNAME[0]}.debug"

  ! $debugMode || printf "%s %s\n" "Included: " "$(decorate each --count quote -- "${tags[@]+"${tags[@]}"}")" >>"$filtersFile"
  ! $debugMode || printf "%s %s\n" "Excluded: " "$(decorate each --count quote -- "${skipTags[@]+"${skipTags[@]}"}")" >>"$filtersFile"

  tempComment=$(fileTemporaryName "$handler") || return $?
  local clean=("$tempComment")

  while [ $# -gt 0 ]; do
    local item="$1"
    if [ "$item" != "${item#\#}" ]; then
      sectionFile="${item#\#}"
    else
      local tag testTags=() defaultKeepIt=true

      [ ${#tags[@]} -eq 0 ] || defaultKeepIt=false
      catchEnvironment "$handler" bashFunctionComment "$sectionFile" "$item" >"$tempComment" || returnClean $? "${clean[@]}" || return $?
      IFS=$'\n' read -r -d "" -a testTags < <(grepSafe "Tag:" <"$tempComment" | removeFields 1 | tr ' ' '\n' | printfOutputSuffix "\n") || :
      ! $debugMode || printf "%s\n" "$(date "+%F %T"): $item" >>"$filtersFile"
      if [ "${#testTags[@]}" -gt 0 ]; then
        ! $debugMode || printf "%s\n" "bashFunctionComment \"$sectionFile\" \"$item\" > tempFile" >>"$filtersFile"
        ! $debugMode || printf "%s: %s\n" "$(date "+%F %T")" "read -r -a testTags < <(grepSafe \"Tag:\" <\"tempFile\" | removeFields 1 | tr ' ' '\n' | printfOutputSuffix \"\n\") || :" >>"$filtersFile"
      fi
      if [ "${testTags[0]-}" = "Stack:" ]; then
        statusMessage --last decorate error "Failed in function $item"
        decorate code
        decorate each --count quote -- "${testTags[@]}" | decorate blue | printfOutputPrefix "%s" "$(decorate info "Match $item:")"
      fi
      local keepIt="$defaultKeepIt" keepNote="by default"
      local specificallyExcludedAlready=false
      [ "${#skipTags[@]}" -eq 0 ] || for tag in "${skipTags[@]}"; do
        local andTag=false
        if [ "${tag#+}" != "$tag" ]; then
          tag="${tag#+}"
          andTag=true
        fi
        [ "${#testTags[@]}" -eq 0 ] || if inArray "$tag" "${testTags[@]}"; then
          keepIt=false
          specificallyExcludedAlready=true
          keepNote="** excluded by tag $tag **"
        elif $andTag; then
          keepIt="$defaultKeepIt"
          keepNote="** excluded AND $tag missing **"
        fi
      done
      if ! $specificallyExcludedAlready; then
        [ ${#tags[@]} -eq 0 ] || for tag in "${tags[@]}"; do
          local andTag=false
          if [ "${tag#+}" != "$tag" ]; then
            tag="${tag#+}"
            andTag=true
          fi
          if inArray "$tag" "${testTags[@]}"; then
            keepIt=true
            keepNote="** with tag $tag **"
          elif $andTag; then
            keepIt=false
            keepNote="** and $tag removed **"
          fi
        done
      fi
      if $keepIt; then
        ! $debugMode || printf "%s\n" "+ $item kept $keepNote Mine: ($(decorate each --count quote -- "${testTags[@]+"${testTags[@]}"}")) Keep: ($(decorate each --count quote -- "${tags[@]+"${tags[@]}"}"))" >>"$filtersFile"
      else
        ! $debugMode || printf "%s\n" "- $item excluded $keepNote Mine: ($(decorate each --count quote -- "${testTags[@]+"${testTags[@]}"}")) Skip: ($(decorate each --count quote -- "${skipTags[@]+"${skipTags[@]}"}"))" >>"$filtersFile"
      fi
      if $keepIt; then
        if [ "$lastSectionFile" != "$sectionFile" ]; then
          printf "#%s\n" "$sectionFile"
          lastSectionFile="$sectionFile"
        fi
        printf "%s\n" "$item"
      fi
    fi
    shift
  done
  catchEnvironment "$handler" rm -f "${clean[@]}" || return $?
}

__testSuiteListTests() {
  local sectionFile suiteName
  suiteName=""
  while [ $# -gt 0 ]; do
    local item="$1"
    if [ "$item" != "${item#\#}" ]; then
      sectionFile="${item#\#}"
      suiteName=$(__testSuitePathToCode "$sectionFile")
      printf -- "# %s\n" "$suiteName"
      shift
      continue
    fi
    printf "%s\n" "$item"
    shift
  done
}

__testFunctionWasTested() {
  local handler="returnMessage"
  local assertedFunctions verboseMode=false

  assertedFunctions=$(catchReturn "$handler" __assertedFunctions) || return $?
  local __fns=()
  while [ $# -gt 0 ]; do
    if [ "$1" = "--verbose" ]; then
      verboseMode=true
      shift
    fi
    local argument
    argument="$(validate "$handler" function function "$1")" || return $?
    if ! muzzle grep -q -e "^$(quoteGrepPattern "$argument")\$" "$assertedFunctions"; then
      return 1
    fi
    __fns+=("$argument")
    shift
  done
  ! $verboseMode || statusMessage decorate info "$(plural "${#__fns[@]}" "Function" "Functions") were tested: $(decorate code "${__fns[@]}")"
}

__testStatsFormat() {
  local milliseconds functionName
  while read -r milliseconds functionName; do
    if isUnsignedInteger "$milliseconds"; then
      printf -- "%s %s\n" "$(decorate value "$(textAlignRight 6 "$(timingFormat "$milliseconds")")")" "$(decorate code "$functionName")"
    else
      printf "%s %s\n" "$milliseconds" "$functionName"
    fi
  done
}

__testStats() {
  local statsFile="$1" targetFile zeroTests
  targetFile="$(buildHome)/test.stats"
  sort -rn <"$statsFile" >"$targetFile"
  rm -rf "$statsFile" || :
  consoleHeadingBoxed "Slowest tests"
  head -n 50 <"$targetFile" | __testStatsFormat
  consoleHeadingBoxed "Fastest tests"
  grep -v -e '^0 ' "$targetFile" | tail -n 20 | __testStatsFormat
  consoleHeadingBoxed "Zero-second tests"
  set +o pipefail
  IFS=$'\n' read -d '' -r -a zeroTests < <(grep -e '^0 ' "$targetFile" | awk '{ print $2 }') || :
  printf -- "%s " "${zeroTests[@]+"${zeroTests[@]}"}"
  printf -- "\n"
  consoleHeadingBoxed "Functions asserted (cumulative)"
  cat "$(__assertedFunctions)"
  lines=$(catchReturn "$handler" fileLineCount "$(__assertedFunctions)") || return $?
  decorate info "$lines $(plural "$lines" "function" "functions")"
  printf -- "\n"
}

# Find our suite code in a list of test file paths
# Argument: testSuite - String. Required.. Name of the test suite to find in a list of test paths.
# Argument: testPaths - RelativeFile. Required. One or more test paths to search.
# stdin: nothing
# stdout: Name of the test path which matches the test suite
__testLookup() {
  local handler="$1" lookup="$2"

  shift 2
  while [ $# -gt 0 ]; do
    if [ "$lookup" = "$(__testSuitePathToCode "$1")" ]; then
      printf "%s\n" "$1"
      return 0
    fi
    shift
  done
  throwArgument "$handler" "No such suite $lookup" || return $?
}

# Fetch the line number of a test
# Argument: testFunction - String. Name of the test suite function.
# stdin: File to look for the function definition
# stdout: PositiveInteger. The line number (with newline)
__testGetLine() {
  local line

  line=$(grep -n "$1() {" | cut -d : -f 1)
  if isPositiveInteger "$line"; then
    printf "%d\n" "$line"
    return 0
  fi
  return 1
}

__testSuiteExecutor() {
  local item="$1" && shift
  local file="$1" && shift
  local line="$1" && shift
  local executor=()

  [ -z "$line" ] || line=":$line"

  statusMessage decorate error "Test $item failed in $file" || return $?
  while [ $# -gt 0 ]; do
    if [ "$1" = "--" ]; then
      if [ "${#executor[@]}" -gt 0 ]; then
        statusMessage decorate info "Running" "${executor[@]}" "$item" "$file" "$line" || return $?
        "${executor[@]}" "$item" "$file" "$line" || return $?
      fi
      executor=()
    else
      executor+=("$1")
    fi
    shift
  done
  consoleLineFill || return $?
}

# Given a path to a file which contains a test suite, return the code for the suite
# The transformation is:
# 1. `basename $file`
# 2. Trim all characters after a `-` in the file name
# 3. Remaining string is the test suite code
#
# Example: `./app/tests/core/magic-tests.sh` -> `magic`
__testSuitePathToCode() {
  local testPath
  while [ "$#" -gt 0 ]; do
    testPath="$(basename "$1")"
    testPath="${testPath%-*}"
    printf "%s\n" "$testPath"
    shift
  done
}

# Find test suite files
# Argument: directory - Directory. Required. One or more paths to search for test files.
# Matches files which end with `-tests.sh`
__testSuitesNames() {
  while [ "$#" -gt 0 ]; do
    find "$1" -type f -name '*-tests.sh'
    shift
  done
}

# Check our global test failure as a back up to some how missing a failure elsewhere
# Environment: __TEST_FAILED
# Return Code: 0 - Something failed somewhere
# Return Code: 1 - Nothing failed anywhere, we should pass
__testDidAnythingFail() {
  export __TEST_FAILED

  __TEST_FAILED=${__TEST_FAILED:-}
  if test "$__TEST_FAILED"; then
    printf %s "$__TEST_FAILED"
    return 0
  fi
  return 1
}

# Load one or more test files and run the tests defined within
#
# Argument: filename ... - File. Required. File located at `./test/tools/` and must be a valid shell file.
__testLoad() {
  local handler="_${FUNCNAME[0]}"
  local tests
  local __test __tests tests __errors

  export DEBUGGING_TEST_LOAD

  __beforeFunctions=$(fileTemporaryName "$handler") || return $?
  __testFunctions="$__beforeFunctions.after"
  __errors="$__beforeFunctions.error"
  __testFunctions="$__beforeFunctions.after"
  __tests=()
  while [ "$#" -gt 0 ]; do
    catchEnvironment "$handler" isExecutable "$1" || returnClean $? "$__beforeFunctions" "$__testFunctions" || return $?

    declare -pF | awk '{ print $3 }' | sort -u >"$__beforeFunctions"
    tests=()
    set -a # UNDO ok
    # shellcheck source=/dev/null
    source "$1" >"$__errors" 2>&1 || throwEnvironment source "$1" || returnClean $? "$__beforeFunctions" "$__testFunctions" || returnUndo $? set +a || return $?
    fileIsEmpty "$__errors" || throwEnvironment "produced output: $(dumpPipe "source $1" <"$__errors")"
    set +a
    if [ "${#tests[@]}" -gt 0 ]; then
      for __test in "${tests[@]}"; do
        [ "$__test" = "${__test#"test"}" ] || decorate error "$1 - no longer need tests+=(\"$__test\")" 1>&2
      done
      __tests+=("${tests[@]}")
    fi
    local extraFunctions=()
    # diff outputs ("-" and "+") prefixes or ("< " and "> ")
    declare -pF | awk '{ print $3 }' | sort -u | diff -U 0 "$__beforeFunctions" - | grep -e '^[-+][^+-]' | cut -c 2- | trimSpace >"$__testFunctions" || :
    while read -r __test; do
      if [ "$__test" != "${__test#_}" ]; then
        extraFunctions+=("$__test")
        continue
      fi
      if [ "$__test" = "${__test#test}" ]; then
        decorate warning "Test function $(decorate code "$__test") found in test suites, start with $(decorate code "_") or $(decorate code "test")" 1>&2
        extraFunctions+=("$__test")
        continue
      fi
      ! inArray "$__test" "${__tests[@]+"${__tests[@]}"}" || {
        consoleLineFill
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
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Set up shell options
#
__testRunShellInitialize() {
  shopt -s shift_verbose failglob
}

#
#
__testCleanup() {
  local handler="returnMessage"
  local home
  home=$(catchReturn "$handler" buildHome) || return $?
  shopt -u failglob
  export __TEST_CLEANUP_DIRS

  catchEnvironment "$handler" rm -rf "$home/test."*/ "$home/.test"*/ "${__TEST_CLEANUP_DIRS[@]+"${__TEST_CLEANUP_DIRS[@]}"}" || return $?
}

__testCleanupMess() {
  local exitCode=$? messyOption="${1-}"

  export __TEST_SUITE_CLEAN_EXIT

  __TEST_SUITE_CLEAN_EXIT="${__TEST_SUITE_CLEAN_EXIT-}"
  if [ "$__TEST_SUITE_CLEAN_EXIT" != "true" ]; then
    printf -- "%s\n%s\n" "Stack:" "$(debuggingStack)"
    local blank
    blank=$(decorate value "(blank)")
    printf "\n%s\n" "$(basename "${BASH_SOURCE[0]}") FAILED $exitCode: TRACE ${__TEST_SUITE_TRACE:-$blank}"
  fi
  if [ "$messyOption" = "true" ]; then
    printf "%s\n" "Messy ... no cleanup"
    return 0
  fi
  __testCleanup
}

_textExit() {
  export __TEST_SUITE_CLEAN_EXIT
  if [ "${1-}" = 0 ]; then
    __TEST_SUITE_CLEAN_EXIT=true
  fi
  exit "$@"
}
