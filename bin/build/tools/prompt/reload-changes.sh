#!/usr/bin/env bash
#
# Bash Prompt Module: binBuild
#
# Copyright &copy; 2025 Market Acumen, Inc.

# Check for shell files changing and reload a shell script after any changes and notify the user
#
# Source-Hook: project-activate
# Source-Hook: project-deactivate
bashPromptModule_reloadChanges() {
  local cacheFile handler="_return"
  local home debug=false removeNames=()

  home=$(buildHome) || return $?
  cacheFile="$(__reloadChangesCacheFile "$handler")" || return $?
  [ -f "$cacheFile" ] || return 0

  local argument pathIndex=0
  ! buildDebugEnabled reloadChanges || debug=true

  ! $debug || decorate pair reloadChanges "$(decorate file "$cacheFile")"

  local name="" source="" paths=()
  while read -r argument; do
    if [ -z "$name" ]; then
      name=$(usageArgumentString "$handler" "name" "$argument") || return $?
      ! $debug || decorate pair name "$name"
      continue
    elif [ -z "$source" ]; then
      source=$(usageArgumentString "$handler" "source" "$argument") || return $?
      [ "${source:0:1}" = "/" ] || source="$home/$source"
      ! $debug || decorate pair source "$(decorate file "$source")"
      continue
    elif [ "$argument" = "--" ]; then
      name=""
      source=""
      paths=()
      continue
    fi

    local newestFile path pathStateFile modified=0 filename="" prefix=""
    path=$(usageArgumentString "$handler" "path" "$argument") || return $?

    if [ ! -d "$path" ]; then
      decorate warning "$path was removed"
      removeNames+=("$name")
      continue
    fi
    if ! fileDirectoryExists "$source"; then
      decorate warning "$source has moved"
      removeNames+=("$name")
      continue
    fi
    [ "${path:0:1}" = "/" ] || path="$home/$path"
    newestFile=$(directoryNewestFile "$path" --find -name '*.sh') || return $?
    newestModified=$(modificationTime "$newestFile") || return $?
    ! $debug || decorate pair newestFile "$(decorate file "$newestFile")"
    pathStateFile="$(__reloadChangesCacheFile "$handler" "$pathIndex")" || return $?
    if [ -f "$pathStateFile" ]; then
      modified="$(head -n 1 "$pathStateFile")"
      filename="$(tail -n 1 "$pathStateFile")"
    fi
    if [ "$newestModified" -gt "$modified" ]; then
      ! $debug || decorate info "$newestModified -gt $modified"
      prefix=""
      [ -z "$filename" ] || prefix="$(decorate file "$filename") -> "
      decorate info "$name code changed, reloading $(decorate file "$source") [$prefix$(decorate file "$newestFile")]"
      modified=$(modificationTime) || return $?
      ! $debug || decorate info "Saving new state file $newestModified $newestFile"
      printf "%s\n" "$newestModified" "$newestFile" >"$pathStateFile"
      # shellcheck source=/dev/null
      source "$source"
    else
      ! $debug || decorate error "! $newestModified -gt $modified"
    fi
  done <"$cacheFile"
  for name in "${removeNames[@]+"${removeNames[@]+}"}"; do
    __reloadChangesRemove "$handler" "$cacheFile" "$name" || return $?
  done
}

__reloadChangesCacheFile() {
  local handler="$1" extension="${2-state}"
  reloadHome=$(__catchEnvironment "$handler" buildEnvironmentGetDirectory --subdirectory "reloadChanges" XDG_STATE_HOME) || return $?
  cacheFile="$(__catchEnvironment "$handler" buildEnvironmentGet APPLICATION_CODE).$extension" || return $?
  printf "%s/%s\n" "${reloadHome%/}" "${cacheFile}"
}

