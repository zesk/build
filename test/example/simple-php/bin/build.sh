#!/bin/bash
#
# Dead simple PHP build
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL __build 11

# Load build tools (installing if needed) and runs a command
# Argument: relativeHome - Optional. Directory. Path to application home.
# Argument: installerPath - Optional. Directory. Path to `install-bin-build.sh` binary. Defaults to `bin`
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: __install
# Example:     __build ../../.. functionToCall "$@"
__build() {
  local relative="${1:-".."}" installerPath="${2:-"bin"}" && shift && shift
  __install "$installerPath/install-bin-build.sh" "bin/build/tools.sh" "$relative" "$@" || return $?
}

# IDENTICAL __install 25

# Load a bash script (installing if needed) and run an optional command
# Argument: installer - Required. File. Installation binary.
# Argument: source - Required. File. Include file which should exist after installation.
# Argument: relativeHome - Optional. Directory. Path to application home. Default is `..`.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Example:      __install bin/install-bin-build.sh bin/build/tools.sh ../../.. decorate info "$@"
# Requires: _return __execute
__install() {
  local installer="${1-}" source="${2-}" relativeHome="${3:-".."}" me="${BASH_SOURCE[0]}"
  local here="${me%/*}" e=253 a
  local install="$here/$relativeHome/$installer" tools="$here/$relativeHome/$source"
  [ -n "$installer" ] || _return $e "blank installer" || return $?
  [ -n "$source" ] || _return $e "blank source" || return $?
  if [ ! -x "$tools" ]; then
    "$install" || _return $e "$install failed" || return $?
    [ -d "${tools%/*}" ] || _return $e "$install failed to create directory ${tools%/*}" || return $?
  fi
  [ -x "$tools" ] || _return $e "$install failed to create $tools" "$@" || return $?
  shift 3 && a=("$@") && set --
  # shellcheck source=/dev/null
  source "$tools" || _return "$e" source "$tools" || return $?
  [ ${#a[@]} -gt 0 ] || return 0
  __execute "${a[@]}" || return $?
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
  case "${1#+}" in --help) usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

__buildSampleApplication() {
  clearLine || return $?
  __environment muzzle pushd "$(buildHome)" || return $?
  __environment phpBuild "$@" -- simple.application.php public src docs || return $?
}

__build .. bin __buildSampleApplication "$@"
