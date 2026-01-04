#!/usr/bin/env bash
#
# Interactivity: Approvals
#
# Support functions here
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/interactive.md
# Test: ./test/tools/interactive-tests.sh

__approveBashSource() {
  local handler="$1" && shift

  local prefix="Loading" verboseFlag=false aa=(--info) bb=(--attempts 1 --timeout 30)
  local clearFlag=false deleteFlag=false reportFlag=false hh=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --info) aa=(--info) ;;
    --no-info) aa=() ;;
    --clear) clearFlag=true ;;
    --verbose) verboseFlag=true ;;
    --delete) hh+=(--delete) && deleteFlag=true ;;
    --report) reportFlag=true ;;
    --prefix) shift && prefix="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $? ;;
    *)
      local sourcePath="$argument" verb=""
      displayPath="$(decorate file "$sourcePath")"
      if "$clearFlag"; then
        __interactiveApproveClear "$handler" "$sourcePath" || return $?
        ! $verboseFlag || statusMessage --last printf -- "%s %s" "$(decorate info "Cleared approval for")" "$displayPath"
        approveBashSource "${aa[@]+"${aa[@]}"}" "$sourcePath" || return $?
        return 0
      fi
      if [ -f "$sourcePath" ]; then
        verb="file"
        if __interactiveApprove "$handler" "$sourcePath" "Load" "${aa[@]+"${aa[@]}"}" "${bb[@]}"; then
          ! $verboseFlag || statusMessage --last printf -- "%s %s %s" "$(decorate info "$prefix")" "$(decorate label "$verb")" "$displayPath"
          catchEnvironment "$handler" source "$sourcePath" || return $?
        else
          decorate subtle "Skipping unapproved file $(decorate file "$sourcePath") Undo: $(decorate code "${handler#_} --clear \"$sourcePath\"")"
        fi
      elif [ -d "$sourcePath" ]; then
        verb="path"
        if __interactiveApprove "$handler" "$sourcePath/" "Load path" "${aa[@]+"${aa[@]}"}" "${bb[@]}"; then
          ! $verboseFlag || statusMessage --last printf -- "%s %s %s" "$(decorate info "$prefix")" "$(decorate label "$verb")" "$displayPath"
          catchEnvironment "$handler" bashSourcePath "$sourcePath" || return $?
        else
          decorate subtle "Skipping unapproved directory $(decorate file "$sourcePath") Undo: $(decorate code "${handler#_} --clear \"$sourcePath\"")"
        fi
      else
        throwEnvironment "$handler" "Not a file or directory? $displayPath is a $(decorate value "$(fileType "$sourcePath")")" || return $?
      fi
      hh+=(--highlight "$sourcePath")
      ;;
    esac
    shift
  done
  if $reportFlag; then
    catchReturn "$handler" approvedSources "${hh[@]+"${hh[@]}"}" || return $?
  elif $deleteFlag; then
    catchReturn "$handler" muzzle approvedSources --delete || return $?
  fi
}

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

  shift 2 || catchArgument "$handler" "shift" || return $?
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
      statusMessage --last printf "%s [%s] %s" "$(decorate success "Approved")" "$displayFile" "$(decorate subtle "(will not ask in the future)")"
    else
      approved=false
    fi
    printf -- "%s\n" "$approved" "$(whoami)" "$(date +%s)" "$(date -u)" "$sourceFile" >"$cacheFile" || throwEnvironment "$handler" "Unable to write $(decorate file "$cacheFile")" || return $?
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
  approvedHome=$(catchReturn "$handler" buildEnvironmentGetDirectory --subdirectory ".interactiveApproved" "XDG_STATE_HOME") || return $?
  printf "%s\n" "$approvedHome"
}

# Get the cache file for a specific file
# Argument: handler - Function. Required.
# Argument: approvedHome - Directory. Required.
# Argument: sourceFile - File. Required.
# stdout: File. Cache file for `sourceFile`
__interactiveApproveCacheFile() {
  local handler="$1" approvedHome="$2" sourceFile="$3" cacheFile

  [ -f "$sourceFile" ] || throwArgument "$handler" "File does not exist: $sourceFile" || return $?
  cacheFile="$approvedHome/$(catchReturn "$handler" shaPipe <"$sourceFile")" || return $?
  printf "%s\n" "$cacheFile"
}

