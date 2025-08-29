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

# handler: {fn} handler sourceFile ...
# Argument: handler - Function. Required.
# Argument: sourceFile - File. Required.
# Argument: Prompt - String. Optional.
# Argument: ... - Arguments. Optional. Passed to `confirmYesNo`
__interactiveApprove() {
  local handler="$1" sourcePath="$2" approved displayFile approvedHome

  shift 2 || __catchArgument "$handler" "shift" || return $?
  approvedHome=$(__interactiveApproveHome "$handler") || return $?

  if [ -d "$sourcePath" ]; then
    sourcePath="${sourcePath%/}"
    local sourceFile approved=true
    while read -r sourceFile; do
      if ! __interactiveApproveRegisterCacheFile "$handler" "$sourceFile" "$approvedHome" "$@"; then
        approved=false
        break
      fi
    done < <(find "$sourcePath" -type f -name '*.sh' ! -path '*/.*/*')
    "$approved"
  else
    __interactiveApproveRegisterCacheFile "$handler" "$sourcePath" "$approvedHome" "$@"
  fi
}

# If a file has been seen already, handle it, otherwise ask the user to approve interactively.
#
# Argument: handler - Function. Required.
# Argument: sourceFile - File. Required.
# Argument: approvedHome - Directory. Required.
# Argument: verb - String. Required.
# Argument: ... - Arguments. Passed to `confirmYesNo`.
__interactiveApproveRegisterCacheFile() {
  local handler="$1" sourceFile="$2" approvedHome="$3" verb="$4" approved displayFile approvedHome

  shift 4
  cacheFile="$(__interactiveApproveCacheFile "$handler" "$approvedHome" "$sourceFile")"
  displayFile=$(decorate file "$sourceFile")
  if [ ! -f "$cacheFile" ]; then
    if confirmYesNo "$@" "$verb $(decorate file "$sourcePath")?"; then
      approved=true
      statusMessage --last printf "%s [%s] %s" "$(decorate success "Approved")" "$(decorate file "$displayFile")" "$(decorate subtle "(will not ask in the future)")"
    else
      approved=false
    fi
    printf -- "%s\n" "$approved" "$(whoami)" "$(date +%s)" "$(date -u)" "$sourceFile" >"$cacheFile" || __throwEnvironment "$handler" "Unable to write $(decorate file "$cacheFile")" || return $?
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
# Argument: handler - Function. Required.
__interactiveApproveHome() {
  local handler="$1" approvedHome
  approvedHome=$(__catch "$handler" buildEnvironmentGetDirectory --subdirectory ".interactiveApproved" "XDG_STATE_HOME") || return $?
  printf "%s\n" "$approvedHome"
}

# Get the cache file for a specific file
# Argument: handler - Function. Required.
# Argument: approvedHome - Directory. Required.
# Argument: sourceFile - File. Required.
# stdout: File. Cache file for `sourceFile`
__interactiveApproveCacheFile() {
  local handler="$1" approvedHome="$2" sourceFile="$3" cacheFile

  [ -f "$sourceFile" ] || __throwArgument "$handler" "File does not exist: $sourceFile" || return $?
  cacheFile="$approvedHome/$(__catch "$handler" shaPipe <"$sourceFile")" || return $?
  printf "%s\n" "$cacheFile"
}

# handler: {fn} handler approvedTarget
__interactiveApproveClear() {
  local handler="$1" sourcePath="$2"

  shift 2 || __catchArgument "$handler" "shift" || return $?
  approvedHome=$(__interactiveApproveHome "$handler") || return $?

  if [ -d "$sourcePath" ]; then
    local sourceFile
    while read -r sourceFile; do
      local cacheFile
      cacheFile=$(__interactiveApproveCacheFile "$handler" "$approvedHome" "$sourceFile") || return $?
      [ ! -f "$cacheFile" ] || __catchEnvironment "$handler" rm -rf "$cacheFile" || return $?
    done < <(find "$sourcePath" -type f -name '*.sh' ! -path '*/.*/*')
  else
    local cacheFile
    cacheFile=$(__interactiveApproveCacheFile "$handler" "$approvedHome" "$sourcePath") || return $?
    [ ! -f "$cacheFile" ] || __catchEnvironment "$handler" rm -rf "$cacheFile" || return $?
  fi
}

# Maybe move this to its own thing if needed later
# handler: {fn} handler timeout attempts extras message
__interactiveCountdownReadBoolean() {
  local handler="$1" tempResult

  [ $# -eq 5 ] || __throwArgument "$handler" "Missing arguments: $# less than 5" || return $?
  tempResult=$(fileTemporaryName "$handler") || return $?

  __interactiveCountdownReadCharacter "$@" "__confirmYesNoValidate" "$tempResult" || returnClean $? "$tempResult" || return $?
  value=$(__catchEnvironment "$handler" cat "$tempResult") || returnClean $? "$tempResult" || return $?
  __catchEnvironment "$handler" rm -rf "$tempResult" || return $?
  "$value"
}

__confirmYesNoValidate() {
  local value="$1" result="$2" && shift 2
  local exitCode=0
  parseBoolean "$value" || exitCode=$?
  case "$exitCode" in
  0)
    printf "%s\n" true >"$result"
    return 0
    ;;
  1)
    printf "%s\n" false >"$result"
    return 0
    ;;
  2) return 1 ;;
  esac
}

