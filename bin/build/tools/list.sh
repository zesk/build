#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/list.md
# Test: ./test/tools/list-tests.sh
#
#  ▜ ▗    ▐
#  ▐ ▄ ▞▀▘▜▀
#  ▐ ▐ ▝▀▖▐ ▖
#   ▘▀▘▀▀  ▀
#
# text-delimited lists

# Output arguments joined by a character
# Output: text
# Usage: {fn} separator text0 arg1 ...
# Argument: separator - Required. EmptyString. Single character to join elements. If a multi-character string is used only the first character is used as the delimiter.
# Argument: text0 - Optional. String. One or more strings to join
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
# Usage: {fn} listValue separator item ...
# Argument: listValue - Required. List value to modify.
# Argument: separator - Required. Separator string for item values (typically `:`)
# Argument: item - the item to be removed from the `listValue`
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

#
# Usage: {fn} listValue separator [ --first | --last | item ]
# Argument: listValue - Required. Path value to modify.
# Argument: separator - Required. Separator string for item values (typically `:`)
# Argument: --first - Optional. Place any items after this flag first in the list
# Argument: --last - Optional. Place any items after this flag last in the list. Default.
# Argument: item - the path to be added to the `listValue`
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
    --first)
      firstFlag=true
      ;;
    --last)
      firstFlag=false
      ;;
    *)
      if [ "$(stringOffset "$argument$separator" "$separator$separator$listValue$separator")" -lt 0 ]; then
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
    shift || throwArgument "$handler" "shift $argument" || return $?
  done
  printf "%s\n" "$listValue"
}
_listAppend() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Removes duplicates from a list and maintains ordering.
#
# Usage: {fn} separator listText
# Argument: --help - Optional. Flag. This help.
# Argument: --removed - Optional. Flag. Show removed items instead of the new list.
#
listCleanDuplicates() {
  local handler="_${FUNCNAME[0]}"
  local IFS
  local item items removed=() separator="" showRemoved=false IFS

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --test)
      shift
      test=$(usageArgumentCallable "$handler" "$argument" "${1-}") || return $?
      ;;
    --removed)
      showRemoved=true
      ;;
    *)
      if [ -z "$separator" ]; then
        separator="$argument"
      else
        break
      fi
      ;;
    esac
    shift
  done

  newItems=()
  while [ $# -gt 0 ]; do
    local tempPath
    IFS="$separator" read -r -a items < <(printf "%s\n" "$1")
    for item in "${items[@]}"; do
      if [ -z "$test" ] || ! "$test" "$item" || ! tempPath=$(listAppend "$tempPath" "$separator" "$item"); then
        removed+=("$item")
      else
        newItems+=("$item")
      fi
    done
    shift
  done
  IFS="$separator"
  if $showRemoved; then
    printf "%s\n" "${removed[*]}"
  else
    printf "%s\n" "${newItems[*]}"
  fi
}
_listCleanDuplicates() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
