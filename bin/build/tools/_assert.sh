#!/usr/bin/env bash
#
# assertHelpers.sh
#
# Assert utilities
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: contextOpen ./docs/_templates/tools/assert.md
# Test: contextOpen ./test/tools/assert-tests.sh

# Format test text, special display for blank strings
__resultText() {
  local passed="$1" text
  shift
  text="$*"
  if "$passed"; then
    # shellcheck disable=SC2015
    [ -z "$text" ] && consoleBlue "(blank)" || consoleCode "$text"
  else
    # shellcheck disable=SC2015
    [ -z "$text" ] && consoleBoldRed "(blank)" || consoleError "$text"
  fi
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
  statusMessage printf -- "%s: %s %s " "$(_symbolFail)" "$(consoleError "$function")" "$(consoleInfo "$@")" 1>&2
  return "$(_code assert)"
}
_assertSuccess() {
  local function="${1-None}"
  incrementor assert-success >/dev/null
  shift || :
  statusMessage printf -- "%s: %s %s " "$(_symbolSuccess)" "$(consoleSuccess "$function")" "$(consoleInfo "$@")"
}

# Core condition assertion handler
# DOC TEMPLATE: assert-common 11
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
# Argument: --dump - Optional. Flag. Output stderr and stdout after test regardless.
# Exit code: 1 - If the assertions fails
# Exit code: 0 - If the assertion succeeds
#
_assertConditionHelper() {
  local this="$1"
  local usage="_$this"
  local argument pairs debugFlag
  local exitCode success testPassed file lineNumber linePrefix displayName tester formatter message result
  local doPlumber runner leaks outputContains outputNotContains stderrContains stderrNotContains
  local errorsOk outputFile errorFile stderrTitle stdoutTitle dumpFlag expectedExitCode code1

  shift
  file=
  lineNumber=
  linePrefix=
  pairs=()
  outputContains=()
  outputNotContains=()
  stderrContains=()
  stderrNotContains=()
  displayName=
  tester=
  errorsOk=false
  dumpFlag=false
  formatter="__resultFormatter"
  doPlumber=true
  leaks=()
  code1=false
  success=true
  debugFlag=false
  expectedExitCode=0
  while [ $# -gt 0 ]; do
    argument="$1"
    case "$argument" in
      --exit)
        shift
        expectedExitCode=$(usageArgumentUnsignedInteger "$usage" "$argument" "${1-}")
        pairs+=("Exit" "$(consoleBoldMagenta " $expectedExitCode ")")
        ;;
      --display)
        shift
        displayName="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      --success)
        shift
        success="$(usageArgumentBoolean "$usage" "$argument" "${1-}")" || return $?
        pairs+=("should" "$(_choose "$success" "succeed" "$(consoleWarning "fail")")")
        ;;
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --debug)
        debugFlag=true
        ;;
      --line)
        shift
        lineNumber="${1-}"
        [ -z "$lineNumber" ] || linePrefix="$(consoleBoldMagenta "Line ${1-}: ")"
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
    shift || usageArgumentMissing "$usage" "$argument" || return $?
  done
  [ -n "$tester" ] || __failArgument "$usage" "--test required ($*)" || return $?

  outputFile=$(__usageEnvironment "$usage" mktemp) || return $?
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
  if $debugFlag; then
    set -xv
  fi
  "${runner[@]}" "$@" >"$outputFile" 2>"$errorFile"
  exitCode=$?
  if $debugFlag; then
    set +xv
  fi
  if [ "$exitCode" = "$expectedExitCode" ]; then
    testPassed=$success
  else
    testPassed=$(_choose "$success" false true)
  fi
  result="$("$formatter" "$testPassed" "$success" "$@" <"$outputFile")"
  # shellcheck disable=SC2059
  message="$(printf "$(consoleLabel %s) %s, " "${pairs[@]}")"
  message="${message%, }"
  message="$(
    printf -- "%s%s ➡️ %s -> (%s)" \
      "$linePrefix" "$(consoleCode "$this")" \
      "$result" \
      "$message"
  )"
  if $code1 || [ "$expectedExitCode" -ne 0 ]; then
    message="$message -> [$exitCode $(_choose "$success" "=" "!=") $expectedExitCode] $(__resultText "$testPassed" "$(_choose "$testPassed" correct incorrect)")"
  fi
  if ! "$errorsOk" && [ -s "$errorFile" ]; then
    message="$(printf -- "%s - %s\n%s\n" "$message" "$(consoleError "produced stderr")" "$(dumpPipe stderr <"$errorFile")")"
    _assertFailure "$this" "$displayName $message" || return $?
  fi
  if $errorsOk && [ ! -s "$errorFile" ]; then
    clearLine
    printf "%s – %s\n" "$message" "$(consoleWarning "--stderr-ok used but is NOT necessary")"
  fi
  stderrTitle="$this $(consoleBoldRed stderr)"
  stdoutTitle="$this $(consoleLabel stdout)"
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
    dumpPipe "$stdoutTitle" <"$outputFile" || :
    dumpPipe "$stderrTitle" <"$errorFile" || :
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
      --help)
        "$usage" 0
        return $?
        ;;
      --line)
        shift
        lineNumber="${1-}"
        if [ -n "$lineNumber" ]; then
          linePrefix="$(consoleBoldMagenta "Line $lineNumber: ")"
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
      _assertSuccess "$this" "$linePrefix$displayName $verb strings: ($(printf -- "\"$(consoleCode "%s")\" " "${args[@]+${args[@]}}"))" || return $?
    else
      message="$(printf -- "%s %s %s\n%s" "$linePrefix$displayName" "$notVerb string:" "$(consoleCode "$expected")" "$(dumpPipe --tail "$displayName" <"$file")")"
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
  printf -- "%s %s %s\n" "$(consoleCode "$left")" "$(_choose "$success" "=" "!=")" "$(__resultText "$testPassed" "$*")"
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
  printf "[%s %s] %s %s\n" "$(consoleCode "$leftValue")" "$(__resultText "$testPassed" "$cmp $rightValue")" "$(_choose "$success" "(true)" "(false)")" "$*"
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
  needle="$(consoleCode "${1-}")" && shift
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
  printf -- "%s %s wd: \"%s" "$(__resultText "$testPassed" "$*")" "$(_choose "$testPassed" "is a file" "is not a file")" "$(consoleValue "$(pwd)")"
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
      dumpPipe "$(consoleError Produced stderr): $binary" "$@" <"$stderr" 1>&2
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

  message="$(consoleCode "$binary")$(printf " \"%s\"" "$@")"
  verb=$(_choose "$success" "matches" "does not match")
  printf -- "%s %s %s %s" "$message" "$(consoleCode "$(cat)")" "$(__resultText "$testPassed" "$verb")" "$(__resultText "$testPassed" "$expected")"
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
  "$@"
}
___assertExitCodeFormat() {
  local testPassed="${1-}" success="${2-}"
  shift 2
  # shellcheck disable=SC2059
  command="$(printf "\"$(consoleCode %s)\" " "$@")"
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
  command="$(printf "\"$(consoleCode %s)\" " "$@")"
  verb=$(_choose "$success" "contains" "does not contain")
  printf "%s => %s \"%s\" %s" "${command% }" "$(consoleValue "$verb")" "$contains" "$(__resultText "$testPassed" "$(_choose "$testPassed" "correctly" "incorrectly")")"
}
