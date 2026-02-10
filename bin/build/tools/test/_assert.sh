#!/usr/bin/env bash
#
# assertHelpers.sh
#
# Assert utilities
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Docs: contextOpen ./documentation/source/tools/assert.md
# Test: contextOpen ./test/tools/assert-tests.sh

__resultText() {
  local passed="$1" text length color && shift
  local text

  text="$(__resultTextCleaned "$*")"

  local color="blue"
  if [ -z "$text" ]; then
    $passed || color="red"
  else
    $passed || color="error"
  fi
  decorate "$color" "$text"
}

# Format test text, special display for blank strings
__resultTextCleaned() {
  local text="$*"
  local length="${#text}"

  if [ "$length" -eq 0 ]; then
    text="(blank)"
  else
    local max=80
    if stringContains "$text" $'\e'; then
      dumpHex --size "$max" "$text"
    else
      local half=$((max / 2))
      # Truncate to something readable
      [ "$length" -lt "$max" ] || text="${text:0:$half} ... ${text:$((length - half)):$((length - 1))}"
      # Hide newlines
      newlineHide "$text"
    fi
  fi
}

# Format test text, special display for blank strings
__resultTextSize() {
  local passed="$1" color=success && shift
  "$passed" || color=error
  __resultTextSizeColor "$color" "$@"
}

# Format test text, special display for blank strings
__resultTextSizeColor() {
  local text color="$1" && shift

  text="$(__resultTextCleaned "$*")"
  local length="${#text}"

  printf -- "%s %s\n" "$(decorate "$color" "$text")" "$(decorate subtle "$(textAlignRight 9 "$(pluralWord "$length" char)")")"
}

___printResultPair() {
  local label="$1" resultStatus="$2" result="$3" suffix="${4-}"
  [ -z "$suffix" ] || suffix=" ${suffix# }"
  printf -- "%s: %s%s\n" "$label" "$(__resultTextSize "$resultStatus" "$result")" "$suffix"
}

__assertTimingSetup() {
  export __BUILD_SAVED_CACHE_DIRECTORY
  if [ -z "${__BUILD_SAVED_CACHE_DIRECTORY-}" ]; then
    __BUILD_SAVED_CACHE_DIRECTORY="$(catchReturn "$handler" buildCacheDirectory "${FUNCNAME[0]}")" || return $?
  fi
}

__assertStatistics() {
  local handler="$1" && shift
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --reset)
      export __BUILD_SAVED_CACHE_DIRECTORY && __assertTimingSetup || return $?
      muzzle incrementor --path "$__BUILD_SAVED_CACHE_DIRECTORY" 0 assert-failure assert-success
      return 0
      ;;
    --total)
      local add=() && IFS=' ' read -r -d $'\n' -a add < <(__assertStatistics "$handler") || return $?
      set -- "${add[@]+"${add[@]}"}"
      local total=0 && while [ $# -gt 0 ]; do total=$((total + $1)) && shift; done
      printf "%d\n" "$total"
      return 0
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  export __BUILD_SAVED_CACHE_DIRECTORY && __assertTimingSetup || return $?
  incrementor --path "$__BUILD_SAVED_CACHE_DIRECTORY" "?" assert-failure assert-success | tr $'\n' ' ' | trimRightSpace | printfOutputSuffix "\n"
}

# Save and report the timing since the last call
__assertTimingCalculate() {
  local handler="returnMessage"
  local timingFile

  export __BUILD_SAVED_CACHE_DIRECTORY
  timingFile="$__BUILD_SAVED_CACHE_DIRECTORY/.${FUNCNAME[0]}" || return $?
  if [ -f "$timingFile" ]; then
    local stamp
    stamp="$(head -n 1 <"$timingFile")"
    if isUnsignedInteger "$stamp"; then
      if ! timingReport "$stamp"; then
        printf "%s\n" "$(decorate error "$(dumpPipe --vanish "$timingFile" "Deleting bad timing")")"
        rm -f "$timingFile" || :
        return
      fi
    else
      decorate error "Timestamp saved was invalid: $(dumpPipe timingFile <"$timingFile")"
    fi
  else
    decorate info "First test ($__BUILD_SAVED_CACHE_DIRECTORY)"
  fi
  timingStart >"$timingFile"
}

