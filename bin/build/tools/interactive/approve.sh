#!/usr/bin/env bash
#
# Interactivity: Approvals
#
# Support functions here
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/interactive.md
# Test: ./test/tools/interactive-tests.sh

####################################################################################################
#
#  ▜▘   ▐              ▐  ▗       ▞▀▖
#  ▐ ▛▀▖▜▀ ▞▀▖▙▀▖▝▀▖▞▀▖▜▀ ▄▌ ▌▞▀▖ ▙▄▌▛▀▖▛▀▖▙▀▖▞▀▖▌ ▌▞▀▖
#  ▐ ▌ ▌▐ ▖▛▀ ▌  ▞▀▌▌ ▖▐ ▖▐▐▐ ▛▀  ▌ ▌▙▄▘▙▄▘▌  ▌ ▌▐▐ ▛▀
#  ▀▘▘ ▘ ▀ ▝▀▘▘  ▝▀▘▝▀  ▀ ▀▘▘ ▝▀▘ ▘ ▘▌  ▌  ▘  ▝▀  ▘ ▝▀▘
#
####################################################################################################

# Usage: {fn} usage sourceFile ...
# Argument: usage - Function. Required.
# Argument: sourceFile - File. Required.
# Argument: Prompt - String. Optional.
# Argument: ... - Arguments. Optional. Passed to `confirmYesNo`
__interactiveApprove() {
  local usage="$1" sourcePath="$2" approved displayFile approvedHome

  shift 2 || __catchArgument "$usage" "shift" || return $?
  approvedHome=$(__interactiveApproveHome "$usage") || return $?

  if [ -d "$sourcePath" ]; then
    sourcePath="${sourcePath%/}"
    local sourceFile approved=true
    while read -r sourceFile; do
      if ! __interactiveApproveRegisterCacheFile "$usage" "$sourceFile" "$approvedHome" "$@"; then
        approved=false
        break
      fi
    done < <(find "$sourcePath" -type f -name '*.sh' ! -path '*/.*/*')
    "$approved"
  else
    __interactiveApproveRegisterCacheFile "$usage" "$sourcePath" "$approvedHome" "$@"
  fi
}

# If a file has been seen already, handle it, otherwise ask the user to approve interactively.
#
# Argument: usage - Function. Required.
# Argument: sourceFile - File. Required.
# Argument: approvedHome - Directory. Required.
# Argument: verb - String. Required.
# Argument: ... - Arguments. Passed to `confirmYesNo`.
__interactiveApproveRegisterCacheFile() {
  local usage="$1" sourceFile="$2" approvedHome="$3" verb="$4" approved displayFile approvedHome

  shift 4
  cacheFile="$(__interactiveApproveCacheFile "$usage" "$approvedHome" "$sourceFile")"
  displayFile=$(decorate file "$sourceFile")
  if [ ! -f "$cacheFile" ]; then
    if confirmYesNo "$@" "$verb $(decorate file "$sourcePath")?"; then
      approved=true
      statusMessage --last printf "%s [%s] %s" "$(decorate success "Approved")" "$(decorate file "$displayFile")" "$(decorate subtle "(will not ask in the future)")"
    else
      approved=false
    fi
    printf -- "%s\n" "$approved" "$(whoami)" "$(date +%s)" "$(date -u)" "$sourceFile" >"$cacheFile" || __throwEnvironment "$usage" "Unable to write $(decorate file "$cacheFile")" || return $?
  fi
  approved=$(head -n 1 "$cacheFile")
  if ! isBoolean "$approved" || ! "$approved"; then
    return 1
  fi
  # Allows identical files in different projects to be approved once
  if ! grep -q "$sourceFile" <"$cacheFile"; then
    printf "%s\n" "$sourceFile" >>"$cacheFile"
  fi
  return 0
}

# The home directory for the interactive approved state files
# Argument: usage - Function. Required.
__interactiveApproveHome() {
  local usage="$1" approvedHome
  approvedHome=$(__catchEnvironment "$usage" buildEnvironmentGetDirectory --subdirectory ".interactiveApproved" "XDG_STATE_HOME") || return $?
  printf "%s\n" "$approvedHome"
}

# Get the cache file for a specific file
# Argument: usage - Function. Required.
# Argument: approvedHome - Directory. Required.
# Argument: sourceFile - File. Required.
# stdout: File. Cache file for `sourceFile`
__interactiveApproveCacheFile() {
  local usage="$1" approvedHome="$2" sourceFile="$3" cacheFile

  [ -f "$sourceFile" ] || __throwArgument "$usage" "File does not exist: $sourceFile" || return $?
  cacheFile="$approvedHome/$(__catchEnvironment "$usage" shaPipe <"$sourceFile")" || return $?
  printf "%s\n" "$cacheFile"
}

