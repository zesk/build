#!/usr/bin/env bash
#
# Bash Prompt Module: binBuild
#
# Copyright &copy; 2025 Market Acumen, Inc.

# Check for shell files changing and reload a shell script after any changes and notify the user
#
# Source-Hook: project-activate
# Source-Hook: project-deactivate
# BUILD_DEBUG: reloadChanges - `bashPromptModule_reloadChanges` will show debugging information
bashPromptModule_reloadChanges() {
  local usage="_return"
  local home removeSources=() cacheFile debug=false

  export __BASH_PROMPT_RELOAD_CHANGES

  home=$(buildHome) || return $?
  cacheFile="$(__reloadChangesCacheFile "$usage")" || return $?
  [ -f "$cacheFile" ] || return 0

  local argument pathIndex=0
  ! buildDebugEnabled reloadChanges || debug=true

  ! $debug || decorate info "reloadChanges:"
  ! $debug || decorate pair cacheFile "$(decorate file "$cacheFile")"

  local name="" source="" paths=()
  local reloadSource=false
  while read -r argument; do
    if [ -z "$source" ]; then
      source=$(usageArgumentString "$usage" "source" "$argument") || return $?
      [ "${source:0:1}" = "/" ] || source="$home/$source"
      ! $debug || decorate pair source "$(decorate file "$source")"
      continue
    elif [ -z "$name" ]; then
      name=$(usageArgumentString "$usage" "name" "$argument") || return $?
      ! $debug || decorate pair name "$name"
      continue
    elif [ "$argument" = "--" ]; then
      reloadSource=false
      name=""
      source=""
      paths=()
      continue
    fi

    local newestFile path pathStateFile modified=0 filename="" prefix=""

    path=$(usageArgumentString "$usage" "path" "$argument") || return $?

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

    pathStateFile="$(__reloadChangesCacheFile "$usage" "$pathIndex")" || return $?
    if [ -f "$pathStateFile" ]; then
      modified="$(head -n 1 "$pathStateFile")"
      filename="$(tail -n 1 "$pathStateFile")"
      if isInteger "${__BASH_PROMPT_RELOAD_CHANGES-}"; then
        if [ "$modified" -gt "${__BASH_PROMPT_RELOAD_CHANGES}" ]; then
          ! $debug || decorate info "Another process detected changes in $(decorate label "$name") [$modified]"
          __BASH_PROMPT_RELOAD_CHANGES="$modified"
          reloadSource=true
        fi
      fi
    fi

    [ "${path:0:1}" = "/" ] || path="$home/$path"
    newestFile=$(directoryNewestFile "$path" --find -name '*.sh') || return $?
    newestModified=$(modificationTime "$newestFile") || return $?
    ! $debug || decorate pair newestFile "$(decorate file "$newestFile")"
    if [ "$newestModified" -gt "$modified" ] && [ "$newestFile" != "$filename" ]; then
      ! $debug || decorate info "$newestModified ($newestFile) -gt $modified ($filename)"
      prefix=""
      [ -z "$filename" ] || prefix="$(decorate file "$filename") -> "
      [ "$filename" != "$newestFile" ] || prefix="✏️"
      printf "%s %s\n" "$(decorate value "$name")" "$(decorate info "code changed, reloading $(decorate file "$source") [$prefix$(decorate file "$newestFile")]")"
      ! $debug || decorate info "Saving new state file $newestModified $newestFile"
      printf "%s\n" "$newestModified" "$newestFile" >"$pathStateFile"
      if isInteger "${__BASH_PROMPT_RELOAD_CHANGES-}" && [ "$__BASH_PROMPT_RELOAD_CHANGES" -lt "$newestModified" ]; then
        __BASH_PROMPT_RELOAD_CHANGES="$newestModified"
      fi
      reloadSource=true
    else
      ! $debug || decorate error "! $newestModified -gt $modified"
      continue
    fi

    if $reloadSource; then
      # shellcheck source=/dev/null
      source "$source"
    fi
  done <"$cacheFile"
  for name in "${removeSources[@]+"${removeSources[@]+}"}"; do
    __reloadChangesRemove "$usage" "$cacheFile" "$source" || return $?
  done
}

