#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# developer.sh Tools for developers and developer.sh
#

# Announce a list of functions now available
developerAnnounce() {
  local aa=() ff=() item itemType
  while read -r item; do
    [ "$item" = "${item#_}" ] || continue
    itemType=$(type -t "$item")
    case "$itemType" in
      alias) aa+=("$item") ;;
      function) ff+=("$item") ;;
      *) decorate info "Type of $(decorate value "$item") is $(decorate code "$itemType") - not handled" 1>&2 ;;
    esac
  done
  [ "${#ff[@]}" -eq 0 ] || decorate info "Available functions $(decorate each code "${ff[@]}")"
  [ "${#aa[@]}" -eq 0 ] || decorate info "Available aliases $(decorate each code "${aa[@]}")"
}

# Undo a set of developer functions or aliases
# stdin: List of functions and aliases to remove from the current environment
developerUndo() {
  local item
  while read -r item; do
    local itemType
    itemType=$(type -t "$item")
    case "$itemType" in
      alias) unalias "$item" ;;
      function) unset "${item}" ;;
      *) decorate info "Type of $(decorate value "$item") is $(decorate code "$itemType") - not handled" 1>&2 ;;
    esac
  done
}

# Track changes to the bash environment
# Argument: source - File. Required. Source which we are tracking for changes to bash environment
# Argument: --verbose - Flag. Optional. Be verbose about what the function is doing.
# Argument: --list - Flag. Optional. Show the list of what has changed since the first invocation.
# stdout: list of function|alias|environment
developerTrack() {
  local usage="_${FUNCNAME[0]}"
  local source="" listChanges=false verboseFlag=false

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
      --list)
        listChanges=true
        ;;
      --verbose)
        verboseFlag=true
        ;;
      *)
        source=$(usageArgumentRealFile "$usage" "source" "${1-}") || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  [ -n "$source" ] || __throwArgument "$usage" "source required" || return $?

  local cachePath

  hash=$(shaPipe <<<"$source")
  cachePath=$(__catchEnvironment "$usage" buildCacheDirectory "${FUNCNAME[0]}" "$hash") || return $?
  ! $verboseFlag || statusMessage decorate info "Cache path is $(decorate file "$cachePath")"

  if $listChanges; then
    local tempPath itemType
    if [ ! -f "$cachePath/function" ]; then
      __throwEnvironment "$usage" "Finish called but never started" || return $?
    fi
    tempPath=$(fileTemporaryName "$usage" -d) || return $?
    ! $verboseFlag || statusMessage decorate info "Finishing tracking ... comparing with $tempPath"
    __developerTrack "$usage" "$tempPath" || return $?
    grep '__build' "$tempPath/function"

    printf -- "%s" "" >"$cachePath/CHANGES"
    for itemType in "alias" "function" "environment"; do
      ! $verboseFlag || statusMessage decorate info "Running $itemType"
      diff "$tempPath/$itemType" "$cachePath/$itemType" | grep '^[<>]' | cut -c 3- >>"$cachePath/CHANGES"
    done
    cat "$cachePath/CHANGES"
  else
    ! $verboseFlag || statusMessage decorate info "Starting developer tracking"
    __catchEnvironment "$usage" printf -- "%s\n" "$source" >"$cachePath/source" || return $?
    __developerTrack "$usage" "$cachePath" || return $?
    ! $verboseFlag || statusMessage --last decorate info "Developer tracking on"
  fi
}
__developerTrack() {
  local usage="$1" path="$2"
  alias -p | removeFields 1 | cut -d = -f 1 | sort -u >"$path/alias" || return $?
  declare -F | cut -d ' ' -f 3 | sort -u >"$path/function" || return $?
  environmentVariables | cut -d ' ' -f 3 | sort -u >"$path/environment" || return $?
}
_developerTrack() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
