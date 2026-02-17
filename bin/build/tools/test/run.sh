#!/usr/bin/env bash
# IDENTICAL zeskBuildBashHeader 5
#
# run.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Test runner

# Load one or more test files and run the tests defined within
#
# Argument: filename - File. Required. File located at `./test/tools/` and must be a valid shell file.
#
__testRun() {
  local handler="$1" && shift
  local __handler="$handler"
  local stateFile="$1" && shift
  local quietLog="${1-}" && shift
  local tempDirectory="${1-}" && shift
  local __test="${1-}" __flagText="${2-}" platform

  local __testDirectory __TEST_SUITE_RESULT
  local __test __tests __testStart
  local __beforeFunctions

  export __TEST_SUITE_TRACE
  export __TEST_SUITE_RESULT

  export TEST_FILE TEST_VERBOSE TEST_LINE TEST_FLAGS TEST_SUITE_NAME TEST_NAME

  local verboseMode="${TEST_VERBOSE-false}"

  # ============================================================================================================
  # HOOK test-start
  # ============================================================================================================
  TEST_SKIPPED=false catchEnvironment "$handler" hookRunOptional "test-start" "$TEST_SUITE_NAME" "$TEST_NAME" "$stateFile" || throwEnvironment "$handler" "$TEST_NAME test-start hook FAILED" return $?

  __testRunShellInitialize

  local captureStdout && captureStdout=$(fileTemporaryName "$handler") || return $?
  local error="$captureStdout.error"

  local clean=("$captureStdout" "$error")

  returnLeak || local leakReturnCode=$?

  __TEST_SUITE_RESULT="$__test not run yet"

  # Renamed to avoid clobbering by tests
  __testDirectory=$(catchEnvironment "$handler" pwd) || returnClean $? "${clean[@]}" || return $?

  # Test
  __testSection "$__test" || :

  __TEST_SUITE_TRACE="$__test"
  __testStart=$(timingStart)
  platform="$(_testPlatform)"
  [ -n "$platform" ] || throwEnvironment "$handler" "No platform defined?" || returnClean $? "${clean[@]}" || return $?
  if ! __testFlagPlatformMatch "$platform" "$__flagText" 2>>"$quietLog"; then
    catchReturn "$handler" statusMessage --last decorate warning "Skipping $(decorate code "$__test") on $(decorate error "$platform")" || returnClean $? "${clean[@]}" || return $?
    __TEST_SUITE_RESULT="skipped platform $platform"
    # ============================================================================================================
    # HOOK test-skip
    # ============================================================================================================
    # catchReturn "$handler" environmentValueWrite skipped "$TEST_NAME" >>"$stateFile" || return $?
    TEST_REASON=$__TEST_SUITE_RESULT TEST_SKIPPED=true TEST_SUCCESS=true catchEnvironment "$handler" hookRunOptional "test-skip" "$TEST_SUITE_NAME" "$TEST_NAME" "$stateFile" || returnClean $? "${clean[@]}" || return $?
    __testRunCleanup "$handler" "$stateFile" || returnClean $? "${clean[@]}" || return $?
    return 0
  fi

  #
  # Initial run output line
  #
  printf "%s %s ...\n" "$(decorate info "Running")" "$(decorate code "$__test")"
  printf "%s\n" "Running $__test" | tee -a "$captureStdout" >>"$quietLog"

  #     ▖   ▐        ▐
  #  ▄▄▖▝▚▖ ▜▀ ▞▀▖▞▀▘▜▀
  #     ▞▘  ▐ ▖▛▀ ▝▀▖▐ ▖
  #          ▀ ▝▀▘▀▀  ▀
  export TMPDIR && local savedTMPDIR=${TMPDIR-} && TMPDIR="$tempDirectory"

  local doHousekeeper && doHousekeeper=$(__testFlagBoolean "Housekeeper" "$__flagText")
  local doPlumber && doPlumber=$(__testFlagBoolean "Plumber" "$__flagText")
  [ -n "$doHousekeeper" ] || doHousekeeper=true
  [ -n "$doPlumber" ] || doPlumber=true
  local buildHomeRequired && buildHomeRequired=$(__testFlagBoolean "Build-Home" "$__flagText" false)
  local testActuallyFails && testActuallyFails=$(__testFlagBoolean "Fail" "$__flagText" false)

  {
    catchReturn "$handler" environmentValueWrite buildHomeRequired "$buildHomeRequired" || return $?
    catchReturn "$handler" environmentValueWrite testShouldFail "$testActuallyFails" || return $?
  } >>"$stateFile" || return $?

  if $verboseMode; then
    decorate pair "Platform" "$platform"
    decorate pair "Housekeeper" "$(decorate "$(booleanChoose "$doHousekeeper" green orange)" "$doHousekeeper")"
    decorate pair "Plumber" "$(decorate "$(booleanChoose "$doPlumber" green orange)" "$doPlumber")"
    decorate pair "Build-Home" "$(decorate "$(booleanChoose "$buildHomeRequired" green orange)" "$buildHomeRequired")"
    ! $testActuallyFails || decorate pair "Fail" "$(decorate green "$testActuallyFails")"
  fi

  local runner=()
  runner=("$__test" "$captureStdout")
  if $doHousekeeper; then
    catchReturn "$handler" environmentValueWrite housekeeper true >>"$stateFile" || return $?
    housekeeperCache=$(catchReturn "$handler" buildCacheDirectory "test-housekeeper.$$") || return $?
    runner=(--ignore '.last-run-test' --ignore '/.git/' --temporary "$savedTMPDIR" --path "$TMPDIR" --path "$(buildHome)" "${runner[@]}")
    ! stringFoundInsensitive ";Housekeeper-Overhead:true;" ";$__flagText;" || runner=(--overhead "${runner[@]}")
    runner=(housekeeper --cache "$housekeeperCache" "${runner[@]}")
  else
    catchReturn "$handler" environmentValueWrite housekeeper false >>"$stateFile" || return $?
  fi
  if $doPlumber; then
    catchReturn "$handler" environmentValueWrite plumber true >>"$stateFile" || return $?
    runner=(plumber --leak __BUILD_LOADER --temporary "$savedTMPDIR" "${runner[@]}")
  else
    catchReturn "$handler" environmentValueWrite plumber false >>"$stateFile" || return $?
  fi

  local startDirectory
  startDirectory=$(catchEnvironment "$handler" pwd) || return $?
  catchReturn "$handler" muzzle pushd "$startDirectory" || return $?

  local resultCode=0
  local assertions && assertions=$(assertStatistics --total)
  local captureStderr="$captureStdout.stderr" && clean+=("$captureStderr")

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
  ! $verboseMode || decorate each code "${runner[@]}"
  if "${runner[@]}" > >(tee -a "$captureStdout") 2> >(tee -a "$captureStderr"); then
    catchReturn "$handler" muzzle popd || returnClean $? "${clean[@]}" || return $?
    TMPDIR="$savedTMPDIR"
    if fileIsEmpty "$captureStderr"; then
      catchReturn "$handler" printf "%s\n" "SUCCESS $__test" | tee -a "$captureStdout" >>"$quietLog" || returnClean $? "${clean[@]}" || return $?
      __TEST_SUITE_RESULT=""
    else
      returnAssert || resultCode=$?
      local stderrLines && stderrLines="$(catchReturn "$handler" fileLineCount "$captureStderr")" || returnClean $? "${clean[@]}" || return $?
      catchReturn "$handler" printf "%s\n" "stderr-SUCCESS $__test has STDERR: $(pluralWord "$stderrLines" line)" | catchReturn "$handler" tee -a "$error" "$quietLog" || return $?
      catchReturn "$handler" dumpPipe <"$captureStderr" | catchReturn "$handler" tee -a "$quietLog" || returnClean $? "${clean[@]}" || return $?
      __TEST_SUITE_RESULT="[$resultCode] $__test failed, found stderr"
    fi
  else
    resultCode=$?
    catchReturn "$handler" muzzle popd || returnClean $? "${clean[@]}" || return $?
    TMPDIR="$savedTMPDIR"
    catchReturn "$handler" printf "\n%s\n" "FAILED [$resultCode] $__test" | catchReturn "$handler" tee -a "$error" "$quietLog" || returnClean $? "${clean[@]}" || return $?
    __TEST_SUITE_RESULT="[$resultCode] $__test failed"
    if ! fileIsEmpty "$captureStderr" && stringFoundInsensitive ";stderr-FAILED;" ";$__flagText;"; then
      catchReturn "$handler" printf "%s\n" "stderr-FAILED [$resultCode] $__test ALSO has STDERR:" | catchReturn "$handler" tee -a "$error" "$quietLog" || returnClean $? "${clean[@]}" || return $?
      catchReturn "$handler" dumpPipe <"$captureStderr" | tee -a "$quietLog" || returnClean $? "${clean[@]}" || return $?
      __TEST_SUITE_RESULT="[$resultCode] $__test failed (found stderr)"
    fi
  fi

  ! $doHousekeeper || catchEnvironment "$handler" rm -rf "$housekeeperCache" || returnClean $? "${clean[@]}" || return $?

  if $testActuallyFails; then
    if [ $resultCode -eq 0 ]; then
      catchReturn "$handler" decorate error "Test supposed to fail but succeeded?" || returnClean $? "${clean[@]}" || return $?
      catchReturn "$handler" printf "%s\n" "$__test: Test supposed to fail but succeeded?" >>"$error" || returnClean $? "${clean[@]}" || return $?
      returnAssert || resultCode=$?
      __TEST_SUITE_RESULT="[$resultCode] $__test didn't fail as intended"
    else
      catchReturn "$handler" decorate success "Test supposed to fail: $resultCode -> 0" || returnClean $? "${clean[@]}" || return $?
      catchReturn "$handler" printf "%s\n" "$__test: Test supposed to fail: $resultCode -> 0" >>"$captureStdout" || returnClean $? "${clean[@]}" || return $?
      resultCode=0
    fi
  fi

  handler="$__handler"

  (
    catchReturn "$handler" environmentValueWrite stderr "$captureStderr" || return $?
    catchReturn "$handler" environmentValueWrite stdout "$captureStdout" || return $?
    catchReturn "$handler" environmentValueWrite error "$error" || return $?
  ) >>"$stateFile" || returnClean $? "${clean[@]}" || return $?

  # So, `handler` can be overridden if it is made global somehow, declare -r prevents changing here
  # documentation-tests.sh change this apparently
  # Instead of preventing this handler, just work around it
  catchEnvironment "$handler" cd "$__testDirectory" || return $?
  local elapsed && elapsed="$(timingElapsed "$__testStart")"
  local timingText && timingText="$(timingReport "$__testStart")"
  if [ "$resultCode" = "$leakReturnCode" ]; then
    if [ -f "$captureStderr" ]; then
      dumpPipe "captureStderr" <"$captureStderr"
    else
      decorate error "NO captureStderr"
    fi
    __TEST_SUITE_RESULT="passed with leaks"
    statusMessage printf "%s %s %s ...\n" "$(decorate code "$__test")" "$(decorate warning "passed with leaks")" "$timingText"
  elif [ "$resultCode" -eq 0 ]; then
    __TEST_SUITE_RESULT=""
    statusMessage printf "%s %s %s ...\n" "$(decorate code "$__test")" "$(decorate success "passed")" "$timingText"
  else
    statusMessage --last printf "[%d] %s %s %s\n" "$resultCode" "$(decorate code "$__test")" "$(decorate error "FAILED")" "$timingText" 1>&2
    dumpPipe --lines 30 LOGFILE <"$quietLog" 1>&2 || :
    __TEST_SUITE_RESULT="failed"
    returnAssert || resultCode=$?
  fi

  local passed=true hh=()
  if [ "$resultCode" -ne 0 ]; then
    passed=false
    hh=(--failed "$__TEST_SUITE_RESULT")
  fi

  # ============================================================================================================
  # HOOK test-stop
  # ============================================================================================================
  TEST_ELAPSED="$elapsed" TEST_REASON="$__TEST_SUITE_RESULT" TEST_ASSERTIONS=$(($(assertStatistics --total) - assertions)) TEST_RETURN_CODE=$resultCode TEST_SKIPPED=false TEST_SUCCESS=$passed catchEnvironment "$handler" hookRunOptional "test-stop" "${hh[@]+"${hh[@]}"}" "$TEST_SUITE_NAME" "$TEST_NAME" "$stateFile" || throwEnvironment "$handler" "$TEST_NAME test-stop hook FAILED" return $?

  __testRunCleanup "$handler" "$stateFile" || return $?

  catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?

  return "$resultCode"
}

__testRunCleanup() {
  local handler="$1" && shift
  local stateFile="$1" && shift

  [ -f "$stateFile" ] || throwArgument "$handler" "stateFile $stateFile is not a file" || return $?
  (
    local stdout="" stderr="" output="" error=""
    catchReturn "$handler" source "$stateFile" || return $?
    local variable && for variable in stdout stderr error output; do
      local file="${!variable-}"
      [ ! -f "$file" ] || catchReturn "$handler" rm -rf "$file" || return $?
      environmentValueWrite "$variable" "" >>"$stateFile"
    done
    : "$stdout $stderr $output $error"
  ) || return $?
  catchReturn "$handler" environmentCompile --parse --in-place "$stateFile" || return $?
}
