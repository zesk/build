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

# Usage: {fn} success thisName verb notVerb [ --display displayName ] [ --help ]
# Core condition assertion handler
# Argument: thisName - Reported function for success or failure
# Argument: fileName - File to search
# Argument: string0 ... - One or more strings which must NOT be found anywhere in `fileName`
# Exit code: 1 - If the assertions fails
# Exit code: 0 - If the assertion succeeds
#
_assertConditionHelper() {
  local this="$1"
  local usage="_$this"
  local argument
  local success testPassed file linePrefix displayName tester formatter result

  shift
  file=
  linePrefix=
  displayName=
  tester=
  success=true
  formatter="__resultFormatter"
  while [ $# -gt 0 ]; do
    argument="$1"
    case "$argument" in
      --display)
        shift
        displayName="$(usageArgumentRequired "$usage" "$argument" "${1-}")" || return $?
        ;;
      --success)
        shift
        success="$(usageArgumentBoolean "$usage" "$argument" "${1-}")" || return $?
        ;;
      --help)
        "$usage" 0
        return $?
        ;;
      --line)
        shift
        linePrefix="$(consoleBoldMagenta "Line ${1-}: ")"
        ;;
      --test)
        shift
        tester="$(usageArgumentRequired "$usage" "$argument" "${1-}")" || return $?
        ;;
      --formatter)
        shift
        formatter="$(usageArgumentRequired "$usage" "$argument" "${1-}")" || return $?
        ;;
      *)
        break
        ;;
    esac
    shift || usageArgumentMissing "$usage" "$argument" || return $?
  done
  [ -n "$tester" ] || __failArgument "$usage" "--test required ($*)" || return $?
  if "$tester" "$@"; then
    testPassed=$success
  else
    testPassed=false
    $success || testPassed=true
  fi
  result="$("$formatter" "$testPassed" "$@")"
  if $testPassed; then
    _assertSuccess "$this" "$linePrefix$displayName ✅ $result" || return $?
  else
    _assertFailure "$this" "$linePrefix$displayName ❌ $result" || return $?
  fi
}

# Generic formatter
# Usage: {fn} testPassed arguments
__resultFormatter() {
  local testPassed

  testPassed="$1" && shift
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
  local testPassed="${1-}" left="${2-}" right="${3-}"
  shift || :
  shift || :
  shift || :
  printf -- "%s %s %s %s\n" "$(consoleCode "$left")" "$(_choose "$testPassed" "=" "!=")" "$(__resultText "$testPassed" "$right")" "$*"
}

