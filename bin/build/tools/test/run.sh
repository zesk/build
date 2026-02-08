#!/usr/bin/env bash
# test-tools.sh
#
# Test runner
#
# Copyright &copy; 2026 Market Acumen, Inc.

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

  __testRunShellInitialize

  local output && output=$(fileTemporaryName "$handler") || return $?
  local error="$output.error"

  __TEST_SUITE_RESULT="$__test not run yet"

  # Renamed to avoid clobbering by tests
  __testDirectory=$(pwd)

  # Test
  __testSection "$__test" || :

  __TEST_SUITE_TRACE="$__test"
  __testStart=$(timingStart)
  platform="$(_testPlatform)"
  [ -n "$platform" ] || throwEnvironment "$handler" "No platform defined?" || return $?
  if ! __testFlagPlatformMatch "$platform" "$__flagText" 2>>"$quietLog"; then
    statusMessage --last decorate warning "Skipping $(decorate code "$__test") on $(decorate error "$platform")"
    __TEST_SUITE_RESULT="skipped platform $platform"
    # ============================================================================================================
    # HOOK test-skip
    # ============================================================================================================
    # catchReturn "$handler" environmentValueWrite skipped "$TEST_NAME" >>"$stateFile" || return $?
    TEST_REASON=$__TEST_SUITE_RESULT TEST_SKIPPED=true TEST_PASS=true catchEnvironment "$handler" hookRunOptional "test-skip" "$TEST_SUITE_NAME" "$TEST_NAME" "$stateFile" || return $?
    __testRunCleanup "$handler" "$stateFile" || return $?
    return 0
  fi

  printf "%s %s ...\n" "$(decorate info "Running")" "$(decorate code "$__test")"
  printf "%s\n" "Running $__test" | tee -a "$output" >>"$quietLog"

  local captureStderr="$output.stderr"
  local captureStdout="$output.stdout"

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

  {
    catchReturn "$handler" environmentValueWrite buildHomeRequired "$buildHomeRequired" || return $?
    catchReturn "$handler" environmentValueWrite testShouldFail "$testActuallyFails" || return $?
  } >>"$stateFile" || return $?

  if "${TEST_VERBOSE-false}"; then
    decorate pair "Platform" "$platform"
    decorate pair "Housekeeper" "$(decorate "$(booleanChoose "$doHousekeeper" green orange)" "$doHousekeeper")"
    decorate pair "Plumber" "$(decorate "$(booleanChoose "$doPlumber" green orange)" "$doPlumber")"
    decorate pair "Build-Home" "$(decorate "$(booleanChoose "$buildHomeRequired" green orange)" "$buildHomeRequired")"
    ! $testActuallyFails || decorate pair "Fail" "$(decorate green "$testActuallyFails")"
  fi

  local runner=()
  runner=("$__test" "$output")
  if $doHousekeeper; then
    catchReturn "$handler" environmentValueWrite housekeeper true >>"$stateFile" || return $?
    housekeeperCache=$(catchReturn "$handler" buildCacheDirectory "test-housekeeper.$$") || return $?
    runner=(--ignore '.last-run-test' --ignore '/.git/' --temporary "$savedTMPDIR" --path "$TMPDIR" --path "$(buildHome)" "${runner[@]}")
    ! isSubstringInsensitive ";Housekeeper-Overhead:true;" ";$__flagText;" || runner=(--overhead "${runner[@]}")
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

  # ============================================================================================================
  # HOOK test-start
  # ============================================================================================================
  local resultCode=0
  local assertions && assertions=$(_assertionTotals)

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
  if "${runner[@]}" 2> >(tee -a "$captureStderr") > >(tee -a "$captureStdout"); then
    catchReturn "$handler" muzzle popd || :
    TMPDIR="$savedTMPDIR"
    if fileIsEmpty "$captureStderr"; then
      printf "%s\n" "SUCCESS $__test" | tee -a "$output" >>"$quietLog"
      __TEST_SUITE_RESULT=""
    else
      returnAssert || resultCode=$?
      printf "%s\n" "stderr-SUCCESS $__test has STDERR:" | tee -a "$error" | tee -a "$quietLog"
      dumpPipe <"$captureStderr" | tee -a "$quietLog"
      __TEST_SUITE_RESULT="[$resultCode] $__test failed, found stderr"
    fi
  else
    resultCode=$?
    catchReturn "$handler" muzzle popd || :
    TMPDIR="$savedTMPDIR"
    printf "\n%s\n" "FAILED [$resultCode] $__test" | tee -a "$error" | tee -a "$quietLog"
    __TEST_SUITE_RESULT="[$resultCode] $__test failed"
    if ! fileIsEmpty "$captureStderr" && isSubstringInsensitive ";stderr-FAILED;" ";$__flagText;"; then
      printf "%s\n" "stderr-FAILED [$resultCode] $__test ALSO has STDERR:" | tee -a "$error" | tee -a "$quietLog"
      dumpPipe <"$captureStderr" | tee -a "$quietLog"
      __TEST_SUITE_RESULT="[$resultCode] $__test failed (found stderr)"
    fi
  fi

  ! $doHousekeeper || catchEnvironment "$handler" rm -rf "$housekeeperCache" || return $?
  catchEnvironment "$handler" rm -rf "$captureStderr" || return $?

  if $testActuallyFails; then
    if [ $resultCode -eq 0 ]; then
      decorate error "Test supposed to fail but succeeded?" || return $?
      printf "%s\n" "$__test: Test supposed to fail but succeeded?" >>"$error" || return $?
      resultCode=$(returnCode assert)
      __TEST_SUITE_RESULT="[$resultCode] $__test didn't fail as intended"
    else
      decorate success "Test supposed to fail: $resultCode -> 0"
      printf "%s\n" "$__test: Test supposed to fail: $resultCode -> 0" >>"$output" || return $?
      resultCode=0
    fi
  fi

  handler="$__handler"

  {
    catchReturn "$handler" environmentValueWrite stderr "$captureStderr" || return $?
    catchReturn "$handler" environmentValueWrite stdout "$captureStdout" || return $?
    catchReturn "$handler" environmentValueWrite output "$output" || return $?
    catchReturn "$handler" environmentValueWrite error "$error" || return $?
  } >>"$stateFile" || return $?

  # So, `handler` can be overridden if it is made global somehow, declare -r prevents changing here
  # documentation-tests.sh change this apparently
  # Instead of preventing this handler, just work around it
  catchEnvironment "$handler" cd "$__testDirectory" || return $?
  local timingText && timingText="$(timingReport "$__testStart")"
  if [ "$resultCode" = "$(returnCode leak)" ]; then
    resultCode=0
    statusMessage printf "%s %s %s ...\n" "$(decorate code "$__test")" "$(decorate warning "passed with leaks")" "$timingText"
  elif [ "$resultCode" -eq 0 ]; then
    statusMessage printf "%s %s %s ...\n" "$(decorate code "$__test")" "$(decorate success "passed")" "$timingText"
  else
    statusMessage --last printf "[%d] %s %s %s\n" "$resultCode" "$(decorate code "$__test")" "$(decorate error "FAILED")" "$timingText" 1>&2
    dumpPipe --lines 30 LOGFILE <"$quietLog" 1>&2 || :
    __TEST_SUITE_RESULT="$__test failed"
    returnAssert || resultCode=$?
  fi

  local passed=true
  if [ "$resultCode" -ne 0 ]; then
    decorate pair "Reason:" "\"$__TEST_SUITE_RESULT\""
    passed=false
    hh+=(--failed "$__TEST_SUITE_RESULT")
  fi

  $passed || catchReturn "$handler" environmentValueWrite failedMessage "$__TEST_SUITE_RESULT" >>"$stateFile" || return $?

  # ============================================================================================================
  # HOOK test-stop
  # ============================================================================================================
  TEST_ASSERTIONS=$(($(_assertionTotals) - assertions)) TEST_RETURN_CODE=$resultCode TEST_SKIPPED=false TEST_PASS=$passed catchEnvironment "$handler" hookRunOptional "test-stop" "${hh[@]+"${hh[@]}"}" "$TEST_SUITE_NAME" "$TEST_NAME" "$stateFile" || return $?

  __testRunCleanup "$handler" "$stateFile" || return $?

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
      local file="${!variable}"
      [ ! -f "$file" ] || catchReturn "$handler" rm -rf "$file" || return $?
      environmentValueWrite "$variable" "" >>"$stateFile"
    done
    : "$stdout $stderr $output"
  ) || return $?
  catchReturn "$handler" environmentCompile --parse --in-place "$stateFile" || return $?
}