# Watch or more directories for changes in a file extension and reload a source file if any changes occur. Loads
# Argument: --source source - Required. File. Source file to source upon change.
# Argument: --name name - Optional. String. The name to call this when changes occur.
# Argument: --path path - Required. Directory. OneOrMore. A directory to scan for changes in `.sh` files
reloadChanges() {
  local handler="_${FUNCNAME[0]}"

  local path="" name="" source="" paths=() showFlag=false

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$handler" 0
        return $?
        ;;
      --source)
        [ -z "$source" ] || __throwArgument "$handler" "--source only can be supplied once" || return $?
        shift
        source="$(usageArgumentRealFile "$handler" "$argument" "${1-}")" || return $?
        ;;
      --show)
        showFlag=true
        ;;
      --stop)
        bashPrompt -bashPromptModule_reloadChanges
        if cacheFile="$(__reloadChangesCacheFile "$handler")"; then
          __catchEnvironment "$handler" rm -rf "$cacheFile" || return $?
        fi
        statusMessage --last decorate success "Disabled reloadChanges ..."
        return 0
        ;;
      --name)
        shift
        name="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
        ;;
      --path)
        shift
        paths+=("$(usageArgumentRealDirectory "$handler" "$argument" "${1-}")") || return $?
        ;;
      -*)
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
      *)
        if [ -z "$source" ]; then
          source="$(usageArgumentRealFile "$handler" "source" "$argument")" || return $?
        else
          paths+=("$(usageArgumentRealDirectory "$handler" "path" "$argument")") || return $?
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  local cacheFile
  cacheFile="$(__reloadChangesCacheFile "$handler")" || return $?

  if $showFlag; then
    __reloadChangesShow "$handler" "$cacheFile"
    return 0
  fi

  [ ${#paths[@]} -eq 0 ] || printf "%s %s\n%s\n" "👀 $(decorate info "$name")" "$(decorate code "(source $(decorate file "$source"))")" "$(printf -- "- %s\n" "${paths[@]}"))"

  [ -n "$source" ] || __throwArgument "$handler" "--source required" || return $?

  [ 0 -lt "${#paths[@]}" ] || __throwArgument "$handler" "At least one path is required" || return $?
  if [ -z "$name" ]; then
    local pathNames=() path
    for path in "${paths[@]}"; do pathNames+=("$(basename "$path")"); done
    name="${pathNames[*]}"
  fi

  __reloadChangesRemove "$handler" "$cacheFile" "$name" || return $?

  __catchEnvironment "$handler" printf -- "%s\n" "$name" "$source" "${paths[@]}" "--" >>"$cacheFile" || return $?

  decorate success "Watching $(decorate each file "${paths[@]}") as $(decorate value "$name")"
  bashPrompt --first bashPromptModule_reloadChanges
}

__reloadChangesShow() {
  local handler="$1" cacheFile="$2" name source paths

  local argument
  name="" && source="" && paths=()
  while read -r argument; do
    if [ -z "$name" ]; then
      name=$(usageArgumentString "$handler" "config-name" "$argument")
    elif [ -z "$source" ]; then
      source="$(usageArgumentRealFile "$handler" "config-source" "$argument")" || return $?
    elif [ "$argument" != "--" ]; then
      paths+=("$(usageArgumentRealDirectory "$handler" "config-path" "$argument")") || return $?
    else
      printf "%s %s\n%s\n" "👀 $(decorate info "$name")" "$(decorate code "(source $(decorate file "$source"))")" "$(printf -- "- %s\n" "${paths[@]}"))"
      name="" && source="" && paths=()
    fi
  done <"$cacheFile"
  dumpPipe "Reload data file:" <"$cacheFile"
}
_reloadChanges() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__reloadChangesRemove() {
  local handler="$1" cacheFile="$2" matchName="$3"

  [ -f "$cacheFile" ] || return 0

  local argument name="" source="" paths=() target="$cacheFile.$$"

  __catchEnvironment "$handler" touch "$target" || return $?
  while IFS="" read -r argument; do
    if [ -z "$name" ]; then
      name=$(usageArgumentString "$handler" "config-name" "$argument")
    elif [ -z "$source" ]; then
      source="$(usageArgumentRealFile "$handler" "config-source" "$argument")" || _clean $? "$target" || return $?
    elif [ "$argument" = "--" ]; then
      if [ "$name" != "$matchName" ]; then
        __catchEnvironment "$handler" printf -- "%s\n" "$name" "$source" "${paths[@]}" "--" >>"$target" || _clean $? "$target" || return $?
      fi
      name=""
      source=""
      paths=()
      continue
    else
      paths+=("$(usageArgumentRealDirectory "$handler" "config-path" "$argument")") || _clean $? "$target" || return $?
    fi
  done <"$cacheFile"
  __catchEnvironment "$handler" mv -f "$target" "$cacheFile" || return $?
}
