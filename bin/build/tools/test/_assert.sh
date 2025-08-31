#!/usr/bin/env bash
#
# assertHelpers.sh
#
# Assert utilities
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: contextOpen ./documentation/source/tools/assert.md
# Test: contextOpen ./test/tools/assert-tests.sh

# Format test text, special display for blank strings
__resultText() {
  local passed="$1" text length max=80 color && shift

  text="$*"
  length="${#text}"

  # Hide newlines
  if stringContains "$text" $'\e'; then
    text="$(dumpHex --size "$max" "$text")"
  else
    text=$(newlineHide "$text")
  fi
  local half=$((max / 2))
  [ "$length" -lt "$max" ] || text="${text:0:$half} ... ${text:$((length - half)):$((length - 1))}"
  if [ "$length" -eq 0 ]; then
    text="(blank)"
    if $passed; then
      color="blue"
    else
      color="bold-red"
    fi
  elif $passed; then
    color="code"
  else
    color="error"
  fi
  decorate "$color" "$text"
}

# Format test text, special display for blank strings
__resultTextSize() {
  local passed="$1" text length && shift

  text="$*"
  length="${#text}"

  printf -- "%s %s\n" "$(__resultText "$passed" "$text")" "$(decorate subtle "$(alignRight 9 "$length $(plural "$length" char chars)")")"
}

___printResultPair() {
  local label="$1" resultStatus="$2" result="$3" suffix="${4-}"
  [ -z "$suffix" ] || suffix=" ${suffix# }"
  printf -- "%s: %s%s\n" "$label" "$(__resultTextSize "$resultStatus" "$result")" "$suffix"
}

# Save and report the timing since the last call
_assertTiming() {
  local timingFile

  export __BUILD_SAVED_CACHE_DIRECTORY

  if [ -z "${__BUILD_SAVED_CACHE_DIRECTORY-}" ]; then
    __BUILD_SAVED_CACHE_DIRECTORY="$(__environment buildCacheDirectory)" || return $?
  fi

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
  timingStart 1>&2 >"$timingFile" && sync -f 1>&2 >>"$timingFile" || printf -- "%s\n" "$? error from timingStart/sync" >>"$timingFile" || :
}