#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
#
# assert numeric
#
#=== === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
# Usage: {fn} function ... leftValue rightValue message ... comparison
_assertNumericHelper() {
  local this="$1"
  shift && _assertConditionHelper "$this" --test ___assertNumericTest --formatter ___assertNumericFormat "$@" || return $?
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
  local leftValue="$1" rightValue="$2" cmp
  cmp="${!#}"
  shift 2
  printf "[%s %s] %s %s\n" "$(consoleCode "$leftValue")" "$(__resultText "$testPassed" "$cmp $rightValue")" "$(_choose "$testPassed" "(true)" "(false)")" "$*"
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
  local testPassed="${1-}"
  local needle haystack

  shift && needle="$(consoleCode "${1-}")"
  shift && haystack=$(__resultText "$testPassed" "$*")
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
  local testPassed="${1-}"
  shift
  printf -- "%s %s" "$(__resultText "$testPassed" "$*")" "$(_choose "$testPassed" "is a directory" "is not a directory")"
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
  local testPassed="${1-}"
  shift
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
  local testPassed="${1-}"
  shift
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
  local testPassed="${1-}"
  shift
  printf -- "%s %s" "$(__resultText "$testPassed" "File Size: $1")" "$(_choose "$testPassed" "$*")"
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
  local expected="${1-}" binary="${2-}" output stderr
  shift 2
  stderr=$(__environment mktemp) || return $?
  isCallable "$binary" || _environment "$binary is not callable: $*" || return $?
  output=$("$binary" "$@" 2>"$stderr") || _environment "Exit code: $?" "$binary" "$@" || return $?
  if [ -s "$stderr" ]; then
    dumpPipe "$(consoleError Produced stderr): $binary" "$@" <"$stderr" 1>&2
    _clean 1 "$stderr" || return $?
  fi
  [ "$output" = "$expected" ]
  printf "%s\n" "$output"
  _clean 0 "$stderr" || return $?
}
___assertOutputEqualsFormat() {
  local testPassed="${1-}"
  shift
  printf -- "%s %s" "$(__resultText "$testPassed" "File Size: $1")" "$(_choose "$testPassed" "$*")"
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
  local file linePrefix
  local found args expected verb notVerb message displayName

  shift 2
  file=
  linePrefix=
  displayName=
  while [ $# -gt 0 ]; do
    argument="$1"
    case "$argument" in
      --display)
        shift
        displayName="$(usageArgumentRequired "$usage" "$argument" "${1-}")" || return $?
        ;;
      --help)
        "$usage" 0
        return $?
        ;;
      --line)
        shift
        linePrefix="$(consoleBoldMagenta "Line ${1-}: ")"
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
  [ -f "$file" ] || _assertFailure "$this" "$displayName is not a file: $*"

  case "$success" in
    true)
      verb="contains"
      notVerb="does not contain"
      ;;
    false)
      verb="does not contain"
      notVerb="contains"
      ;;
    *) _assertFailure "Invalid success ($success) passed" || return $? ;;
  esac
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
      message="$(printf -- "%s %s %s\n%s" "$linePrefix$displayName" "$notVerb string:" "$(consoleCode "$expected")" "$(dumpPipe "$displayName" <"$file")")"
      _assertFailure "$this" "$message" || return $?
    fi
    shift
  done
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
# Argument: --skip-exit-save - Optional. Flag. Skip saveErrorExit to test errorExit functions.
# Argument: --debug - Optional. Flag. Debugging
# Local cache: None.
# Environment: None.
# Examples: assertExitCode 0 hasHook version-current
# Reviewed: 2023-11-12
# Exit code: 0 - If the process exits with the provided exit code
# Exit code: 1 - If the process exits with a different exit code
#
_assertExitCodeHelper() {
  local argument savedArguments
  local usage this
  local isExitCode errorsOk debugAssertRun dumpFlag saveExit exitCode
  local actual expected bin linePrefix lineNumber
  local outputFile errorFile testPassed
  local stderrTitle stdoutTitle
  local saved failureText message textCommand
  local outputContains outputNotContains stderrContains stderrNotContains

  # --not
  isExitCode=1
  # --stderr-ok
  errorsOk=

  # expected
  expected=
  # binary ...
  bin=
  failureText="expected"

  usage="$1"
  this="${usage#_}"
  shift || :

  linePrefix=
  lineNumber=
  savedArguments=("$@")
  outputContains=()
  outputNotContains=()
  stderrContains=()
  stderrNotContains=()
  debugAssertRun=false
  dumpFlag=false
  saveExit=true
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --debug)
        debugAssertRun=true
        ;;
      --line)
        shift
        lineNumber="${1-}"
        if [ -n "$lineNumber" ]; then
          linePrefix="$(consoleBoldMagenta "Line ${1-}: ")"
        fi
        ;;
      --stderr-ok)
        errorsOk=1
        ;;
      --skip-exit-save)
        saveExit=false
        ;;
      --stderr-match)
        shift || :
        [ -n "${1-}" ] || __failArgument "$usage" "Blank $argument argument" || return $?
        stderrContains+=("$1")
        errorsOk=1
        ;;
      --stderr-no-match)
        shift || :
        [ -n "${1-}" ] || __failArgument "$usage" "Blank $argument argument" || return $?
        stderrNotContains+=("$1")
        errorsOk=1
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
      --not)
        isExitCode=
        failureText="expected NOT"
        ;;
      *)
        if [ -z "$expected" ]; then
          expected="$argument"
          isInteger "$expected" || __failArgument "$usage" "Expected \"$(consoleCode "$expected")$(consoleError "\" should be an integer")" || return $?
        elif [ -z "$bin" ]; then
          bin="$argument"
          shift || :
          break
        fi
        ;;
    esac
    shift || :
  done
  outputFile=$(mktemp) || __failEnvironment "$usage" "INTERNAL unable to mktemp" || return $?
  errorFile="$outputFile.err"
  outputFile="$outputFile.out"

  if $saveExit; then
    saved=false
    isErrorExit && saved=true
    set -e
  fi

  if $debugAssertRun; then
    clearLine || :
    consoleBoldMagenta -n "(Hit enter) $-:" "$bin" "$@"
    read -r actual || :
    set -x
  fi
  textCommand="$bin$(printf -- " \"%s\"" "$@")"
  set -E
  actual="$(
    "$bin" "$@" >"$outputFile" 2>"$errorFile"
    printf %d "$?"
  )"
  set +E
  if $debugAssertRun; then
    set +x
  fi
  if $saveExit; then
    "$saved" && set -e
  fi

  if ! test "$errorsOk" && [ -s "$errorFile" ]; then
    actual=$(__resultText false "$actual")
    message="$(printf -- "%s%s %s -> %s %s\n%s\n" \
      "$linePrefix" \
      "$(consoleCode "$this")" \
      "$textCommand" \
      "$(consoleSuccess "$actual")" \
      "$(consoleError "produced stderr")" "$(dumpPipe stderr <"$errorFile")")"
    _assertFailure "$this" "$message" || return $?
    __failEnvironment "$usage" "$message" || return $?
  fi
  if test $errorsOk && [ ! -s "$errorFile" ]; then
    printf "%s%s %s – %s\n" "$(clearLine)" "$(consoleError "${usage#_}")" "$(consoleCode "$bin ${savedArguments[*]}")" "$(consoleWarning "--stderr-ok used but is NOT necessary:")"
  fi
  stderrTitle="$textCommand $(consoleBoldRed stderr)"
  stdoutTitle="$textCommand $(consoleLabel stdout)"
  if [ ${#stderrContains[@]} -gt 0 ]; then
    __assertFileContainsThis "$this" --display "$linePrefix$stderrTitle" "$errorFile" "${stderrContains[@]}" || return $?
  fi
  if [ ${#stderrNotContains[@]} -gt 0 ]; then
    __assertFileDoesNotContainThis "$this" --display "$linePrefix$stderrTitle" "$errorFile" "${stderrNotContains[@]}" || return $?
  fi
  if [ ${#outputContains[@]} -gt 0 ]; then
    __assertFileContainsThis "$this" --display "$linePrefix$stdoutTitle" "$outputFile" "${outputContains[@]}" || return $?
  fi
  if [ ${#outputNotContains[@]} -gt 0 ]; then
    __assertFileDoesNotContainThis "$this" --display "$linePrefix$stdoutTitle" "$outputFile" "${outputNotContains[@]}" || return $?
  fi

  if { test "$isExitCode" && [ "$expected" != "$actual" ]; } || { ! test "$isExitCode" && [ "$expected" = "$actual" ]; }; then
    testPassed=false
  else
    testPassed=true
  fi
  actual=$(__resultText "$testPassed" "$actual")
  if $testPassed; then
    _assertSuccess "$this" "$actual" "$(consoleCode "${savedArguments[*]}")" || :
    exitCode=$?
    if $dumpFlag; then
      dumpPipe "$stdoutTitle" <"$outputFile" || :
      dumpPipe "$stderrTitle" <"$errorFile" || :
    fi
  else
    # Failure
    message=$(
      printf "%s%s %s ➜ %s%s\n%s\n%s\n" \
        "$linePrefix" \
        "$textCommand" \
        "$(printf -- "\"%s%s%s\"" "$(consoleCode)" "${savedArguments[*]}" "$(consoleReset)")" \
        "$(consoleSuccess "$expected") $failureText, $actual actual" \
        "$(consoleReset)" \
        "$(dumpPipe "$stdoutTitle" <"$outputFile")" \
        "$(dumpPipe "$stderrTitle" <"$errorFile")"
    )
    _assertFailure "$this" "$message" || exitCode=$?
  fi
  rm -rf "$outputFile" "$errorFile" || :
  return $exitCode
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
  local expected="" commands=() tempFile exitCode=0 pipeStdErr="" actual message
  local command linePrefix lineNumber
  local trueTest="$1" this="$2" testPassed

  shift 2
  linePrefix=
  lineNumber=
  while [ $# -gt 0 ]; do
    case $1 in
      --exit)
        shift
        assertExitCode 0 --line "$lineNumber" isNumber "$1" || return $?
        exitCode="$1"
        ;;
      --line)
        shift
        lineNumber="${1-}"
        if [ -n "$lineNumber" ]; then
          linePrefix="$(consoleMagenta "Line $1: ")"
        fi
        ;;
      --stderr)
        pipeStdErr=1
        ;;
      *)
        if [ -z "$expected" ]; then
          expected=$(quoteGrepPattern "$1")
        else
          commands+=("$1")
        fi
        ;;
    esac
    shift
  done
  command="$(printf -- " \"%s\"" "${commands[@]}")"
  command="$(consoleCode "${command# }")"

  tempFile=$(mktemp)
  printf -- "%s: %s\n" "$(consoleInfo Running)" "$command"
  if test $pipeStdErr; then
    actual=$(
      "${commands[@]}" >"$tempFile" 2>&1
      printf "%d" $?
    )
  else
    actual=$(
      "${commands[@]}" >"$tempFile"
      printf "%d" $?
    )
  fi
  testPassed=false
  assertEquals --line "$lineNumber" "$exitCode" "$actual" "$(printf -- "%s %s %s (%s)\nCommand: %s\n" "$(consoleInfo "$this")" "Exit code should be" "$(consoleGreen "$exitCode")" "$(consoleError "$actual")" "$command")" || return $?
  if grep -q -e "$expected" "$tempFile"; then
    testPassed=$trueTest
  else
    if ! $trueTest; then
      testPassed=true
    fi
  fi
  expected="$(consoleCode "$expected")"
  if $testPassed; then
    message="$(printf "\"%s\" found in output: %s" "$expected" "$command")"
    _assertSuccess "$this" "$message" || return $?
  else
    message=
    dumpPipe --lines 1000 "$command output" <"$tempFile" 1>&2
    _assertFailure "$this" "$(printf "\"%s\" not found in output" "$expected")" || return $?
  fi
}
