#!/usr/bin/env bash
#
# reload-changes API (management)
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__reloadChanges() {
  local handler="$1" && shift

  local path="" name="" source="" paths=() showFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --source)
      [ -z "$source" ] || __throwArgument "$handler" "--source only can be supplied once" || return $?
      shift
      source="$(usageArgumentRealFile "$handler" "$argument" "${1-}")" || return $?
      ;;
    --show)
      showFlag=true
      ;;
    --stop)
      # If not found we do not care
      muzzle bashPrompt --remove bashPromptModule_reloadChanges 2>&1 || :
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
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    *)
      if [ -z "$source" ]; then
        source="$(usageArgumentRealFile "$handler" "source" "$argument")" || return $?
      else
        paths+=("$(usageArgumentRealDirectory "$handler" "path" "$argument")") || return $?
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

  [ -n "$source" ] || __throwArgument "$handler" "--source required" || return $?

  [ 0 -lt "${#paths[@]}" ] || __throwArgument "$handler" "At least one path is required" || return $?
  if [ -z "$name" ]; then
    local pathNames=() path
    for path in "${paths[@]}"; do pathNames+=("$(basename "$path")"); done
    name="${pathNames[*]}"
  fi

  __reloadChangesRemove "$handler" "$cacheFile" "$source" || return $?

  __catchEnvironment "$handler" printf -- "%s\n" "$source" "$name" "${paths[@]}" "--" >>"$cacheFile" || return $?

  decorate success "Watching $(decorate each file "${paths[@]}") as $(decorate value "$name")"
  bashPrompt --first bashPromptModule_reloadChanges
}

__reloadChangesShow() {
  local handler="$1" cacheFile="$2" name source paths

  local argument done=false
  name="" && source="" && paths=()
  while ! $done; do
    read -r argument || done=true
    [ -n "$argument" ] || continue
    if [ -z "$source" ]; then
      source="$(usageArgumentRealFile "$handler" "config-source" "$argument")" || return $?
    elif [ -z "$name" ]; then
      name=$(usageArgumentString "$handler" "config-name" "$argument") || return $?
    elif [ "$argument" != "--" ]; then
      paths+=("$(usageArgumentRealDirectory "$handler" "config-path" "$argument")") || return $?
    else
      printf "%s %s %s\n%s\n" "👀 $(decorate info "$name")" "$(decorate code "(source $(decorate file "$source"))")" "when changes found in" "$(printf -- "%s\n" "${paths[@]}" | decorate code | decorate wrap -- "- ")"
      name="" && source="" && paths=()
    fi
  done <"$cacheFile"
}
_reloadChanges() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__reloadChangesRemove() {
  local handler="$1" cacheFile="$2" matchSource="$3"

  [ -f "$cacheFile" ] || return 0

  local argument name="" source="" paths=() target="$cacheFile.$$.temp"

  __catchEnvironment "$handler" touch "$target" || returnClean $? "$target" || return $?
  while IFS="" read -r argument; do
    if [ -z "$source" ]; then
      source="$(usageArgumentRealFile "$handler" "config-source" "$argument")" || returnClean $? "$target" || return $?
    elif [ -z "$name" ]; then
      name=$(usageArgumentString "$handler" "config-name" "$argument") || returnClean $? "$target" || return $?
    elif [ "$argument" = "--" ]; then
      if [ "$source" != "$matchSource" ]; then
        __catchEnvironment "$handler" printf -- "%s\n" "$source" "$name" "${paths[@]}" "--" >>"$target" || returnClean $? "$target" || return $?
      fi
      name=""
      source=""
      paths=()
      continue
    else
      paths+=("$(usageArgumentRealDirectory "$handler" "config-path" "$argument")") || returnClean $? "$target" || return $?
    fi
  done <"$cacheFile"
  __catchEnvironment "$handler" mv -f "$target" "$cacheFile" || returnClean $? "$target" || return $?
  __catchEnvironment "$handler" find "$(dirname "$cacheFile")" -name '*.temp' -delete || return $?
}

__reloadChangesCacheFile() {
  local handler="$1" extension="${2-state}"
  reloadHome=$(__catch "$handler" buildEnvironmentGetDirectory --subdirectory "reloadChanges" XDG_STATE_HOME) || return $?
  cacheFile="$(__catch "$handler" buildEnvironmentGet APPLICATION_CODE).$extension" || return $?
  printf "%s/%s\n" "${reloadHome%/}" "${cacheFile}"
}