__assertedFunctions() {
  local handler="_${FUNCNAME[0]}"
  local logFile

  logFile="$(__catch "$handler" buildCacheDirectory)/$handler" || return $?
  logFile="$(__catch "$handler" fileDirectoryRequire "$logFile")" || return $?
  if [ $# -eq 0 ]; then
    __catchEnvironment "$handler" touch "$logFile" || return $?
    if [ -f "$logFile.dirty" ]; then
      __catchEnvironment "$handler" sort -u "$logFile" -o "$logFile" || return $?
      __catchEnvironment "$handler" rm -f "$logFile.dirty" || return $?
    fi
    printf -- "%s\n" "$logFile"
    return 0
  fi
  local track
  track=$(__catch "$handler" buildEnvironmentGet TEST_TRACK_ASSERTIONS) || return $?
  if [ "$track" != "false" ]; then
    __catchEnvironment "$handler" printf -- "%s\n" "$@" >>"$logFile" || return $?
    __catchEnvironment "$handler" touch "$logFile.dirty" || return $?
  fi
}
___assertedFunctions() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Decorations
#
_symbolSuccess() {
  printf %s "✅ "
}
_symbolFail() {
  printf %s "❌ "
}
_assertFailure() {
  local function="${1-None}" ll=() message newline=$'\n'
  incrementor assert-failure >/dev/null
  shift || :
  message="$*"
  if [ "${message#*"$newline"}" != "$message" ]; then
    ll=(--last)
  fi
  statusMessage "${ll[@]+"${ll[@]}"}" printf -- "%s %s %s [%s] " "$(_symbolFail)" "$(decorate error "$function")" "$message" "$(_assertTiming)" 1>&2 || return $?
  return "$(returnCode assert)"
}
_assertSuccess() {
  local function="${1-None}"
  incrementor assert-success >/dev/null
  shift || :
  statusMessage printf -- "%s %s %s [%s] " "$(_symbolSuccess)" "$(decorate success "$function")" "$*" "$(_assertTiming)" || return $?
}

# Core condition assertion handler
# DOC TEMPLATE: assert-common 18
# Argument: --help - Optional. Flag. Display this help.
# Argument: --line lineNumber - Optional. Integer. Line number of calling function.
# Argument: --line-depth depth - Optional. Integer. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Optional. Flag. Debugging enabled for the assertion function.
# Argument: --debug-lines - Optional. Flag. Debugging of SOLELY differences between --line passed in and the computed line from the --line-depth parameter.
# Argument: --display - Optional. String. Display name for the condition.
# Argument: --success - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
# Argument: --stderr-match - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
# Argument: --stdout-no-match - Optional. String. One or more strings which must match stderr.
# Argument: --stdout-match - Optional. String. One or more strings which must match stdout.
# Argument: --stdout-no-match - Optional. String. One or more strings which must match stdout.
# Argument: --stderr-ok - Optional. Flag. Output to stderr will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Optional. Flag. Skip plumber check for function calls.
# Argument: --dump - Optional. Flag. Output stderr and stdout after test regardless.
# Argument: --dump-binary - Optional. Flag. Output stderr and stdout after test regardless, and output binary.
# Argument: --head - Optional. Flag. When outputting stderr or stdout, output the head of the file.
# Argument: --tail - Optional. Flag. When outputting stderr or stdout, output the tail of the file. (Default)
# Exit code: 1 - If the assertions fails
# Exit code: 0 - If the assertion succeeds
_assertConditionHelper() {
  local handler="$1" && shift
  local pairs=() debugFlag=false
  local success=true file="" lineDepth="" lineNumber="" displayName="" tester="" formatter="__resultFormatter"
  local outputContains=() outputNotContains=() stderrContains=() stderrNotContains=()
  local doPlumber="" leaks=() whichEnd="tail"
  local errorsOk=false dumpFlag=false dumpBinaryFlag=false expectedExitCode=0 code1=false debugLines=false
  local message result testPassed runner exitCode outputFile errorFile stderrTitle stdoutTitle

  set -eou pipefail
  # _IDENTICAL_ argumentBlankLoopHandler 4
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --exit)
      shift
      expectedExitCode=$(usageArgumentUnsignedInteger "$handler" "$argument" "${1-}") || return $?
      pairs+=("Exit" "$(decorate bold-magenta " $expectedExitCode ")")
      ;;
    --display)
      shift
      displayName="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      ;;
    --success)
      shift
      success="$(usageArgumentBoolean "$handler" "$argument" "${1-}")" || return $?
      pairs+=("should" "$(_choose "$success" "succeed" "$(decorate warning "fail")")")
      ;;
    --debug)
      debugFlag=true
      ;;
    --line)
      shift
      lineNumber="${1-}"
      ;;
    --line-depth)
      shift
      lineDepth="$(usageArgumentPositiveInteger "$handler" "$argument" "${1-}")" || return $?
      ;;
    --test)
      shift
      tester="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      ;;
    --formatter)
      shift
      formatter="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      ;;
    --stderr-ok)
      errorsOk=true
      ;;
    --stderr-match)
      shift || :
      [ -n "${1-}" ] || __throwArgument "$handler" "Blank $argument argument" || return $?
      stderrContains+=("$1")
      errorsOk=true
      ;;
    --stderr-no-match)
      shift || :
      [ -n "${1-}" ] || __throwArgument "$handler" "Blank $argument argument" || return $?
      stderrNotContains+=("$1")
      errorsOk=true
      ;;
    --stdout-match)
      shift || :
      [ -n "${1-}" ] || __throwArgument "$handler" "Blank $argument argument" || return $?
      outputContains+=("$1")
      ;;
    --stdout-no-match)
      shift || :
      [ -n "${1-}" ] || __throwArgument "$handler" "Blank $argument argument" || return $?
      outputNotContains+=("$1")
      ;;
    --dump)
      dumpFlag=true
      dumpBinaryFlag=false
      ;;
    --dump-binary)
      dumpBinaryFlag=true
      dumpFlag=true
      ;;
    --plumber)
      doPlumber=true
      ;;
    --head)
      whichEnd="head"
      ;;
    --tail)
      whichEnd="tail"
      ;;
    --skip-plumber)
      doPlumber=false
      leaks=()
      ;;
    --leak)
      shift
      doPlumber=true
      leaks+=(--leak "$(usageArgumentString "$handler" "$argument globalName" "${1-}")") || return $?
      ;;
    --debug-lines)
      debugLines=true
      ;;
    --code1)
      code1=true
      ;;
    *)
      break
      ;;
    esac
    shift
  done

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
  [ -z "$lineNumber" ] || linePrefix="$(decorate bold-magenta "Line $lineNumber: ")"
  # -- end IDENTICAL lineDepthComputation

  if [ -z "$doPlumber" ]; then
    flags=$(__catch "$handler" buildEnvironmentGet BUILD_TEST_FLAGS) || return $?
    doPlumber=false
    ! isSubstringInsensitive ";Plumber:true;" ";$flags;" || doPlumber=true
  fi
  [ -n "$tester" ] || __throwArgument "$handler" "--test required ($*)" || return $?

  outputFile=$(fileTemporaryName "$handler") || return $?
  errorFile="$outputFile.err"

  if $code1; then
    [ "$expectedExitCode" -eq 0 ] || __catchArgument "$handler" "--exit and --code1 and mutually exclusive for non-zero --exit" || return $?
    expectedExitCode="$(usageArgumentUnsignedInteger "$handler" "exitCode" "${1-}")" || return $?
    shift
  fi
  if $doPlumber; then
    runner=(plumber "${leaks[@]+"${leaks[@]}"}" "$tester")
  else
    runner=("$tester")
  fi
  buildDebugStart "assert"
  if $debugFlag; then
    __buildDebugEnable v
  fi
  exitCode=0
  local clean=("$outputFile" "$errorFile")
  "${runner[@]}" "$@" >"$outputFile" 2>"$errorFile" || exitCode=$?

  if $debugFlag; then
    __buildDebugDisable v
  fi
  if [ "$exitCode" = "$expectedExitCode" ]; then
    testPassed=$success
  else
    testPassed=$(_choose "$success" false true)
  fi
  result="$("$formatter" "$testPassed" "$success" "$@" <"$outputFile")"
  # shellcheck disable=SC2059
  message="$(printf "$(decorate label %s) %s, " "${pairs[@]+"${pairs[@]}"}")"
  message="${message%, }"
  message="$(printf -- "%s ➡️ %s -> %s\n" "$linePrefix" "$message" "$result")"
  if $code1 || [ "$expectedExitCode" -ne 0 ]; then
    message="$message -> $exitCode ($(_choose "$success" "=" "!=") expected $expectedExitCode), $(__resultText "$testPassed" "$(_choose "$testPassed" correct incorrect)")"
  fi
  local functionName="${handler#_}"
  if ! "$errorsOk" && [ -s "$errorFile" ]; then
    message="$(printf -- "%s - %s\n%s\n" "$message" "$(decorate error "produced stderr")" "$(dumpPipe --tail stderr <"$errorFile")")"
    _assertFailure "$functionName" "$displayName $message" || return $?
  fi
  if $errorsOk && [ ! -s "$errorFile" ]; then
    statusMessage --last printf "%s – %s" "$message" "$(decorate warning "--stderr-ok used but is NOT necessary")"
  fi
  stderrTitle="$functionName $(decorate bold-red stderr)"
  stdoutTitle="$functionName $(decorate label stdout)"
  if [ ${#stderrContains[@]} -gt 0 ]; then
    __assertFileContainsThis "$handler" --line "$lineNumber" --display "$stderrTitle" "$errorFile" "${stderrContains[@]}" || testPassed=false
  fi
  if [ ${#stderrNotContains[@]} -gt 0 ]; then
    __assertFileDoesNotContainThis "$handler" --line "$lineNumber" --display "$stderrTitle" "$errorFile" "${stderrNotContains[@]}" || testPassed=false
  fi
  if [ ${#outputContains[@]} -gt 0 ]; then
    __assertFileContainsThis "$handler" --line "$lineNumber" --display "$stdoutTitle" "$outputFile" "${outputContains[@]}" || testPassed=false
  fi
  if [ ${#outputNotContains[@]} -gt 0 ]; then
    __assertFileDoesNotContainThis "$handler" --line "$lineNumber" --display "$stdoutTitle" "$outputFile" "${outputNotContains[@]}" || testPassed=false
  fi
  if $testPassed; then
    _assertSuccess "$functionName" "$displayName $message" || exitCode=$?
    exitCode=0
  else
    _assertFailure "$functionName" "$displayName $message" || exitCode=$?
  fi
  if ! $testPassed || $dumpFlag; then
    if $dumpBinaryFlag; then
      dumpBinary "$stdoutTitle" <"$outputFile" || :
      dumpBinary "$stderrTitle" <"$errorFile" || :
    else
      dumpPipe "--$whichEnd" "$stdoutTitle" <"$outputFile" || :
      dumpPipe "--$whichEnd" "$stderrTitle" <"$errorFile" || :
    fi
  fi
  __catchEnvironment "$handler" rm -f "${clean[@]}" || return $?
  return $exitCode
}

# Usage: {fn} success thisName fileName string0 [ ... ]
#
# Argument: thisName - Reported function for success or failure
# Argument: fileName - File to search
# Argument: string0 ... - One or more strings which must NOT be found anywhere in `fileName`
# Exit code: 1 - If the assertions fails
# Exit code: 0 - If the assertion succeeds
# Environment: If the file does not exist, this will fail.
# Example:     assertFileDoesNotContain "$logFile" error Error ERROR
# Example:     assertFileDoesNotContain "$logFile" warning Warning WARNING
#
__assertFileContainsHelper() {
  local success="$1"
  local handler="$2"
  local argument
  local lineNumber="" file="" displayName="" lineDepth="" debugLines=false

  shift 2

  # _IDENTICAL_ argumentBlankLoopHandler 4
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --display)
      shift
      displayName="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      ;;
    --line)
      shift
      lineNumber="${1-}"
      ;;
    --line-depth)
      shift
      lineDepth="$(usageArgumentPositiveInteger "$handler" "$argument" "${1-}")" || return $?
      ;;
    --debug-lines)
      debugLines=true
      ;;
    *)
      if [ -z "$file" ]; then
        file="$argument"
      else
        break
      fi
      ;;
    esac
    shift
  done

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
  [ -z "$lineNumber" ] || linePrefix="$(decorate bold-magenta "Line $lineNumber: ")"
  # -- end IDENTICAL lineDepthComputation

  local functionName="${handler#_}"
  displayName="${displayName:-"$file"}"
  [ -f "$file" ] || _assertFailure "$functionName" "$displayName is not a file \"$file\": $*" || return $?

  local args verb notVerb

  verb=$(_choose "$success" "contains" "does not contain") || return $?
  notVerb=$(_choose "$success" "does not contain" "contains") || return $?
  args=("$@")

  while [ $# -gt 0 ]; do
    local expected="$1" found
    [ -n "$expected" ] || _assertFailure "$functionName" "Blank match passed: ${args[*]}" || return $?
    if grep -q -e "$(quoteGrepPattern "$expected")" "$file"; then
      found=true
    else
      found=false
    fi
    if [ "$found" = "$success" ]; then
      # shellcheck disable=SC2059
      _assertSuccess "$functionName" "$linePrefix$displayName $verb string: \"$(decorate code "$expected")\"" || return $?
    else
      local message
      message="$(printf -- "%s %s %s\n%s" "$linePrefix$displayName" "$notVerb string:" "$(decorate code "$expected")" "$(dumpPipe --tail "$displayName" <"$file")")"
      _assertFailure "$functionName" "$message" || return $?
    fi
    shift
  done
}

# Generic formatter
# Usage: {fn} testPassed arguments
__resultFormatter() {
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
  _assertConditionHelper "$handler" --line-depth 2 --test ___assertIsEqual --formatter ___assertIsEqualFormat "$@" || return $?
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
      printf "%s %s" "$(decorate green "equals")" "$(__resultTextSize true "$left")"
    else
      printf "%s %s != %s" "$(decorate green "not equals")" "$(__resultTextSize true "$left")" "$(__resultTextSize false "$right")"
    fi
  else
    compare="$(decorate warning "$(_choose "$success" "DOES NOT EQUAL" "EQUALS")")"
    decorate error "Test for $(_choose "$success" "equality" "inequality") failed:"
    printf -- "%s\n%s\n" "$(___printResultPair "Expected" true "$left" "$compare")" "$(___printResultPair "  Actual" "$testPassed" "$right")"
  fi

}

#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
#
# assert equals
#
#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===

_assertStringEmptyHelper() {
  local handler="$1" && shift
  _assertConditionHelper "$handler" --line-depth 2 --test ___assertIsEmpty --formatter ___assertIsEmptyFormat "$@" || return $?
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
  if $testPassed; then
    if $success; then
      decorate green "empty"
    else
      local index=1
      while [ $# -gt 0 ]; do
        if [ -n "${1-}" ]; then
          printf "%s %s (%s)" "$(decorate green "not empty")" "$(__resultTextSize true "$1")" "$(decorate value "#$index")"
        fi
        index=$((index + 1))
        shift
      done
    fi
  else
    local compare verb
    while [ $# -gt 0 ]; do
      if $success && [ -n "${1-}" ]; then
        printf "%s %s (%s)" "$(__resultTextSize true "$1")" "$(decorate red "not empty")" "$(decorate value "#$index")"
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
# Usage: {fn} function ... leftValue rightValue message ... comparison
_assertNumericHelper() {
  local handler="$1" && shift
  _assertConditionHelper "$handler" --test ___assertNumericTest --formatter ___assertNumericFormat "$@" || return $?
}
___assertNumericTest() {
  local leftValue="${1-}" rightValue="${2-}" cmp
  cmp="${!#}"
  isNumber "$leftValue" || _argument "$leftValue is not numeric ($*)" || return $?
  isNumber "$rightValue" || _argument "$rightValue is not numeric ($*)" || return $?
  [ "$cmp" != "${cmp#-}" ] || _argument "$cmp is not a comparison flag ($*)" || return $?
  test "$leftValue" "$cmp" "$rightValue"
}
___assertNumericFormat() {
  local testPassed="${1-}" success="${2-}"
  shift 2
  local leftValue="$1" rightValue="$2" cmp
  cmp="${!#}"
  shift 2
  printf "[%s %s] %s %s\n" "$(decorate code "$leftValue")" "$(__resultText "$testPassed" "$cmp $rightValue")" "$(_choose "$success" "(true)" "(false)")" "$*"
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
  [ -n "$needle" ] || _argument "blank needle passed to contains assertion" || return $?
  shift
  while [ $# -gt 0 ]; do
    haystack="${1-}"
    [ -n "$haystack" ] || _argument "blank haystack passed to contains assertion" || return $?
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
  printf -- "%s %s %s\n" "$needle" "$(_choose "$testPassed" "is contained in" "is not contained in")" "$haystack"
}

#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
#
# Directory exists
#
#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
_assertDirectoryExistsHelper() {
  local handler="$1" && shift
  _assertConditionHelper "$handler" --line-depth 2 --test ___assertDirectoryExists --formatter ___assertDirectoryExistsFormat "$@" || return $?
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
  printf -- "%s %s" "$(__resultText "$testPassed" "$*")" "$(_choose "$success" "is a directory" "is not a directory")"
}

#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
#
# Directory empty
#
#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
_assertDirectoryEmptyHelper() {
  local handler="$1" && shift
  _assertConditionHelper "$handler" --line-depth 2 --test ___assertDirectoryEmpty --formatter ___assertDirectoryEmptyFormat "$@" || return $?
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
  printf -- "%s %s" "$(__resultText "$testPassed" "$*")" "$(_choose "$testPassed" "is an empty directory" "is not an empty directory")"
}

#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
#
# File exists
#
#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
_assertFileExistsHelper() {
  local handler="$1" && shift
  _assertConditionHelper "$handler" --line-depth 2 --test ___assertFileExists --formatter ___assertFileExistsFormat "$@" || return $?
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
  printf -- "%s %s wd: \"%s" "$(__resultText "$testPassed" "$*")" "$(_choose "$testPassed" "is a file" "is not a file")" "$(decorate value "$(pwd)")"
}

#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
#
# File size
#
#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
_assertFileSizeHelper() {
  local handler="$1" && shift
  _assertConditionHelper "$handler" --line-depth 2 --test ___assertFileSize --formatter ___assertFileSizeFormat "$@" || return $?
}
___assertFileSize() {
  local expectedSize="${1-}" actualSize
  shift
  isUnsignedInteger "$expectedSize" || _argument "$expectedSize is not an unsigned integer" || return $?
  [ "$expectedSize" -ge 0 ] || _argument "$expectedSize is negative" || return $?
  [ $# -gt 0 ] || _argument "no file arguments supplied" || return $?
  while [ $# -gt 0 ]; do
    if ! actualSize="$(fileSize "$1")"; then
      _environment "fileSize \"$(escapeDoubleQuotes "$1")\" failed -> $?" || return $?
    fi
    [ "$expectedSize" = "$actualSize" ] || return 1
    shift
  done

}
___assertFileSizeFormat() {
  local testPassed="${1-}" success="${2-}"
  shift 2
  printf -- "%s %s %s\n" "$(__resultText "$testPassed" "File Size: $1")" "$(_choose "$success" "matches" "does not match")" "$*"
}

#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
#
# Output equals
#
#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
_assertOutputEqualsHelper() {
  local handler="$1" && shift
  _assertConditionHelper "$handler" --line-depth 2 --test ___assertOutputEquals --formatter ___assertOutputEqualsFormat "$@" || return $?
}
___assertOutputEquals() {
  local handler="_return"
  local expected="${1-}" binary="${2-}" output stderr exitCode=0

  shift 2 || :
  stderr=$(fileTemporaryName "$handler") || return $?
  isCallable "$binary" || __throwEnvironment "$handler" "$binary is not callable: $*" || return $?
  if output=$(plumber "$binary" "$@" 2>"$stderr"); then
    if [ -s "$stderr" ]; then
      dumpPipe "$(decorate error Produced stderr): $binary" "$@" <"$stderr" 1>&2
      returnClean 1 "$stderr" || return $?
    fi
    [ "$output" = "$expected" ] || exitCode=1
    printf "%s\n" "$output"
  else
    exitCode=$?
    [ "$exitCode" -eq "$(returnCode leak)" ] && ! __throwEnvironment "$handler" "Leak:" "$binary" "$!" || __throwEnvironment "$handler" "Exit code: $?" "$binary" "$@" || exitCode=$?
  fi
  returnClean "$exitCode" "$stderr" || return $?
}
___assertOutputEqualsFormat() {
  local testPassed="${1-}" success="${2-}" verb expected="$3" binary="$4"
  shift 4 || :

  message="$(decorate code "$binary")$(printf " \"%s\"" "$@")"
  verb=$(_choose "$success" "matches" "does not match")
  printf -- "%s %s %s %s" "$message" "$(decorate code "$(cat)")" "$(__resultText "$testPassed" "$verb")" "$(__resultTextSize "$testPassed" "$expected")"
}

# Usage: {fn} thisName arguments
__assertFileContainsThis() {
  __assertFileContainsHelper true "$@" || return $?
}

# Usage: {fn} thisName arguments
__assertFileDoesNotContainThis() {
  __assertFileContainsHelper false "$@" || return $?
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
# Usage: {fn} handler expectedExitCode command [ arguments ... ]
#
# Argument: expectedExitCode - A numeric exit code expected from the command
# Argument: command - The command to run
# Argument: arguments - Any arguments to pass to the command to run
# Argument: --debug - Optional. Flag. Debugging
# Local cache: None.
# Environment: None.
# Examples: assertExitCode 0 hasHook version-current
# Reviewed: 2023-11-12
# Exit code: 0 - If the process exits with the provided exit code
# Exit code: 1 - If the process exits with a different exit code
#
_assertExitCodeHelper() {
  local handler="$1" && shift
  _assertConditionHelper "$handler" --line-depth 2 --code1 --test ___assertExitCodeTest --formatter ___assertExitCodeFormat "$@" || return $?
}
___assertExitCodeTest() {
  local binary="${1-}"

  isCallable "$binary" || _argument "$binary is not callable: $*" || return $?
  ! isFunction "$binary" || __assertedFunctions "$binary" || return $?
  "$@"
}
___assertExitCodeFormat() {
  local testPassed="${1-}" success="${2-}"
  shift 2
  # shellcheck disable=SC2059
  command="$(printf "\"$(decorate code %s)\" " "$@")"
  printf "%s => %s" "${command% }" "$(__resultText "$testPassed" "$(_choose "$testPassed" "correctly" "incorrectly")")"
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
# Usage: {fn} expected command [ arguments ... ]
# Argument: expected - A string to expect in the output
# Argument: command - The command to run
# Argument: arguments - Any arguments to pass to the command to run
# Argument: - `--exit` - Assert exit status of process to be this number
# Argument: - `--stderr` - Also include standard error in output checking
# Exit code: 0 - If the output contains at least one occurrence of the string
# Exit code: 1 - If output does not contain string
# Example:     {fn} Success complex-thing.sh --dry-run
# Reviewed: 2023-11-12
#
_assertOutputContainsHelper() {
  local handler="$1" && shift
  _assertConditionHelper "$handler" --line-depth 2 --test ___assertOutputContainsTest --formatter ___assertOutputContainsFormat "$@" || return $?
}
___assertOutputContainsTest() {
  local handler="_return"
  local contains="${1-}" binary="${2-}" captureOut exitCode
  shift 1
  [ -n "$contains" ] || __throwArgument "$handler" "contains is blank: $*" || return $?
  isCallable "$binary" || __throwArgument "$handler" "$binary is not callable: $*" || return $?
  captureOut=$(fileTemporaryName "$handler") || return $?
  exitCode=1
  ! isFunction "$binary" || __assertedFunctions "$binary" || return $?
  if "$@" >"$captureOut"; then
    if grep -q -e "$(quoteGrepPattern "$contains")" <"$captureOut"; then
      exitCode=0
    fi
    cat "$captureOut"
  else
    cat "$captureOut"
    _return "$?" "$@" "FAILED" || exitCode=$?
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
  verb=$(_choose "$success" "contains" "does not contain")
  printf "%s => %s \"%s\" %s" "${command% }" "$(decorate value "$verb")" "$contains" "$(__resultText "$testPassed" "$(_choose "$testPassed" "correctly" "incorrectly")")"
}
