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
# Argument: handler - Callable. Required. Function to call on error.
# Argument: command - Callable. Required. Command to run.
# Argument: ... - Arguments. Optional. Any additional arguments to `command`.
__catch() {
  local __count=$# __saved=("$@") handler="$1" command="$2"
  shift 2 || __throwArgument "$handler" "missing arguments #$__count $(decorate each code "${__saved[@]}")" || return $?
  isCallable "$handler" || __throwArgument "$handler" "handler not callable $(decorate code "$handler")" || return $?
  isCallable "$command" || __throwArgument "$handler" "command Not callable $(decorate code "$command")" || return $?
  "$command" "$@" || "$handler" "$?" "$command" "$@" || return $?
}
___catch() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run `command`, handle failure with `handler` with `code` and `command` as error
# Usage: {fn} code handler command ...
# Argument: code - Required. Integer. Exit code to return
# Argument: handler - Required. String. Failure command, passed remaining arguments and error code.
# Argument: command - Required. String. Command to run.
# Requires: isInteger _argument isFunction isCallable
__catchCode() {
  local __count=$# __saved=("$@") usage="_${FUNCNAME[0]}" code="${1-0}" handler="${2-}" command="${3-}"
  isInteger "$code" || __throwArgument "$usage" "Not integer: $(decorate value "[$code]") (#$__count $(decorate each code "${__saved[@]}"))" || return $?
  isFunction "$handler" || __throwArgument "$usage" "Not a function $(decorate code "$handler"): $(debuggingStack)" || return $?
  isCallable "$command" || __throwArgument "$usage" "Not callable $(decorate code "$command")" || return $?
  shift 3
  "$command" "$@" || "$handler" "$code" "$(decorate each code "$command" "$@")" || return $?
}
___catchCode() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run `command`, upon failure run `handler` with an environment error
# Usage: {fn} handler command ...
# Argument: handler - Required. String. Failure command
# Argument: command - Required. Command to run.
__catchEnvironment() {
  __catchCode 1 "$@" || return $?
}

# Run `command`, upon failure run `handler` with an argument error
# Usage: {fn} handler command ...
# Argument: handler - Required. String. Failure command
# Argument: command - Required. Command to run.
__catchArgument() {
  __catchCode 2 "$@" || return $?
}

# Run `handler` with an environment error
# Usage: {fn} handler ...
__throwEnvironment() {
  local handler="${1-}"
  isFunction "$handler" || _argument "${FUNCNAME[0]} \"$handler\" is not handler function $(debuggingStack)" || return $?
  shift && "$handler" 1 "$@" || return $?
}

# Run `handler` with an argument error
# Usage: {fn} handler ...
__throwArgument() {
  local handler="${1-}"
  isFunction "$handler" || _argument "${FUNCNAME[0]} \"$handler\" is not handler function $(debuggingStack)" || return $?
  shift && "$handler" 2 "$@" || return $?
}

# Run `handler` with an environment error
# Usage: {fn} handler quietLog message ...
# Requires: isFunction _argument buildFailed debuggingStack __throwEnvironment
__catchEnvironmentQuiet() {
  local handler="${1-}" quietLog="${2-}"
  isFunction "$handler" || _argument "${FUNCNAME[0]} \"$handler\" is not handler function $(debuggingStack)" || return $?
  shift 2 && "$@" >>"$quietLog" 2>&1 || buildFailed "$quietLog" || __throwEnvironment "$handler" "$@" || return $?
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

# Usage: {fn} command ...
# Suppress stdout without piping. Handy when you just want a behavior not the output. e.g. `muzzle pushd`
# Argument: command - Required. Callable. Thing to muzzle.
# Argument: ... - Optional. Arguments. Additional arguments.
# Example:     {fn} pushd
# Example:     __catchEnvironment "$handler" phpBuild || _undo $? {fn} popd || return $?
muzzle() {
  "$@" >/dev/null
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
  local usage="_${FUNCNAME[0]}" value="" from="" to=""

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        if [ -z "$value" ]; then
          value=$(usageArgumentUnsignedInteger "$usage" "value" "$1") || return $?
        elif [ -z "$from" ]; then
          from=$(usageArgumentUnsignedInteger "$usage" "from" "$1") || return $?
        elif [ -z "$to" ]; then
          to=$(usageArgumentUnsignedInteger "$usage" "to" "$1") || return $?
          if [ "$value" -eq "$from" ]; then
            return "$to"
          fi
          from="" && to=""
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  return "${value:-0}"
}
_mapReturn() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# _IDENTICAL_ __execute 7

# Argument: binary ... - Required. Executable. Any arguments are passed to `binary`.
# Run binary and output failed command upon error
# Requires: _return
__execute() {
  "$@" || _return "$?" "$@" || return $?
}

# IDENTICAL _undo 37

# Run a function and preserve exit code
# Returns `exitCode`
# Argument: exitCode - Required. Integer. Exit code to return.
# Argument: undoFunction - Optional. Command to run to undo something. Return status is ignored.
# Argument: -- - Flag. Optional. Used to delimit multiple commands.
# As a caveat, your command to `undo` can NOT take the argument `--` as a parameter.
# Example:     local undo thing
# Example:     thing=$(__catchEnvironment "$handler" createLargeResource) || return $?
# Example:     undo+=(-- deleteLargeResource "$thing")
# Example:     thing=$(__catchEnvironment "$handler" createMassiveResource) || _undo $? "${undo[@]}" || return $?
# Example:     undo+=(-- deleteMassiveResource "$thing")
# Requires: isPositiveInteger __catchArgument decorate __execute
# Requires: usageDocument
_undo() {
  local __count=$# __saved=("$@") __usage="_${FUNCNAME[0]}" exitCode="${1-}" args=()
  shift
  isPositiveInteger "$exitCode" || __catchArgument "$__usage" "Not an integer $(decorate value "$exitCode") (#$__count: $(decorate each code "${__saved[@]+"${__saved[@]}"}"))" || return $?
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
  return "$exitCode"
}
__undo() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
