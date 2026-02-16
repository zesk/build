#!/usr/bin/env bash
# IDENTICAL zeskBuildBashHeader 5
#
# main.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# TODO: bashCoverage support
__testSuite() {
  local handler="$1" && shift

  local runner=()
  local beQuiet=false verboseMode=false continueFlag=false action="" testsCache=""
  local forceCreateIndex=false
  local cdAway=false stopFlag=false
  local testPaths=() failExecutors=() hookArgs=()
  local startTest="" df=() debugFlag=false
  local testIndexFile=""

  # Queries
  local qq=() suites=() tags=() skipTags=() matchTests=()

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

    #  ▐        ▐
    #  ▜▀ ▞▀▖▞▀▘▜▀ ▞▀▘
    #  ▐ ▖▛▀ ▝▀▖▐ ▖▝▀▖
    #   ▀ ▝▀▘▀▀  ▀ ▀▀
    --tests) shift && testPaths+=("$(validate "$handler" Directory "$argument" "${1-}")") || return $? ;;

    --index-file) shift && testIndexFile="$(validate "$handler" RealFileDirectory "$argument" "${1-}")" || return $? ;;
    --make-index) forceCreateIndex=true && action="quit" ;;
    --cache-file) shift && testsCache="$(validate "$handler" RealFileDirectory "$argument" "${1-}")" || return $? ;;

    #        ▐        ▐
    #  ▞▀▖▌ ▌▜▀ ▛▀▖▌ ▌▜▀ ▞▀▘
    #  ▌ ▌▌ ▌▐ ▖▙▄▘▌ ▌▐ ▖▝▀▖
    #  ▝▀ ▝▀▘ ▀ ▌  ▝▀▘ ▀ ▀▀

    --junit | --tap | --stats | --stats-report)
      local module && module="${argument#--}" && module="${module%-*}"
      local hookPath && hookPath="bin/build/tools/test/$module/hooks"
      [ -d "$home/$hookPath" ] || throwEnvironment "$handler" "$hookPath must exist for $argument" || return $?
      export BUILD_HOOK_DIRS
      catchReturn "$handler" buildEnvironmentLoad BUILD_HOOK_DIRS || return $?
      BUILD_HOOK_DIRS="$hookPath:${BUILD_HOOK_DIRS-}"
      shift && hookArgs+=("$argument" "$(validate "$handler" FileDirectory "$argument" "${1-}")") || return $?
      ;;

    --debug) hookArgs+=("$argument") && debugFlag=true ;;

    #  ▜ ▗    ▐
    #  ▐ ▄ ▞▀▘▜▀ ▞▀▘
    #  ▐ ▐ ▝▀▖▐ ▖▝▀▖
    #   ▘▀▘▀▀  ▀ ▀▀

    # Old
    --show) _deprecated "${FUNCNAME[0]}" "$argument" && action="list-suites" && beQuiet=true ;;
    --list-tags | --show-tags) _deprecated "${FUNCNAME[0]}" "$argument" && action="list-tags" && beQuiet=true ;;
    # New
    -l | --list) action="list" && verboseMode=false && beQuiet=true ;;
    --suites) action="list-suites" && beQuiet=true ;;
    --tags) action="list-tags" && beQuiet=true ;;

    #           ▐  ▗
    #  ▞▀▖▞▀▖▛▀▖▜▀ ▄ ▛▀▖▌ ▌▞▀▖
    #  ▌ ▖▌ ▌▌ ▌▐ ▖▐ ▌ ▌▌ ▌▛▀
    #  ▝▀ ▝▀ ▘ ▘ ▀ ▀▘▘ ▘▝▀▘▝▀▘
    -c | --continue) continueFlag=true ;;
    --start)
      [ -z "$startTest" ] || throwArgument "$handler" "$argument supplied twice" || return $?
      continueFlag=true && shift && startTest="$(validate "$handler" String "$argument" "$1")" || return $?
      ;;
    --stop) stopFlag=true ;;

    #                  ▐  ▗
    #  ▙▀▖▌ ▌▛▀▖ ▞▀▖▛▀▖▜▀ ▄ ▞▀▖▛▀▖▞▀▘
    #  ▌  ▌ ▌▌ ▌ ▌ ▌▙▄▘▐ ▖▐ ▌ ▌▌ ▌▝▀▖
    #  ▘  ▝▀▘▘ ▘ ▝▀ ▌   ▀ ▀▘▝▀ ▘ ▘▀▀
    --env-file) shift && muzzle validate "$handler" LoadEnvironmentFile "envFile" "${1-}" && decorate info "Loaded environment file $(decorate code "$1")" || return $? ;;
    --debug-filter) df=(--debug) ;;
    --debugger) bashDebuggerEnable ;;
    --verbose) verboseMode=true ;;
    --cd-away) cdAway=true ;;
    --coverage) $beQuiet || decorate warning "Will collect coverage statistics ..." && runner=(bashCoverage) ;;
    --fail)
      shift && failExecutors+=("$(validate "$handler" Callable "failExecutor" "${1-}")") || return $?
      # shellcheck disable=SC2015
      while [ $# -gt 0 ]; do [ "$1" != "--" ] && failExecutors+=("$1") && shift || break; done
      failExecutors+=("--")
      ;;

    #     ▜          ▗
    #  ▞▀▖▐ ▞▀▖▝▀▖▛▀▖▄ ▛▀▖▞▀▌
    #  ▌ ▖▐ ▛▀ ▞▀▌▌ ▌▐ ▌ ▌▚▄▌
    #  ▝▀  ▘▝▀▘▝▀▘▘ ▘▀▘▘ ▘▗▄▘
    --clean) action="clean" ;;
    --delete) shift && dd+=("$(validate "$handler" FileDirectory "$argument" "${1-}")") || return $? ;;
    --delete-common) dd+=("$(buildHome)/vendor" "$(buildHome)/node_modules" "$(buildHome)/.composer") ;;
    --messy) trap '__testCleanupMess true' EXIT QUIT TERM ;;

    #        ▜       ▐   ▐        ▐
    #  ▞▀▘▞▀▖▐ ▞▀▖▞▀▖▜▀  ▜▀ ▞▀▖▞▀▘▜▀ ▞▀▘
    #  ▝▀▖▛▀ ▐ ▛▀ ▌ ▖▐ ▖ ▐ ▖▛▀ ▝▀▖▐ ▖▝▀▖
    #  ▀▀ ▝▀▘ ▘▝▀▘▝▀  ▀   ▀ ▝▀▘▀▀  ▀ ▀▀
    -1 | --one | --suite)
      shift && item="$(validate "$handler" String "$argument" "${1-}")" || return $?
      suites+=("$item")
      qq+=("--suite" "$item")
      ;;
    --tag)
      shift && item="$(validate "$handler" String "$argument" "${1-}")" || return $?
      tags+=("$item")
      qq+=("$argument" "$item")
      ;;
    --skip-tag)
      shift && item="$(validate "$handler" String "$argument" "${1-}")" || return $?
      skipTags+=("$item")
      qq+=("$argument" "$item")
      ;;
    -*)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    #        ▜       ▐   ▐        ▐
    #  ▞▀▘▞▀▖▐ ▞▀▖▞▀▖▜▀  ▜▀ ▞▀▖▞▀▘▜▀ ▞▀▘
    #  ▝▀▖▛▀ ▐ ▛▀ ▌ ▖▐ ▖ ▐ ▖▛▀ ▝▀▖▐ ▖▝▀▖
    #  ▀▀ ▝▀▘ ▘▝▀▘▝▀  ▀   ▀ ▝▀▘▀▀  ▀ ▀▀
    *)
      item="$(validate "$handler" String "match" "$1")" || return $?
      matchTests+=("$item")
      qq+=("$item")
      ;;
    esac
    shift
  done

  # Test internal exports
  export __TEST_SUITE_CLEAN_EXIT __TEST_SUITE_TRACE __TEST_SUITE_CLEAN_DIRS

  $beQuiet || catchReturn "$handler" statusMessage decorate info "Initializing test suite ..." || return $?
  __testSuiteInitialize "$handler" || return $?

  if [ "$action" = "clean" ]; then
    $beQuiet || statusMessage decorate warning "Cleaning tests and exiting ... "
    __TEST_SUITE_CLEAN_EXIT=true
    __testCleanup || return $?
    $beQuiet || statusMessage timingReport "$allTestStart" "Cleaned in"
    $beQuiet || printf "\n"
    return 0
  fi

  local prettyLoad && prettyLoad=$(decorate value "(Load $(loadAverage | head -n 1))")

  catchReturn "$handler" buildEnvironmentLoad BUILD_COLORS XDG_CACHE_HOME XDG_STATE_HOME HOME || return $?

  local testCacheDirectory && testCacheDirectory=$(__testSuiteCacheDirectory "$handler") || return $?

  if [ -f "$testsCache" ]; then
    $beQuiet || statusMessage decorate info "Loading $(decorate file "$testsCache")"
    __testSuiteCacheInitialize "$handler" "$testCacheDirectory" "$testsCache" || return $?
  fi

  local testTemporaryHome && testTemporaryHome=$(catchReturn "$handler" buildCacheDirectory "testSuite.$$") || return $?

  local clean=("$testTemporaryHome")

  local testTemporaryTest && testTemporaryTest=$(catchReturn "$handler" directoryRequire "$testTemporaryHome/T") || returnClean $? "${clean[@]}" || return $?
  local testTemporaryInternal && testTemporaryInternal=$(catchReturn "$handler" directoryRequire "$testTemporaryHome/internal") || returnClean $? "${clean[@]}" || return $?

  export TMPDIR
  TMPDIR="$testTemporaryInternal"

  local startString && startString="$(catchEnvironment "$handler" date +"%F %T")" || returnClean $? "${clean[@]}" || return $?
  local allTestStart && allTestStart=$(timingStart) || returnClean $? "${clean[@]}" || return $?

  local quietLog && quietLog="$(fileTemporaryName "$handler")" || returnClean $? "${clean[@]}" || return $?
  clean+=("$quietLog")

  # Start tracing
  catchEnvironment "$handler" printf -- "%s\n" "$__TEST_SUITE_TRACE" >>"$quietLog" || returnClean $? "${clean[@]}" || return $?
  # QUIET LOG =============== QUIET LOG =============== QUIET LOG =============== QUIET LOG ===============

  # Color mode
  decorateInitialized || muzzle consoleConfigureDecorate || :

  [ "${#testPaths[@]}" -gt 0 ] || throwArgument "$handler" "Need at least one --tests directory ($(decorate each quote "${__saved[@]}"))" || returnClean $? "${clean[@]}" || return $?

  if ! $forceCreateIndex && [ -n "$testIndexFile" ] && [ -z "$testsCache" ]; then
    ! $verboseMode || decorate warning "Using index alone" || return $?
  else
    # Set up and synchronize our cache structure (usually quick)
    __testSuiteTestsProcess "$handler" "$testCacheDirectory" "$beQuiet" "${testPaths[@]}" || return $?

    if [ -n "$testsCache" ]; then
      local why="no cache"
      if [ ! -f "$testsCache" ] || why="manifest changed" && [ "$testCacheDirectory/manifest" -nt "$testsCache" ]; then
        $beQuiet || statusMessage decorate info "Writing $(decorate file "$testsCache") ($why)"
        __testSuiteCacheGenerate "$handler" "$testCacheDirectory" "$testsCache" || return $?
      fi
    fi
    if [ -n "$testIndexFile" ]; then
      catchEnvironment "$handler" cp -f "$testCacheDirectory/testFinder" "$testIndexFile" || return $?
      catchEnvironment "$handler" statusMessage decorate info "Wrote $(decorate file "$testIndexFile")" || return $?
    else
      testIndexFile="$testCacheDirectory/testFinder"
    fi
  fi

  if [ "$action" = "quit" ]; then
    consoleLineFill
    _testExit 0
    return 0
  fi

  local foundTests && foundTests=$(fileTemporaryName "$handler") || return $?
  local clean=("$foundTests")

  __testSuiteTestsSearch "$handler" "${df[@]+"${df[@]}"}" "${qq[@]+"${qq[@]}"}" >"$foundTests" <"$testIndexFile" || returnClean $? "${clean[@]}" || return $?
  local foundTestCount && foundTestCount=$(catchReturn "$handler" fileLineCount "$foundTests") || return $?

  #
  # Showing them? Great. We're done.
  #
  if [ "$action" = "list" ]; then
    __TEST_SUITE_TRACE="listing-tests"
    local currentSuiteName="" _remainder
    while read -r testName suiteName _remainder; do
      local suiteName="${suiteName#suite=}"
      if [ "$currentSuiteName" != "$suiteName" ]; then
        currentSuiteName="$suiteName" && catchReturn "$handler" printf -- "# %s\n" "$currentSuiteName" || return $?
      fi
      catchReturn "$handler" printf -- "%s\n" "$testName" || return $?
    done <"$foundTests"
    catchEnvironment "$handler" printf -- "# %s\n" "$(pluralWord "$foundTestCount" "test")" || return $?
    catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
    _testExit 0
    return 0
  fi

  if [ "$action" = "list-tags" ]; then
    __TEST_SUITE_TRACE="showing-tags"
    catchReturn "$handler" __testSuiteShowTags <"$foundTests" || returnClean $? "${clean[@]}" || return $?
    catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
    _testExit 0
    return 0
  fi

  if [ "$action" = "list-suites" ]; then
    __TEST_SUITE_TRACE="listing-suites"
    local prefix="suite="
    catchEnvironment "$handler" awk "{ print \$2 }" <"$foundTests" | cut -c "$((${#prefix} + 1))-" | sort -u || returnClean $? "${clean[@]}" || return $?
    catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
    _testExit 0
    return 0
  fi

  #
  # Intro statement to console
  #
  if ! $beQuiet; then
    local intro
    intro=$(printf -- "%s started on %s %s\n" "$(decorate BOLD magenta "${handler#_}")" "$startString" "$prettyLoad")
    if "$verboseMode"; then
      consoleHasColors || printf "%s" "No colors available in TERM ${TERM-}\n"
      statusMessage printf -- "%s" "$intro"
    fi

    if [ ${#suites[@]} -gt 0 ]; then
      printf "%s %s\n" "$(decorate warning "Adding $(pluralWord "${#suites[@]}" suite):")" "$(decorate BOLD orange "${suites[@]}")"
    fi

    catchEnvironment "$handler" printf -- "%s\n" "$intro" | consoleToPlain >>"$quietLog" || returnClean $? "${clean[@]}" || return $?
    printf "%s:%s : Found %s" "Query" "$(printf -- " %s" "${qq[@]+"${qq[@]}"}")" "$(pluralWord "$foundTestCount" "test")" | tee -a "$quietLog" || return $?
    # QUIET LOG =============== QUIET LOG =============== QUIET LOG =============== QUIET LOG ===============
  fi

  # Set up continue file if needed (remove it if we are *NOT* continuing)
  local continueFile="$home/.last-run-test"
  # Are we continuing? -> Do nothing. Continue file may or may not be there.
  # Otherwise, we are NOT continuing. Does the continue file NOT exist? -> No need to delete.
  # Otherwise, delete the continue file.

  if $continueFlag; then
    if [ "${#matchTests[@]}" -gt 0 ]; then
      ! $verboseMode || statusMessage decorate info "Continue is ignored when a match test is specified: ${qq[*]-}"
      startTest="" && continueFlag=false
    elif [ -z "$startTest" ]; then
      # If the continue file exists, the file contains the next test name on line 1
      startTest="$([ ! -f "$continueFile" ] || head -n 1 "$continueFile")"
      if [ "$startTest" = "PASSED" ]; then
        statusMessage --last decorate success "All tests passed successfully. Next test run will start from the beginning."
        catchEnvironment "$handler" rm -rf "$continueFile" || returnClean $? "${clean[@]}" || return $?
        catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
        _testExit 0
        return 0
      fi
    elif [ "$startTest" = "START" ] || [ "$startTest" = "-" ]; then
      startTest=""
    fi
  fi

  if [ "$foundTestCount" -eq 0 ]; then
    local message=()
    [ ${#matchTests[@]} -eq 0 ] || message+=("Match: $(decorate each code "${matchTests[@]}")")
    [ ${#suites[@]} -eq 0 ] || message+=("Suites: $(decorate each code "${suites[@]}")")
    [ ${#tags[@]} -eq 0 ] || message+=("Tags: $(decorate each code "${tags[@]}")")
    [ ${#skipTags[@]} -eq 0 ] || message+=("Skip Tags: $(decorate each code "${skipTags[@]}")")
    [ ${#qq[@]} -eq 0 ] || message+=("Query (#${#qq[@]}): $(decorate quote -- "${qq[*]}")")
    throwEnvironment "$handler" "No tests match" "${message[@]}" || returnClean $? "${clean[@]}" || return $?
  fi

  if [ -n "$startTest" ]; then
    if ! grep -q -e "^$startTest " "$foundTests"; then
      statusMessage --last decorate warning "$continueFile contains an unknown test: $startTest, starting from beginning"
      startTest=""
    fi
  fi

  # Continue setup
  $continueFlag || [ ! -f "$continueFile" ] || catchEnvironment "$handler" rm "$continueFile" || returnClean $? "${clean[@]}" || return $?

  #    ▀▛▘     ▐  ▗        ▜
  #     ▌▞▀▖▞▀▘▜▀ ▄ ▛▀▖▞▀▌ ▐ ▞▀▖▞▀▖▛▀▖
  #     ▌▛▀ ▝▀▖▐ ▖▐ ▌ ▌▚▄▌ ▐ ▌ ▌▌ ▌▙▄▘
  #     ▘▝▀▘▀▀  ▀ ▀▘▘ ▘▗▄▘  ▘▝▀ ▝▀ ▌
  local testsRun=() finalReturnCode=0

  local globalFlags && globalFlags=$(catchReturn "$handler" buildEnvironmentGet BUILD_TEST_FLAGS) || return $?
  local stateFile
  if $debugFlag; then
    stateFile="$home/.test.state"
  else
    stateFile="$(fileTemporaryName "$handler")" || return $?
  fi
  clean+=("$stateFile")
  {
    catchReturn "$handler" environmentValueWrite testSuiteArgumentCount "$__count" || returnClean $? "${clean[@]}" || return $?
    catchReturn "$handler" environmentValueWriteArray testSuiteArguments "${__saved[@]}" || returnClean $? "${clean[@]}" || return $?
    catchReturn "$handler" environmentValueWrite tests "$foundTestCount" || returnClean $? "${clean[@]}" || return $?
    catchReturn "$handler" environmentValueWriteArray flags "$globalFlags" || returnClean $? "${clean[@]}" || return $?
    catchReturn "$handler" environmentValueWriteArray timestamp "$(date +'%FT%T')" || returnClean $? "${clean[@]}" || return $?
    catchReturn "$handler" environmentValueWriteArray platform "$(_testPlatform)" || returnClean $? "${clean[@]}" || return $?
    catchReturn "$handler" environmentValueWriteArray continueFlag "$continueFlag" || returnClean $? "${clean[@]}" || return $?
    catchReturn "$handler" environmentValueWriteArray startTest "$startTest" || returnClean $? "${clean[@]}" || return $?
  } >"$stateFile" || returnClean $? "${clean[@]}" || return $?

  if $debugFlag; then
    dumpPipe "State File" <"$stateFile"
    decorate pair stateFile "$stateFile"
  fi
  # ============================================================================================================
  # HOOK tests-start
  # ============================================================================================================
  hookRunOptional --handler "$handler" --application "$home" tests-start "$stateFile" "${hookArgs[@]+"${hookArgs[@]}"}" || returnClean $? "${clean[@]}" || return $?

  local undo=("hookRunOptional" "tests-stop" "--failed" "undo called" "$stateFile" -- rm -rf "${clean[@]}")

  __TEST_SUITE_TRACE=options
  local suiteName="" sectionFile="" _remainder terminated=() currentSuiteName=""
  while read -r item suiteName sectionFile _remainder; do
    suiteName="${suiteName#suite=}"
    if [ -n "$startTest" ]; then
      if [ "$item" = "$startTest" ]; then
        statusMessage decorate info "Starting at test $(decorate code "$item")" || return $?
        startTest=""
      else
        statusMessage decorate info "Skipping test $(decorate code "$item")" || return $?
        continue
      fi
    fi
    local suiteUndo=()
    [ -z "$suiteName" ] || suiteUndo=(hookRunOptional --handler "$handler" --application "$home" testsuite-stop "$suiteName" "$stateFile")
    suiteUndo+=("${undo[@]}")

    if [ "$suiteName" != "$currentSuiteName" ]; then
      if [ -n "$currentSuiteName" ]; then
        # ============================================================================================================
        # HOOK testsuite-stop
        # ============================================================================================================
        TEST_SUITE_NAME="$suiteName" hookRunOptional --handler "$handler" --application "$home" testsuite-stop "$suiteName" "$stateFile" || returnUndo $? "${suiteUndo[@]}" || throwEnvironment "$handler" "testsuite-stop failed" || return $?
      fi
      currentSuiteName=$suiteName
      consoleLineFill
      __testHeading "$suiteName"
      timingReport "$allTestStart" "elapsed"
      # ============================================================================================================
      # HOOK testsuite-start
      # ============================================================================================================
      TEST_FILE=$sectionFile TEST_SUITE_NAME="$suiteName" hookRunOptional --handler "$handler" --application "$home" testsuite-start "$suiteName" "$stateFile" || returnUndo $? "${suiteUndo[@]}" || throwEnvironment "$handler" "testsuite-start failed" || return $?

      catchReturn "$handler" source "$sectionFile" || returnUndo $? "${suiteUndo[@]}" || throwEnvironment "$handler" "Loading $(decorate file "$sectionFile")" || return $?
    fi

    local __testStart && __testStart=$(timingStart)

    #  ▛▀▖
    #  ▙▄▘▌ ▌▛▀▖▛▀▖▞▀▖▙▀▖
    #  ▌▚ ▌ ▌▌ ▌▌ ▌▛▀ ▌
    #  ▘ ▘▝▀▘▘ ▘▘ ▘▝▀▘▘

    local testLine && testLine=$(muzzleReturn __testGetLine "$item" <"$sectionFile")
    local __flags && __flags=$(__testLoadFlags "$handler" "$sectionFile" "$item") || return $?
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

    if $continueFlag; then
      catchEnvironment "$handler" printf "%s\n" "$item" >"$continueFile" || return $?
    fi

    #       ▐        ▐  ▛▀▖
    #       ▜▀ ▞▀▖▞▀▘▜▀ ▙▄▘▌ ▌▛▀▖
    #       ▐ ▖▛▀ ▝▀▖▐ ▖▌▚ ▌ ▌▌ ▌
    #  ▀▀▀▀▀▀▀ ▝▀▘▀▀  ▀ ▘ ▘▝▀▘▘ ▘
    local testReturnCode=0
    TEST_START="$__testStart" TEST_FILE=$sectionFile TEST_VERBOSE=$verboseMode TEST_LINE=$testLine TEST_FLAGS=$rawFlags TEST_SUITE_NAME="$suiteName" TEST_NAME=$item "${runner[@]+"${runner[@]}"}" __testRun "$handler" "$stateFile" "$quietLog" "$testTemporaryTest" "$item" "$rawFlags" || testReturnCode=$?
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

    [ "${#cleanTestOnly[@]}" -eq 0 ] || catchEnvironment "$handler" rm -rf "${cleanTestOnly[@]}" || returnClean $? "${clean[@]}" "${cleanTestOnly[@]+}" || return $?
    if ! $passed && $stopFlag; then
      terminated=(--terminate "Stopped after $item failed")
      break
    fi
  done <"$foundTests"
  if [ -n "$currentSuiteName" ]; then
    # ============================================================================================================
    # HOOK testsuite-stop
    # ============================================================================================================
    TEST_SUITE_NAME="$currentSuiteName" hookRunOptional --handler "$handler" --application "$home" testsuite-stop "$currentSuiteName" "$stateFile" || returnUndo $? "${suiteUndo[@]}" || throwEnvironment "$handler" "testsuite-stop failed" || return $?
  fi

  # ============================================================================================================
  # HOOK tests-stop
  # ============================================================================================================
  hookRunOptional --handler "$handler" --application "$home" tests-stop "${terminated[@]+"${terminated[@]}"}" "$stateFile" || returnClean $? "${clean[@]}" || throwEnvironment "$handler" "tests-stop failed" || return $?

  [ ${#matchTests[@]} -eq 0 ] || [ ${#testsRun[@]} -gt 0 ] || throwArgument "$handler" "Match not found: $(decorate each code "${matchTests[@]}")" || returnClean $? "${clean[@]}" || return $?

  consoleLineFill
  if [ $finalReturnCode -eq 0 ]; then
    bigText --bigger Passed | decorate wrap "" "    " | decorate success | decorate wrap --fill "*" "    "
    if $continueFlag; then
      printf "%s\n" "PASSED" >"$continueFile"
    fi
  else
    bigText --bigger FAILED | decorate wrap "" "    " | decorate error | decorate wrap --fill "." "    "
  fi

  local as=() && read -r -a as < <(catchReturn "$handler" assertStatistics) || return $?

  catchReturn "$handler" assertStatistics --reset || return $?

  local failColor="error"
  [ "${as[0]}" -ne 0 ] || failColor="info"

  local stats=() && stats+=("$(decorate "$failColor" "$(pluralWord "${as[0]}" "failed assertion")")," "$(decorate success "$(pluralWord "${as[1]}" "successful assertion")")")

  [ ${#clean[@]} -eq 0 ] || $debugFlag || catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?

  timingReport "$allTestStart" "Completed $(decorate orange "${stats[*]}") in"

  _testExit "$finalReturnCode"
}

# Display the tags
__testSuiteShowTags() {
  local label="tag=" && removeFields 3 | tr ' ' $'\n' | grepSafe "$label" | sort -u | cut -c $((${#label} + 1))-
}

__testSuiteFunctionTested() {
  local handler="$1" && shift
  local assertedFunctions verboseMode=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --verbose) verboseMode=true ;;
    *)
      if ! assertedFunctions=$(__assertedFunctions); then
        throwEnvironment "$handler" "TEST_TRACK_ASSERTIONS is not enabled" || return $?
      fi
      argument="$(validate "$handler" Function function "$argument")" || return $?
      if ! muzzle grep -q -e "^$(quoteGrepPattern "$argument")\$" "$assertedFunctions"; then
        return 1
      fi
      __fns+=("$argument")
      ;;
    esac
    shift
  done
  ! $verboseMode || statusMessage decorate info "$(plural "${#__fns[@]}" "Function" "Functions") were tested: $(decorate code "${__fns[@]}")"
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
  local handler="$1" && shift

  local home && home="$(catchReturn "$handler" buildHome)/" || return $?

  catchEnvironment "$handler" muzzle pushd "$home" || return $?
  while [ "$#" -gt 0 ]; do
    local path="${1#"$home"}"
    find "$path" -type f -name '*-tests.sh'
    shift
  done
  catchEnvironment "$handler" muzzle popd || return $?
}
