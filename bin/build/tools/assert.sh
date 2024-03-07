#!/usr/bin/env bash
#
# assert.sh
#
# Simple assert functions for testing
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh text.sh prefixLines
#
# Docs: contextOpen ./docs/_templates/tools/assert.md
# Test: contextOpen ./test/tools/assert-tests.sh

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

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
  printf "%s %s\n" "$(_symbolFail)" "$(consoleError "$@")" 1>&2
  return $errorEnvironment
}
_assertSuccess() {
  printf "%s %s\n" "$(_symbolSuccess)" "$(consoleSuccess "$@")" 1>&2
  return 0
}

#
# Assert two strings are equal.
#
# If this fails it will output an error and exit.
#
# Usage: assertEquals expected actual [ message ]
# Argument: - `expected` - Expected string
# Argument: - `actual` - Actual string
# Argument: - `message` - Message to output if the assertion fails
# Example:     assertEquals "$(alignRight 4 "hi")" "  hi" "alignRight not working"
# Reviewed: 2023-11-12
#
assertEquals() {
  local expected=$1 actual=$2
  shift || _assertFailure "missing expected arg" || return $?
  shift || _assertFailure "missing actual arg" || return $?
  if [ "$expected" = "$actual" ]; then
    _assertSuccess "${FUNCNAME[0]} \"$expected\" == \"$actual\" (correct)"
  else
    _assertFailure "${FUNCNAME[0]} expected \"$expected\" should equal actual \"$actual\" but does not: ${*-not equal}"
  fi
}

# Assert two strings are not equal.
#
# If this fails it will output an error and exit.
# Summary: Assert two strings are not equal
# Usage: assertNotEquals expected actual [ message ]
# Argument: expected - Required. Expected string.
# Argument: actual - Required. Actual string.
# Argument: message - Message to output if the assertion fails. Optional.
# Example:     assertNotEquals "$(uname -s)" "Darwin" "Not compatible with Darwin"
# Example:     Single quote break-s
# Reviewed: 2023-11-12
#
assertNotEquals() {
  local expected=$1 actual=$2
  shift
  shift
  if [ "$expected" != "$actual" ]; then
    _assertSuccess "${FUNCNAME[0]} \"$expected\" != \"$actual\" (correct)"
  else
    _assertFailure "${FUNCNAME[0]} expected \"$expected\" equals \"$actual\" but should not: ${*-equals}"
  fi
}

