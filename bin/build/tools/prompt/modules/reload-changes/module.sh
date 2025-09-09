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

  local name="" source=""
  local reloadSource=false
  while read -r argument; do
    if [ -z "$source" ]; then
      source=$(usageArgumentString "$handler" "source" "$argument") || return $?
      [ "${source:0:1}" = "/" ] || source="$home/$source"
      ! $debug || decorate pair source "$(decorate file "$source")"
      continue
    elif [ -z "$name" ]; then
      name=$(usageArgumentString "$handler" "name" "$argument") || return $?
      ! $debug || decorate pair name "$name"
      continue
    elif [ "$argument" = "--" ]; then
      reloadSource=false
      name=""
      source=""
      continue
    fi

    local fileNewest path pathStateFile modified=0 filename="" prefix=""

    path=$(usageArgumentString "$handler" "path" "$argument") || return $?

    # Reloaded on a prior path, just skip until the next record
    if $reloadSource; then
      ! $debug || decorate pair Skipping path "$(decorate file "$path")"
      continue
    fi

    ! $debug || decorate pair path "$(decorate file "$path")"

    if [ ! -d "$path" ]; then
      decorate warning "$path was removed"
      removeSources+=("$source")
      continue
    fi
    if ! fileDirectoryExists "$source"; then
      decorate warning "$source has moved"
      removeSources+=("$source")
      continue
    fi

    pathStateFile="$(__reloadChangesCacheFile "$handler" "$pathIndex")" || return $?
    if [ -f "$pathStateFile" ]; then
      modified="$(head -n 1 "$pathStateFile")"
      filename="$(tail -n 1 "$pathStateFile")"
      if ! isInteger "$modified"; then
        if $debug; then
          decorate warning "Modified in $pathStateFile is non-integer: \"$modified\""
        else
          __catchEnvironment "$handler" rm -f "$pathStateFile" || return $?
        fi
        modified=0
      elif isInteger "${__BASH_PROMPT_RELOAD_CHANGES-}"; then
        if [ "$modified" -gt "${__BASH_PROMPT_RELOAD_CHANGES}" ]; then
          ! $debug || decorate info "Another process detected changes in $(decorate label "$name") [$modified]"
          __BASH_PROMPT_RELOAD_CHANGES="$modified"
          reloadSource=true
        fi
      fi
    fi

    [ "${path:0:1}" = "/" ] || path="$home/$path"
    fileNewest=$(directoryNewestFile "$path" --find -name '*.sh') || return $?
    newestModified=$(fileModificationTime "$fileNewest") || return $?
    ! $debug || decorate pair fileNewest "$(decorate file "$fileNewest")"
    if [ "$newestModified" -ne "$modified" ] || [ "$fileNewest" != "$filename" ]; then
      ! $debug || decorate info "$newestModified ($fileNewest) -gt $modified ($filename)"
      prefix=""
      [ -z "$filename" ] || prefix="$(decorate file "$filename") -> "
      [ "$filename" != "$fileNewest" ] || prefix="✏️"
      printf "%s %s\n" "$(decorate value "$name")" "$(decorate info "code changed, reloading $(decorate file "$source") [$prefix$(decorate file "$fileNewest")]")"
      ! $debug || decorate info "Saving new state file $newestModified $fileNewest"
      printf "%s\n" "$newestModified" "$fileNewest" >"$pathStateFile"
      if isInteger "${__BASH_PROMPT_RELOAD_CHANGES-}" && [ "$__BASH_PROMPT_RELOAD_CHANGES" -lt "$newestModified" ]; then
        __BASH_PROMPT_RELOAD_CHANGES="$newestModified"
      fi
      reloadSource=true
    else
      ! $debug || decorate error "! $newestModified -eq $modified"
      continue
    fi

    if $reloadSource; then
      # shellcheck source=/dev/null
      source "$source"
    fi
    pathIndex=$((pathIndex + 1))
  done <"$cacheFile"
  for name in "${removeSources[@]+"${removeSources[@]+}"}"; do
    __reloadChangesRemove "$handler" "$cacheFile" "$source" || return $?
  done
}