# Usage: {fn} usage approvedTarget
__interactiveApproveClear() {
  local usage="$1" sourcePath="$2"

  shift 2 || __catchArgument "$usage" "shift" || return $?
  approvedHome=$(__interactiveApproveHome "$usage") || return $?

  if [ -d "$sourcePath" ]; then
    local sourceFile
    while read -r sourceFile; do
      local cacheFile
      cacheFile=$(__interactiveApproveCacheFile "$usage" "$approvedHome" "$sourceFile") || return $?
      [ ! -f "$cacheFile" ] || __catchEnvironment "$usage" rm -rf "$cacheFile" || return $?
    done < <(find "$sourcePath" -type f -name '*.sh' ! -path '*/.*/*')
  else
    local cacheFile
    cacheFile=$(__interactiveApproveCacheFile "$usage" "$approvedHome" "$sourcePath") || return $?
    [ ! -f "$cacheFile" ] || __catchEnvironment "$usage" rm -rf "$cacheFile" || return $?
  fi
}

# Maybe move this to its own thing if needed later
# Usage: {fn} usage timeout attempts extras message
__interactiveCountdownReadBoolean() {
  local usage="$1" && shift
  local timeout="" rr=() extras icon="⏳" attempts prompt width=0

  if [ "$1" != "" ]; then
    rr=(-t 1)
    timeout=$(usageArgumentPositiveInteger "$usage" "timeout" "${1-}") || return $?
    width="$timeout"
    width="${#width}"
    # milliseconds
    timeout=$((timeout * 1000))
  fi
  shift

  attempts=$(usageArgumentInteger "$usage" "attempts" "${1-}") && shift || return $?

  extras="${1-}" && shift

  local value start now elapsed=0 message="$*" counter=1 exitCode=0 prefix="" timingSuffix=""
  start=$(__environment timingStart) || return $?

  # IDENTICAL __interactiveCountdownReadBooleanStatus 3
  [ "$attempts" -le 1 ] || prefix="$(decorate value "[ 🧪 $counter of $attempts ]") "
  [ "$timeout" = "" ] || timingSuffix="$(printf " %s %s" "$icon" "$(alignRight "$width" "$(((timeout - elapsed + 500) / 1000))")")"
  prompt=$(printf -- "%s%s%s%s" "$prefix" "$message" "$extras" "$timingSuffix")

  exitCode=2
  while [ "$exitCode" -ge 2 ]; do
    while ! value=$(bashUserInput -p "$prompt" -n 1 -s "${rr[@]+"${rr[@]}"}"); do
      if [ -z "$timeout" ]; then
        return 2
      fi
      now=$(__environment timingStart) || return $?
      elapsed=$((now - start))
      if [ "$elapsed" -gt "$timeout" ]; then
        return 10
      fi
      # IDENTICAL __interactiveCountdownReadBooleanStatus 3
      [ "$attempts" -le 1 ] || prefix="$(decorate value "[ 🧪 $counter of $attempts ]") "
      [ "$timeout" = "" ] || timingSuffix="$(printf " %s %s" "$icon" "$(alignRight "$width" "$(((timeout - elapsed + 500) / 1000))")")"
      prompt=$(printf -- "%s%s%s%s" "$prefix" "$message" "$extras" "$timingSuffix")
      statusMessage printf -- "%s" ""
    done
    statusMessage printf -- "%s" ""
    exitCode=0
    parseBoolean "$value" || exitCode=$?
    [ "$exitCode" -ge 2 ] || break
    counter=$((counter + 1))
    if [ "$attempts" -gt 0 ]; then
      if [ $counter -gt "$attempts" ]; then
        return 11
      fi
      # IDENTICAL __interactiveCountdownReadBooleanStatus 3
      [ "$attempts" -le 1 ] || prefix="$(decorate value "[ 🧪 $counter of $attempts ]") "
      [ "$timeout" = "" ] || timingSuffix="$(printf " %s %s" "$icon" "$(alignRight "$width" "$(((timeout - elapsed + 500) / 1000))")")"
      prompt=$(printf -- "%s%s%s%s" "$prefix" "$message" "$extras" "$timingSuffix")
    fi
  done
  return "$exitCode"
}
