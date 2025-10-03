#!/usr/bin/env bash
#
# Original of application.sh
#
# This template can be used to load or install Zesk Build in another project
#
# - Copy this file to bin/tools.sh
# - Copy install-bin-build.sh to bin/install-bin-build.sh
# - `source bin/tools.sh` installs and loads Zesk Build.
#
# Copyright &copy; 2025, Market Acumen, Inc.
#

# _IDENTICAL_ application.sh 134

#
# This file generically loads all application tools in `./bin/tools` and allows for extensions
# to Zesk Build within an application with little effort.
#
# Copy this file into your application project at `./bin/` next to `install-bin-build.sh`
#
# To do `developerTrack` define `DEVELOPER_TRACK` prior to sourcing this file to get
# access to functions created via `__applicationToolsList`.
#
# Environment: DEVELOPER_TRACK
#

# IDENTICAL __source 21

# Load a source file and run a command
# Argument: source - Required. File. Path to source relative to application root..
# Argument: relativeHome - Optional. Directory. Path to application root. Defaults to `..`
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: returnMessage
# Security: source
# Return Code: 253 - source failed to load (internal error)
# Return Code: 0 - source loaded (and command succeeded)
# Return Code: ? - All other codes are returned by the command itself
__source() {
  local here="${BASH_SOURCE[0]%/*}" e=253
  local source="$here/${2:-".."}/${1-}" && shift 2 || returnMessage $e "missing source" || return $?
  [ -d "${source%/*}" ] || returnMessage $e "${source%/*} is not a directory" || return $?
  [ -f "$source" ] && [ -x "$source" ] || returnMessage $e "$source not an executable file" "$@" || return $?
  local a=("$@") && set --
  # shellcheck source=/dev/null
  source "$source" || returnMessage $e source "$source" "$@" || return $?
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

# IDENTICAL __install 25

# Load a bash script (installing if needed) and run an optional command
# Argument: installer - Required. File. Installation binary.
# Argument: source - Required. File. Include file which should exist after installation.
# Argument: relativeHome - Optional. Directory. Path to application home. Default is `..`.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Example:      __install bin/install-bin-build.sh bin/build/tools.sh ../../.. decorate info "$@"
# Requires: returnMessage __execute
__install() {
  local installer="${1-}" source="${2-}" relativeHome="${3:-".."}" me="${BASH_SOURCE[0]}"
  local here="${me%/*}" e=253 a
  local install="$here/$relativeHome/$installer" tools="$here/$relativeHome/$source"
  [ -n "$installer" ] || returnMessage $e "blank installer" || return $?
  [ -n "$source" ] || returnMessage $e "blank source" || return $?
  if [ ! -x "$tools" ]; then
    "$install" || returnMessage $e "$install failed" || return $?
    [ -d "${tools%/*}" ] || returnMessage $e "$install failed to create directory ${tools%/*}" || return $?
  fi
  [ -x "$tools" ] || returnMessage $e "$install failed to create $tools" "$@" || return $?
  shift 3 && a=("$@") && set --
  # shellcheck source=/dev/null
  source "$tools" || returnMessage "$e" source "$tools" || return $?
  [ ${#a[@]} -gt 0 ] || return 0
  __execute "${a[@]}" || return $?
}

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

# IDENTICAL returnMessage 29

# Return passed in integer return code and output message to `stderr` (non-zero) or `stdout` (zero)
# Argument: exitCode - Required. UnsignedInteger. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output
# Return Code: exitCode
# Requires: isUnsignedInteger printf returnMessage
_return() {
  local to=1 icon="✅" code="${1:-1}" && shift 2>/dev/null
  isUnsignedInteger "$code" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer \"$code\"" "$@" || return $?
  if [ "$code" -gt 0 ]; then icon="❌ [$code]" && to=2; fi
  printf -- "%s %s\n" "$icon" "${*-§}" 1>&"$to"
  return "$code"
}

# Test if an argument is an unsigned integer
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Original: is_uint
# Argument: value - EmptyString. Value to test if it is an unsigned integer.
# Usage: {fn} argument ...
# Return Code: 0 - if it is an unsigned integer
# Return Code: 1 - if it is not an unsigned integer
# Requires: _return
isUnsignedInteger() {
  [ $# -eq 1 ] || _return 2 "Single argument only: $*" || return $?
  case "${1#+}" in --help) usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

__applicationTools() {
  local source="${BASH_SOURCE[0]}"
  local here="${source%/*}" __saved=("$@")

  set --
  __build .. bin >/dev/null || return $?

  bashSourcePath "$(realPath "$here/tools/")" || return $?

  __execute "${__saved[@]+"${__saved[@]}"}" || return $?
}

if [ "$(basename "${0##-}")" = "$(basename "${BASH_SOURCE[0]}")" ] && [ $# -gt 0 ]; then
  __applicationTools "$@"
else
  __applicationTools :
fi