# handler: {fn} handler approvedTarget
__interactiveApproveClear() {
  local handler="$1" sourcePath="$2"

  shift 2 || catchArgument "$handler" "shift" || return $?
  approvedHome=$(__interactiveApproveHome "$handler") || return $?

  if [ -d "$sourcePath" ]; then
    local sourceFile
    while read -r sourceFile; do
      local cacheFile
      cacheFile=$(__interactiveApproveCacheFile "$handler" "$approvedHome" "$sourceFile") || return $?
      [ ! -f "$cacheFile" ] || catchEnvironment "$handler" rm -rf "$cacheFile" || return $?
    done < <(find "$sourcePath" -type f -name '*.sh' ! -path '*/.*/*')
  else
    local cacheFile
    cacheFile=$(__interactiveApproveCacheFile "$handler" "$approvedHome" "$sourcePath") || return $?
    [ ! -f "$cacheFile" ] || catchEnvironment "$handler" rm -rf "$cacheFile" || return $?
  fi
}

# List approved Bash script sources which can be loaded automatically by project hooks.
__approvedSources() {
  local handler="$1" && shift

  local debugFlag=false deleteFlag=false highlighted=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --highlight) shift && highlighted+=("$(usageArgumentFile "$handler" "$argument" "${1-}")") || return $? ;;
    --debug) debugFlag=true ;;
    --delete) deleteFlag=true ;;
    --no-delete) deleteFlag=false ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local home

  home=$(__interactiveApproveHome "$handler") || return $?
  local cacheFile unapprovedBashSources=() approvedBashSources=() handledFiles=() deleteFiles=()
  while read -r cacheFile; do
    local displayCacheFile
    displayCacheFile=$(decorate file "$cacheFile")

    ! $debugFlag || statusMessage decorate info "Processing $displayCacheFile $(decorate green ${#approvedBashSources[@]})/$(decorate red ${#unapprovedBashSources[@]})/$(decorate magenta ${#handledFiles[@]})"

    local approved user timestamp fullDate name why=()
    if fileIsEmpty "$cacheFile"; then
      why+=("file is empty:")
    else
      IFS=$'\n' read -r -d '' approved user timestamp fullDate name <"$cacheFile" || :
      isBoolean "$approved" || why+=("approved is not boolean")
      [ -n "$user" ] || why+=("user blank")
      isPositiveInteger "$timestamp" || why+=("timestamp not integer")
      [ -n "$fullDate" ] || why+=("date blank")

      local displayName
      displayName=$(decorate file "$name")

      if [ -f "$name" ]; then
        local actualCacheFile
        actualCacheFile=$(__interactiveApproveCacheFile "$handler" "$home" "$name") || return $?
        if [ "$actualCacheFile" != "$cacheFile" ]; then
          why+=("original file $displayName changed")
        fi
        if [ "${#handledFiles[@]}" -gt 0 ] && inArray "$name" "${handledFiles[@]}"; then
          why+=("Already handled $displayName")
        fi
      else
        why+=("file $name not found")
      fi
    fi
    if [ "${#why[@]}" -gt 0 ]; then
      if $deleteFlag; then
        deleteFiles+=("$cacheFile")
        ! $debugFlag || statusMessage --last decorate error "Will delete cache file: $displayCacheFile: $(decorate each code -- "${why[@]}")"
      else
        ! $debugFlag || statusMessage --last decorate error "Would delete cache file: $displayCacheFile: $(decorate each code -- "${why[@]}")"
      fi
    else
      local textTime fileText padding nearWidth
      textTime="$(dateFromTimestamp "$timestamp")"
      nearWidth="$(stripAnsi <<<"$displayName")"
      padding=$((60 - ${#nearWidth}))
      fileText="$displayName"
      if [ ${#highlighted[@]} -gt 0 ] && inArray "$name" "${highlighted[@]}"; then
        fileText="[$(decorate orange "$displayName")]"
        padding=$((padding - 2))
      fi

      if [ "$padding" -lt 0 ]; then
        fileText="$fileText ..."
      else
        fileText="$fileText$(repeat "$padding" " ")"
      fi
      output="$(printf -- "%s|%s %s\n" "$name" "$fileText" "$textTime")"
      if [ "$approved" = true ]; then
        approvedBashSources+=("$output")
        ! $debugFlag || statusMessage --last decorate error "Approved $displayName"
      else
        unapprovedBashSources+=("$output")
        ! $debugFlag || statusMessage --last decorate error "Not approved: $displayName"
      fi
      handledFiles+=("$name")
    fi
  done < <(find "$home" -mindepth 1 -maxdepth 1 -type f)

  [ "${#approvedBashSources[@]}" -eq 0 ] || printf "%s\n%s\n\n" "$(decorate info "Approved:")" "$(printf -- "%s\n" "${approvedBashSources[@]}" | sort | awk -F '|' '{ print $2 }')"
  [ "${#unapprovedBashSources[@]}" -eq 0 ] || printf "%s\n%s\n\n" "$(decorate warning "Unapproved:")" "$(printf -- "%s\n" "${unapprovedBashSources[@]}" | sort | awk -F '|' '{ print $2 }')"

  ! $deleteFlag || catchEnvironment "$handler" rm -f "${deleteFiles[@]}" || return $?
}
