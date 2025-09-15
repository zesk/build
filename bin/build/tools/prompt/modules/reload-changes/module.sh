#!/usr/bin/env bash
#
# reload-changes code
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__bashPromptModule_reloadChanges() {
  local handler="$1" && shift
  local home removeSources=() cacheFile debug=false

  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0

  export __BASH_PROMPT_RELOAD_CHANGES

  home=$(buildHome) || return $?
  cacheFile="$(__reloadChangesCacheFile "$handler")" || return $?
  [ -f "$cacheFile" ] || return 0

  local argument pathIndex=0
  ! buildDebugEnabled reloadChanges || debug=true

  ! $debug || decorate info "reloadChanges:"
  ! $debug || decorate pair cacheFile "$(decorate file "$cacheFile")"

  local name="" source="" directories=()
  local sourceIndex=0

  while read -r argument; do
    if [ -z "$source" ]; then
      source=$(usageArgumentString "$handler" "source" "$argument") || return $?
      [ "${source:0:1}" = "/" ] || source="$home/$source"
      ! $debug || decorate pair source "$(decorate file "$source")"
      pathStateFile="$(__reloadChangesCacheFile "$handler" "$sourceIndex")" || return $?
      sourceIndex=$((sourceIndex + 1))
      continue
    elif [ -z "$name" ]; then
      name=$(usageArgumentString "$handler" "name" "$argument") || return $?
      ! $debug || decorate pair name "$name"
      continue
    elif [ "$argument" = "--" ]; then
      if ! fileDirectoryExists "$source"; then
        decorate warning "$source has moved"
        removeSources+=("$source")
      else
        if ___bashPromptModule_reloadChangesCheck "$handler" "$debug" "$pathStateFile" "$source" "$name" "${directories[@]}"; then
          # shellcheck source=/dev/null
          source "$source"
        fi
      fi
      source=""
      name=""
      directories=()
    else
      [ -n "$argument" ] || continue
      if [ ! -d "$argument" ]; then
        decorate warning "$argument was removed"
        removeSources+=("$source")
      else
        directories+=("$argument")
      fi
    fi
  done <"$cacheFile"

  for name in "${removeSources[@]+"${removeSources[@]+}"}"; do
    __reloadChangesRemove "$handler" "$cacheFile" "$source" || return $?
  done

}

___bashPromptModule_reloadChangesCheck() {
  local handler="$1" && shift
  local debug="$1" && shift
  local pathStateFile="$1" && shift
  local source="$1" && shift
  local name="$1" && shift

  local maxModified=0 maxNewestFile=""
  while [ $# -gt 0 ]; do
    local path="$1" fileNewest newestModified

    ! $debug || decorate pair path "$(decorate file "$path") (#$pathIndex)"

    fileNewest=$(directoryNewestFile "$path" --find -name '*.sh') || return $?
    newestModified=$(fileModificationTime "$fileNewest") || return $?

    if [ "$maxModified" -eq 0 ] || [ "$newestModified" -gt "$maxModified" ]; then
      maxModified=$newestModified
      maxNewestFile=$fileNewest
    fi
    shift
  done
  local stateModified=0 stateNewestFile=""

  if [ -f "$pathStateFile" ]; then
    stateModified="$(head -n 1 "$pathStateFile")"
    stateNewestFile="$(tail -n 1 "$pathStateFile")"
    if ! isInteger "$stateModified"; then
      if $debug; then
        decorate warning "Modified in $pathStateFile is non-integer: \"$stateModified\""
      else
        __catchEnvironment "$handler" rm -f "$pathStateFile" || return $?
      fi
      stateModified=0
    elif isInteger "${__BASH_PROMPT_RELOAD_CHANGES-}"; then
      if [ "$stateModified" -gt "${__BASH_PROMPT_RELOAD_CHANGES}" ]; then
        ! $debug || decorate info "Another process detected changes in $(decorate label "$name") [$stateModified]"
        __BASH_PROMPT_RELOAD_CHANGES="$stateModified"
        return 0
      fi
    fi
  fi

  if [ "$maxModified" -eq "$stateModified" ] && [ "$maxNewestFile" = "$stateNewestFile" ]; then
    ! $debug || decorate success "No changes: $stateModified $stateNewestFile"
    return 1
  fi

  ! $debug || decorate info "$newestModified ($stateNewestFile) -gt $maxModified ($maxNewestFile)"

  local prefix=""
  [ -z "$stateNewestFile" ] || prefix="$(decorate file "$stateNewestFile") -> "
  [ "$maxNewestFile" != "$stateNewestFile" ] || prefix="✏️"
  printf "%s %s\n" "$(decorate value "$name")" "$(decorate info "code changed, reloading $(decorate file "$source") [$prefix$(decorate file "$maxNewestFile")]")"
  ! $debug || decorate info "Saving new state file $maxModified $maxNewestFile"

  printf "%s\n" "$maxModified" "$maxNewestFile" >"$pathStateFile"
  if isInteger "${__BASH_PROMPT_RELOAD_CHANGES-}" && [ "$__BASH_PROMPT_RELOAD_CHANGES" -lt "$maxModified" ]; then
    __BASH_PROMPT_RELOAD_CHANGES="$maxModified"
  fi
  return 0

}
