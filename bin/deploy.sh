#!/usr/bin/env bash
#
# Deploy Zesk Build
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL __source 19

# Load a source file and run a command
# Argument: source - Required. File. Path to source relative to application root..
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: _return
# Security: source
__source() {
  local me="${BASH_SOURCE[0]}" e=253
  local here="${me%/*}" a=()
  local source="$here/${2:-".."}/${1-}" && shift 2 || _return $e "missing source" || return $?
  [ -d "${source%/*}" ] || _return $e "${source%/*} is not a directory" || return $?
  [ -f "$source" ] && [ -x "$source" ] || _return $e "$source not an executable file" "$@" || return $?
  while [ $# -gt 0 ]; do a+=("$1") && shift; done
  # shellcheck source=/dev/null
  source "$source" || _return $e source "$source" "$@" || return $?
  [ ${#a[@]} -gt 0 ] || return 0
  "${a[@]}" || return $?
}

# IDENTICAL __tools 8

# Load build tools and run command
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: __source _return
__tools() {
  __source bin/build/tools.sh "$@"
}

# IDENTICAL _return 26

# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Required. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
# Requires: isUnsignedInteger printf _return
_return() {
  local r="${1-:1}" && shift 2>/dev/null
  isUnsignedInteger "$r" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf -- "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
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
# Deploy Zesk Build
#
__buildDeploy() {
  local start appId notes
  local usage

  usage="${FUNCNAME[0]#_}"

  start=$(timingStart) || __throwEnvironment "$usage" "timingStart" || return $?

  statusMessage decorate info "Fetching deep copy of repository ..." || :
  __catchEnvironment "$usage" git fetch --unshallow || return $?

  statusMessage decorate info "Collecting application version and ID ..." || :
  currentVersion="$(hookRun version-current)" || __throwEnvironment "$usage" "hookRun version-current" || return $?
  appId=$(hookRun application-id) || __throwEnvironment "$usage" "hookRun application-id" || return $?

  [ -n "$currentVersion" ] || __throwEnvironment "$usage" "Blank version-current" || return $?
  [ -n "$appId" ] || __throwEnvironment "$usage" "No application ID (blank?)" || return $?

  notes=$(releaseNotes) || __throwEnvironment "$usage" "releaseNotes" || return $?
  [ -f "$notes" ] || __throwEnvironment "$usage" "$notes does not exist" || return $?

  bigText "$currentVersion" | wrapLines "    $(decorate green "Zesk BUILD    🛠️️ ") $(decorate magenta)" "$(decorate green " ⚒️ ")" || :
  decorate info "Deploying a new release ... " || :

  if ! githubRelease "$notes" "$currentVersion" "$appId"; then
    decorate warning "Deleting tagged version ... " || :
    gitTagDelete "$currentVersion" || decorate error "gitTagDelete $currentVersion ALSO failed but continuing ..." || :
    __throwEnvironment "$usage" "githubRelease" || return $?
  fi
  timingReport "$start" "Release completed in" || :
}
_buildDeploy() {
  usageDocument "${BASH_SOURCE[0]}" "_${FUNCNAME[0]}" "$@"
}

__tools .. __buildDeploy "$@"
