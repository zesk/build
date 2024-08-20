#!/bin/bash
#
# Dead simple PHP build
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __build 9
# Load build tools (installing if needed) and run command
# Usage: {fn} [ relativeHome installerPath [ command ... ] ]
# Argument: installerPath - Optional. Directory. Path to `install-bin-build.sh` binary.
# Argument: relativeHome - Required. Directory. Path to application home.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__build() {
  local relative="${1:-".."}" installerPath="${2:-"bin"}" && shift && shift
  __install "$installerPath/install-bin-build.sh" "bin/build/tools.sh" "$relative" "$@" || return $?
}

# IDENTICAL __install 23
# Load build tools (installing if needed) and run command
# Usage: {fn} [ relativeHome installer source [ command ... ] ]
# Argument: installer - Required. File. Installation binary.
# Argument: source - Required. File. Include file which should exist after installation.
# Argument: relativeHome - Optional. Directory. Path to application home. Default is `..`.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__install() {
  local installer="${1-}" source="${2-}" relativeHome="${1:-".."}" me="${BASH_SOURCE[0]}"
  local here="${me%/*}" e=253 arguments=()
  local install="$here/$relativeHome/$installer" tools="$here/$relativeHome/$source"
  [ -n "$installer" ] || _return $e "blank installer" || return $?
  [ -n "$source" ] || _return $e "blank source" || return $?
  if [ ! -x "$tools" ]; then
    "$install" || _return $e "$install failed" || return $?
    [ -d "${tools%/*}" ] || _return $e "$install failed to create directory ${tools%/*}" || return $?
  fi
  [ -x "$tools" ] || _return $e "$install failed to create $tools" "$@" || return $?
  shift && shift && shift && while [ $# -gt 0 ]; do arguments+=("$1") && shift; done
  # shellcheck source=/dev/null
  source "$tools" || _return $e source "$tools" || return $?
  [ ${#arguments[@]} -gt 0 ] || return 0
  __return "${arguments[@]}" || return $?
}

# IDENTICAL _return 19
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
_return() {
  local r="${1-:1}" && shift
  _integer "$r" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
}

# Is this an unsigned integer?
# Usage: {fn} value
# Exit Code: 0 - if value is an unsigned integer
# Exit Code: 1 - if value is not an unsigned integer
_integer() {
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

__buildSampleApplication() {
  clearLine || return $?
  __environment muzzle pushd "$(buildHome)" || return $?
  __environment phpBuild --deployment staging --skip-tag "$@" -- simple.application.php public src docs || return $?
}

__build .. bin __buildSampleApplication "$@"
