#!/usr/bin/env bash
#
# Syntactic sugar
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Docs: contextOpen ./documentation/source/tools/sugar.md
# Test: contextOpen ./test/tools/sugar-tests.sh

# Run a command, fail using a handler
# Usage: {fn} handler command arguments
# Argument: handler - Function. Required. Function to call on error.
# Argument: command - Callable. Required. Command to run.
# Argument: ... - Arguments. Optional. Any additional arguments to `command`.
__catch() {
  local __count=$# __saved=("$@") __handler="${1-}" command="${2-}"
  shift 2 || __throwArgument "$__handler" "missing arguments #$__count $(decorate each code "${__saved[@]}")" || return $?
  "$command" "$@" || "$__handler" "$?" "$command" "$@" || return $?
}
___catch() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run `command`, handle failure with `handler` with `code` and `command` as error
# Usage: {fn} code handler command ...
# Argument: code - Required. Integer. Exit code to return
# Argument: handler - Required. Function. Failure command, passed remaining arguments and error code.
# Argument: command - Required. String. Command to run.
# Requires: isInteger _argument isFunction isCallable
__catchCode() {
  local __count=$# __saved=("$@") __handler="_${FUNCNAME[0]}" code="${1-0}" command="${3-}"
  __handler="${2-}"
  shift 3
  "$command" "$@" || "$__handler" "$code" "$(decorate each code "$command" "$@")" || return $?
}
___catchCode() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run `command`, upon failure run `handler` with an environment error
# Usage: {fn} handler command ...
# Argument: handler - Required. Function. Failure command
# Argument: command - Required. Command to run.
__catchEnvironment() {
  __catchCode 1 "$@" || return $?
}

# Run `command`, upon failure run `handler` with an argument error
# Argument: handler - Required. Function. Failure command
# Argument: command - Required. Command to run.
__catchArgument() {
  __catchCode 2 "$@" || return $?
}

# Run `handler` with an environment error
# Argument: handler - Required. Function. Failure command
# Argument: message - Optional. Error message to display.
__throwEnvironment() {
  local __handler="${1-}"
  shift && "$__handler" 1 "$@" || return $?
}

# Run `handler` with an argument error
# Argument: handler - Required. Function. Failure command
# Argument: message - Optional. Error message to display.
__throwArgument() {
  local __handler="${1-}"
  shift && "$__handler" 2 "$@" || return $?
}

# Run `handler` with an environment error
# Usage: {fn} handler quietLog message ...
# Requires: isFunction _argument buildFailed debuggingStack __throwEnvironment
__catchEnvironmentQuiet() {
  local __handler="${1-}" quietLog="${2-}"
  shift 2 && "$@" >>"$quietLog" 2>&1 || buildFailed "$quietLog" || __throwEnvironment "$__handler" "$@" || return $?
}

# Logs all deprecated functions to application root in a file called `.deprecated`
# Usage: {fn} command ...
# Argument: function - Required. String. Function which is deprecated.
# Example:     {fn} "${FUNCNAME[0]}"
# Requires: printf date
_deprecated() {
  export BUILD_HOME
  printf "DEPRECATED: %s\n" "$@" 1>&2
  [ ! -d "$BUILD_HOME" ] || printf -- "$(date "+%F %T"),%s\n%s\n" "$*" "$(debuggingStack)" >>"${BUILD_HOME}/.deprecated"
}