# Argument:
# Environment: TEST_TRACK_ASSERTIONS
__assertedFunctions() {
  export TEST_TRACK_ASSERTIONS
  if [ "${TEST_TRACK_ASSERTIONS-}" != "false" ]; then
    local handler="_${FUNCNAME[0]}"
    local logFile

    logFile="$(catchReturn "$handler" buildCacheDirectory)/$handler" || return $?
    logFile="$(catchReturn "$handler" fileDirectoryRequire "$logFile")" || return $?
    [ ! -f "$logFile.clean" ] || catchReturn "$handler" touch "$logFile.clean" || return $?
    if [ $# -eq 0 ]; then
      catchEnvironment "$handler" touch "$logFile" || return $?
      if [ "$logFile" -nt "$logFile.clean" ]; then
        printf "%s\n" "SORTED" 1>&2
        catchEnvironment "$handler" sort -u "$logFile" -o "$logFile" || return $?
        catchEnvironment "$handler" touch "$logFile.clean" || return $?
      fi
      printf -- "%s\n" "$logFile"
      return 0
    fi
    catchEnvironment "$handler" printf -- "%s\n" "$@" >>"$logFile" || return $?
  fi
  return 1
}
___assertedFunctions() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Decorations and statistics collection
#
_assertFailure() {
  local function="${1-None}" failIcon="❌"
  export BUILD_TEST_FLAGS
  #  local timing="" flags=";${BUILD_TEST_FLAGS-};" flag="Assert-Statistics:true"
  #  if [ "${flags#*;"$flag";}" != "$flags" ]; then
  export __BUILD_SAVED_CACHE_DIRECTORY
  ! __assertTimingSetup || timing=" [$(__assertTimingCalculate)]"
  incrementor --path "$__BUILD_SAVED_CACHE_DIRECTORY" assert-failure
  #  fi
  shift && statusMessage --last printf -- "%s %s %s%s" "$failIcon" "$(decorate error "$function")" "$*" "$timing" 1>&2 || return $?
  returnAssert
}

_assertSuccess() {
  local function="${1-None}" successIcon="✅"
  #  local timing="" flags=";${BUILD_TEST_FLAGS-};" flag="Assert-Statistics:true"
  #  if [ "${flags#*;"$flag";}" != "$flags" ]; then
  export __BUILD_SAVED_CACHE_DIRECTORY
  ! __assertTimingSetup || timing=" [$(__assertTimingCalculate)]"
  incrementor --path "$__BUILD_SAVED_CACHE_DIRECTORY" assert-success
  #  fi
  shift && statusMessage printf -- "%s %s %s%s" "$successIcon" "$(decorate success "$function")" "$*" "$timing" || return $?
}

# INTERNAL: To optimize this (or see where it is slow), use
# INTERNAL:     BUILD_COLORS=false bin/tools.sh assertEquals --profile a a | grep -v assert | sort -rn --key=2.1
# INTERNAL:     bin/tools.sh assertEquals --profile a a | grep -v assert | sort -rn --key=2.1
# Core condition assertion handler
# DOC TEMPLATE: assert-common 27
# Argument: --help - Flag. Optional. Display this help.
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# INTERNAL: Argument: --return returnCode - UnsignedInteger. Optional. Return code to expect from the `testFunction`.
# Argument: --display - String. Optional. Display name for the condition.
# INTERNAL: Argument: --success - Flag. Optional. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# INTERNAL: Argument: --profile - Flag. Optional. Profile the assertion function.
# Argument: --debug - Flag. Optional. Debugging enabled for the assertion function.
# Argument: --line lineNumber - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
# INTERNAL: Argument: --test testFunction - Callable. Required. The test call to run.
# INTERNAL: Argument: --formatter formatterFunction - Callable. Optional. The formatter to format the test result.
# Argument: --stdout-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - String. Optional. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Flag. Optional. Output to `stderr` will not cause the test to fail.
# Argument: --stderr-match - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stderr-no-match - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
# Argument: --dump - Flag. Optional. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --plumber - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
# Argument: --skip-plumber - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
# Argument: --head - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# INTERNAL: Argument: --debug-lines - Flag. Optional. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# INTERNAL: Argument: --code1 - Flag. Optional. When passed the first argument to this function is the `returnCode`.
# INTERNAL: Argument: ... - Arguments. Optional. Additional arguments are passed to `testFunction` or `formatterFunction`.
# END DOC TEMPLATE: assert-common
# Return Code: 1 - If the assertions fails
# Return Code: 0 - If the assertion succeeds
_assertConditionHelper() {
  export BUILD_TEST_FLAGS
  local flag=";Assert-Profile:true;" flags=";${BUILD_TEST_FLAGS-};"

  local handler="$1" && shift

  local pairs=() debugFlag=false
  local formatter="__assertResultFormatter"

  local doPlumber=""
  local success=true
  local lineDepth="" lineNumber="" displayName="" tester="" file=""

  local outputContains=() outputNotContains=() stderrContains=() stderrNotContains=()

  local doPlumber="" leaks=() whichEnd="tail"
  local errorsOk=false dumpFlag=false dumpBinaryFlag=false expectedExitCode=0 code1=false debugLines=false

  # _IDENTICAL_ argumentBlankLoopHandler 4
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --exit)
      shift && expectedExitCode=$(validate "$handler" UnsignedInteger "$argument" "${1-}") || return $?
      pairs+=("Exit" "$(decorate BOLD magenta " $expectedExitCode ")")
      ;;
    --display) shift && displayName="$(validate "$handler" String "$argument" "${1-}")" || return $? ;;
    --success)
      shift && success="$(validate "$handler" Boolean "$argument" "${1-}")" || return $?
      pairs+=("should" "$(booleanChoose "$success" "succeed" "$(decorate warning "fail")")")
      ;;
    --profile)
      # IDENTICAL profileFunctionEnable 3
      # ********************************************************************************************************************
      if [ "$__profile" = "false" ]; then __profile=$(timingStart) && __profile0=$__profile; fi
      # ********************************************************************************************************************
      ;;
    --debug) debugFlag=true ;;
    --line) shift && lineNumber="${1-}" ;;
    --line-depth) shift && lineDepth="$(validate "$handler" PositiveInteger "$argument" "${1-}")" || return $? ;;
    --test) shift && tester="$(validate "$handler" String "$argument" "${1-}")" || return $? ;;
    --formatter) shift && formatter="$(validate "$handler" Callable "$argument" "${1-}")" || return $? ;;
    --stderr-ok) errorsOk=true ;;
    --stderr-match) errorsOk=true && shift && stderrContains+=("$(validate "$handler" String "stderrContainsText" "${1-}")") || return $? ;;
    --stderr-no-match) errorsOk=true && shift && stderrNotContains+=("$(validate "$handler" String "stderrNotContainsText" "${1-}")") || return $? ;;
    --stdout-match) shift && outputContains+=("$(validate "$handler" String "stdoutContainsText" "${1-}")") || return $? ;;
    --stdout-no-match) shift && outputNotContains+=("$(validate "$handler" String "stdoutNotContainsText" "${1-}")") || return $? ;;
    --dump) dumpFlag=true && dumpBinaryFlag=false ;;
    --dump-binary) dumpBinaryFlag=true && dumpFlag=true ;;
    --plumber) doPlumber=true ;;
    --leak) shift && doPlumber=true && leaks+=(--leak "$(validate "$handler" String "$argument globalName" "${1-}")") || return $? ;;
    --skip-plumber) doPlumber=false && leaks=() ;;
    --head) whichEnd="head" ;;
    --tail) whichEnd="tail" ;;
    --debug-lines) debugLines=true ;;
    --code1) code1=true ;;
    *)
      break
      ;;
    esac
    shift
  done

  # IDENTICAL profileFunctionHead 4
  # ********************************************************************************************************************
  local __profile="false" __profile0="" __profileNext __profileUsed=0 __profileLabel="arguments (#$__count)" __profilePrefix="Profile-${FUNCNAME[0]}: "
  if [ -n "$flags" ] && [ "${flags#*"$flag"}" != "$flags" ]; then __profile=$(timingStart) && __profile0=$__profile; fi
  # ********************************************************************************************************************

  if $code1; then
    [ "$expectedExitCode" -eq 0 ] || catchArgument "$handler" "--exit and --code1 and mutually exclusive for non-zero --exit" || return $?
    expectedExitCode="$(validate "$handler" UnsignedInteger "exitCode" "${1-}")" || return $?
    shift
  fi

  __profileLabel="arguments"
  # IDENTICAL profileFunctionMarker 3
  # ********************************************************************************************************************
  if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
  # ********************************************************************************************************************

  # IDENTICAL lineDepthComputation 11
  local linePrefix=""
  if [ -n "$lineDepth" ]; then
    local computeLine="${BASH_LINENO[lineDepth]}"
    if [ -z "$lineNumber" ]; then
      lineNumber="$computeLine"
    elif [ "$lineNumber" != "$computeLine" ] && $debugLines; then
      displayName="${displayName} (Computed line [$computeLine] != passed line [$lineNumber])"
    fi
  fi
  [ -z "$lineNumber" ] || linePrefix="Line $lineNumber: "
  # -- end IDENTICAL lineDepthComputation

  if [ -z "$doPlumber" ]; then
    flag=";Assert-Plumber:true;"
    [ "${flags#*"$flag"}" = "$flags" ] && doPlumber=false || doPlumber=true
  fi
  [ -n "$tester" ] || throwArgument "$handler" "--test required ($*)" || return $?

  local outputFile && outputFile=$(fileTemporaryName "$handler") || return $?
  local errorFile="$outputFile.err"
  local runner=("$tester")
  if $doPlumber; then
    runner=(plumber "${leaks[@]+"${leaks[@]}"}" "$tester")
  fi
  buildDebugStart "assert"
  ! $debugFlag || __buildDebugEnable v
  local exitCode=0
  local clean=("$outputFile" "$errorFile")
  local testPassed=false

  __profileLabel="runner-setup"
  # IDENTICAL profileFunctionMarker 3
  # ********************************************************************************************************************
  if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
  # ********************************************************************************************************************

  "${runner[@]}" "$@" >"$outputFile" 2>"$errorFile" || exitCode=$?

  __profileLabel="runner"
  # IDENTICAL profileFunctionMarkerOthers 3
  # ********************************************************************************************************************
  if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && __profileUsed=$((__profileUsed + (__profileNext - __profile))) && printf "Line %d: %s%d %s (*them %d)\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" "$__profileUsed" 1>&2 && __profile=$__profileNext; fi
  # ********************************************************************************************************************

  ! $debugFlag || __buildDebugDisable v
  if [ "$exitCode" = "$expectedExitCode" ]; then
    testPassed=$success
  else
    $success && testPassed=false || testPassed=true
  fi
  local result && result="$("$formatter" "$testPassed" "$success" "$@" <"$outputFile")"

  __profileLabel="formatter"
  # IDENTICAL profileFunctionMarkerOthers 3
  # ********************************************************************************************************************
  if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && __profileUsed=$((__profileUsed + (__profileNext - __profile))) && printf "Line %d: %s%d %s (*them %d)\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" "$__profileUsed" 1>&2 && __profile=$__profileNext; fi
  # ********************************************************************************************************************

  # shellcheck disable=SC2059
  local message
  message="$(printf "$(decorate label %s) %s, " "${pairs[@]+"${pairs[@]}"}")"
  message="${message%, }"
  message="$(printf -- "%s➡️ %s -> %s\n" "$linePrefix" "$message" "$result")"
  if $code1 || [ "$expectedExitCode" -ne 0 ]; then
    message="$message ($exitCode $(booleanChoose "$success" "=" "!=") expected $expectedExitCode), $(__resultText "$testPassed" "$(booleanChoose "$testPassed" correct incorrect)")"
  fi
  local functionName="${handler#_}"
  if ! "$errorsOk" && [ -s "$errorFile" ]; then
    message="$(printf -- "%s - %s\n%s\n" "$message" "$(decorate error "produced stderr")" "$(dumpPipe --tail stderr <"$errorFile")")"
    _assertFailure "$functionName" "$displayName $message" || return $?
  fi
  if $errorsOk && [ ! -s "$errorFile" ]; then
    statusMessage --last printf "%s – %s" "$message" "$(decorate warning "--stderr-ok used but is NOT necessary")"
  fi

  local stdoutTitle="$functionName (stdout)" stderrTitle="$functionName (stderr)"
  if [ ${#stderrContains[@]} -gt 0 ]; then
    __assertFileContainsHelper "$handler" true "$__profile" --line "$lineNumber" --display "$stderrTitle" "$errorFile" -- "${stderrContains[@]}" || testPassed=false
  fi
  if [ ${#stderrNotContains[@]} -gt 0 ]; then
    __assertFileContainsHelper "$handler" false "$__profile" --line "$lineNumber" --display "$stderrTitle" "$errorFile" -- "${stderrNotContains[@]}" || testPassed=false
  fi
  if [ ${#outputContains[@]} -gt 0 ]; then
    __assertFileContainsHelper "$handler" true "$__profile" --line "$lineNumber" --display "$stdoutTitle" "$outputFile" -- "${outputContains[@]}" || testPassed=false
  fi
  if [ ${#outputNotContains[@]} -gt 0 ]; then
    __assertFileContainsHelper "$handler" false "$__profile" --line "$lineNumber" --display "$stdoutTitle" "$outputFile" -- "${outputNotContains[@]}" || testPassed=false
  fi

  __profileLabel="output-processing 0:(${#outputContains[@]},!${#outputNotContains[@]}) 1:(${#stderrContains[@]},!${#stderrNotContains[@]})"
  # IDENTICAL profileFunctionMarker 3
  # ********************************************************************************************************************
  if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
  # ********************************************************************************************************************

  if $testPassed; then
    _assertSuccess "$functionName" "$displayName $message" || exitCode=$?
    exitCode=0
  else
    _assertFailure "$functionName" "$displayName $message" || exitCode=$?
    [ "$exitCode" != "0" ] || exitCode=$(returnCode assert)
  fi
  __profileLabel="assert-status"
  # IDENTICAL profileFunctionMarker 3
  # ********************************************************************************************************************
  if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
  # ********************************************************************************************************************

  if ! $testPassed || $dumpFlag; then
    if $dumpBinaryFlag; then
      dumpBinary "$stdoutTitle" <"$outputFile" || :
      dumpBinary "$stderrTitle" <"$errorFile" || :
    else
      dumpPipe "--$whichEnd" "$stdoutTitle" <"$outputFile" || :
      dumpPipe "--$whichEnd" "$stderrTitle" <"$errorFile" || :
    fi
  fi
  catchEnvironment "$handler" rm -f "${clean[@]}" || return $?

  __profileLabel="cleanup -> return $exitCode"
  # IDENTICAL profileFunctionTail 7
  # ********************************************************************************************************************
  if [ "$__profile" != "false" ]; then
    __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2
    printf -- "Line %d: %s%d %s (%d + %d) %s + %s %d%%\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile0))" '*TOTAL*' "$((__profileNext - __profile0 - __profileUsed))" "$__profileUsed" 'us' 'them' "$(((100 * __profileUsed) / (__profileNext - __profile0)))" 1>&2
  fi
  # ********************************************************************************************************************

  return "$exitCode"
}

# Argument: thisName - Reported function for success or failure
# Argument: fileName - File to search
# Argument: -- - Delimiter. Required. Separate arguments from match strings.
# Argument: string0 ... - String. One or more strings which must NOT be found anywhere in `fileName`
# Return Code: 1 - If the assertions fails
# Return Code: 0 - If the assertion succeeds
# Environment: If the file does not exist, this will fail.
# Example:     assertFileDoesNotContain "$logFile" error Error ERROR
# Example:     assertFileDoesNotContain "$logFile" warning Warning WARNING
#
__assertFileContainsHelper() {
  local __aa=("$@")
  local handler="$1" && shift
  local success="$1" && shift
  local __profileLabel="none" __profile="$1" && shift
  local lineNumber="" file="" displayName="" lineDepth="" debugLines=false

  # _IDENTICAL_ argumentBlankLoopHandler 4
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --display) shift && displayName="$(validate "$handler" String "$argument" "${1-}")" || return $? ;;
    --line) shift && lineNumber="${1-}" ;;
    --line-depth) shift && lineDepth="$(validate "$handler" PositiveInteger "$argument" "${1-}")" || return $? ;;
    --debug-lines) debugLines=true ;;
    --)
      [ -n "$file" ] || throwArgument "$handler" "No file before --" || return $?
      shift && break
      ;;
    *)
      if [ -z "$file" ]; then
        file=$(validate "$handler" File file "$argument") || return $?
      else
        break
      fi
      ;;
    esac
    shift
  done
  [ -n "$file" ] || throwArgument "$handler" "file is required" || return $?

  local matches=() quoted=() && while [ $# -gt 0 ]; do
    local match && match="$(validate "$handler" String "match" "$1")" || return $?
    matches+=("$match")
    quoted+=("$(catchReturn "$handler" quoteGrepPattern "$match")") || return $?
    shift
  done
  [ 0 -lt "${#matches[@]}" ] || throwArgument "$handler" "Requires at least one match" || return $?

  # IDENTICAL lineDepthComputation 11
  local linePrefix=""
  if [ -n "$lineDepth" ]; then
    local computeLine="${BASH_LINENO[lineDepth]}"
    if [ -z "$lineNumber" ]; then
      lineNumber="$computeLine"
    elif [ "$lineNumber" != "$computeLine" ] && $debugLines; then
      displayName="${displayName} (Computed line [$computeLine] != passed line [$lineNumber])"
    fi
  fi
  [ -z "$lineNumber" ] || linePrefix="Line $lineNumber: "
  # -- end IDENTICAL lineDepthComputation

  local functionName="${handler#_}"
  displayName="${displayName:-"$file"}"

  __profileLabel="__assertFileContainsHelper head" || return $? # assertion check fails without the || return $? here
  # IDENTICAL profileFunctionMarker 3
  # ********************************************************************************************************************
  if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
  # ********************************************************************************************************************

  local successes=() failures=() verb notVerb failWhy && if $success; then
    IFS="|" read -r verb notVerb failWhy <<<"contains|does not contain|but should"
    local index=0 match && for match in "${quoted[@]}"; do
      if ! grep -q -e "$match" "$file"; then
        failures+=("${matches[index]}")
      else
        successes+=("${matches[index]}")
      fi
      index=$((index + 1))
    done
    __profileLabel="grep (find) x ${#matches[@]} $file"
  else
    IFS="|" read -r verb notVerb failWhy <<<"does not contain|contains|and should not"
    if grep -q -e "\($(listJoin "\|" "${quoted[@]}")\)" "$file"; then
      local index=0 match && for match in "${quoted[@]}"; do
        if grep -q -e "$match" "$file"; then
          failures+=("${matches[index]}")
        fi
        index=$((index + 1))
      done
    else
      successes+=("${matches[@]}")
    fi
    __profileLabel="grep (not found) x ${#matches[@]} $file"
  fi

  if [ "${#failures[@]}" -gt 0 ]; then
    local message
    message="$(printf -- "%s %s %s\n%s" "$linePrefix$displayName" "$notVerb $(plural "${#failures[@]}" string):" "$failWhy: $(decorate each code "${failures[@]}")" "$(dumpPipe --tail "$displayName" <"$file")")"
    __profileLabel="$__profileLabel failed"
    # IDENTICAL profileFunctionMarker 3
    # ********************************************************************************************************************
    if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
    # ********************************************************************************************************************
    _assertFailure "$functionName" "$message" || return $?
    returnAssert
  fi
  __profileLabel="$__profileLabel success"
  _assertSuccess "$functionName" "$linePrefix$displayName $verb $(plural "${#successes[@]}" string): \"$(decorate each code "${successes[@]}")\"" || return $?
}

# Generic formatter
# Argument: testPassed
# Argument: arguments
__assertResultFormatter() {
  local testPassed="${1-}" success="${2-}"

  shift 2
  if "$testPassed"; then
    # shellcheck disable=SC2059
    printf "PASS: %s\n" "$(printf -- " \"$(__resultText "$testPassed" "%s")\"" "$@")"
  else
    # shellcheck disable=SC2059
    printf "FAIL: %s\n" "$(printf -- " \"$(__resultText "$testPassed" "%s")\"" "$@")"
  fi
}

#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
#
# assert equals
#
#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===

_assertEqualsHelper() {
  local handler="$1" && shift
  _assertConditionHelper "$handler" --line-depth 5 --test ___assertIsEqual --formatter ___assertIsEqualFormat "$@" || return $?
}

___assertIsEqual() {
  [ "${1-}" = "${2-}" ]
}

___assertIsEqualFormat() {
  local testPassed="${1-}" success="${2-}" left="${3-}" suffix="" compare right
  shift && shift && shift
  right="$*"
  if $testPassed; then
    if $success; then
      printf "%s %s" "$(decorate green "equals")" "$(__resultTextSizeColor success "$left")"
    else
      printf "%s %s != %s" "$(decorate green "not equals")" "$(__resultTextSizeColor success "$left")" "$(__resultTextSizeColor error "$right")"
    fi
  else
    compare="$(decorate warning "$(booleanChoose "$success" "DOES NOT EQUAL" "EQUALS")")"
    decorate error "Test for $(booleanChoose "$success" "equality" "inequality") failed:"
    printf -- "%s\n%s\n" "$(___printResultPair "Expected" true "$left" "$compare")" "$(___printResultPair "  Actual" "$testPassed" "$right")"
  fi

}

#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
#
# assert is empty
#
#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===

_assertStringEmptyHelper() {
  local handler="$1" && shift
  _assertConditionHelper "$handler" --line-depth 5 --test ___assertIsEmpty --formatter ___assertIsEmptyFormat "$@" || return $?
}

___assertIsEmpty() {
  while [ $# -gt 0 ]; do
    [ -z "${1-}" ] || return 1
    shift
  done
}

___assertIsEmptyFormat() {
  local testPassed="${1-}" success="${2-}"
  shift && shift
  local index=1
  if $testPassed; then
    if $success; then
      decorate green "empty"
    else
      while [ $# -gt 0 ]; do
        if [ -n "${1-}" ]; then
          printf "%s %s (%s)" "$(decorate green "not empty")" "$(__resultTextSizeColor success "$1")" "$(decorate value "#$index")"
        fi
        index=$((index + 1))
        shift
      done
    fi
  else
    local compare verb
    while [ $# -gt 0 ]; do
      if $success && [ -n "${1-}" ]; then
        printf "%s %s (%s)" "$(__resultTextSizeColor success "$1")" "$(decorate red "not empty")" "$(decorate value "#$index")"
      elif ! $success && [ -z "${1-}" ]; then
        printf "%s (%s)" "$(decorate red "empty")" "$(decorate value "#$index")"
      fi
      index=$((index + 1))
      shift
    done
  fi
}

#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
#
# assert numeric
#
#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
_assertNumericHelper() {
  local handler="$1" && shift
  _assertConditionHelper "$handler" --test ___assertNumericTest --formatter ___assertNumericFormat "$@" || return $?
}
___assertNumericTest() {
  local leftValue="${1-}" rightValue="${2-}" cmp
  cmp="${!#}"
  isNumber "$leftValue" || returnArgument "$leftValue is not numeric ($*)" || return $?
  isNumber "$rightValue" || returnArgument "$rightValue is not numeric ($*)" || return $?
  [ "$cmp" != "${cmp#-}" ] || returnArgument "$cmp is not a comparison flag ($*)" || return $?
  test "$leftValue" "$cmp" "$rightValue"
}
___assertNumericFormat() {
  local testPassed="${1-}" success="${2-}"
  shift 2
  local leftValue="$1" rightValue="$2" cmp
  cmp="${!#}"
  shift 2
  printf "[%s %s] %s %s\n" "$(decorate code "$leftValue")" "$(__resultText "$testPassed" "$cmp $rightValue")" "$(booleanChoose "$success" "(true)" "(false)")" "$*"
}

#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
#
# String contains
#
#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
_assertContainsHelper() {
  local handler="$1" && shift
  _assertConditionHelper "$handler" --test ___assertContains --formatter ___assertContainsFormat "$@" || return $?
}
___assertContains() {
  local needle haystack

  needle="${1-}"
  [ -n "$needle" ] || returnArgument "blank needle passed to contains assertion" || return $?
  shift
  while [ $# -gt 0 ]; do
    haystack="${1-}"
    [ -n "$haystack" ] || returnArgument "blank haystack passed to contains assertion" || return $?
    [ "${haystack#*"$needle"}" != "$haystack" ] || return 1
    shift
  done
}
___assertContainsFormat() {
  local testPassed="${1-}" success="${2-}"
  local needle haystack

  shift 2
  needle="$(decorate code "${1-}")" && shift
  haystack=$(__resultTextSize "$testPassed" "$*")
  printf -- "%s %s %s\n" "$needle" "$(booleanChoose "$testPassed" "is contained in" "is not contained in")" "$haystack"
}

#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
#
# Directory exists
#
#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
_assertDirectoryExistsHelper() {
  local handler="$1" && shift
  _assertConditionHelper "$handler" --line-depth 5 --test ___assertDirectoryExists --formatter ___assertDirectoryExistsFormat "$@" || return $?
}
___assertDirectoryExists() {
  while [ $# -gt 0 ]; do
    [ -d "${1-}" ] || return 1
    shift
  done
}
___assertDirectoryExistsFormat() {
  local testPassed="${1-}" success="${2-}"
  shift 2
  printf -- "%s %s" "$(__resultText "$testPassed" "$*")" "$(booleanChoose "$success" "is a directory" "is not a directory")"
}

#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
#
# Directory empty
#
#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
_assertDirectoryEmptyHelper() {
  local handler="$1" && shift
  _assertConditionHelper "$handler" --line-depth 5 --test ___assertDirectoryEmpty --formatter ___assertDirectoryEmptyFormat "$@" || return $?
}
___assertDirectoryEmpty() {
  while [ $# -gt 0 ]; do
    directoryIsEmpty "${1-}" || return 1
    shift
  done
}
___assertDirectoryEmptyFormat() {
  local testPassed="${1-}" success="${2-}"
  shift 2
  printf -- "%s %s" "$(__resultText "$testPassed" "$*")" "$(booleanChoose "$testPassed" "is an empty directory" "is not an empty directory")"
}

#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
#
# File exists
#
#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
_assertFileExistsHelper() {
  local handler="$1" && shift
  _assertConditionHelper "$handler" --line-depth 5 --test ___assertFileExists --formatter ___assertFileExistsFormat "$@" || return $?
}
___assertFileExists() {
  while [ $# -gt 0 ]; do
    [ -f "${1-}" ] || return 1
    shift
  done
}
___assertFileExistsFormat() {
  local testPassed="${1-}" success="${2-}"
  shift 2
  printf -- "%s %s (wd: \"%s\")" "$(__resultText "$testPassed" "$*")" "$(booleanChoose "$testPassed" "is a file" "is not a file")" "$(decorate value "$(pwd)")"
}

#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
#
# File size
#
#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
_assertFileSizeHelper() {
  local handler="$1" && shift
  _assertConditionHelper "$handler" --line-depth 5 --test ___assertFileSize --formatter ___assertFileSizeFormat "$@" || return $?
}
___assertFileSize() {
  local expectedSize="${1-}" actualSize
  shift
  isUnsignedInteger "$expectedSize" || returnArgument "$expectedSize is not an unsigned integer" || return $?
  [ "$expectedSize" -ge 0 ] || returnArgument "$expectedSize is negative" || return $?
  [ $# -gt 0 ] || returnArgument "no file arguments supplied" || return $?
  while [ $# -gt 0 ]; do
    if ! actualSize="$(fileSize "$1")"; then
      returnEnvironment "fileSize \"$(escapeDoubleQuotes "$1")\" failed -> $?" || return $?
    fi
    [ "$expectedSize" = "$actualSize" ] || return 1
    shift
  done

}
___assertFileSizeFormat() {
  local testPassed="${1-}" success="${2-}"
  shift 2
  printf -- "%s %s %s\n" "$(__resultText "$testPassed" "File Size: $1")" "$(booleanChoose "$success" "matches" "does not match")" "$*"
}

#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
#
# Output equals
#
#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
_assertOutputEqualsHelper() {
  local handler="$1" && shift
  _assertConditionHelper "$handler" --line-depth 5 --test ___assertOutputEquals --formatter ___assertOutputEqualsFormat "$@" || return $?
}
___assertOutputEquals() {
  local handler="returnMessage"
  local expected="${1-}" binary="${2-}" output stderr exitCode=0

  shift 2 || :
  stderr=$(fileTemporaryName "$handler") || return $?
  isCallable "$binary" || throwEnvironment "$handler" "$binary is not callable: $*" || return $?
  if output=$(plumber "$binary" "$@" 2>"$stderr"); then
    if [ -s "$stderr" ]; then
      dumpPipe "$(decorate error Produced stderr): $binary" "$@" <"$stderr" 1>&2
      returnClean 1 "$stderr" || return $?
    fi
    [ "$output" = "$expected" ] || exitCode=1
    printf "%s\n" "$output"
  else
    exitCode=$?
    [ "$exitCode" -eq "$(returnCode leak)" ] && ! throwEnvironment "$handler" "Leak:" "$binary" "$!" || throwEnvironment "$handler" "Exit code: $?" "$binary" "$@" || exitCode=$?
  fi
  returnClean "$exitCode" "$stderr" || return $?
}
___assertOutputEqualsFormat() {
  local testPassed="${1-}" success="${2-}" verb expected="$3" binary="$4"
  shift 4 || :

  message="$(decorate code "$binary")$(printf " \"%s\"" "$@")"
  verb=$(booleanChoose "$success" "matches" "does not match")
  printf -- "%s %s %s %s" "$message" "$(decorate code "$(cat)")" "$(__resultText "$testPassed" "$verb")" "$(__resultTextSize "$testPassed" "$expected")"
}

#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
#
# Exit Code
#
#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===#
# Assert a process runs and exits with the correct exit code.
#
# If this fails it will output an error and exit.
#
# Argument: handler - Function. Required. Error handler.
# Argument: expectedExitCode - A numeric exit code expected from the command
# Argument: command - The command to run
# Argument: arguments - Any arguments to pass to the command to run
# Argument: --debug - Flag. Optional. Debugging
# Environment: None.
# Examples: assertExitCode 0 hasHook version-current
# Reviewed: 2023-11-12
# Return Code: 0 - If the process exits with the provided exit code
# Return Code: 1 - If the process exits with a different exit code
#
_assertExitCodeHelper() {
  local handler="$1" && shift
  _assertConditionHelper "$handler" --line-depth 5 --code1 --test ___assertExitCodeTest --formatter ___assertExitCodeFormat "$@" || return $?
}
___assertExitCodeTest() {
  local binary="${1-}"
  isCallable "$binary" || returnArgument "$binary is not callable: $*" || return $?
  ! isFunction "$binary" || __assertedFunctions "$binary" || :
  "$@" || return $?
}
___assertExitCodeFormat() {
  local testPassed="${1-}" color="code" success="${2-}" nope="☹️" yep="☑️"
  shift 2
  $testPassed || color="red"
  $testPassed && testPassed=$yep || testPassed=$nope
  # shellcheck disable=SC2059
  printf "%s-> %s" "$(decorate "$color" "$(printf -- "\"%s\" " "$@")")" "$testPassed"
}

#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
#
# Output contains
#
#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===#
#
# Run a command and expect the output to contain the occurrence of a string.
#
# If this fails it will output the command result to stdout.
#
# Argument: expected - A string to expect in the output
# Argument: command - The command to run
# Argument: arguments - Any arguments to pass to the command to run
# Argument: - `--exit` - Assert exit status of process to be this number
# Argument: - `--stderr` - Also include standard error in output checking
# Return Code: 0 - If the output contains at least one occurrence of the string
# Return Code: 1 - If output does not contain string
# Example:     {fn} Success complex-thing.sh --dry-run
# Reviewed: 2023-11-12
#
_assertOutputContainsHelper() {
  local handler="$1" && shift
  _assertConditionHelper "$handler" --line-depth 5 --test ___assertOutputContainsTest --formatter ___assertOutputContainsFormat "$@" || return $?
}
___assertOutputContainsTest() {
  local handler="returnMessage"
  local contains="${1-}" binary="${2-}" captureOut exitCode
  shift 1
  [ -n "$contains" ] || throwArgument "$handler" "contains is blank: $*" || return $?
  isCallable "$binary" || throwArgument "$handler" "$binary is not callable: $*" || return $?
  captureOut=$(fileTemporaryName "$handler") || return $?
  exitCode=1
  ! isFunction "$binary" || __assertedFunctions "$binary" || :
  if "$@" >"$captureOut"; then
    if grep -q -e "$(quoteGrepPattern "$contains")" <"$captureOut"; then
      exitCode=0
    fi
    cat "$captureOut"
  else
    cat "$captureOut"
    returnMessage "$?" "$@" "FAILED" || exitCode=$?
  fi
  rm -rf "$captureOut" || :
  return "$exitCode"
}
___assertOutputContainsFormat() {
  local testPassed="${1-}" success="${2-}"
  local contains="${3-}" binary="${4-}" verb
  shift 3
  # shellcheck disable=SC2059
  command="$(printf "\"$(decorate code %s)\" " "$@")"
  verb=$(booleanChoose "$success" "contains" "does not contain")
  printf "%s => %s \"%s\" %s" "${command% }" "$(decorate value "$verb")" "$contains" "$(__resultText "$testPassed" "$(booleanChoose "$testPassed" "correctly" "incorrectly")")"
}
