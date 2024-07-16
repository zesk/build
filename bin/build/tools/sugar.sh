#!/usr/bin/env bash
#
# Syntactic sugar
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: isInteger isFunction isCallable
#
# Docs: contextOpen ./docs/_templates/tools/sugar.md
# Test: contextOpen ./test/tools/sugar-tests.sh

# IDENTICAL __return 8
# Usage: {fn} __return binary [ ... ]
# Argument: binary - Required. Executable.
# Argument: ... - Any arguments are passed to binary
# Run binary and output failed command upon error
__return() {
  [ $# -gt 0 ] || _argument "${FUNCNAME[0]} no arguments $(debuggingStack -s)" || return $?
  "$@" || _return "$?" "$@" || return $?
}

# Run `command`, handle failure with `usage` with `code` and `command` as error
# Usage: {fn} code usage command ...
# Argument: code - Required. Integer. Exit code to return
# Argument: usage - Required. String. Failure command, passed remaining arguments and error code.
# Argument: command - Required. String. Command to run.
__usage() {
  local code="${1-0}" usage="$2" command="${3?}"
  isInteger "$code" || _argument "${FUNCNAME[0]} Not integer $code $usage $command" || return $?
  isFunction "$usage" || _argument "${FUNCNAME[0]} \"$usage\" is not usage function $(debuggingStack)" || return $?
  isCallable "$command" || _argument "${FUNCNAME[0]} \"$command\" is not callable" || return $?
  shift 3 || :
  "$command" "$@" || "$usage" "$code" "$(_command "$command" "$@")" || return $?
}

# Run `command`, upon failure run `usage` with an environment error
# Usage: {fn} usage command ...
# Argument: usage - Required. String. Failure command
# Argument: command - Required. Command to run.
__usageEnvironment() {
  __usage "$(_code "${FUNCNAME[0]#__usage}")" "$@"
}

# Run `command`, upon failure run `usage` with an argument error
# Usage: {fn} usage command ...
# Argument: usage - Required. String. Failure command
# Argument: command - Required. Command to run.
__usageArgument() {
  __usage "$(_code "${FUNCNAME[0]#__usage}")" "$@"
}

# Run `usage` with an environment error
# Usage: {fn} usage ...
__failEnvironment() {
  local usage="${1-}"
  isFunction "$usage" || _argument "${FUNCNAME[0]} \"$usage\" is not usage function $(debuggingStack)" || return $?
  shift && "$usage" "$(_code environment)" "$@" || return $?
}

# Run `usage` with an argument error
# Usage: {fn} usage ...
__failArgument() {
  local usage="${1-}"
  isFunction "$usage" || _argument "${FUNCNAME[0]} \"$usage\" is not usage function $(debuggingStack)" || return $?
  shift && "$usage" "$(_code argument)" "$@" || return $?
}

# Run `usage` with an environment error
# Usage: {fn} usage quietLog message ...
__usageEnvironmentQuiet() {
  local usage="${1-}" quietLog="${2-}"
  isFunction "$usage" || _argument "${FUNCNAME[0]} \"$usage\" is not usage function $(debuggingStack)" || return $?
  shift 2 && "$@" >>"$quietLog" 2>&1 || buildFailed "$quietLog" || __failEnvironment "$usage" "$@" || return $?
}

#
# Check output for content and trigger environment error if found
# Usage {fn} [ --help ] [ --verbose ] [ --name name ]
# Argument: --help - Help
# Argument: --verbose - Optional. Flag. Verbose messages when no errors exist.
# Argument: --name name - Optional. String. Name for verbose mode.
# # shellcheck source=/dev/null
# Example:     source "$include" > >(_environmentOutput source "$include") || return $?
_environmentOutput() {
  local usage="_${FUNCNAME[0]}"
  local argument
  local error message verbose name

  name="${FUNCNAME[1]}}"
  verbose=false
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --help)
        "$usage" 0
        return $?
        ;;
      --verbose)
        verbose=true
        ;;
      --name)
        shift || __failArgument "$usage" "missing $argument argument" || return $?
        [ -n "$1" ] || __failArgument "$usage" "Blank $argument argument" || return $?
        name="$1"
        ;;
      *)
        break
        ;;
    esac
    shift || __failArgument "$usage" "shift argument $argument" || return $?
  done

  error=$(mktemp) || __failEnvironment "$usage" "mktemp" "$@" || return $?
  lineCount=0
  while read -r line; do
    printf "%s\n" "$line" >>"$error"
    lineCount=$((lineCount + 1))
  done
  lineText="$lineCount $(plural "$lineCount" line lines)"
  if [ ! -s "$error" ]; then
    rm -rf "$error" || :
    ! $verbose || consoleInfo "No output in $(consoleCode "$name") $(consoleValue "$lineText")" || :
    return 0
  fi
  message=$(dumpFile "$error") || message="dumpFile $error failed"
  rm -rf "$error" || :
  _environment "stderr found in $(consoleCode "$name") $(consoleValue "$lineText"): " "$@" "$message" || return $?
}
__environmentOutput() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Logs all deprecated functions to application root in a file called `.deprecated`
# Usage: {fn} command ...
# Argument: function - Required. String. Function which is deprecated.
# Example:     {fn} "${FUNCNAME[0]}"
_deprecated() {
  printf "DEPRECATED: %s" "$@" 1>&2
  printf -- "$(date "+%F %T"),%s\n" "$@" >>"$(dirname "$(dirname "$(dirname "${BASH_SOURCE[0]}")")")/.deprecated"
}

# Usage: {fn} exitCode item ...
# Argument: exitCode - Required. Integer. Exit code to return.
# Argument: item - Optional. One or more files or folders to delete, failures are logged to stderr.
_clean() {
  local exitCode="${1-}"
  shift
  isUnsignedInteger "$exitCode" || _argument "${FUNCNAME[0]} $*" || return $?
  while [ $# -gt 0 ]; do
    [ ! -f "$1" ] || __environment rm "$1" || return $?
    [ ! -d "$1" ] || __environment rm -rf "$1" || return $?
    shift
  done
  return "$exitCode"
}