# Watch or more directories for changes in a file extension and reload a source file if any changes occur.
# Argument: --source source - Required. File. Source file to source upon change.
# Argument: --name name - Optional. String. The name to call this when changes occur.
# Argument: --path path - Required. Directory. OneOrMore. A directory to scan for changes in `.sh` files
# Argument: --stop - Flag. Optional. Stop watching changes and remove all watches.
# Argument: --show - Flag. Optional. Show watched settings and exit.
# Argument: source - File. Optional. If supplied directly on the command line, sets the source.
# Argument: path ... - Directory. Optional. If `source` supplied, then any other command line argument is treated as a path to scan for changes.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
reloadChanges() {
  local usage="_${FUNCNAME[0]}"

  local path="" name="" source="" paths=() showFlag=false

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
    --source)
      [ -z "$source" ] || __throwArgument "$usage" "--source only can be supplied once" || return $?
      shift
      source="$(usageArgumentRealFile "$usage" "$argument" "${1-}")" || return $?
      ;;
    --show)
      showFlag=true
      ;;
    --stop)
      # If not found we do not care
      muzzle bashPrompt --remove bashPromptModule_reloadChanges 2>&1 || :
      if cacheFile="$(__reloadChangesCacheFile "$usage")"; then
        __catchEnvironment "$usage" rm -rf "$cacheFile" || return $?
      fi
      statusMessage --last decorate success "Disabled reloadChanges ..."
      return 0
      ;;
    --name)
      shift
      name="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
      ;;
    --path)
      shift
      paths+=("$(usageArgumentRealDirectory "$usage" "$argument" "${1-}")") || return $?
      ;;
    -*)
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    *)
      if [ -z "$source" ]; then
        source="$(usageArgumentRealFile "$usage" "source" "$argument")" || return $?
      else
        paths+=("$(usageArgumentRealDirectory "$usage" "path" "$argument")") || return $?
      fi
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  local cacheFile
  cacheFile="$(__reloadChangesCacheFile "$usage")" || return $?

  if $showFlag; then
    __reloadChangesShow "$usage" "$cacheFile"
    return 0
  fi

  [ ${#paths[@]} -eq 0 ] || printf "%s %s\n%s\n" "👀 $(decorate info "$name")" "$(decorate code "(source $(decorate file "$source"))")" "$(printf -- "- %s\n" "${paths[@]}"))"

  [ -n "$source" ] || __throwArgument "$usage" "--source required" || return $?

  [ 0 -lt "${#paths[@]}" ] || __throwArgument "$usage" "At least one path is required" || return $?
  if [ -z "$name" ]; then
    local pathNames=() path
    for path in "${paths[@]}"; do pathNames+=("$(basename "$path")"); done
    name="${pathNames[*]}"
  fi

  __reloadChangesRemove "$usage" "$cacheFile" "$source" || return $?

  __catchEnvironment "$usage" printf -- "%s\n" "$source" "$name" "${paths[@]}" "--" >>"$cacheFile" || return $?

  decorate success "Watching $(decorate each file "${paths[@]}") as $(decorate value "$name")"
  bashPrompt --first bashPromptModule_reloadChanges
}

__reloadChangesShow() {
  local usage="$1" cacheFile="$2" name source paths

  local argument done=false
  name="" && source="" && paths=()
  while ! $done; do
    read -r argument || done=true
    [ -n "$argument" ] || continue
    if [ -z "$source" ]; then
      source="$(usageArgumentRealFile "$usage" "config-source" "$argument")" || return $?
    elif [ -z "$name" ]; then
      name=$(usageArgumentString "$usage" "config-name" "$argument")
    elif [ "$argument" != "--" ]; then
      paths+=("$(usageArgumentRealDirectory "$usage" "config-path" "$argument")") || return $?
    else
      printf "%s %s %s\n%s\n" "👀 $(decorate info "$name")" "$(decorate code "(source $(decorate file "$source"))")" "when changes found in" "$(printf -- "%s\n" "${paths[@]}" | decorate code | decorate wrap -- "- ")"
      name="" && source="" && paths=()
    fi
  done <"$cacheFile"
}
_reloadChanges() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__reloadChangesRemove() {
  local usage="$1" cacheFile="$2" matchSource="$3"

  [ -f "$cacheFile" ] || return 0

  local argument name="" source="" paths=() target="$cacheFile.$$"

  __catchEnvironment "$usage" touch "$target" || return $?
  while IFS="" read -r argument; do
    if [ -z "$source" ]; then
      source="$(usageArgumentRealFile "$usage" "config-source" "$argument")" || _clean $? "$target" || return $?
    elif [ -z "$name" ]; then
      name=$(usageArgumentString "$usage" "config-name" "$argument")
    elif [ "$argument" = "--" ]; then
      if [ "$source" != "$matchSource" ]; then
        __catchEnvironment "$usage" printf -- "%s\n" "$source" "$name" "${paths[@]}" "--" >>"$target" || _clean $? "$target" || return $?
      fi
      name=""
      source=""
      paths=()
      continue
    else
      paths+=("$(usageArgumentRealDirectory "$usage" "config-path" "$argument")") || _clean $? "$target" || return $?
    fi
  done <"$cacheFile"
  __catchEnvironment "$usage" mv -f "$target" "$cacheFile" || return $?
}

__reloadChangesCacheFile() {
  local usage="$1" extension="${2-state}"
  reloadHome=$(__catchEnvironment "$usage" buildEnvironmentGetDirectory --subdirectory "reloadChanges" XDG_STATE_HOME) || return $?
  cacheFile="$(__catchEnvironment "$usage" buildEnvironmentGet APPLICATION_CODE).$extension" || return $?
  printf "%s/%s\n" "${reloadHome%/}" "${cacheFile}"
}
