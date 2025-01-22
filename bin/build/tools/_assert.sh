#!/usr/bin/env bash
#
# assertHelpers.sh
#
# Assert utilities
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: contextOpen ./docs/_templates/tools/assert.md
# Test: contextOpen ./test/tools/assert-tests.sh

# Format test text, special display for blank strings
__resultText() {
  local passed="$1" text
  shift
  text="$*"
  # Hide newlines
  text=${text//$'\n'/"␤"}
  if "$passed"; then
    # shellcheck disable=SC2015
    [ -z "$text" ] && decorate blue "(blank)" || decorate code "$text"
  else
    # shellcheck disable=SC2015
    [ -z "$text" ] && decorate bold-red "(blank)" || decorate error "$text"
  fi
}

# Save and report the timing since the last call
_assertTiming() {
  local timingFile stamp _now
  timingFile=$(__environment buildCacheDirectory ".${FUNCNAME[0]}") || return $?

  _now="$(date +%s)"
  if [ -f "$timingFile" ]; then
    stamp="$(head -n 1 <"$timingFile")"
    if isUnsignedInteger "$stamp"; then
      stamp=$((_now - stamp))
      decorate value "$(printf -- "%d %s\n" "$stamp" "$(plural "$stamp" second seconds)")"
    else
      decorate error "Timestamp saved was invalid: $stamp"
    fi
  else
    decorate info "First test"
  fi
  printf -- "%d\n" "$_now" >"$timingFile"
}

__assertedFunctions() {
  local usage="_${FUNCNAME[0]}"
  local logFile

  logFile=$(__usageEnvironment "$usage" buildCacheDirectory "$usage") || return $?
  __usageEnvironment "$usage" requireFileDirectory "$logFile" || return $?
  if [ $# -eq 0 ]; then
    __usageEnvironment "$usage" touch "$logFile" || return $?
    if [ -f "$logFile.dirty" ]; then
      __usageEnvironment "$usage" sort -u "$logFile" -o "$logFile" || return $?
      __usageEnvironment "$usage" rm -f "$logFile.dirty" || return $?
    fi
    printf -- "%s\n" "$logFile"
    return 0
  fi
  __usageEnvironment "$usage" printf -- "%s\n" "$@" >>"$logFile" || return $?
  __usageEnvironment "$usage" touch "$logFile.dirty" || return $?
}
___assertedFunctions() {
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
  local function="${1-None}"
  incrementor assert-failure >/dev/null
  shift || :
  statusMessage printf -- "%s: %s %s [%s] " "$(_symbolFail)" "$(decorate error "$function")" "$(decorate info "$@")" "$(_assertTiming)" 1>&2 || return $?
  return "$(_code assert)"
}
_assertSuccess() {
  local function="${1-None}"
  incrementor assert-success >/dev/null
  shift || :
  statusMessage printf -- "%s: %s %s [%s] " "$(_symbolSuccess)" "$(decorate success "$function")" "$(decorate info "$@")" "$(_assertTiming)" || return $?
}

# Core condition assertion handler
# DOC TEMPLATE: assert-common 14
# Argument: --help - Optional. Flag. Display this help.
# Argument: --line lineNumber - Optional. Integer. Line number of calling function.
# Argument: --debug - Optional. Flag. Debugging
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
# Exit code: 1 - If the assertions fails
# Exit code: 0 - If the assertion succeeds
_assertConditionHelper() {
  local this="$1" && shift
  local usage="_$this"
  local pairs=() debugFlag=false
  local success=true file="" lineNumber="" linePrefix="" displayName="" tester="" formatter="__resultFormatter"
  local outputContains=() outputNotContains=() stderrContains=() stderrNotContains=()
  local doPlumber=true leaks=()
  local errorsOk=false dumpFlag=false dumpBinaryFlag=false expectedExitCode=0 code1=false
  local message result testPassed runner exitCode outputFile errorFile stderrTitle stdoutTitle

  set -eou pipefail
  # IDENTICAL argument-case-header-blank 4
  local saved=("$@") nArguments=$#
  while [ $# -gt 0 ]; do
    local argument="$1" argumentIndex=$((nArguments - $# + 1))
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --exit)
        shift
        expectedExitCode=$(usageArgumentUnsignedInteger "$usage" "$argument" "${1-}")
        pairs+=("Exit" "$(decorate bold-magenta " $expectedExitCode ")")
        ;;
      --display)
        shift
        displayName="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      --success)
        shift
        success="$(usageArgumentBoolean "$usage" "$argument" "${1-}")" || return $?
        pairs+=("should" "$(_choose "$success" "succeed" "$(decorate warning "fail")")")
        ;;
      --debug)
        debugFlag=true
        ;;
      --line)
        shift
        lineNumber="${1-}"
        [ -z "$lineNumber" ] || linePrefix="$(decorate bold-magenta "Line ${1-}: ")"
        ;;
      --test)
        shift
        tester="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      --formatter)
        shift
        formatter="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      --stderr-ok)
        errorsOk=true
        ;;
      --stderr-match)
        shift || :
        [ -n "${1-}" ] || __failArgument "$usage" "Blank $argument argument" || return $?
        stderrContains+=("$1")
        errorsOk=true
        ;;
      --stderr-no-match)
        shift || :
        [ -n "${1-}" ] || __failArgument "$usage" "Blank $argument argument" || return $?
        stderrNotContains+=("$1")
        errorsOk=true
        ;;
      --stdout-match)
        shift || :
        [ -n "${1-}" ] || __failArgument "$usage" "Blank $argument argument" || return $?
        outputContains+=("$1")
        ;;
      --stdout-no-match)
        shift || :
        [ -n "${1-}" ] || __failArgument "$usage" "Blank $argument argument" || return $?
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
      --skip-plumber)
        doPlumber=false
        leaks=()
        ;;
      --leak)
        shift
        leaks+=(--leak "$(usageArgumentString "$usage" "globalName" "${1-}")") || return $?
        ;;
      --code1)
        code1=true
        ;;
      *)
        break
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing #$argumentIndex/$nArguments: $argument $(decorate each code "${saved[@]}")" || return $?
  done
  [ -n "$tester" ] || __failArgument "$usage" "--test required ($*)" || return $?

  outputFile=$(fileTemporaryName "$usage") || return $?
  errorFile="$outputFile.err"
  outputFile="$outputFile.out"

  if $code1; then
    [ "$expectedExitCode" -eq 0 ] || __usageArgument "$usage" "--exit and --code1 and mutually exclusive for non-zero --exit" || return $?
    expectedExitCode="$(usageArgumentUnsignedInteger "$usage" "exitCode" "${1-}")"
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
  "${runner[@]}" "$@" >"$outputFile" 2>"$errorFile"
  exitCode=$?
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
  message="$(
    printf -- "%s%s ➡️ %s -> (%s)" \
      "$linePrefix" "$(decorate code "$this")" \
      "$result" \
      "$message"
  )"
  if $code1 || [ "$expectedExitCode" -ne 0 ]; then
    message="$message -> [$exitCode $(_choose "$success" "=" "!=") $expectedExitCode] $(__resultText "$testPassed" "$(_choose "$testPassed" correct incorrect)")"
  fi
  if ! "$errorsOk" && [ -s "$errorFile" ]; then
    message="$(printf -- "%s - %s\n%s\n" "$message" "$(decorate error "produced stderr")" "$(dumpPipe --tail stderr <"$errorFile")")"
    _assertFailure "$this" "$displayName $message" || return $?
  fi
  if $errorsOk && [ ! -s "$errorFile" ]; then
    statusMessage --last printf "%s – %s" "$message" "$(decorate warning "--stderr-ok used but is NOT necessary")"
  fi
  stderrTitle="$this $(decorate bold-red stderr)"
  stdoutTitle="$this $(decorate label stdout)"
  if [ ${#stderrContains[@]} -gt 0 ]; then
    __assertFileContainsThis "$this" --line "$lineNumber" --display "$stderrTitle" "$errorFile" "${stderrContains[@]}" || testPassed=false
  fi
  if [ ${#stderrNotContains[@]} -gt 0 ]; then
    __assertFileDoesNotContainThis "$this" --line "$lineNumber" --display "$stderrTitle" "$errorFile" "${stderrNotContains[@]}" || testPassed=false
  fi
  if [ ${#outputContains[@]} -gt 0 ]; then
    __assertFileContainsThis "$this" --line "$lineNumber" --display "$stdoutTitle" "$outputFile" "${outputContains[@]}" || testPassed=false
  fi
  if [ ${#outputNotContains[@]} -gt 0 ]; then
    __assertFileDoesNotContainThis "$this" --line "$lineNumber" --display "$stdoutTitle" "$outputFile" "${outputNotContains[@]}" || testPassed=false
  fi
  if $testPassed; then
    _assertSuccess "$this" "$displayName $message" || exitCode=$?
    exitCode=0
  else
    _assertFailure "$this" "$displayName $message" || exitCode=$?
  fi
  if $dumpFlag; then
    if $dumpBinaryFlag; then
      dumpBinary <"$outputFile" | dumpPipe "$stdoutTitle" || :
      dumpBinary <"$errorFile" | dumpPipe "$stderrTitle" || :
    else
      dumpPipe --tail "$stdoutTitle" <"$outputFile" || :
      dumpPipe --tail "$stderrTitle" <"$errorFile" || :
    fi
  fi
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
  local this="$2"
  local argument
  local file lineNumber linePrefix
  local found args expected verb notVerb message displayName

  shift 2
  file=

  linePrefix=
  lineNumber=
  displayName=
  while [ $# -gt 0 ]; do
    argument="$1"
    case "$argument" in
      --display)
        shift
        displayName="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --line)
        shift
        lineNumber="${1-}"
        if [ -n "$lineNumber" ]; then
          linePrefix="$(decorate bold-magenta "Line $lineNumber: ")"
        fi
        ;;
      *)
        if [ -z "$file" ]; then
          file="$argument"
        else
          break
        fi
        ;;
    esac
    shift || usageArgumentMissing "$usage" "$argument" || return $?
  done

  displayName="${displayName:-"$file"}"
  [ -f "$file" ] || _assertFailure "$this" "$displayName is not a file \"$file\": $*" || return $?

  verb=$(_choose "$success" "contains" "does not contain") || return $?
  notVerb=$(_choose "$success" "does not contain" "contains") || return $?
  args=("$@")
  while [ $# -gt 0 ]; do
    expected="$1"
    [ -n "$expected" ] || _assertFailure "$this" "Blank match passed: ${args[*]}" || return $?
    if grep -q -e "$(quoteGrepPattern "$expected")" "$file"; then
      found=true
    else
      found=false
    fi
    if [ "$found" = "$success" ]; then
      # shellcheck disable=SC2059
      _assertSuccess "$this" "$linePrefix$displayName $verb strings: ($(printf -- "\"$(decorate code "%s")\" " "${args[@]+${args[@]}}"))" || return $?
    else
      message="$(printf -- "%s %s %s\n%s" "$linePrefix$displayName" "$notVerb string:" "$(decorate code "$expected")" "$(dumpPipe --tail "$displayName" <"$file")")"
      _assertFailure "$this" "$message" || return $?
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
  local this="$1"
  shift
  _assertConditionHelper "$this" --test ___assertIsEqual --formatter ___assertIsEqualFormat "$@" || return $?
}
___assertIsEqual() {
  [ "${1-}" = "${2-}" ]
}
___assertIsEqualFormat() {
  local testPassed="${1-}" success="${2-}" left="${3-}"
  shift && shift && shift
  printf -- "%s %s %s\n" "$(__resultText "$testPassed" "$left")" "$(_choose "$success" "=" "!=")" "$(__resultText "$testPassed" "$*")"
}

#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
#
# assert numeric
#
#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
# Usage: {fn} function ... leftValue rightValue message ... comparison
_assertNumericHelper() {
  local this="$1"
  shift
  _assertConditionHelper "$this" --test ___assertNumericTest --formatter ___assertNumericFormat "$@" || return $?
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
  local this="$1"
  shift
  _assertConditionHelper "$this" --test ___assertContains --formatter ___assertContainsFormat "$@" || return $?
}
___assertContains() {
  local needle haystack

  needle="${1-}"
  [ -n "$needle" ] || _argument "blank needle passed to contains assertion" || return $?
  shift
  while [ $# -gt 0 ]; do
    haystack="${1-}"
    [ -n "$haystack" ] || _argument "blank haystack passed to contains assertion" || return $?
    printf "%s" "$haystack" | grep -q "$needle" || return $?
    shift
  done
}
___assertContainsFormat() {
  local testPassed="${1-}" success="${2-}"
  local needle haystack

  shift 2
  needle="$(decorate code "${1-}")" && shift
  haystack=$(__resultText "$testPassed" "$*")
  printf -- "%s %s %s\n" "$needle" "$(_choose "$testPassed" "contains" "does not contain")" "$haystack"
}

#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
#
# Directory exists
#
#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
_assertDirectoryExistsHelper() {
  local this="$1"
  shift
  _assertConditionHelper "$this" --test ___assertDirectoryExists --formatter ___assertDirectoryExistsFormat "$@" || return $?
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
  local this="$1"
  shift
  _assertConditionHelper "$this" --test ___assertDirectoryEmpty --formatter ___assertDirectoryEmptyFormat "$@" || return $?
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
  local this="$1"
  shift
  _assertConditionHelper "$this" --test ___assertFileExists --formatter ___assertFileExistsFormat "$@" || return $?
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
  local this="$1"
  shift
  _assertConditionHelper "$this" --test ___assertFileSize --formatter ___assertFileSizeFormat "$@" || return $?
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
  local this="$1"
  shift
  _assertConditionHelper "$this" --test ___assertOutputEquals --formatter ___assertOutputEqualsFormat "$@" || return $?
}
___assertOutputEquals() {
  local expected="${1-}" binary="${2-}" output stderr exitCode=0

  shift 2 || :
  stderr=$(__environment mktemp) || return $?
  isCallable "$binary" || _environment "$binary is not callable: $*" || return $?
  if output=$(plumber "$binary" "$@" 2>"$stderr"); then
    if [ -s "$stderr" ]; then
      dumpPipe "$(decorate error Produced stderr): $binary" "$@" <"$stderr" 1>&2
      _clean 1 "$stderr" || return $?
    fi
    [ "$output" = "$expected" ] || exitCode=1
    printf "%s\n" "$output"
  else
    exitCode=$?
    [ "$exitCode" -eq "$(_code leak)" ] && ! _environment "Leak:" "$binary" "$!" || _environment "Exit code: $?" "$binary" "$@" || exitCode=$?
  fi
  _clean "$exitCode" "$stderr" || return $?
}
___assertOutputEqualsFormat() {
  local testPassed="${1-}" success="${2-}" verb expected="$3" binary="$4"
  shift 4 || :

  message="$(decorate code "$binary")$(printf " \"%s\"" "$@")"
  verb=$(_choose "$success" "matches" "does not match")
  printf -- "%s %s %s %s" "$message" "$(decorate code "$(cat)")" "$(__resultText "$testPassed" "$verb")" "$(__resultText "$testPassed" "$expected")"
}

# Usage: {fn} thisName arguments
__assertFileContainsThis() {
  __assertFileContainsHelper true "$@" || return $?
}

# Usage: {fn} thisName arguments
__assertFileDoesNotContainThis() {
  __assertFileContainsHelper false "$@" || return $?
}

#
# Assert a process runs and exits with the correct exit code.
#
# If this fails it will output an error and exit.
#
# Usage: {fn} usage expectedExitCode command [ arguments ... ]
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
  local this="$1"
  shift
  _assertConditionHelper "$this" --code1 --test ___assertExitCodeTest --formatter ___assertExitCodeFormat "$@" || return $?
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
  local this="$1"
  shift
  _assertConditionHelper "$this" --test ___assertOutputContainsTest --formatter ___assertOutputContainsFormat "$@" || return $?
}
___assertOutputContainsTest() {
  local contains="${1-}" binary="${2-}" captureOut exitCode
  shift 1
  [ -n "$contains" ] || _argument "contains is blank: $*" || return $?
  isCallable "$binary" || _argument "$binary is not callable: $*" || return $?
  captureOut=$(__environment mktemp) || return $?
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
