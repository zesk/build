#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# PATH related
# See: PATH.sh

# Remove a path from the PATH environment variable
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional.Display this help.
# Argument: path - Requires. String. The path to be removed from the `PATH` environment.
pathRemove() {
  local handler="_${FUNCNAME[0]}"
  local items=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      items+=("$(validate "$handler" Directory "path" "$1")") || return $?
      ;;
    esac
    shift
  done

  [ "${#items[@]}" -gt 0 ] || return 0

  export PATH
  PATH="$(catchEnvironment "$handler" listRemove "${PATH-}" ':' "${items[@]}")" || return $?
}
_pathRemove() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Modify the PATH environment variable to add a path.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional.Display this help.
# Argument: --first - Optional. Place any paths after this flag first in the list
# Argument: --last - Optional. Place any paths after this flag last in the list. Default.
# Argument: path - the path to be added to the `PATH` environment
pathConfigure() {
  local handler="_${FUNCNAME[0]}"

  export PATH
  local tempPath="${PATH-}" firstFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --first) firstFlag=true ;;
    --last) firstFlag=false ;;
    *)
      local item
      item=$(validate "$handler" Directory "path" "$1") || return $?
      $firstFlag && tempPath="$item:$tempPath" || tempPath="$tempPath:$item"
      ;;
    esac
    shift
  done
  tempPath="${tempPath#:}"
  tempPath="${tempPath%:}"
  PATH="$tempPath"
}
_pathConfigure() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Utility for pathCleanDuplicates to show bad directories
_pathIsDirectory() {
  [ -n "$1" ] || return 1
  [ -d "$1" ] || return 1
}

# Cleans the path and removes non-directory entries and duplicates
#
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional.Display this help.
# Maintains ordering.
#
# Environment: PATH
pathCleanDuplicates() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  export PATH

  newPath=$(catchEnvironment "$handler" listCleanDuplicates --test _pathIsDirectory ':' "${PATH-}") || return $?

  PATH="$newPath"
}
_pathCleanDuplicates() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Show the path and where binaries are found
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional.Display this help.
# Argument: binary - Executable. Optional.Display where this executable appears in the path.
pathShow() {
  local handler="_${FUNCNAME[0]}"

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    *)
      break
      ;;
    esac
    shift
  done

  local bf=() pp=() bb=("$@")
  IFS=":" read -r -a pp <<<"$PATH"
  local p
  for p in "${pp[@]}"; do
    local bt=() b
    for b in "${bb[@]+${bb[@]}}"; do
      if [ -x "$p/$b" ]; then
        local style=success
        if inArray "$b" "${bf[@]+"${bf[@]}"}"; then
          style=warning
        else
          bf+=("$b")
        fi
        bt+=("$(decorate "$style" "$b")")
      fi
    done
    [ "${#bt[@]}" -gt 0 ] || bt+=("$(decorate info none)")
    decorate pair 100 "$p" "${bt[*]}"
  done
  local foundAll=true
  for b in "${bb[@]+${bb[@]}}"; do
    if ! inArray "$b" "${bf[@]+"${bf[@]}"}"; then
      foundAll=false
      decorate error "binary $(decorate code "$b") not found" 1>&2
    fi
  done
  $foundAll
}
_pathShow() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
