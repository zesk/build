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
  # IDENTICAL _integerExitCode 1
  _integer "$exitCode" || _argument "${FUNCNAME[0]} $exitCode (not an integer) $*" || return $?
  while [ $# -gt 0 ]; do
    [ ! -f "$1" ] || __environment rm "$1" || return $?
    [ ! -d "$1" ] || __environment rm -rf "$1" || return $?
    shift
  done
  return "$exitCode"
}

# Usage: {fn} exitCode undoFunction ...
# Argument: exitCode - Required. Integer. Exit code to return.
# Argument: undoFunction - Required. Command to run to undo something. Returns `exitCode`
_undo() {
  local exitCode="${1-}"
  shift
  # IDENTICAL _integerExitCode 1
  _integer "$exitCode" || _argument "${FUNCNAME[0]} $exitCode (not an integer) $*" || return $?
  isCallable "$1" || _argument "_undo $1 is not callable: $*" || return "$exitCode"
  __execute "$@" || :
  return "$exitCode"
}
