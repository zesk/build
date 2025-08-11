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
# Argument: --no-configuration - Optional. Flag. Do not fix any configuration issues from past versions.
# Argument: --just-configuration - Optional. Flag. Just fix any configuration issues from past versions. (Sets all other flags to false)
# Argument: --configuration - Optional. Flag. Do the fix any configuration issues from past versions. (other flags remain unchanged)
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
  local doCannon=true doTokens=true doSpelling=true doConfiguration=true ignoreExtras=()

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
    --configuration)
      doConfiguration=true
      ;;
    --no-configuration)
      doConfiguration=false
      ;;
    --just-configuration)
      doConfiguration="true"
      doCannon=false
      doSpelling=false
      doTokens=false
      ;;
    --cannon)
      doCannon=true
      ;;
    --no-cannon)
      doCannon=false
      ;;
    --just-cannon)
      doConfiguration=false
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
      doConfiguration=false
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
      doConfiguration=false
      doCannon=false
      doTokens=false
      doSpelling="true"
      ;;
    --find)
      shift
      while [ $# -gt 0 ]; do
        if [ "$1" = "--" ]; then
          break
        fi
        ignoreExtras+=("$1")
        shift
      done
      [ $# -eq 0 ] || shift
      ;;
    *)
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  export __BUILD_DEPRECATED_EXTRAS
  __BUILD_DEPRECATED_EXTRAS=("${ignoreExtras[@]+"${ignoreExtras[@]}"}")

  __BUILD_DEPRECATED_EXTRAS+=(! -path '*/documentation/*/release/*' ! -path '*/documentation/site/*')

  start=$(__environment timingStart) || return $?
  local home

  home=$(__environment buildHome) || return $?

  # END OF CANNONS
  if $doCannon; then
    statusMessage --last decorate info "Deprecated cannon ..."
    __deprecatedCannonsByVersion "$home" || exitCode=$?
  fi
  if $doSpelling; then
    statusMessage --last decorate info "Spelling cannon ..."
    __misspellingCannonByVersion "$home" || exitCode=$?
  fi
  if $doTokens; then
    statusMessage --last decorate info "Finding deprecated tokens ..."
    __deprecatedTokensByVersion "$home" || exitCode=$?
  fi
  if $doConfiguration; then
    statusMessage --last decorate info "Cleaning up configuration ..."
    __deprecatedConfiguration || exitCode=$?
  fi
  statusMessage --last timingReport "$start" "Deprecated process took"
  return "$exitCode"
}
___deprecatedCleanup() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
#  ▛▀▖                  ▐       ▌ ▞▀▖               ▐
#  ▌ ▌▞▀▖▛▀▖▙▀▖▞▀▖▞▀▖▝▀▖▜▀ ▞▀▖▞▀▌ ▚▄ ▌ ▌▛▀▖▛▀▖▞▀▖▙▀▖▜▀
#  ▌ ▌▛▀ ▙▄▘▌  ▛▀ ▌ ▖▞▀▌▐ ▖▛▀ ▌ ▌ ▖ ▌▌ ▌▙▄▘▙▄▘▌ ▌▌  ▐ ▖
#  ▀▀ ▝▀▘▌  ▘  ▝▀▘▝▀ ▝▀▘ ▀ ▝▀▘▝▀▘ ▝▀ ▝▀▘▌  ▌  ▝▀ ▘   ▀
#

#
# --tokens
#
__deprecatedTokensByVersion() {
  deprecatedTokensFile deprecatedIgnore "$1/bin/build/deprecated-tokens.txt"
}

#
# --cannons
#
__deprecatedCannonsByVersion() {
  deprecatedCannonFile deprecatedIgnore "$1/bin/build/deprecated.txt"
}

#
# --spelling
#
# Fingers don't always hit the keys right
__misspellingCannonByVersion() {
  deprecatedCannonFile deprecatedIgnore "$1/bin/build/deprecated-misspelled.txt"
}

#
# --configuration
#
__deprecatedConfiguration() {
  local home

  home=$(__environment buildHome) || return $?

  export HOME

  local newHome
  newHome=$(__environment buildEnvironmentGet "BUILD_CACHE_HOME") || return $?

  [ -d "$HOME" ] || _environment HOME is not set || return $?

  if [ -f "$HOME/.applicationHome" ]; then
    mv "$HOME/.applicationHome" "$newHome"
  fi
  local oldHome="$HOME/.build"
  if [ -d "$oldHome" ]; then
    if [ -d "$newHome" ]; then
      decorate warning "Both $oldHome and $newHome exist - merge manually"
    else
      mv "$oldHome" "$newHome"
    fi
  fi

  [ ! -f "$home/.env.STAGING" ] || mv "$home/.env.STAGING" "$home/.STAGING.env" || return $?
  [ ! -f "$home/.env.PRODUCTION" ] || mv "$home/.env.PRODUCTION" "$home/.PRODUCTION.env" || return $?
  local fileName
  while read -r fileName; do
    local directory newName suffix
    directory=$(dirname "$fileName")
    fileName="$(basename "$fileName")"
    newName="${fileName#.env.}"
    suffix="${newName#*.}"
    newName="${newName%%.*}"
    mv "$directory/$fileName" "$directory/.$suffix.$newName.env"
  done < <(find "$home" -name '.env.STAGING.*' -or -name '.env.PRODUCTION.*' -name '.env.staging.*' -or -name '.env.production.*')

  local exitCode=0
  find "$home" -name '.check-assertions' | outputTrigger "$(decorate error ".check-assertions is deprecated")" || exitCode=$?
  find "$home" -name '.debugging' | outputTrigger "$(decorate error ".debugging is deprecated")" || exitCode=$?
  return "$exitCode"
}

# IDENTICAL _return 29

# Return passed in integer return code and output message to `stderr` (non-zero) or `stdout` (zero)
# Argument: exitCode - Required. UnsignedInteger. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output
# Exit Code: exitCode
# Requires: isUnsignedInteger printf _return
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
# Exit Code: 0 - if it is an unsigned integer
# Exit Code: 1 - if it is not an unsigned integer
# Requires: _return
isUnsignedInteger() {
  [ $# -eq 1 ] || _return 2 "Single argument only: $*" || return $?
  case "${1#+}" in --help) usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return
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

__tools ../.. __deprecatedCleanup "$@"
