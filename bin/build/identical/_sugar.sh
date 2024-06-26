#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/tools/_sugar.md
# Test: o ./test/tools/sugar-tests.sh
#
# -- CUT BELOW HERE --

# IDENTICAL _sugar 98

# Output a titled list
# Usage: {fn} title [ items ... ]
_list() {
  local title
  title="${1-"§"}" && shift && printf "%s\n%s\n" "$title" "$(printf -- "- %s\n" "$@")"
}

# Critical exit - exit immediately
# Usage: {fn} {title} [ items ... ]
# Exit code: 99 - Failure
_exit() {
  local title="${1-"§"}"
  export BUILD_DEBUG
  # shellcheck disable=SC2016
  exec 1>&2 && shift && _list "$title" "$(printf '%s ' "$@")"
  if [ "true" = "${BUILD_DEBUG-false}" ]; then
    _list "Stack" "${FUNCNAME[@]}" || :
    _list "Sources" "${BASH_SOURCE[@]}" || :
  fi
  exit 99
}

#
# _return related
#

# Return code always. Outputs `message ...` to `stderr`.
# Usage: {fn} code command || return $?
# Argument: code - Integer. Required. Return code.
# Argument: message ... - String. Optional. Message to output.
_return() {
  local code="${1-1}" # make this a two-liner ;)
  shift || : && printf "[%d] ❌ %s\n" "$code" "${*-§}" 1>&2 || : && return "$code"
}

# Return `$errorEnvironment` always. Outputs `message ...` to `stderr`.
# Usage: {fn} message ...
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 1
_environment() {
  _return 1 "$@" || return $?
}

# Return `$errorArgument` always. Outputs `message ...` to `stderr`.
# Usage: {fn} message ..`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 2
_argument() {
  _return 2 "$@" || return $?
}

#
# RUN related
#

# Run `command ...` (with any arguments) and then `_return` if it fails.
# Usage: {fn} command ...
# Argument: command ... - Any command and arguments to run.
__execute() {
  "$@" || _return $? "${*-"§"}" || return $?
}

# Run `command ...` (with any arguments) and then `_exit` if it fails. Critical code only.
# Usage: {fn} command ...
# Argument: command ... - Any command and arguments to run.
# Exit Code: None
__try() {
  __execute "$@" || _exit "Exit code: $?" "$@"
}

# Output the `command ...` to stdout prior to running, then `__execute` it
# Usage: {fn} command ...
# Argument: command ... - Any command and arguments to run.
# Exit Code: Any
__echo() {
  printf "Running: %s\n" "${*-"§"}" && __execute "$@" || return $?
}

# Run `command ...` (with any arguments) and then `_environment` if it fails.
# Usage: {fn} command ...
# Argument: command ... - Any command and arguments to run.
# Exit Code: 0 - Success
# Exit Code: 1 - Failed
__environment() {
  "$@" || _environment "$@" || return $?
}

# Run `command ...` (with any arguments) and then `_argument` if it fails.
# Usage: {fn} command ...FUNCNAME
# Argument: command ... - Any command and arguments to run.
# Exit Code: 0 - Success
# Exit Code: 2 - Failed
__argument() {
  "$@" || _argument "$@" || return $?
}

# END IDENTICAL
