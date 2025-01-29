#!/bin/bash
#
# Run this if you want to upgrade your scripts
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

set -eou pipefail

# Clean up deprecated code automatically. This can be dangerous (uses `cannon`) so use it on
# a clean build checkout and examine changes manually each time.
#
# - Replaces deprecated code in shell and other files
# - Finds tokens which are no longer in use and reports on the files found
# - Does common misspellings and replaces them
#
# Usage: {fn}
# fn: {base}
# Exit Code: 0 - All cleaned up
# Exit Code: 1 - If fails or validation fails
#
# There are three flags to control the three processes, you can set them using arguments (all three cleanups are by default enabled)
#
# Argument: --no-cannon - Optional. Flag. Do not do the cannon to replace tokens in code.
# Argument: --just-cannon - Optional. Flag. Just do the cannon to replace tokens in code. (Sets all other flags to false)
# Argument: --cannon - Optional. Flag. Do the cannon  to replace tokens in code. (other flags remain unchanged)
# Argument: --no-tokens - Optional. Flag. Report on deprecated tokens found in the code.
# Argument: --just-tokens - Optional. Flag. Just report on deprecated tokens found in the code. (Sets all other flags to false)
# Argument: --tokens - Optional. Flag. Report on deprecated tokens found in the code. (other flags remain unchanged)
# Argument: --no-spelling - Optional. Flag. Search for common (wink) misspellings and fix them.
# Argument: --just-spelling - Optional. Flag. Just search for common (wink) misspellings and fix them. (Sets all other flags to false)
# Argument: --spelling - Optional. Flag. Search for common (wink) misspellings and fix them. (other flags remain unchanged)
# MOST RECENT STUFF at the top as it will likely have more hits
# See: docs/_templates/deprecated.md
__deprecatedCleanup() {
  local usage="_${FUNCNAME[0]}" exitCode=0
  local doCannon=true doTokens=true doSpelling=true

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
      --cannon)
        doCannon=true
        ;;
      --no-cannon)
        doCannon=false
        ;;
      --just-cannon)
        doCannon="true"
        doSpelling=false
        doTokens=false
        ;;
      --tokens)
        doTokens=true
        ;;
      --no-tokens)
        doTokens=false
        ;;
      --just-tokens)
        doCannon=false
        doTokens="true"
        doSpelling=false
        ;;
      --spelling)
        doSpelling=true
        ;;
      --no-spelling)
        doSpelling=false
        ;;
      --just-spelling)
        doCannon=false
        doTokens=false
        doSpelling="true"
        ;;
      *)
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  start=$(__environment beginTiming) || return $?

  # END OF CANNONS
  if $doCannon; then
    statusMessage --last decorate info "Deprecated cannon ..."
    __deprecatedCannonsByVersion || exitCode=$?
  fi
  if $doSpelling; then
    statusMessage --last decorate info "Spelling cannon ..."
    __misspellingCannon || exitCode=$?
  fi
  if $doTokens; then
    statusMessage --last decorate info "Finding deprecated tokens ..."
    __deprecatedTokensByVersion || exitCode=$?
  fi
  statusMessage --last reportTiming "$start" "Deprecated process took"
  return "$exitCode"
}
___deprecatedCleanup() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
#  ▛▀▖                  ▐       ▌ ▞▀▖               ▐
#  ▌ ▌▞▀▖▛▀▖▙▀▖▞▀▖▞▀▖▝▀▖▜▀ ▞▀▖▞▀▌ ▚▄ ▌ ▌▛▀▖▛▀▖▞▀▖▙▀▖▜▀
#  ▌ ▌▛▀ ▙▄▘▌  ▛▀ ▌ ▖▞▀▌▐ ▖▛▀ ▌ ▌ ▖ ▌▌ ▌▙▄▘▙▄▘▌ ▌▌  ▐ ▖
#  ▀▀ ▝▀▘▌  ▘  ▝▀▘▝▀ ▝▀▘ ▀ ▝▀▘▝▀▘ ▝▀ ▝▀▘▌  ▌  ▝▀ ▘   ▀
#

# list of ignore flags for `find`
__deprecatedIgnore() {
  printf -- "%s\n" "!" -name 'deprecated.txt' "!" -name 'deprecated.sh' "!" -name 'deprecated.md' ! -name 'unused.md' "!" -path '*/docs/release/*' ! -path "*/.*/*"
}

# Find files which match a token
__deprecatedFind() {
  local ignoreStuff=()
  read -d '' -r -a ignoreStuff < <(__deprecatedIgnore) || [ "${#ignoreStuff[@]}" -gt 0 ] || _environment "__deprecatedIgnore empty?" || return $?
  while [ "$#" -gt 0 ]; do
    if find . -type f -name '*.sh' "${ignoreStuff[@]}" -print0 | xargs -0 grep -q "$1"; then
      return 0
    fi
    shift
  done
  return 1
}

