#!/usr/bin/env bash
# test-tools.sh
#
# Test tools
#
# Copyright &copy; 2025 Market Acumen, Inc.

export __TEST_SUITE_TRACE
export globalTestFailure=

# Run bash test suites
#
# Supports argument flags in tests:
# `TAP-Directive` `Test-Skip` `TODO`
# You can also use `BUILD_TEST_FLAGS` to change the default flags.
# Environment: - `BUILD_TEST_FLAGS` - Modify default flags and test behavior.
# Environment: - `BUILD_DEBUG` - Many settings to debug different systems, comma-delimited.
# Filters (`--tag` and `--skip-tag`) are applied in order after the function pattern or suite filter.
# Argument: --help - Optional. This help.
# Argument: --clean - Optional. Delete test artifact files and exit. (No tests run)
# Argument: --list - Optional. Flag. List all test names (which match if applicable).
# Argument: --env-file environmentFile - Optional. EnvironmentFile. Load one ore more environment files prior to running tests
# Argument: --continue - Optional. Flag. Continue from last successful test.
# Argument: -c - Optional. Flag. Continue from last successful test.
# Argument: --delete directoryOrFile - Optional. FileDirectory. A file or directory to delete when the test suite terminates.
# Argument: --delete-common - Flag. Delete `./vendor` and `./node_modules` (and other temporary build directories) by default.
# Argument: --verbose - Optional. Flag. Be verbose.
# Argument: --coverage - Optional. Flag. Feature in progress - generate a coverage file for tests.
# Argument: --no-stats - Optional. Flag. Do not generate a test.stats file showing test timings when completed.
# Argument: --messy - Optional. Do not delete test artifact files afterwards.
# Argument: --fail executor - Optional. Callable. One or more programs to run on the failed test files. Takes arguments: testName testFile testLine
# Argument: --cd-away - Optional. Flag. Change directories to a temporary directory before each test.
# Argument: --tap tapFile - Optional. FileDirectory. Output test results in TAP format to `tapFile`.
# Argument: --show - Optional. Flag. List all test suites.
# Argument: -l - Optional. Flag. List all test suites.
# Argument: --one testSuite - Optional. Add one test suite to run. (Synonym for `--suite`)
# Argument: --suite testSuite - Optional. Add one test suite to run.
# Argument: -1 testSuite - Optional. Add one test suite to run. (Synonym for `--suite`)
# Argument: --tag tagName - Optional. String. Include tests (only) tagged with this name.
# Argument: --show-tags - Optional. Flag. Of the matched tests, display the tags that they have, if any. Unique list.
# Argument: --skip-tag tagName - Optional. String. Skip tests tagged with this name.
# Argument: testFunctionPattern - Optional. String. Test function (or substring of function name) to run.
# Hook: bash-test-start
# Hook: bash-test-pass
# Hook: bash-test-fail
# Requires: head tee printf trap
# Requires: decorate loadAverage consoleConfigureColorMode
# Requires: buildEnvironmentLoad usageArgumentString catchEnvironment
# Requires: bashCoverage TODO
testSuite() {
  local handler="_${FUNCNAME[0]}"

  local tags=() skipTags=() runner=()
  local beQuiet=false listFlag=false verboseMode=false continueFlag=false doStats=true showFlag=false showTags=false tapFile="" cleanFlag=false
  local cdAway=false
  local testPaths=() messyOption="" runTestSuites=() matchTests=() failExecutors=()
  local startTest=""

  set -eou pipefail

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
    --verbose)
      verboseMode=true
      ;;
    --show-tags)
      beQuiet=true
      showTags=true
      ;;
    --tap)
      shift
      tapFile=$(usageArgumentFileDirectory "$handler" "$argument" "${1-}") || return $?
      ;;
    --tag)
      shift
      tags+=("$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      ;;
    --skip-tag)
      shift
      skipTags+=("$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      ;;
    --env-file)
      shift
      muzzle usageArgumentLoadEnvironmentFile "$handler" "envFile" "${1-}" || return $?
      decorate info "Loaded environment file $(decorate code "$1")"
      ;;
    --cd-away)
      cdAway=true
      ;;
    --tests)
      shift
      testPaths+=("$(usageArgumentDirectory "$handler" "$argument" "${1-}")") || return $?
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
      startTest="$(usageArgumentString "$handler" "$argument" "$1")" || return $?
      continueFlag=true
      ;;
    -1 | --one | --suite)
      shift
      runTestSuites+=("$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      ;;
    --list)
      verboseMode=false
      beQuiet=true
      listFlag=true
      ;;
    --fail)
      shift
      failExecutors+=("$(usageArgumentCallable "$handler" "failExecutor" "${1-}")") || return $?
      # shellcheck disable=SC2015
      while [ $# -gt 0 ]; do [ "$1" != "--" ] && failExecutors+=("$1") && shift || break; done
      failExecutors+=("--")
      ;;
    --clean)
      cleanFlag=true
      ;;
    --delete)
      shift
      dd+=("$(usageArgumentFileDirectory "$handler" "$argument" "${1-}")") || return $?
      ;;
    --delete-common)
      dd+=("$(buildHome)/vendor") || return $?
      dd+=("$(buildHome)/node_modules") || return $?
      dd+=("$(buildHome)/.composer") || return $?
      ;;
    --messy)
      trap '__testCleanupMess true' EXIT QUIT TERM
      ;;
    -*)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    *)
      matchTests+=("$(usageArgumentString "$handler" "match" "$1")") || return $?
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

  catchReturn "$handler" buildEnvironmentLoad BUILD_COLORS_MODE BUILD_COLORS XDG_CACHE_HOME XDG_STATE_HOME HOME || return $?

  local load home testTemporaryHome testTemporaryInternal testTemporaryTest clean=()

  home=$(catchReturn "$handler" buildHome) || return $?

  testTemporaryHome=$(catchReturn "$handler" buildCacheDirectory "testSuite.$$") || return $?

  clean+=("$testTemporaryHome")
  export TMPDIR

  testTemporaryTest=$(catchReturn "$handler" directoryRequire "$testTemporaryHome/T") || returnClean $? "${clean[@]}" || return $?
  testTemporaryInternal=$(catchReturn "$handler" directoryRequire "$testTemporaryHome/internal") || returnClean $? "${clean[@]}" || return $?

  TMPDIR="$testTemporaryInternal"

  load=$(decorate value "(Load $(loadAverage | head -n 1))")

  local startString allTestStart quietLog

  startString="$(catchEnvironment "$handler" date +"%F %T")" || returnClean $? "${clean[@]}" || return $?
  allTestStart=$(timingStart) || returnClean $? "${clean[@]}" || return $?

  quietLog="$(fileTemporaryName "$handler")" || returnClean $? "${clean[@]}" || return $?

  # Start tracing
  catchEnvironment "$handler" printf -- "%s\n" "$__TEST_SUITE_TRACE" >>"$quietLog" || returnClean $? "${clean[@]}" || return $?

  # Color mode
  export BUILD_COLORS BUILD_COLORS_MODE
  BUILD_COLORS_MODE=$(catchReturn "$handler" consoleConfigureColorMode) || returnClean $? "${clean[@]}" || return $?

  [ "${#testPaths[@]}" -gt 0 ] || throwArgument "$handler" "Need at least one --tests directory ($(decorate each quote "${__saved[@]}"))" || returnClean $? "${clean[@]}" || return $?

  #
  # Intro statement to console
  #
  if ! $beQuiet; then
    if [ ${#runTestSuites[@]} -gt 0 ]; then
      printf "%s %s\n" "$(decorate warning "Adding ${#runTestSuites[@]} $(plural ${#runTestSuites[@]} suite suites):")" "$(decorate bold-red "${runTestSuites[@]}")"
    fi
    local intro
    intro=$(printf -- "%s started on %s %s\n" "$(decorate bold-magenta "${handler#_}")" "$startString" "$load")
    if "$verboseMode"; then
      local mode="$BUILD_COLORS_MODE" intro
      [ -n "$mode" ] || mode=none
      hasColors || printf "%s" "No colors available in TERM ${TERM-}\n"
      statusMessage printf -- "%s" "$intro"
    fi
    catchEnvironment "$handler" printf -- "%s\n" "$intro" >>"$quietLog" || returnClean $? "${clean[@]}" || return $?
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
    if [ -z "$startTest" ]; then
      # If the continue file exists, the file contains the next test name on line 1
      startTest="$([ ! -f "$continueFile" ] || head -n 1 "$continueFile")"
      if [ "$startTest" = "PASSED" ]; then
        statusMessage --last decorate success "All tests passed successfully. Next test run will start from the beginning."
        catchEnvironment "$handler" rm -rf "$continueFile" || returnClean $? "${clean[@]}" || return $?
        __TEST_SUITE_CLEAN_EXIT=true
        catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
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
          clearLine
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
    while read -r item; do tagFilteredTests+=("$item"); done < <(__testSuiteFilterTags "$handler" "${tags[@]+"${tags[@]}"}" -- "${skipTags[@]+"${skipTags[@]}"}" -- "${filteredTests[@]}") || returnClean $? "${clean[@]}" || return $?
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

  [ -z "$tapFile" ] || __testSuiteTAP_plan "$tapFile" "${#filteredTests[@]}" || returnClean $? "${clean[@]}" || return $?
  [ -z "$tapFile" ] || failExecutors+=("__testSuiteTAP_not_ok" "$tapFile" --)

  local runTime testsRun=()
  if [ ${#filteredTests[@]} -gt 0 ]; then
    __TEST_SUITE_TRACE=options
    local sectionName="" sectionNameHeading="" sectionFile
    for item in "${filteredTests[@]}"; do
      if [ "$item" != "${item#\#}" ]; then
        sectionFile="${item#\#}"
        sectionName=$(__testSuitePathToCode "$sectionFile")
        continue
      fi
      if $continueFlag; then
        printf "%s\n" "$item" >"$continueFile"
      fi
      if [ "$sectionName" != "$sectionNameHeading" ]; then
        clearLine
        __testHeading "$sectionName"
        timingReport "$allTestStart" "elapsed"
        sectionNameHeading="$sectionName"
      fi

      local __testStart testLine
      __testStart=$(timingStart)
      catchEnvironment "$handler" hookRunOptional bash-test-start "$sectionName" "$item" || throwEnvironment "$handler" "... continuing" || :

      #  ▛▀▖
      #  ▙▄▘▌ ▌▛▀▖▛▀▖▞▀▖▙▀▖
      #  ▌▚ ▌ ▌▌ ▌▌ ▌▛▀ ▌
      #  ▘ ▘▝▀▘▘ ▘▘ ▘▝▀▘▘
      local __flags globalFlags
      testLine=$(__testGetLine "$item" <"$sectionFile") || :
      __flags=$(__testLoadFlags "$sectionFile" "$item")
      globalFlags=$(catchReturn "$handler" buildEnvironmentGet BUILD_TEST_FLAGS) || return $?
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
      "${runner[@]+"${runner[@]}"}" __testRun "$quietLog" "$testTemporaryTest" "$item" "$rawFlags" || __testSuiteExecutor "$item" "$sectionFile" "$testLine" "$__flags" "${failExecutors[@]+"${failExecutors[@]}"}" || __testFailed "$sectionName" "$item" || returnUndo $? cd "$saveHome" || returnClean $? "${clean[@]}" || return $?

      catchEnvironment "$handler" cd "$saveHome" || returnClean $? "${clean[@]}" "${cleanTestOnly[@]+}" || return $?

      [ -z "$tapFile" ] || __testSuiteTAP_ok "$tapFile" "$item" "$sectionFile" "$testLine" "$rawFlags" || returnClean $? "${clean[@]}" "${cleanTestOnly[@]+}" || return $?

      runTime=$(($(timingStart) - __testStart))
      ! $doStats || printf "%s %s\n" "$runTime" "$item" >>"$statsFile"
      catchEnvironment "$handler" hookRunOptional bash-test-pass "$sectionName" "$item" "$rawFlags" || throwEnvironment "$handler" "... continuing" || :

      [ "${#cleanTestOnly[@]}" -eq 0 ] || catchEnvironment "$handler" rm -rf "${cleanTestOnly[@]}" || returnClean $? "${clean[@]}" "${cleanTestOnly[@]+}" || return $?
    done
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

  local failColor="error"
  [ "$assertionFailures" -ne 0 ] || failColor="subtle"

  stats+=("$(decorate "$failColor" "$(pluralWord "$assertionFailures" "failed assertion")")," "$(decorate success "$(pluralWord "$assertionSuccesses" "successful assertion")")")
  [ -z "$statsFile" ] || __testStats "$statsFile"

  [ ${#clean[@]} -eq 0 ] || catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?

  timingReport "$allTestStart" "Completed $(decorate orange "${stats[*]}") in"

  _textExit 0
}
_testSuite() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Set up test-related environment variables and traps
__testSuiteInitialize() {
  local beQuiet="$1"

  $beQuiet || statusMessage decorate info "Initializing test suite ..."

  # Add fast-usage to debugging
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
# Usage: {fn} [ tags ... ] -- [ skipTags ... ] -- tests ...
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
      local testTag testTags=() defaultKeepIt=true

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
      for testTag in "${testTags[@]+"${testTags[@]}"}"; do
        if [ ${#tags[@]} -gt 0 ] && inArray "$testTag" "${tags[@]}"; then
          keepIt=true
          keepNote="** with tag $testTag **"
        elif [ ${#skipTags[@]} -gt 0 ] && inArray "$testTag" "${skipTags[@]}"; then
          keepIt=false
          keepNote="** excluded by tag $testTag **"
        fi
      done
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
  local sectionFile sectionName
  sectionName=""
  while [ $# -gt 0 ]; do
    local item="$1"
    if [ "$item" != "${item#\#}" ]; then
      sectionFile="${item#\#}"
      sectionName=$(__testSuitePathToCode "$sectionFile")
      printf -- "# %s\n" "$sectionName"
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
    argument="$(usageArgumentFunction "$handler" function "$1")" || return $?
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
      printf -- "%s %s\n" "$(decorate value "$(alignRight 6 "$(timingFormat "$milliseconds")")")" "$(decorate code "$functionName")"
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
  boxedHeading "Slowest tests"
  head -n 50 <"$targetFile" | __testStatsFormat
  boxedHeading "Fastest tests"
  grep -v -e '^0 ' "$targetFile" | tail -n 20 | __testStatsFormat
  boxedHeading "Zero-second tests"
  set +o pipefail
  IFS=$'\n' read -d '' -r -a zeroTests < <(grep -e '^0 ' "$targetFile" | awk '{ print $2 }') || :
  printf -- "%s " "${zeroTests[@]+"${zeroTests[@]}"}"
  printf -- "\n"
  boxedHeading "Functions asserted (cumulative)"
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
  local item="${1-}"
  local file="${2-}"
  local line="${3-}"
  local executor=()

  shift 3 || returnArgument "Missing item file or line" || return $?

  [ -z "$line" ] || line=":$line"

  statusMessage decorate error "Test $item failed in $file" || :
  while [ $# -gt 0 ]; do
    if [ "$1" = "--" ]; then
      if [ "${#executor[@]}" -gt 0 ]; then
        statusMessage decorate info "Running" "${executor[@]}" "$item" "$file" "$line"
        "${executor[@]}" "$item" "$file" "$line"
      fi
      executor=()
    else
      executor+=("$1")
    fi
    shift
  done
  clearLine
  return 1
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
# Environment: globalTestFailure
# Return Code: 0 - Something failed somewhere
# Return Code: 1 - Nothing failed anywhere, we should pass
__testDidAnythingFail() {
  export globalTestFailure

  globalTestFailure=${globalTestFailure:-}
  if test "$globalTestFailure"; then
    printf %s "$globalTestFailure"
    return 0
  fi
  return 1
}

#
# Output a heading for a test section
#
# Argument: String. Required. Test heading.
#
__testSection() {
  [ -n "$*" ] || returnArgument "Blank argument $(debuggingStack)"
  clearLine
  boxedHeading --size 0 "$@"
}

#
# Output a heading for a test
#
__testHeading() {
  local bar

  bar=$(decorate code "$(echoBar '*')")

  clearLine
  printf -- "%s\n" "$bar"
  bigText "$@" | decorate wrap --fill " " "    " | decorate code
  printf -- "%s\n" "$bar"
}

#
# Output debugging for terminal issues and colors/CI
#
__testDebugTermDisplay() {
  printf -- "TERM: %s DISPLAY: %s hasColors: %s\n" "${TERM-none}" "${DISPLAY-none}" "$(
    hasColors
    printf %d $?
  )"
}

# Load flags associated with a test
# Parses a test comment header and fetches values which are in the form `# Test-Foo: value`
# Converts these to a string in the form:
#
#     Foo:value;Bar:anotherValue;Marker:true
#
# Which can be easily scanned by other tools to determine eligibility of a test to run or
# other options.
# Argument: source - File. Required. File to scan.
# Argument: functionName - String. Required. Function to fetch the flags for
# stdout: String
# stdin: none
__testLoadFlags() {
  local source="$1" functionName="$2"
  local values=()
  while read -r variableLine; do
    local __flags=() flag
    IFS=" " read -r -a __flags <<<"$(trimSpace "${variableLine#*:}")"
    [ "${#__flags[@]}" -eq 0 ] || for flag in "${__flags[@]}"; do
      [ -z "$flag" ] || values+=("$(trimSpace "${variableLine%%:*}"):$flag")
    done
  done < <(bashFunctionCommentVariable --prefix "$source" "$functionName" "Test-")
  [ ${#values[@]} -eq 0 ] || listJoin ";" "${values[@]}"
}

#
# Load one or more test files and run the tests defined within
#
# Usage: {fn} filename [ ... ]
# Argument: filename - File. Required. File located at `./test/tools/` and must be a valid shell file.
#
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
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Set up shell options
#
__testRunShellInitialize() {
  shopt -s shift_verbose failglob
}

# Outputs the platform name
# Requires: __testPlatformName
_testPlatform() {
  __testPlatformName
}

# Outputs ALL platform names
# See: __testPlatformName
__testPlatforms() {
  local handler="_${FUNCNAME[0]}"
  local home
  home="$(catchReturn "$handler" buildHome)" || return $?
  find "$home/bin/build/tools/platform/" -type f -name '*.sh' -print0 | xargs -0 grep -A 1 '__testPlatformName()' | grep printf | awk '{ print $5 }' | sed 's/"//g'
}
___testPlatforms() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Load one or more test files and run the tests defined within
#
# Usage: {fn} filename [ ... ]
# Argument: filename - File. Required. File located at `./test/tools/` and must be a valid shell file.
#
__testRun() {
  local handler="_${FUNCNAME[0]}"
  local quietLog="${1-}" && shift
  local tempDirectory="${1-}" && shift
  local __test="${1-}" __flagText="${2-}" platform

  local tests __testDirectory __TEST_SUITE_RESULT
  local __test __tests tests __testStart
  local __beforeFunctions errorTest

  export __TEST_SUITE_TRACE
  export __TEST_SUITE_RESULT

  __testRunShellInitialize

  errorTest=$(returnCode assert)
  stickyCode=0

  # Renamed to avoid clobbering by tests
  __testDirectory=$(pwd)

  __TEST_SUITE_RESULT=AOK

  # Test
  __testSection "$__test" || :
  printf "%s %s ...\n" "$(decorate info "Running")" "$(decorate code "$__test")"

  catchEnvironment "$handler" muzzle fileDirectoryRequire "$quietLog" || return $?

  printf "%s\n" "Running $__test" >>"$quietLog"

  local resultCode=0 stickyCode=0
  __TEST_SUITE_TRACE="$__test"
  __testStart=$(timingStart)
  platform="$(_testPlatform)"
  [ -n "$platform" ] || throwEnvironment "$handler" "No platform defined?" || return $?
  if ! __testFlagPlatformMatch "$platform" "$__flagText" 2>>"$quietLog"; then
    statusMessage --last decorate warning "Skipping $(decorate code "$__test") on $(decorate error "$platform")"
    __TEST_SUITE_RESULT="skipped platform $platform"
    resultCode=0
  else
    local captureStderr
    captureStderr=$(fileTemporaryName "$handler") || return $?
    #     ▖   ▐        ▐
    #  ▄▄▖▝▚▖ ▜▀ ▞▀▖▞▀▘▜▀
    #     ▞▘  ▐ ▖▛▀ ▝▀▖▐ ▖
    #          ▀ ▝▀▘▀▀  ▀
    local savedTMPDIR
    export TMPDIR
    savedTMPDIR=$TMPDIR
    TMPDIR="$tempDirectory"

    local doHousekeeper="" doPlumber="" buildHomeRequired="" testActuallyFails=""
    doHousekeeper=$(__testFlagBoolean "Housekeeper" "$__flagText")
    doPlumber=$(__testFlagBoolean "Plumber" "$__flagText")
    [ -n "$doHousekeeper" ] || doHousekeeper=true
    [ -n "$doPlumber" ] || doPlumber=true

    buildHomeRequired=$(__testFlagBoolean "Build-Home" "$__flagText" false)
    testActuallyFails=$(__testFlagBoolean "Fail" "$__flagText" false)

    if $verboseMode; then
      decorate pair "Platform" "$platform"
      decorate pair "Housekeeper" "$(decorate "$(booleanChoose "$doHousekeeper" green orange)" "$doHousekeeper")"
      decorate pair "Plumber" "$(decorate "$(booleanChoose "$doPlumber" green orange)" "$doPlumber")"
      decorate pair "Build-Home" "$(decorate "$(booleanChoose "$buildHomeRequired" green orange)" "$buildHomeRequired")"
      ! $testActuallyFails || decorate pair "Fail" "$(decorate green "$testActuallyFails")"
    fi
    local runner=()
    runner=("$__test" "$quietLog")
    if $doHousekeeper; then
      housekeeperCache=$(catchReturn "$handler" buildCacheDirectory "test-housekeeper.$$") || return $?
      runner=(--ignore '.last-run-test' --ignore '/.git/' --temporary "$savedTMPDIR" --path "$TMPDIR" --path "$(buildHome)" "${runner[@]}")
      ! isSubstringInsensitive ";Housekeeper-Overhead:true;" ";$__flagText;" || runner=(--overhead "${runner[@]}")
      runner=(housekeeper --cache "$housekeeperCache" "${runner[@]}")
    fi
    if $doPlumber; then
      runner=(plumber --leak __BUILD_LOADER --temporary "$savedTMPDIR" "${runner[@]}")
    fi
    ###########################################
    ###########################################
    ###########################################
    ###########################################
    ###########################################
    ##########                       ##########
    ##########                       ##########
    ##########                       ##########
    ########## Here is the test call ##########
    ##########                       ##########
    ##########                       ##########
    ##########                       ##########
    ###########################################
    ###########################################
    ###########################################
    ###########################################
    ###########################################
    # ! $verboseMode || decorate each code "${runner[@]}"
    local startDirectory
    startDirectory=$(catchEnvironment "$handler" pwd) || return $?
    catchReturn "$handler" muzzle pushd "$startDirectory" || return $?
    if "${runner[@]}" 2> >(tee -a "$captureStderr"); then
      catchReturn "$handler" muzzle popd || :
      TMPDIR="$savedTMPDIR"
      if fileIsEmpty "$captureStderr"; then
        printf "%s\n" "SUCCESS $__test" >>"$quietLog"
      else
        resultCode=97
        stickyCode=$errorTest
        printf "%s\n" "stderr-SUCCESS $__test has STDERR:" | tee -a "$quietLog"
        dumpPipe <"$captureStderr" | tee -a "$quietLog"
      fi
    else
      resultCode=$?
      catchReturn "$handler" muzzle popd || :
      TMPDIR="$savedTMPDIR"
      stickyCode=$errorTest
      printf "\n%s\n" "FAILED [$resultCode] $__test" | tee -a "$quietLog"
      if ! fileIsEmpty "$captureStderr" && isSubstringInsensitive ";stderr-FAILED;" ";$__flagText;"; then
        printf "%s\n" "stderr-FAILED [$resultCode] $__test ALSO has STDERR:" | tee -a "$quietLog"
        dumpPipe <"$captureStderr" | tee -a "$quietLog"
      fi
    fi

    ! $doHousekeeper || catchEnvironment "$handler" rm -rf "$housekeeperCache" || return $?
    catchEnvironment "$handler" rm -rf "$captureStderr" || return $?

    if $testActuallyFails; then
      if [ $resultCode -eq 0 ]; then
        decorate error "Test supposed to fail but succeeded?" || return $?
        resultCode=$(returnCode assert)
      else
        decorate success "Test supposed to fail: $resultCode -> 0"
        resultCode=0 && stickyCode=0
      fi
    fi

    handler="_${FUNCNAME[0]}"
  fi

  # So, `handler` can be overridden if it is made global somehow, declare -r prevents changing here
  # documentation-tests.sh change this apparently
  # Instead of preventing this handler, just work around it
  catchEnvironment "_${FUNCNAME[0]}" cd "$__testDirectory" || return $?
  local timingText
  timingText="$(timingReport "$__testStart")"
  if [ "$resultCode" = "$(returnCode leak)" ]; then
    resultCode=0
    printf "%s %s %s ...\n" "$(decorate code "$__test")" "$(decorate warning "passed with leaks")" "$timingText"
  elif [ "$resultCode" -eq 0 ]; then
    printf "%s %s %s ...\n" "$(decorate code "$__test")" "$(decorate success "passed")" "$timingText"
  else
    printf "[%d] %s %s %s\n" "$resultCode" "$(decorate code "$__test")" "$(decorate error "FAILED")" "$timingText" 1>&2
    buildFailed "$quietLog" || :
    __TEST_SUITE_RESULT="test $__test failed"
    stickyCode=$errorTest
  fi

  if [ "$stickyCode" -eq 0 ] && __TEST_SUITE_RESULT=$(__testDidAnythingFail); then
    # Should probably reset test status but ...
    stickyCode=$errorTest
  fi
  if [ "$stickyCode" -ne 0 ]; then
    decorate pair "Reason:" "\"$__TEST_SUITE_RESULT\""
  fi
  return "$stickyCode"
}
___testRun() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: testPattern - String. Required. Test string to match.
# Argument: testMatches ... - String. Optional. One or more tests to match with.
# Performs a case-insensitive anywhere-in-the-string match
# Return Code: 0 - Test was found in the list
# Return Code: 1 - Test was not found in the list
__testMatches() {
  local testPattern match

  testPattern=$(lowercase "$1")
  shift
  while [ "$#" -gt 0 ]; do
    match=$(lowercase "$1")
    if [ "${testPattern#*"$match"}" != "$testPattern" ]; then
      return 0
    fi
    shift
  done
  return 1
}

# Our test failed
# BUILD_DEBUG: test-dump-environment - When set tests will dump the environment at the end.
__testFailed() {
  local errorCode sectionName="$1" item="$2"

  catchEnvironment "$handler" hookRunOptional bash-test-fail "$sectionName" "$item" || throwEnvironment "$handler" "... continuing" || :

  errorCode="$(returnCode assert)"
  printf "\n%s: %s - %s %s (%s)\n" "$(decorate error "Exit")" "$(decorate bold-red "$errorCode")" "$(decorate error "Failed running")" "$(decorate info "$item")" "$(decorate magenta "$sectionName")" || :

  ! buildDebugEnabled "test-dump-environment" || dumpEnvironment || :
  dumpLoadAverages || :

  decorate info "$(decorate magenta "$sectionName") $(decorate code "$item") failed on $(decorate value "$(date +"%F %T")")" || :
  export globalTestFailure="$*"
  return "$errorCode"
}

#
# Usage: {fn}
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

__testSuiteTAP_plan() {
  local tapFile="${1-}" testCount="$2"
  printf -- "%d%s%d\n" "$(incrementor 1 TAP_TEST)" ".." "$testCount" >"$tapFile"
}

__testSuiteTAP_line() {
  local status="$1" && shift
  local handler="returnMessage"
  local tapFile="${1-}"

  export __TEST_SUITE_RESULT

  [ -f "$tapFile" ] && shift 1 || throwEnvironment "$handler" "tapFile does not exist: $tapFile" || return $?

  local functionName="${1-}" source="${2-}" functionLine="${3-}" __flagText="${4-}"
  shift 4 || throwArgument "$handler" "Missing functionName source or functionLine" || return $?

  local directive="" value
  if isSubstringInsensitive ";Skip:true;" ";$__flagText;"; then
    directive="skip in test comment"
  fi
  if isSubstringInsensitive ";Ignore:true;" ";$__flagText;"; then
    directive="TODO Ignore test comment"
  fi
  value=$(bashFunctionCommentVariable "$source" "$functionName" "TODO") || :
  [ -z "$value" ] || directive="TODO ${value//$'\n'/ }"
  [ -z "$directive" ] || directive="$__TEST_SUITE_RESULT"
  [ -z "$directive" ] || directive="# $directive"
  printf -- "%s %d %s%s\n" "$status" "$(incrementor TAP_TEST)" "$functionName @ $source:$functionLine" "$directive" >>"$tapFile"
}

# Argument: tapFile - File. Required. The target output file.
# Argument: functionName - String. Required. Test function.
# Argument: functionFile - File. Required. File where test is defined.
# Argument: functionLine - UnsignedInteger. Required. Line number where test is defined.
# Argument: flags - SemicolonList. Required. Flags from the test in the form
__testSuiteTAP_ok() {
  __testSuiteTAP_line "ok" "$@"
}

# Argument: tapFile - File. Required. The target output file.
# Argument: functionName - String. Required. Test function.
# Argument: functionFile - File. Required. File where test is defined.
# Argument: functionLine - UnsignedInteger. Required. Line number where test is defined.
__testSuiteTAP_not_ok() {
  __testSuiteTAP_line "not ok" "$@"
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
