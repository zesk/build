#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/list.md
# Test: ./test/tools/list-tests.sh
#
#  ▜ ▗    ▐
#  ▐ ▄ ▞▀▘▜▀
#  ▐ ▐ ▝▀▖▐ ▖
#   ▘▀▘▀▀  ▀
#
# Character-delimited lists
#
# Environment: PATH MANPATH

# Output a list of items joined by a character
# Output: text
# Argument: separator - EmptyString. Required. Single character to join elements. If a multi-character string is used only the first character is used as the delimiter.
# Argument: text0 ... - String. Optional. One or more strings to join
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
listJoin() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local IFS="${1-:0:1}"
  shift || :
  printf "%s" "$*"
}
_listJoin() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Remove one or more items from a text-delimited list
# Argument: listValue - Required. List value to modify.
# Argument: separator - Required. Separator string for item values (typically `:`)
# Argument: item - the item to be removed from the `listValue`
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
listRemove() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local argument listValue="${1-}" separator="${2-}"

  shift 2 || throwArgument "$handler" "Missing arguments" || return $?
  firstFlag=false
  while [ $# -gt 0 ]; do
    local offset next argument="$1"
    [ -n "$argument" ] || throwArgument "$handler" "blank argument" || return $?
    offset="$(stringOffset "$argument$separator" "$separator$separator$listValue$separator")"
    if [ "$offset" -lt 0 ]; then
      shift
      continue
    fi
    offset=$((offset - ${#separator} * 2))
    next=$((offset + ${#argument} + ${#separator}))
    listValue="${listValue:0:$offset}${listValue:$next}"
    shift
  done
  printf "%s\n" "$listValue"
}
_listRemove() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Does a character-delimited list contain item(s)?
# Return code 0 IFF all items are found in the list. If any item is not found, returns code 1.
# Return code: 0 - All items are found in the `listValue`
# Return code: 1 - One or more items were NOT found in the `listValue`
# If no items are passed in the return value is 0 (true).
# Argument: listValue - Required. List value to search.
# Argument: separator - Required. Separator string for item values (typically `:`)
# Argument: item ... - Optional. the item to be searched for in the `listValue`
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Add an item to the beginning or end of a text-delimited list
listContains() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local argument listValue="${1-}" separator="${2-}"

  [ ${#separator} -eq 1 ] || throwArgument "$handler" "character-length separator required: ${#separator} $(decorate code "$separator")" || return $?
  shift 2

  firstFlag=false
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
      if [ "$(stringOffset "$separator$argument$separator" "$separator$separator$listValue$separator")" -lt 0 ]; then
        return 1
      fi
      ;;
    esac
    shift
  done
}
_listContains() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Add an item to a character-delimited list.
# Add an item to a list IFF it does not exist in the list already
# Argument: listValue - Required. List value to modify.
# Argument: separator - Required. Separator string for item values (typically `:`)
# Argument: --first - Flag. Optional. Place any items after this flag first in the list
# Argument: --last - Flag. Optional. Place any items after this flag last in the list. Default.
# Argument: item - the value to be added to the `listValue`
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Add an item to the beginning or end of a text-delimited list
listAppend() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local argument listValue="${1-}" separator="${2-}"

  [ ${#separator} -eq 1 ] || throwArgument "$handler" "character-length separator required: ${#separator} $(decorate code "$separator")" || return $?
  shift 2

  firstFlag=false
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
      if [ "$(stringOffset "$separator$argument$separator" "$separator$separator$listValue$separator")" -lt 0 ]; then
        if [ -z "$listValue" ]; then
          listValue="$argument"
        elif "$firstFlag"; then
          listValue="$argument$separator${listValue#"$separator"}"
        else
          listValue="${listValue%"$separator"}$separator$argument"
        fi
      fi
      ;;
    esac
    shift
  done
  printf "%s\n" "$listValue"
}
_listAppend() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Removes duplicates from a list and maintains ordering.
#
# Argument: separator - String. Required. List separator character.
# Argument: listText - String. Required. List to clean duplicates.
# Argument: --removed - Flag. Optional. Show removed items instead of the new list.
# Argument: --test testFunction - Function. Optional. Run this function on each item in the list and if the return code is non-zero, then remove it from the list.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
listCleanDuplicates() {
  local handler="_${FUNCNAME[0]}"
  local IFS
  local item separator="" showRemoved=false testFunction=""
  local debugFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --debug) debugFlag=true ;;
    --test) shift && testFunction=$(validate "$handler" Callable "$argument" "${1-}") || return $? ;;
    --removed) showRemoved=true ;;
    *) if [ -z "$separator" ]; then separator="$argument"; else break; fi ;;
    esac
    shift
  done

  local tempPath="" removed=()
  while [ $# -gt 0 ]; do
    local items
    IFS="$separator" read -r -a items < <(printf "%s\n" "$1")
    local item
    for item in "${items[@]}"; do
      if [ "${#removed[@]}" -gt 0 ] && inArray "$item" "${removed[@]}"; then
        ! $debugFlag || decorate info "Removed $item (already removed)"
      elif [ -n "$testFunction" ] && ! "$testFunction" "$item"; then
        removed+=("$item")
        ! $debugFlag || decorate info "Removed $item with $testFunction"
      else
        tempPath=$(listAppend "$tempPath" "$separator" "$item")
        ! $debugFlag || decorate info "$(decorate code "$tempPath") - Added $item"
      fi
    done
    shift
  done
  IFS="$separator"
  if $showRemoved; then
    printf "%s\n" "${removed[*]}"
  else
    printf "%s\n" "$tempPath"
  fi
}
_listCleanDuplicates() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
