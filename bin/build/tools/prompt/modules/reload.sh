#!/usr/bin/env bash
#
# reload.sh (management)
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__reloadChanges() {
  local handler="$1" && shift

  local path="" name="" source="" paths=() showFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --source)
      [ -z "$source" ] || throwArgument "$handler" "--source only can be supplied once" || return $?
      shift && source="$(validate "$handler" RealFile "$argument" "${1-}")" || return $?
      ;;
    --show) showFlag=true ;;
    --stop)
      # If not found we do not care
      muzzle bashPrompt --skip-prompt --remove __bashPromptModule_reloadChanges 2>&1 || :
      if cacheFile="$(__reloadChangesCacheFile "$handler")"; then
        catchEnvironment "$handler" rm -rf "$cacheFile" || return $?
      fi
      statusMessage --last decorate success "Disabled reloadChanges ..."
      return 0
      ;;
    --name) shift && name="$(validate "$handler" String "$argument" "${1-}")" || return $? ;;
    --path) shift && paths+=("$(validate "$handler" RealDirectory "$argument" "${1-}")") || return $? ;;
    --file) shift && paths+=("$(validate "$handler" RealFile "$argument" "${1-}")") || return $? ;;
    -*)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    *)
      if [ -z "$source" ]; then
        source="$(validate "$handler" RealFile "source" "$argument")" || return $?
      elif [ -f "$argument" ]; then
        paths+=("$(validate "$handler" RealFile "file" "$argument")") || return $?
      else
        paths+=("$(validate "$handler" RealDirectory "path" "$argument")") || return $?
      fi
      ;;
    esac
    shift
  done

  local cacheFile
  cacheFile="$(__reloadChangesCacheFile "$handler")" || return $?

  if $showFlag; then
    __reloadChangesShow "$handler" "$cacheFile"
    return 0
  fi

  [ ${#paths[@]} -eq 0 ] || printf "%s %s\n%s\n" "👀 $(decorate info "$name")" "$(decorate code "(source $(decorate file "$source"))")" "$(printf -- "- %s\n" "${paths[@]}"))"

  [ -n "$source" ] || throwArgument "$handler" "--source required" || return $?

  [ 0 -lt "${#paths[@]}" ] || throwArgument "$handler" "At least one path is required" || return $?
  if [ -z "$name" ]; then
    local pathNames=() path
    for path in "${paths[@]}"; do pathNames+=("$(basename "$path")"); done
    name="${pathNames[*]}"
  fi

  __reloadChangesRemove "$handler" "$cacheFile" "$source" || return $?
  catchEnvironment "$handler" printf -- "%s\n" "$source" "$name" "${paths[@]}" "--" >>"$cacheFile" || return $?
  ___bashPromptModule_reloadChangesInit "$handler" <"$cacheFile" || return $?
  decorate success "Watching $(decorate each file "${paths[@]}") as $(decorate value "$name")"
  bashPrompt --skip-prompt --first __bashPromptModule_reloadChanges
}

__reloadChangesShow() {
  local handler="$1" cacheFile="$2" name source paths

  local argument done=false
  name="" && source="" && paths=()
  while ! $done; do
    read -r argument || done=true
    [ -n "$argument" ] || continue
    if [ -z "$source" ]; then
      source="$(validate "$handler" RealFile "config-source" "$argument")" || return $?
    elif [ -z "$name" ]; then
      name=$(validate "$handler" String "config-name" "$argument") || return $?
    elif [ "$argument" != "--" ]; then
      if [ -f "$argument" ]; then
        paths+=("$(validate "$handler" RealFile "config-file" "$argument")") || return $?
      else
        paths+=("$(validate "$handler" RealDirectory "config-path" "$argument")") || return $?
      fi
    else
      printf "%s %s %s\n%s\n" "👀 $(decorate info "$name")" "$(decorate code "(source $(decorate file "$source"))")" "when changes found in" "$(printf -- "%s\n" "${paths[@]}" | decorate code | decorate wrap -- "- ")"
      name="" && source="" && paths=()
    fi
  done <"$cacheFile"
}
__reloadChangesRemove() {
  local handler="$1" cacheFile="$2" matchSource="$3"

  [ -f "$cacheFile" ] || return 0

  local argument name="" source="" paths=() target="$cacheFile.$$.temp"

  catchEnvironment "$handler" touch "$target" || returnClean $? "$target" || return $?
  while IFS="" read -r argument; do
    if [ -z "$source" ]; then
      source="$(validate "$handler" RealFile "config-source" "$argument")" || returnClean $? "$target" || return $?
    elif [ -z "$name" ]; then
      name=$(validate "$handler" String "config-name" "$argument") || returnClean $? "$target" || return $?
    elif [ "$argument" = "--" ]; then
      if [ "$source" != "$matchSource" ]; then
        catchEnvironment "$handler" printf -- "%s\n" "$source" "$name" "${paths[@]}" "--" >>"$target" || returnClean $? "$target" || return $?
      fi
      name=""
      source=""
      paths=()
      continue
    elif [ -f "$argument" ]; then
      paths+=("$(validate "$handler" RealFile "config-file" "$argument")") || return $?
    else
      paths+=("$(validate "$handler" RealDirectory "config-path" "$argument")") || return $?
    fi
  done <"$cacheFile"
  catchEnvironment "$handler" mv -f "$target" "$cacheFile" || returnClean $? "$target" || return $?
  catchEnvironment "$handler" find "$(dirname "$cacheFile")" -name '*.temp' -delete || return $?
}

__reloadChangesCacheFile() {
  local handler="$1" && shift
  local extension="${1:-state}"

  export __BASH_PROMPT_RELOAD_CHANGES_CACHE

  local prefix
  if [ -z "${__BASH_PROMPT_RELOAD_CHANGES_CACHE-}" ]; then
    local reloadHome cacheFile
    reloadHome=$(catchReturn "$handler" buildEnvironmentGetDirectory --subdirectory "reloadChanges" XDG_STATE_HOME) || return $?
    cacheFile="$(catchReturn "$handler" buildEnvironmentGet APPLICATION_CODE)" || return $?
    prefix="${reloadHome%/}/$cacheFile"
    __BASH_PROMPT_RELOAD_CHANGES_CACHE="$prefix"
  else
    prefix="$__BASH_PROMPT_RELOAD_CHANGES_CACHE"
  fi
  printf "%s.%s\n" "$prefix" "$extension"
}

# Check for shell files changing and reload a shell script after any changes and notify the user
__bashPromptModule_reloadChanges() {
  local handler="_${FUNCNAME[0]}"
  local home removeSources=() cacheFile debug=false profile=false
  local start

  start=$(timingStart)

  ! buildDebugEnabled reloadChanges || debug=true
  ! buildDebugEnabled reloadChangesProfile || profile=true

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  export __BASH_PROMPT_RELOAD_CHANGES
  export __BASH_PROMPT_RELOAD_CHANGES_CACHE

  # Primes the cached value
  muzzle __reloadChangesCacheFile "$handler" || return $?
  home=$(catchReturn "$handler" buildHome) || return $?
  cacheFile="$(__reloadChangesCacheFile "$handler")" || return $?
  ! $profile || timingReport "$start" "cacheFile=$cacheFile"
  [ -f "$cacheFile" ] || return 0

  local argument pathIndex=0

  ! $debug || decorate info "reloadChanges:"
  ! $debug || decorate pair cacheFile "$(decorate file "$cacheFile")"

  local name="" source="" directories=()
  local sourceIndex=0

  while read -r argument; do
    if [ -z "$source" ]; then
      source=$argument
      [ "${source:0:1}" = "/" ] || source="$home/$source"
      ! $profile || timingReport "$start" "source=$source"
      ! $debug || decorate pair source "$(decorate file "$source")"
      pathStateFile="$(__reloadChangesCacheFile "$handler" "$sourceIndex")" || return $?
      sourceIndex=$((sourceIndex + 1))
      ! $profile || timingReport "$start" "pathStateFile=$pathStateFile"
      continue
    elif [ -z "$name" ]; then
      name=$argument
      ! $profile || timingReport "$start" "name=$name"
      ! $debug || decorate pair name "$name"
      continue
    elif [ "$argument" = "--" ]; then
      if ! fileDirectoryExists "$source"; then
        decorate warning "$source has moved"
        removeSources+=("$source")
      else
        ! $profile || timingReport "$start" "Running check for $source"
        if ___bashPromptModule_reloadChangesCheck "$handler" "$debug" true "$pathStateFile" "$source" "$name" "${directories[@]+"${directories[@]}"}" -- "${files[@]+"${files[@]}"}"; then
          # shellcheck source=/dev/null
          source "$source"
        fi
      fi
      source=""
      name=""
      directories=()
    else
      [ -n "$argument" ] || continue
      if [ -f "$argument" ]; then
        files+=("$argument")
      elif [ -d "$argument" ]; then
        directories+=("$argument")
      else
        decorate warning "$argument was removed"
        removeSources+=("$source")
      fi
    fi
  done <"$cacheFile"

  for name in "${removeSources[@]+"${removeSources[@]+}"}"; do
    ! $profile || timingReport "$start" "Removing $name"
    __reloadChangesRemove "$handler" "$cacheFile" "$source" || return $?
  done
  ! $profile || timingReport "$start" "DONE"
}
___bashPromptModule_reloadChanges() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

___bashPromptModule_reloadChangesInit() {
  local handler="$1" && shift
  local cacheFile
  local source="" name=""
  local ff=() dd=() sourceIndex=0
  while read -r source; do
    catchEnvironment "$handler" read -r name || return $?
    local path && while read -r path; do
      if [ "$path" = "--" ]; then
        break
      fi
      [ -d "$path" ] && dd+=("$path") || ff+=("$path")
    done
    cacheFile=$(__reloadChangesCacheFile "$handler" "$sourceIndex")
    ___bashPromptModule_reloadChangesCheck "$handler" false false "$cacheFile" "$source" "$name" "${dd[@]+"${dd[@]}"}" -- "${ff[@]+"${ff[@]}"}" || :
    sourceIndex=$((sourceIndex + 1))
  done
}

___bashPromptModule_reloadChangesCheck() {
  local handler="$1" && shift
  local debug="$1" && shift
  local verbose="$1" && shift
  local pathStateFile="$1" && shift
  local source="$1" && shift
  local name="$1" && shift

  local maxModified=0 maxNewestFile=""
  while [ $# -gt 0 ]; do
    local path="$1" fileNewest newestModified
    if [ "$path" = "--" ]; then
      shift
      break
    fi
    ! $debug || decorate pair path "$(decorate file "$path") (#$pathIndex)"

    fileNewest=$(directoryNewestFile "$path" --find -name '*.sh') || return $?
    newestModified=$(fileModificationTime "$fileNewest") || return $?

    if [ "$maxModified" -eq 0 ] || [ "$newestModified" -gt "$maxModified" ]; then
      maxModified=$newestModified
      maxNewestFile=$fileNewest
    fi
    shift
  done
  while [ $# -gt 0 ]; do
    local file="$1"
    newestModified=$(fileModificationTime "$file") || return $?
    if [ "$maxModified" -eq 0 ] || [ "$newestModified" -gt "$maxModified" ]; then
      maxModified=$newestModified
      maxNewestFile=$file
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
        catchEnvironment "$handler" rm -f "$pathStateFile" || return $?
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
  ! $verbose || printf "%s %s\n" "$(decorate value "$name")" "$(decorate info "code changed, reloading $(decorate file "$source") [$prefix$(decorate file "$maxNewestFile")]")"
  ! $debug || decorate info "Saving new state file $maxModified $maxNewestFile"

  printf "%s\n" "$maxModified" "$maxNewestFile" >"$pathStateFile"
  if ! isInteger "${__BASH_PROMPT_RELOAD_CHANGES-}" || [ "$__BASH_PROMPT_RELOAD_CHANGES" -lt "$maxModified" ]; then
    __BASH_PROMPT_RELOAD_CHANGES="$maxModified"
  fi
  return 0
}
