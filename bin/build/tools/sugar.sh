#!/usr/bin/env bash
#
# Syntactic sugar
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Docs: contextOpen ./docs/_templates/tools/sugar.md
# Test: contextOpen ./test/tools/sugar-tests.sh

# IDENTICAL __execute 9
# Usage: {fn} __execute binary [ ... ]
# Argument: binary - Required. Executable.
# Argument: ... - Any arguments are passed to binary
# Run binary and output failed command upon error
# Unlike `_sugar.sh`'s `__execute`, this does not depend on `_command`.
# Requires: _return
__execute() {
  "$@" || _return "$?" "$@" || return $?
}

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
  local __count=$# __saved=("$@") handler="_${FUNCNAME[0]}" code="${1-0}" handler="${2-}" command="${3?}"
  isInteger "$code" || __throwArgument "$handler" "Not integer: $code (#$__count $(decorate each code "${__saved[@]}"))" || return $?
  isFunction "$handler" || __throwArgument "$handler" "Not a function $(decorate code "$handler"): $(debuggingStack)" || return $?
  isCallable "$command" || __throwArgument "$handler" "Not callable $(decorate code "$command")" || return $?
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
  __catchCode 1 "$@"
}

# Run `command`, upon failure run `handler` with an argument error
# Usage: {fn} handler command ...
# Argument: handler - Required. String. Failure command
# Argument: command - Required. Command to run.
__catchArgument() {
  __catchCode 2 "$@"
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
__catchEnvironmentQuiet() {
  local handler="${1-}" quietLog="${2-}"
  isFunction "$handler" || _argument "${FUNCNAME[0]} \"$handler\" is not handler function $(debuggingStack)" || return $?
  shift 2 && "$@" >>"$quietLog" 2>&1 || buildFailed "$quietLog" || __throwEnvironment "$handler" "$@" || return $?
}

# Logs all deprecated functions to application root in a file called `.deprecated`
# Usage: {fn} command ...
# Argument: function - Required. String. Function which is deprecated.
# Example:     {fn} "${FUNCNAME[0]}"
_deprecated() {
  export BUILD_HOME
  printf "DEPRECATED: %s\n" "$@" 1>&2
  [ ! -d "$BUILD_HOME" ] || printf -- "$(date "+%F %T"),%s\n" "$@" >>"${BUILD_HOME}/.deprecated"
}

# Run a function and preserve exit code
# Returns `exitCode`
# Usage: {fn} exitCode undoFunction ...
# Argument: exitCode - Required. Integer. Exit code to return.
# Argument: undoFunction - Optional. Command to run to undo something. Return status is ignored.
# Argument: -- - Flag. Optional. Used to delimit multiple commands.
# As a caveat, your command to `undo` can NOT take the argument `--` as a parameter.
# Example: local undo thing
# Example: thing=$(__catchEnvironment "$handler" createLargeResource) || return $?
# Example: undo+=(-- deleteLargeResource "$thing")
# Example: thing=$(__catchEnvironment "$handler" createMassiveResource) || _undo $? "${undo[@]}" || return $?
# Example: undo+=(-- deleteMassiveResource "$thing")
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
        isCallable "${1-}" || __catchArgument "$__usage" "Not callable $(decorate value "$1") (#$__count: $(decorate each code "${__saved[@]}"))" || return "$exitCode"
        args+=("$1")
        ;;
    esac
    shift
  done
  return "$exitCode"
}
__undo() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
