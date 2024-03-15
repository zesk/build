#!/usr/bin/env bash
# Copyright &copy; 2024 Market Acumen, Inc.
# -- CUT HERE --

# IDENTICAL _sugar 84
errorEnvironment=1
errorArgument=2
errorCritical=99
emptyArgument="§"

# Output a titled list
# Usage: {fn} title [ items ... ]
_list() {
  local title
  title="${1-"$emptyArgument"}" && shift && printf "%s\n%s\n" "$title" "$(printf -- "- %s\n" "$@")"
}

# Critical exit `errorCritical` - exit immediately
# Usage: {fn} {title} [ items ... ]
_exit() {
  local title="${1-"$emptyArgument"}"
  export BUILD_DEBUG
  # shellcheck disable=SC2016
  exec 1>&2 && shift && _list "$title" "$(printf '%s ' "$@")"
  if test "${BUILD_DEBUG-}"; then
    _list "Stack" "${FUNCNAME[@]}" || :
    _list "Sources" "${BASH_SOURCE[@]}" || :
  fi
  exit "$errorCritical"
}

#
# _return related
#

# Usage: {fn} code command || return $?
_return() {
  local code
  code="${1-1}" && shift && printf "%s failed (%d)\n" "${*-"$emptyArgument"}" "$code" 1>&2 && return "$code"
}

# Usage: foo || _environment "bad env" || return $?
# Always fails
_environment() {
  _return "$errorEnvironment" "$@" || return $?
}

# Usage: foo || _argument "bad arg" || return $?
# Always fails
_argument() {
  _return "$errorArgument" "$@" || return $?
}

#
# RUN related
#

# Usage: {fn} command || return $?
__execute() {
  "$@" && return 0
  _return $? "${*-"$emptyArgument"}" && return $?
}

# Exit if a command fails.
# Usage: {fn} command
__try() {
  __execute "$@" || _exit "Exit code: $?" "$@"
}

# Usage: __echo command
__echo() {
  printf "Running: %s\n" "${*-"$emptyArgument"}" && __execute "$@"
}

# Run `command`, return environment error upon failure
# Usage: {fn} command ...
# Argument: command - Required. Command to run.
__environment() {
  "$@" || _environment "$@" || return $?
}

# Run `command`, return argument error upon failure
# Usage: {fn} command ...
# Argument: command - Required. Command to run.
__argument() {
  "$@" || _argument "$@" || return $?
}

# END IDENTICAL
