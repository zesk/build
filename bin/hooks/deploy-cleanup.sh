#!/usr/bin/env bash
#
# Run during deployRemoteFinish
#
# Run ON THE REMOTE SYSTEM, not in the pipeline so assume little.
#
# Delete any temporary files left over from deployment and finish deployment.
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL __source 21

# Load a source file and run a command
# Argument: source - Required. File. Path to source relative to application root..
# Argument: relativeHome - Optional. Directory. Path to application root. Defaults to `..`
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: _return
# Security: source
# Exit Code: 253 - source failed to load (internal error)
# Exit Code: 0 - source loaded (and command succeeded)
# Exit Code: ? - All other codes are returned by the command itself
__source() {
  local here="${BASH_SOURCE[0]%/*}" e=253
  local source="$here/${2:-".."}/${1-}" && shift 2 || _return $e "missing source" || return $?
  [ -d "${source%/*}" ] || _return $e "${source%/*} is not a directory" || return $?
  [ -f "$source" ] && [ -x "$source" ] || _return $e "$source not an executable file" "$@" || return $?
  local a=("$@") && set --
  # shellcheck source=/dev/null
  source "$source" || _return $e source "$source" "$@" || return $?
  [ ${#a[@]} -gt 0 ] || return 0
  "${a[@]}" || return $?
}

# IDENTICAL __tools 8

# Load build tools and run command
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: __source
__tools() {
  __source bin/build/tools.sh "$@"
}

# IDENTICAL _return 27

# Return passed in integer return code and output message to `stderr` (non-zero) or `stdout` (zero)
# Argument: exitCode - Required. UnsignedInteger. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output
# Exit Code: exitCode
# Requires: isUnsignedInteger printf _return
_return() {
  local code="${1:-1}" && shift 2>/dev/null
  isUnsignedInteger "$code" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer \"$code\"" "$@" || return $?
  [ "$code" -eq 0 ] && printf -- "✅ %s\n" "${*-§}" && return 0 || printf -- "❌ [%d] %s\n" "$code" "${*-§}" 1>&2
  return "$code"
}

# Test if an argument is an unsigned integer
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Original: is_uint
# Usage: {fn} argument ...
# Exit Code: 0 - if it is an unsigned integer
# Exit Code: 1 - if it is not an unsigned integer
# Requires: _return
isUnsignedInteger() {
  [ $# -eq 1 ] || _return 2 "Single argument only: $*" || return $?
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

#
# fn: {base}
# Summary: Run after a successful deployment
# Run on remote systems after deployment has succeeded on all systems.
#
# This step must always succeed on the remote system; the deployment step prior to this
# should do whatever is required to ensure that.
#
__hookDeployCleanup() {
  ! buildDebugEnabled || decorate success "${BASH_SOURCE[0]} is a noop and should be replaced or deleted."
  : "$@"
}

__tools ../.. __hookDeployCleanup "$@"
