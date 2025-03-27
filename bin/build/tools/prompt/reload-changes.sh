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
  local cacheFile usage="_return"
  local home debug=false removeNames=()

  home=$(buildHome) || return $?
  cacheFile="$(__reloadChangesCacheFile "$usage")" || return $?
  [ -f "$cacheFile" ] || return 0

  local argument pathIndex=0
  ! buildDebugEnabled reloadChanges || debug=true

  ! $debug || decorate pair reloadChanges "$(decorate file "$cacheFile")"

  local name="" source="" paths=()
  while read -r argument; do
    if [ -z "$name" ]; then
      name=$(usageArgumentString "$usage" "name" "$argument") || return $?
      ! $debug || decorate pair name "$name"
      continue
    elif [ -z "$source" ]; then
      source=$(usageArgumentString "$usage" "source" "$argument") || return $?
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
    path=$(usageArgumentString "$usage" "path" "$argument") || return $?

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
    pathStateFile="$(__reloadChangesCacheFile "$usage" "$pathIndex")" || return $?
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
    __reloadChangesRemove "$usage" "$cacheFile" "$name" || return $?
  done
}

__reloadChangesCacheFile() {
  local usage="$1" extension="${2-state}"
  reloadHome=$(__catchEnvironment "$usage" buildEnvironmentGetDirectory --subdirectory "reloadChanges" XDG_STATE_HOME) || return $?
  cacheFile="$(__catchEnvironment "$usage" buildEnvironmentGet APPLICATION_CODE).$extension" || return $?
  printf "%s/%s\n" "${reloadHome%/}" "${cacheFile}"
}

# Watch or more directories for changes in a file extension and reload a source file if any changes occur. Loads
# Argument: --source source - Required. File. Source file to source upon change.
# Argument: --name name - Optional. String. The name to call this when changes occur.
# Argument: --path path - Required. Directory. OneOrMore. A directory to scan for changes in `.sh` files
reloadChanges() {
  local usage="_${FUNCNAME[0]}"

  local path="" name=""

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
      --stop)
        bashPrompt -bashPromptModule_reloadChanges
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
        elif [ 0 -eq "${#paths[@]}" ]; then
          paths+=("$(usageArgumentRealDirectory "$usage" "path" "$argument")") || return $?
        else
          name="$*"
          break
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ -n "$source" ] || __throwArgument "$usage" "--source required" || return $?

  [ 0 -lt "${#paths[@]}" ] || __throwArgument "$usage" "At least one path is required" || return $?
  if [ -n "$name" ]; then
    local pathNames=() path
    for path in "${paths[@]}"; do pathNames+=("$(basename "$path")"); done
    name="${pathNames[*]}"
  fi

  cacheFile="$(__reloadChangesCacheFile "$usage")" || return $?
  __reloadChangesRemove "$usage" "$cacheFile" "$name" || return $?

  printf "%s\n" "$name" "$source" "${paths[@]}" "--" >>"$cacheFile"

  decorate success "Watching $(decorate file "$path") as $(decorate value "$name")"
  bashPrompt --first bashPromptModule_reloadChanges
}
_reloadChanges() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__reloadChangesRemove() {
  local handler="$1" file="$2" name="$3" firstLine

  [ -f "$file" ] || return 0
  while read -r firstLine; do
    local lineNumber firstLine="${firstLine%:*}" aa=()
    while read -r lineNumber; do
      aa+=("-e" "${lineNumber}d")
    done < <(seq "$((lineNumber + 1))" "$((lineNumber + 4))")
    __catchEnvironment "$handler" sed "${aa[@]}" <"$file" >"$file.$$" || _clean $? "$file.$$" || return $?
    __catchEnvironment "$handler" cp -f "$file.$$" "$file" || return $?
  done < <(grep -m 1 -n -e "^$(quoteGrepPattern "$name")$" "$file")
}