# Maybe move this to its own thing if needed later
# handler: {fn} handler timeout attempts extras message parser
# Argument: handler - Function. Error handler
# Argument: timeout - UnsignedInteger|Empty. Milliseconds to time out after.
# Argument: attempts - Integer. Number ot attempts to allow.
# Argument: extras - EmptyString. Extra text to add to the prompt.
# Argument: message - EmptyString. The message to show to prompt the user.
# Argument: parser ... - Function. Function to call to check the input if it's valid and arguments to add.
# Exit code: 10 - Timeout
# Exit code: 11 - Attempts ran out
# Exit code: 0 - All good, print character
# Exit code: 1 - Error
# Exit code: 2 - Error
__interactiveCountdownReadCharacter() {
  local handler="$1" && shift
  local timeout="" rr=() extras icon="⏳" attempts prompt width=0

  if [ "$1" != "" ]; then
    rr=(-t 1)
    timeout=$(usageArgumentPositiveInteger "$handler" "timeout" "${1-}") || return $?
    width="$timeout"
    width="${#width}"
    # milliseconds
    timeout=$((timeout * 1000))
  fi
  shift

  attempts=$(usageArgumentInteger "$handler" "attempts" "${1-}") && shift || return $?

  extras="${1-}" && shift

  local value start elapsed=0 message="$1" counter=1 prefix="" timingSuffix="" && shift
  local parser="$1" && shift

  start=$(timingStart)

  # IDENTICAL __interactiveCountdownReadBooleanStatus 3
  [ "$attempts" -le 1 ] || prefix="$(decorate value "[ 🧪 $counter of $attempts ]") "
  [ "$timeout" = "" ] || timingSuffix="$(printf " %s %s" "$icon" "$(alignRight "$width" "$(((timeout - elapsed + 500) / 1000))")")"
  prompt=$(printf -- "%s%s%s%s" "$prefix" "$message" "$extras" "$timingSuffix")

  while true; do
    statusMessage printf -- ""
    while ! value=$(bashUserInput -p "$prompt" -n 1 -s "${rr[@]+"${rr[@]}"}"); do
      if [ -z "$timeout" ]; then
        return 2
      fi
      elapsed=$(($(timingStart) - start))
      if [ "$elapsed" -gt "$timeout" ]; then
        return 10
      fi
      # IDENTICAL __interactiveCountdownReadBooleanStatus 3
      [ "$attempts" -le 1 ] || prefix="$(decorate value "[ 🧪 $counter of $attempts ]") "
      [ "$timeout" = "" ] || timingSuffix="$(printf " %s %s" "$icon" "$(alignRight "$width" "$(((timeout - elapsed + 500) / 1000))")")"
      prompt=$(printf -- "%s%s%s%s" "$prefix" "$message" "$extras" "$timingSuffix")
      statusMessage printf -- ""
    done
    statusMessage printf -- ""
    if [ -n "$value" ] && "$parser" "$value" "$@"; then
      return 0
    fi
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
  return 1
}