# Usage: {fn} search replace [ additionalCannonArgs ]
__deprecatedCannon() {
  local from="$1" to="$2" ignoreStuff=()
  shift 2
  read -d '' -r -a ignoreStuff < <(__deprecatedIgnore) || [ "${#ignoreStuff[@]}" -gt 0 ] || _environment "__deprecatedIgnore empty?" || return $?
  # ignore should go at the end so it has priority over previous entries
  cannon "$from" "$to" "$@" "${ignoreStuff[@]}"
}

__deprecatedTokens() {
  local ignoreStuff exitCode=0 start results
  read -d '' -r -a ignoreStuff < <(__deprecatedIgnore) || :
  results=$(__environment mktemp) || return $?
  start=$(__environment beginTiming) || return $?
  for deprecatedToken in "$@"; do
    statusMessage decorate info "Looking for deprecated token $(decorate code "$deprecatedToken") ..."
    if find . -type f "${ignoreStuff[@]+"${ignoreStuff[@]}"}" -print0 | xargs -0 grep -l -e "$deprecatedToken" >"$results"; then
      statusMessage --last decorate error "DEPRECATED token $(decorate code "$deprecatedToken") found"
      wrapLines "$(decorate code)" "$(decorate reset)" <"$results" || _clean $? "$results" || return $?
      exitCode=1
    fi
  done
  __environment rm -rf "$results" || return $?
  statusMessage --last reportTiming "$start" "Deprecated token scan took"
  return "$exitCode"
}

#
# --tokens
#
__deprecatedTokensByVersion() {
  local deprecatedTokens=()
  deprecatedTokens=()

  # v0.22.0
  deprecatedTokens+=(_format _command _list)

  # v0.17.0
  # deprecatedToken+=(' --env ')

  # v0.14.3
  home=$(__environment buildHome) || return $?
  for file in "$home/bin/build/pipeline/"*.sh; do
    deprecatedToken+=("${file#"$home"}")
  done
  for file in "$home/bin/build/install/"*.sh; do
    deprecatedToken+=("${file#"$home"}")
  done
  deprecatedToken+=('__''try')
  # v0.11.4
  deprecatedTokens+=("ops"".sh" "__""ops")
  deprecatedTokens+=(crontab-application-sync.sh)
  # v0.7.10
  deprecatedToken+=('bin/build/pipeline')
  # v0.7.0
  deprecatedTokens+=(dockerPHPExtensions usageWrapper usageRequireBinary usage "[^_]usageEnvironment")
  __deprecatedTokens "${deprecatedToken[@]}"
}

#
# --cannons
#
__deprecatedCannonsByVersion() {
  local start home exitCode=0 version="No version yet"

  set -eou pipefail

  home=$(__environment buildHome) || return $?
  start=$(__environment beginTiming) || return $?

  while read -r line; do
    local IFS tokens=() trimmed
    trimmed=$(__environment trimSpace "$line") || return $?
    [ -n "$trimmed" ] || continue
    if [ "${trimmed:0:1}" = "#" ]; then
      version="$(__environment trimSpace "${trimmed:1}")" || return $?
      continue
    fi
    IFS="|" read -r -a tokens <<<"$line" || :
    if [ "${#tokens[@]}" -le 1 ]; then
      decorate error "Bad line: $line" || :
      exitCode=1
      continue
    fi
    statusMessage printf -- "%s: %s -> %s %s" "$(decorate bold-magenta "$version")" "$(decorate code "${tokens[0]}")" "$(decorate code "${tokens[1]}")"
    if ! __deprecatedCannon "${tokens[@]}"; then
      exitCode=1
      printf -- "\n"
    fi
  done <"$home/bin/build/deprecated.txt"
  statusMessage --last reportTiming "$start" "Deprecated cannon took"
  return "$exitCode"
}

#
# --spelling
#
# Fingers don't always hit the keys right
__misspellingCannon() {
  local start exitCode=0
  start=$(__environment beginTiming) || return $?
  # START OF MISSPELLING CANNON
  __deprecatedCannon 'decoreate' 'decorate' || exitCode=$?
  # END OF MISSPELLING CANNON
  statusMessage --last reportTiming "$start" "Misspelling cannon took"
  return "$exitCode"
}

# IDENTICAL __source 20

# Usage: {fn} source relativeHome  [ command ... ] ]
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

# IDENTICAL __tools 9

# Usage: {fn} [ relativeHome [ command ... ] ]
# Load build tools and run command
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: __source _return
__tools() {
  __source bin/build/tools.sh "$@"
}

# IDENTICAL _return 26

# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
# Requires: isUnsignedInteger printf _return
_return() {
  local r="${1-:1}" && shift
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

__tools ../.. __deprecatedCleanup "$@"