#
# Assert a process runs and exits with the correct exit code.
#
# If this fails it will output an error and exit.
#
# Usage: {fn} usageFunction expectedExitCode command [ arguments ... ]
#
# Argument: - `expectedExitCode` - A numeric exit code expected from the command
# Argument: - `command` - The command to run
# Argument: - `arguments` - Any arguments to pass to the command to run
# Local cache: None.
# Environment: None.
# Examples: assertExitCode 0 hasHook version-current
# Reviewed: 2023-11-12
# Exit code: 0 - If the process exits with the provided exit code
# Exit code: 1 - If the process exits with a different exit code
#
_assertExitCodeHelper() {
  local usageFunction
  local isExitCode errorsOk
  local expected bin
  local outputFile errorFile
  local saved actual failureText
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

  usageFunction="$1"
  shift || :

  outputContains=()
  outputNotContains=()
  stderrContains=()
  stderrNotContains=()

  while [ $# -gt 0 ]; do
    if [ -z "$1" ]; then
      "$usageFunction" "$errorArgument" "Blank argument" || return $?
    fi
    case "$1" in
      --stderr-ok)
        errorsOk=1
        ;;
      --stderr-match)
        shift || :
        stderrContains+=("$1")
        errorsOk=1
        ;;
      --stderr-no-match)
        shift || :
        stderrNotContains+=("$1")
        errorsOk=1
        ;;
      --stdout-match)
        shift || :
        outputContains+=("$1")
        ;;
      --stdout-no-match)
        shift || :
        outputNotContains+=("$1")
        ;;
      --not)
        isExitCode=
        failureText="expected NOT"
        ;;
      *)
        if [ -z "$expected" ]; then
          expected="$1"
          if ! isInteger "$expected"; then
            "$usageFunction" "$errorArgument" "Expected \"$(consoleCode "$expected")\" should be an integer" || return $?
          fi
        elif [ -z "$bin" ]; then
          bin="$1"
          shift
          break
        fi
        ;;
    esac
    shift
  done
  if ! outputFile=$(mktemp) || ! errorFile=$(mktemp); then
    "$usageFunction" $errorEnvironment "INTERNAL unable to mktemp" || return $?
  fi

  saved=$(saveErrorExit)
  set -e
  actual="$(
    "$bin" "$@" >"$outputFile" 2>"$errorFile"
    printf %d "$?"
  )"
  restoreErrorExit "$saved"

  if ! test $errorsOk && [ -s "$errorFile" ]; then
    $usageFunction $errorEnvironment "$(printf "%s %s -> %s %s\n%s\n" "$(consoleCode "${usageFunction#_} $bin")" "$(consoleInfo "$(printf "\"%s\" " "$@")")" "$(consoleError "$actual")" "$(consoleError "Produced stderr")" "$(prefixLines "$(consoleError ERROR:) $(consoleCode)" <"$errorFile")")" || return $?
  fi
  if test $errorsOk && [ ! -s "$errorFile" ]; then
    consoleWarning "--stderr-ok used but is NOT necessary: $(consoleCode "${usageFunction#_} $bin $*")"
  fi
  if [ ${#stderrContains[@]} -gt 0 ]; then
    assertFileContains "$errorFile" "${stderrContains[@]}" || return $?
  fi
  if [ ${#stderrNotContains[@]} -gt 0 ]; then
    assertFileDoesNotContain "$errorFile" "${stderrNotContains[@]}" || return $?
  fi
  if [ ${#outputContains[@]} -gt 0 ]; then
    assertFileContains "$outputFile" "${outputContains[@]}" || return $?
  fi
  if [ ${#outputNotContains[@]} -gt 0 ]; then
    assertFileDoesNotContain "$outputFile" "${outputNotContains[@]}" || return $?
  fi
  if { test "$isExitCode" && [ "$expected" != "$actual" ]; } || { ! test "$isExitCode" && [ "$expected" = "$actual" ]; }; then
    # Failure
    printf "%s %s %s: %s -> %s, %s\n%s\n" \
      "$(_symbolFail)" "${usageFunction#_}" "$(consoleCode "$bin $*")" \
      "$(consoleError "$actual")" "$failureText" "$(consoleSuccess "$expected")" \
      "$(wrapLines "$(consoleCode)" "$(consoleReset)" <"$outputFile")" 1>&2
    rm -rf "$outputFile" "$errorFile" || :
    return $errorEnvironment
  fi
  printf "%s %s: %s -> %s\n" "$(_symbolSuccess)" "$(consoleSuccess "${usageFunction#_}")" "$(consoleCode "$bin $*")" "$(consoleSuccess "$actual")"
  rm -rf "$outputFile" "$errorFile" || :
  return 0
}

#
# Assert a process runs and exits with the correct exit code.
#
# If this fails it will output an error and exit.
#
# Usage: assertExitCode expectedExitCode command [ arguments ... ]
#
# Argument: - `expectedExitCode` - A numeric exit code expected from the command
# Argument: - `command` - The command to run
# Argument: - `arguments` - Any arguments to pass to the command to run
# Local cache: None.
# Environment: None.
# Examples: assertExitCode 0 hasHook version-current
# Reviewed: 2023-11-12
# Exit code: 0 - If the process exits with the provided exit code
# Exit code: 1 - If the process exits with a different exit code
#
assertExitCode() {
  _assertExitCodeHelper "_${FUNCNAME[0]}" "$@"
}
_assertExitCode() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Assert a process runs and exits with an exit code which does not match the passed in exit code.
#
# If this fails it will output an error and exit.
#
# Usage: assertNotExitCode expectedExitCode command [ arguments ... ]
# Argument: expectedExitCode - A numeric exit code not expected from the command
# Argument: command - The command to run
# Argument: arguments - Any arguments to pass to the command to run
# Examples: assertNotExitCode 0 hasHook make-cash-quickly
# Reviewed: 2023-11-12
# Exit code: 0 - If the process exits with a different exit code
# Exit code: 1 - If the process exits with the provided exit code
#
assertNotExitCode() {
  _assertExitCodeHelper "_${FUNCNAME[0]}" --not "$@"
}
_assertNotExitCode() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Assert one string contains another (case-sensitive)
#
# Usage: {fn} needle haystack
#
# Argument: needle - Thing we are looking for
# Argument: haystack - Thing we are looking in
# Exit Code: 0 - The assertion succeeded
# Exit Code: 1 - Assertion failed
# Exit Code: 2 - Bad arguments
#
assertContains() {
  local expected=$1 actual=$2 shortActual
  shift || return "$errorArgument"

  shift || return "$errorArgument"
  shortActual="$(printf %s "$actual" | head -n 5)"
  if [ "$shortActual" != "$actual" ]; then
    shortActual="${shortActual} ..."
  fi
  if ! printf %s "$actual" | grep -q "$expected"; then
    _assertFailure "${FUNCNAME[0]} \"$expected\" \"$shortActual\" but should: ${*-contain}"
  else
    _assertSuccess "${FUNCNAME[0]} \"$expected\" == \"$shortActual\" (correct)"
  fi
}

#
# Assert one string does not contains another (case-sensitive)
#
# Usage: {fn} needle haystack
#
# Argument: needle - Thing we are looking for
# Argument: haystack - Thing we are looking in
# Exit Code: 0 - The assertion succeeded
# Exit Code: 1 - Assertion failed
# Exit Code: 2 - Bad arguments
# See: assertContains
assertNotContains() {
  local expected=$1 actual=$2 shortActual
  shift || return "$errorArgument"

  shift || return "$errorArgument"
  shortActual="$(printf %s "$actual" | head -n 5)"
  if [ "$shortActual" != "$actual" ]; then
    shortActual="${shortActual} ..."
  fi
  if printf %s "$actual" | grep -q "$expected"; then
    _assertFailure "${FUNCNAME[0]} \"$expected\" \"$shortActual\" but should NOT: ${*-contain}"
  else
    _assertSuccess "${FUNCNAME[0]} \"$expected\" == \"$shortActual\" (correct)"
  fi
}

################################################################################################################################
#
# ▛▀▖▗          ▐
# ▌ ▌▄ ▙▀▖▞▀▖▞▀▖▜▀ ▞▀▖▙▀▖▌ ▌
# ▌ ▌▐ ▌  ▛▀ ▌ ▖▐ ▖▌ ▌▌  ▚▄▌
# ▀▀ ▀▘▘  ▝▀▘▝▀  ▀ ▝▀ ▘  ▗▄▘
#

#
# Usage: assertDirectoryExists directory [ message ... ]
#
# Argument: - `directory` - Directory that should exist
# Argument: - `message` - An error message if this fails
# Exit code: - `0` - If the assertion succeeds
# Exit code: - `1` - If the assertion fails
# Local cache: None
# Environment: - This fails if `directory` is anything but a `directory`
# Example:     assertDirectoryExists "$HOME" "HOME not found"
# Summary: Test that a directory exists
#
assertDirectoryExists() {
  local d=$1 noun=directory

  shift || _assertFailure "${FUNCNAME[0]} Missing directory argument"
  if [ ! -d "$d" ]; then
    _assertFailure "$(printf "%s: %s was expected to be a %s but is NOT %s\n" "$(consoleCode "${FUNCNAME[0]}")" "$(consoleError "$d")" "$noun" "$(consoleError "${message-$noun not found}")")"
  else
    _assertSuccess "${FUNCNAME[0]} $d is a directory"
  fi
}

#
# Usage: assertDirectoryDoesNotExist directory [ message ... ]
#
# Argument: - `directory` - Directory that should NOT exist
# Argument: - `message` - An error message if this fails
# Exit code: - `0` - If the assertion succeeds
# Exit code: - `1` - If the assertion fails
# Local cache: None
# Environment: - This fails if `directory` is anything at all, even a non-directory (such as a link)
# Examples: assertDirectoryDoesNotExist "$INSTALL_PATH" "INSTALL_PATH should not exist yet"
# Summary: Test that a directory does not exist
# Reviewed: 2023-11-12
#
assertDirectoryDoesNotExist() {
  local d=$1 noun=directory

  shift || _assertFailure "${FUNCNAME[0]} Missing directory argument"
  if [ -d "$d" ]; then
    _assertFailure "$(printf "%s: %s was expected NOT to be a %s but is %s (%s)\n" "$(consoleCode "${FUNCNAME[0]}")" "$(consoleError "$d")" "$noun" "$(consoleError "${message-$noun not found}")" "$(consoleWarning "$(type "$d")")")"
  else
    _assertSuccess "${FUNCNAME[0]} $d is a directory"
  fi
}

################################################################################################################################
#
# ▛▀▘▗▜
# ▙▄ ▄▐ ▞▀▖
# ▌  ▐▐ ▛▀
# ▘  ▀▘▘▝▀▘
#

#
# Usage: assertDirectoryExists directory [ message ... ]
#
# Argument: - `directory` - Directory that should exist
# Argument: - `message` - An error message if this fails
# Exit code: - `0` - If the assertion succeeds
# Exit code: - `1` - If the assertion fails
# Local cache: None
# Environment: - This fails if `directory` is anything but a `directory`
# Example:     assertDirectoryExists "$HOME" "HOME not found"
# Summary: Test that a file exists
#
assertFileExists() {
  local d=$1 noun=file

  shift
  message="$*"
  if [ ! -f "$d" ]; then
    _assertFailure "$(printf "%s: %s should exist but does NOT %s\n" "$(consoleCode "${FUNCNAME[0]}")" "$(consoleError "$d")" "$(consoleError "${message-$noun not found}")")"
    return 1
  else
    _assertSuccess "${FUNCNAME[0]} $d is a file"
  fi
}

#
# Usage: assertFileDoesNotExist file [ message ... ]
#
# Argument: - `file` - Directory that should NOT exist
# Argument: - `message` - An error message if this fails
# Exit code: - `0` - If the assertion succeeds
# Exit code: - `1` - If the assertion fails
# Local cache: None
# Environment: - This fails if `file` is anything at all, even a non-directory (such as a link)
# Examples: assertDirectoryDoesNotExist "$INSTALL_PATH" "INSTALL_PATH should not exist yet"
# Summary: Test that a file does not exist
# Reviewed: 2023-11-12
#
assertFileDoesNotExist() {
  local d=$1 noun=file

  shift
  if [ -f "$d" ]; then
    _assertFailure "$(printf "%s: %s should not exist but does %s (%s)\n" "$(consoleCode "${FUNCNAME[0]}")" "$(consoleError "$d")" "$(consoleError "${message-$noun WAS found}")" "$(consoleWarning "$(betterType "$d")")")"
    return 1
  else
    _assertSuccess "${FUNCNAME[0]} $d file does not exist"
  fi
}

################################################################################################################################
#
# ▞▀▖   ▐        ▐
# ▌ ▌▌ ▌▜▀ ▛▀▖▌ ▌▜▀
# ▌ ▌▌ ▌▐ ▖▙▄▘▌ ▌▐ ▖
# ▝▀ ▝▀▘ ▀ ▌  ▝▀▘ ▀

#
# Assert output of a binary equals a string
#
# If this fails it will output an error and exit.
#
# Usage: assertOutputEquals expected binary [ parameters ]
# Argument: - `expected` - Expected string
# Argument: - `binary` - Binary to run and evaluate output
# Argument: - `parameters` - Any additional parameters to binary
# Example:     assertOutputEquals "2023" date +%Y
# Reviewed: 2023-11-12
#
assertOutputEquals() {
  local expected=$1 actual
  shift
  actual=$("$@" || printf "exited with code %d" "$?")
  if [ "$expected" != "$actual" ]; then
    _assertFailure "${FUNCNAME[0]} \"$expected\" \"$actual\" (output of \"$*\")"
  else
    _assertSuccess "${FUNCNAME[0]} \"$expected\" \"$actual\" (CORRECT: $1)"
  fi
}

#
# Run a command and expect the output to contain the occurrence of a string.
#
# If this fails it will output the command result to stdout.
#
# Usage: {fn} expected command [ arguments ... ]
# Argument: - `expected` - A string to expect in the output
# Argument: - `command` - The command to run
# Argument: - `arguments` - Any arguments to pass to the command to run
# Argument: - `--exit` - Assert exit status of process to be this number
# Argument: - `--stderr` - Also include standard error in output checking
# Exit code: 0 - If the output contains at least one occurrence of the string
# Exit code: 1 - If output does not contain string
# Example:     {fn} Success complex-thing.sh --dry-run
# Reviewed: 2023-11-12
#
assertOutputContains() {
  local nLines expected="" commands=() tempFile exitCode=0 pipeStdErr=""

  while [ $# -gt 0 ]; do
    case $1 in
      --exit)
        shift
        assertExitCode 0 isNumber "$1"
        exitCode="$1"
        ;;
      --stderr)
        pipeStdErr=1
        ;;
      *)
        if [ -z "$expected" ]; then
          expected="$1"
        else
          commands+=("$1")
        fi
        ;;
    esac
    shift
  done
  tempFile=$(mktemp)
  printf "%s%s%s: \"%s%s%s\"\n" "$(consoleInfo)" "Running" "$(consoleReset)" "$(consoleCode)" "${commands[*]}" "$(consoleReset)"
  if test $pipeStdErr; then
    actual=$(
      "${commands[@]}" >"$tempFile" 2>&1
      echo $?
    )
  else
    actual=$(
      "${commands[@]}" >"$tempFile"
      echo $?
    )
  fi
  assertEquals "$exitCode" "$actual" "Exit code should be $exitCode ($actual)"
  if grep -q "$expected" "$tempFile"; then
    _assertSuccess "\"$expected\" found in \"${commands[*]}\" output"
  else
    consoleInfo "$(echoBar)" 1>&2
    prefixLines "$(consoleCode)" <"$tempFile" 1>&2
    consoleError "$(echoBar)" 1>&2
    nLines=$(($(wc -l <"$tempFile") + 0))
    consoleSuccess "$(printf "%d %s\n" "$nLines" "$(plural "$nLines" line lines)")" 1>&2
    _assertFailure "$(printf "%s%s\n" "$(consoleError "\"$expected\" not found in \"${commands[*]}\" output")" "$(consoleCode)")"
  fi
}

#
# Run a command and expect the output to not contain the occurrence of a string.
#
# If this fails it will output the command result to stdout.
#
# Usage: assertOutputDoesNotContain expected command [ arguments ... ]
# Argument: - `expected` - A string to NOT expect in the output
# Argument: - `command` - The command to run
# Argument: - `arguments` - Any arguments to pass to the command to run
# Argument: - `--exit` - Assert exit status of process to be this number
# Argument: - `--stderr` - Also include standard error in output checking
# Exit code: 0 - If the output contains at least one occurrence of the string
# Exit code: 1 - If output does not contain string
# Local cache: None
# Example:     assertOutputDoesNotContain Success complex-thing.sh --dry-run
# Reviewed: 2023-11-12
#
assertOutputDoesNotContain() {
  local expected="" commands=() tempFile exitCode=0 pipeStdErr=""

  while [ $# -gt 0 ]; do
    case $1 in
      --exit)
        shift
        assertExitCode 0 isNumber "$1"
        exitCode="$1"
        ;;
      --stderr)
        pipeStdErr=1
        ;;
      *)
        if [ -z "$expected" ]; then
          expected="$1"
        else
          commands+=("$1")
        fi
        ;;
    esac
    shift
  done
  tempFile=$(mktemp)
  if test $pipeStdErr; then
    actual=$(
      "${commands[@]}" >"$tempFile" 2>&1
      echo $?
    )
  else
    actual=$(
      "${commands[@]}" >"$tempFile"
      echo $?
    )
  fi
  assertEquals "$exitCode" "$actual" "Exit code should be $exitCode"
  if ! grep -q "$expected" "$tempFile"; then
    _assertSuccess "${FUNCNAME[0]} $expected NOT found in ${commands[*]} output (correct)"
  else
    prefixLines "$(consoleCode)" <"$tempFile" 1>&2
    consoleError "$(echoBar)" 1>&2
    _assertFailure "${FUNCNAME[0]} $expected found in $* output (incorrect)"
  fi
}

# Usage: assertFileContains fileName string0 [ ... ]
#
# Argument: - `fileName` - File to search
# Argument: - `string0 ...` - One or more strings which must be found on at least one line in the file
#
# Exit code: - `0` - If the assertion succeeds
# Exit code: - `1` - If the assertion fails
# Local cache: None
# Environment: If the file does not exist, this will fail.
# Example:     assertFileContains $logFile Success
# Example:     assertFileContains $logFile "is up to date"
# Reviewed: 2023-11-12
#
assertFileContains() {
  local f=$1 args

  args=("$@")
  shift || _assertFailure "Missing argument" || return $?
  if [ ! -f "$f" ]; then
    consoleError "${FUNCNAME[0]}: $f is not a file: $*"
  fi
  while [ $# -gt 0 ]; do
    if ! grep -q "$1" "$f"; then
      dumpFile "$f"
      _assertFailure "${FUNCNAME[0]}: $f does not contain string: $1"
      return 1
    fi
    shift
  done
  _assertSuccess "${FUNCNAME[0]}: $f contains strings: $(consoleCode "$(printf "%s" "${args[@]+${args[@]}}")")"
}

#
# Usage: assertFileDoesNotContain fileName string0 [ ... ]
#
# Argument: - `fileName` - File to search
# Argument: - `string0 ...` - One or more strings which must NOT be found anywhere in `fileName`
# Exit code: - `1` - If the assertions fails
# Exit code: - `0` - If the assertion succeeds
# Environment: If the file does not exist, this will fail.
# Example:     assertFileDoesNotContain $logFile error Error ERROR
# Example:     assertFileDoesNotContain $logFile warning Warning WARNING
#
assertFileDoesNotContain() {
  local f=$1 args

  args=("$@")
  shift || _assertFailure "Missing argument" || return $?
  if [ ! -f "$f" ]; then
    consoleError "${FUNCNAME[0]}: $f is not a file: $*"
  fi
  while [ $# -gt 0 ]; do
    if grep -q "$1" "$f"; then
      dumpFile "$f"
      _assertFailure "${FUNCNAME[0]}: $f does contain string: $1"
      return 1
    fi
    shift
  done
  _assertSuccess "${FUNCNAME[0]}: $f does not contain strings: $(consoleCode "$(printf "%s" "${args[@]+${args[@]}}")")"
}

#
# Usage: {fn} expectedSize [ fileName ... ]
#
# Argument: - `expectedSize` - Integer file size which `fileName` should be, in bytes.
# Argument: - `fileName ...` - One ore more file which should be `expectedSize` bytes in size.
# Exit code: - `1` - If the assertions fails
# Exit code: - `0` - If the assertion succeeds
# Environment: If the file does not exist, this will fail.
# Example:     {fn} 22 .config
# Example:     {fn} 0 .env
#
assertFileSize() {
  local expectedSize="${1-}" actualSize

  assertExitCode 0 isInteger "$expectedSize" || return $?
  shift || :
  while [ $# -gt 0 ]; do
    if ! actualSize="$(fileSize "$1")"; then
      _assertFailure "${FUNCNAME[0]}: fileSize \"$(escapeDoubleQuotes "$1")\" failed -> $?"
      return $errorArgument
    fi
    assertEquals "$expectedSize" "$actualSize" "${FUNCNAME[0]}: File $1 actual size $actualSize is not expected $expectedSize" || return $?
    shift
  done
}

#
# Usage: {fn} expectedSize [ fileName ... ]
#
# Argument: - `expectedSize` - Integer file size which `fileName` should NOT be, in bytes.
# Argument: - `fileName ...` - One ore more file which should NOT be `expectedSize` bytes in size.
# Exit code: - `1` - If the assertions fails
# Exit code: - `0` - If the assertion succeeds
# Environment: If the file does not exist, this will fail.
# Example:     {fn} 22 .config
# Example:     {fn} 0 .env
#
assertNotFileSize() {
  local expectedSize="${1-}" actualSize

  assertExitCode 0 isInteger "$expectedSize" || return $?
  shift || :
  while [ $# -gt 0 ]; do
    if ! actualSize="$(fileSize "$1")"; then
      _assertFailure "${FUNCNAME[0]}: fileSize \"$(escapeDoubleQuotes "$1")\" failed -> $?"
      return $errorArgument
    fi
    assertNotEquals "$expectedSize" "$actualSize" "${FUNCNAME[0]}: File $1 actual size $actualSize incorrectly matches expected $expectedSize" || return $?
    shift
  done
}

#
# Usage: {fn} [ fileName ... ]
#
# Argument: - `fileName ...` - One ore more file which should be zero bytes in size.
# Exit code: - `1` - If the assertions fails
# Exit code: - `0` - If the assertion succeeds
# Environment: If the file does not exist, this will fail.
# Example:     {fn} .config
# Example:     {fn} /var/www/log/error.log
#
assertZeroFileSize() {
  assertFileSize 0 "$@"
}

#
# Usage: {fn} [ fileName ... ]
#
# Argument: - `fileName ...` - One ore more file which should NOT be zero bytes in size.
# Exit code: - `1` - If the assertions fails
# Exit code: - `0` - If the assertion succeeds
# Environment: If the file does not exist, this will fail.
# Example:     {fn} 22 .config
# Example:     {fn} 0 .env
#
assertNotZeroFileSize() {
  assertNotFileSize 0 "$@"
}

################################################################################################################################
#
# ▙ ▌             ▗     ▞▀▖                ▗
# ▌▌▌▌ ▌▛▚▀▖▞▀▖▙▀▖▄ ▞▀▖ ▌  ▞▀▖▛▚▀▖▛▀▖▝▀▖▙▀▖▄ ▞▀▘▞▀▖▛▀▖
# ▌▝▌▌ ▌▌▐ ▌▛▀ ▌  ▐ ▌ ▖ ▌ ▖▌ ▌▌▐ ▌▙▄▘▞▀▌▌  ▐ ▝▀▖▌ ▌▌ ▌
# ▘ ▘▝▀▘▘▝ ▘▝▀▘▘  ▀▘▝▀  ▝▀ ▝▀ ▘▝ ▘▌  ▝▀▘▘  ▀▘▀▀ ▝▀ ▘ ▘
#

#
# Assert `leftValue > rightValue`
#
# Usage: assertGreaterThan expected actual [ message ]
# Argument: leftValue - Value to compare on the left hand side of the comparison
# Argument: rightValue - Value to compare on the right hand side of the comparison
# Argument: message - Message to output if the assertion fails
# Example:     assertGreaterThan 3 "$found"
# Reviewed: 2023-11-14
#
assertGreaterThan() {
  _assertNumeric "${FUNCNAME[0]}" -gt "$@"
}

# Assert `leftValue >= rightValue`
#
# Usage: assertNotEquals expected actual [ message ]
# Argument: leftValue - Value to compare on the left hand side of the comparison
# Argument: rightValue - Value to compare on the right hand side of the comparison
# Argument: - `message` - Message to output if the assertion fails
# Example:     assertGreaterThanOrEqual 3 $found
# Reviewed: 2023-11-12
# Summary: Assert actual value is greater than or equal to expected value
assertGreaterThanOrEqual() {
  _assertNumeric "${FUNCNAME[0]}" -ge "$@"
}

#
# Assert `leftValue < rightValue`
#
# Usage: assertLessThan expected actual [ message ]
# Argument: leftValue - Value to compare on the left hand side of the comparison
# Argument: rightValue - Value to compare on the right hand side of the comparison
# Argument: - `message` - Message to output if the assertion fails
# Example:     assertLessThan 3 $found
# Reviewed: 2023-11-12
# Exit code: 0 - expected less than to actual
# Exit code: 1 - expected greater than or equal to actual, or invalid numbers
assertLessThan() {
  _assertNumeric "${FUNCNAME[0]}" -lt "$@"
}

# Assert `leftValue <= rightValue`
#
# Usage: assertLessThanOrEqual leftValue rightValue [ message ]
# Argument: leftValue - Value to compare on the left hand side of the comparison
# Argument: rightValue - Value to compare on the right hand side of the comparison
# Argument: - `message` - Message to output if the assertion fails
# Example:     assertLessThanOrEqual 3 $found
# Reviewed: 2023-11-12
# Exit code: 0 - expected less than or equal to actual
# Exit code: 1 - expected greater than actual, or invalid numbers
#
assertLessThanOrEqual() {
  _assertNumeric "${FUNCNAME[0]}" -le "$@"
}

#
_assertNumeric() {
  local func cmp leftValue rightValue
  func="$1"
  shift || return $?
  cmp="$1"
  shift || return $?
  leftValue="$1"
  shift || return $?
  rightValue="$1"
  shift || return $?

  if ! isNumber "$leftValue"; then
    _assertFailure "$func [ \"$leftValue\" $cmp \"$rightValue\" ] (not number $leftValue): $*"
    return "$errorEnvironment"
  fi
  if ! isNumber "$rightValue"; then
    _assertFailure "$func [ \"$leftValue\" $cmp\"$rightValue\" ] (not number $rightValue): $*"
    return "$errorEnvironment"
  fi
  if test "$leftValue" "$cmp" "$rightValue"; then
    _assertSuccess "$func [ \"$leftValue\" $cmp \"$rightValue\" ] (correct)"
  else
    _assertFailure "$func [ \"$leftValue\" $cmp \"$rightValue\" ] (FAILED): $*"
    return "$errorEnvironment"
  fi
}