# Suppress stdout without piping. Handy when you just want a behavior not the output.
# Argument: command - Required. Callable. Thing to muzzle.
# Argument: ... - Optional. Arguments. Additional arguments.
# Example:     {fn} pushd
# Example:     __catchEnvironment "$handler" phpBuild || returnUndo $? {fn} popd || return $?
# stdout: - No output from stdout ever from this function
muzzle() {
  "$@" >/dev/null
}
_muzzle() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# map a return value from one value to another
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: value - Integer. A return value.
# Argument: from - Integer. When value matches `from`, instead return `to`
# Argument: to - Integer. The value to return when `from` matches `value`
# Argument: ... - Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match
mapReturn() {
  local handler="_${FUNCNAME[0]}" value="" from="" to=""

  while [ $# -gt 0 ]; do
    if [ -z "$value" ]; then
      value=$(usageArgumentUnsignedInteger "$__handler" "value" "$1") || return $?
    elif [ -z "$from" ]; then
      from=$(usageArgumentUnsignedInteger "$__handler" "from" "$1") || return $?
    elif [ -z "$to" ]; then
      to=$(usageArgumentUnsignedInteger "$__handler" "to" "$1") || return $?
      if [ "$value" -eq "$from" ]; then
        return "$to"
      fi
      from="" && to=""
    fi
    shift
  done
  return "${value:-0}"
}
_mapReturn() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# map a value from one value to another given from-to pairs
#
# Prints the mapped value to stdout
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: value - String. A value.
# Argument: from - String. When value matches `from`, instead print `to`
# Argument: to - String. The value to print when `from` matches `value`
# Argument: ... - Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match
convertValue() {
  local __handler="_${FUNCNAME[0]}" value="" from="" to=""

  while [ $# -gt 0 ]; do
    if [ -z "$value" ]; then
      value=$(usageArgumentString "$__handler" "value" "$1") || return $?
    elif [ -z "$from" ]; then
      from=$(usageArgumentString "$__handler" "from" "$1") || return $?
    elif [ -z "$to" ]; then
      to=$(usageArgumentString "$__handler" "to" "$1") || return $?
      if [ "$value" = "$from" ]; then
        printf "%s\n" "$to"
        return 0
      fi
      from="" && to=""
    fi
    shift
  done
  printf "%s\n" "${value:-0}"
}
_convertValue() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: binary ... - Required. Executable. Any arguments are passed to `binary`.
# Run binary and output failed command upon error
# Requires: _return
__execute() {
  "$@" || _return "$?" "$@" || return $?
}

# Run a function and preserve exit code
# Returns `code`
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: code - Required. UnsignedInteger. Exit code to return.
# Argument: undoFunction - Optional. Command to run to undo something. Return status is ignored.
# Argument: -- - Flag. Optional. Used to delimit multiple commands.
# As a caveat, your command to `undo` can NOT take the argument `--` as a parameter.
# Example:     local undo thing
# Example:     thing=$(__catchEnvironment "$handler" createLargeResource) || return $?
# Example:     undo+=(-- deleteLargeResource "$thing")
# Example:     thing=$(__catchEnvironment "$handler" createMassiveResource) || returnUndo $? "${undo[@]}" || return $?
# Example:     undo+=(-- deleteMassiveResource "$thing")
# Requires: isPositiveInteger __catchArgument decorate __execute
# Requires: usageDocument
returnUndo() {
  local __count=$# __saved=("$@") __handler="_${FUNCNAME[0]}" code="${1-}" args=()
  shift
  while [ $# -gt 0 ]; do
    case "$1" in
    --)
      [ "${#args[@]}" -eq 0 ] || __execute "${args[@]}" || :
      args=()
      ;;
    *)
      args+=("$1")
      ;;
    esac
    shift
  done
  [ "${#args[@]}" -eq 0 ] || __execute "${args[@]}" || :
  return "$code"
}
_returnUndo() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Support arguments and stdin as arguments to an executor
# Argument: executor ... -- - The command to run on each line of input or on each additional argument. Arguments to prefix the final variable argument can be supplied prior to an initial `--`.
# Argument: -- - Alone after the executor forces `stdin` to be ignored. The `--` flag is also removed from the arguments passed to the executor.
# Argument: ... - Any additional arguments are passed directly to the executor
__executeInputSupport() {
  local handler="$1" executor=() && shift

  while [ $# -gt 0 ]; do
    if [ "$1" = "--" ]; then
      shift
      break
    fi
    executor+=("$1")
    shift
  done
  [ ${#executor[@]} -gt 0 ] || return 0

  local byte
  # On Darwin `read -t 0` DOES NOT WORK as a select on stdin
  if [ $# -eq 0 ] && IFS="" read -r -t 1 -n 1 byte; then
    local line done=false
    if [ "$byte" = $'\n' ]; then
      __catchEnvironment "$handler" "${executor[@]}" "" || return $?
      byte=""
    fi
    while ! $done; do
      IFS="" read -r line || done=true
      [ -n "$byte$line" ] || ! $done || break
      __catchEnvironment "$handler" "${executor[@]}" "$byte$line" || return $?
      byte=""
    done
  else
    if [ "${1-}" = "--" ]; then
      shift
    fi
    __catchEnvironment "$handler" "${executor[@]}" "$@" || return $?
  fi
}
