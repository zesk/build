#!/usr/bin/env bash
#
# Deploy Zesk Build
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __source 17
# Usage: {fn} source relativeHome  [ command ... ] ]
# Load a source file and run a command
# Argument: source - Required. File. Path to source relative to application root..
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
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

# IDENTICAL __tools 7
# Usage: {fn} [ relativeHome [ command ... ] ]
# Load build tools and run command
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__tools() {
  __source bin/build/tools.sh "$@"
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

#
# Deploy Zesk Build
#
__buildDeploy() {
  local start appId notes
  local usage

  usage="${FUNCNAME[0]#_}"

  start=$(beginTiming) || __failEnvironment "$usage" "beginTiming" || return $?

  statusMessage decorate info "Fetching deep copy of repository ..." || :
  __usageEnvironment "$usage" git fetch --unshallow || return $?

  statusMessage decorate info "Collecting application version and ID ..." || :
  currentVersion="$(runHook version-current)" || __failEnvironment "$usage" "runHook version-current" || return $?
  appId=$(runHook application-id) || __failEnvironment "$usage" "runHook application-id" || return $?

  [ -n "$currentVersion" ] || __failEnvironment "$usage" "Blank version-current" || return $?
  [ -n "$appId" ] || __failEnvironment "$usage" "No application ID (blank?)" || return $?

  notes=$(releaseNotes) || __failEnvironment "$usage" "releaseNotes" || return $?
  [ -f "$notes" ] || __failEnvironment "$usage" "$notes does not exist" || return $?

  bigText "$currentVersion" | wrapLines "    $(decorate green "Zesk BUILD    🛠️️ ") $(decorate magenta)" "$(decorate green " ⚒️ ")" || :
  decorate info "Deploying a new release ... " || :

  if ! githubRelease "$notes" "$currentVersion" "$appId"; then
    decorate warning "Deleting tagged version ... " || :
    gitTagDelete "$currentVersion" || decorate error "gitTagDelete $currentVersion ALSO failed but continuing ..." || :
    __failEnvironment "$usage" "githubRelease" || return $?
  fi
  reportTiming "$start" "Release completed in" || :
}
_buildDeploy() {
  usageDocument "${BASH_SOURCE[0]}" "_${FUNCNAME[0]}" "$@"
}

__tools .. __buildDeploy "$@"
