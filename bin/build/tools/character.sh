#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
#     ▌              ▐
#  ▞▀▖▛▀▖▝▀▖▙▀▖▝▀▖▞▀▖▜▀ ▞▀▖▙▀▖
#  ▌ ▖▌ ▌▞▀▌▌  ▞▀▌▌ ▖▐ ▖▛▀ ▌
#  ▝▀ ▘ ▘▝▀▘▘  ▝▀▘▝▀  ▀ ▝▀▘▘
#

__characterLoader() {
  __functionLoader __characterClassReport character "$@"
}

# Write a report of the character classes
# Argument: --help - Optional. Flag. Display this help.
# Argument: --class - Optional. Flag. Show class and then characters in that class.
# Argument: --char - Optional. Flag. Show characters and then class for that character.
characterClassReport() {
  __characterLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_characterClassReport() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Ensure that every character in a text string passes all character class tests
# Usage: {fn} text class0 [ ... ]
# Argument: text - Text to validate
# Argument: class0 - One or more character classes that the characters in string should match
# Note: This is slow.
stringValidate() {
  local handler="_${FUNCNAME[0]}"

  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0

  local text character

  text="${1-}"
  shift || __throwArgument "$handler" "missing text" || return $?
  [ $# -gt 0 ] || __throwArgument "$handler" "missing class" || return $?
  for character in $(printf "%s" "$text" | grep -o .); do
    if ! isCharacterClasses "$character" "$@"; then
      return 1
    fi
  done
}
_stringValidate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} [ character ... ]
# Convert one or more characters from their ascii representation to an integer value.
# Requires a single character to be passed
#
characterToInteger() {
  local index

  index=0
  while [ $# -gt 0 ]; do
    [ "$1" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
    index=$((index + 1))
    [ "${#1}" = 1 ] || __throwArgument "$handler" "Single characters only (argument #$index): \"$1\" (${#1} characters)" || return $?
    LC_CTYPE=C printf '%d' "'$1" || __throwEnvironment "$handler" "Single characters only (argument #$index): \"$1\" (${#1} characters)" || return $?
    shift
  done
}
_characterToInteger() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Does this character match one or more character classes?
#
# Usage: {fn} character [ class0 class1 ... ]
# Argument: character - Required. Single character to test.
# Argument: class0 - Optional. A class name or a character to match. If more than is supplied, a single value must match to succeed (any).
#
isCharacterClasses() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0

  local character="${1-}" class

  [ "${#character}" -eq 1 ] || __throwArgument "$handler" "Non-single character: \"$character\"" || return $?
  if ! shift || [ $# -eq 0 ]; then
    __throwArgument "$handler" "Need at least one class" || return $?
  fi
  while [ "$#" -gt 0 ]; do
    class="$1"
    if [ "${#class}" -eq 1 ]; then
      if [ "$class" = "$character" ]; then
        return 0
      fi
    elif isCharacterClass "$class" "$character"; then
      return 0
    fi
    shift || __throwArgument "$handler" "shift $class failed" || return $?
  done
  return 1
}
_isCharacterClasses() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Given a list of integers, output the character codes associated with them (e.g. `chr` in other languages)
# Credit: dsmsk80
#
# Source: https://mywiki.wooledge.org/BashFAQ/071
characterFromInteger() {
  local handler="_${FUNCNAME[0]}"

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      isUnsignedInteger "$argument" || __throwArgument "$handler" "Argument is not unsigned integer: $(decorate code "$argument")" || return $?
      [ "$argument" -lt 256 ] || __throwArgument "$handler" "Integer out of range: \"$argument\"" || return $?
      if [ "$argument" -eq 0 ]; then
        printf "%s\n" $'\0'
      else
        # shellcheck disable=SC2059
        printf "\\$(printf '%03o' "$argument")"
      fi
      ;;
    esac
    shift
  done
}
_characterFromInteger() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List the valid character classes allowed in `isCharacterClass`
characterClasses() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  printf "%s\n" alnum alpha ascii blank cntrl digit graph lower print punct space upper word xdigit
}
_characterClasses() {
  true || characterClasses --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} className character0 [ character1 ... ]
#
# Poor-man's bash character class matching
#
# Returns true if all `characters` are of `className`
#
# `className` can be one of:
#     alnum   alpha   ascii   blank   cntrl   digit   graph   lower
#     print   punct   space   upper   word    xdigit
#
isCharacterClass() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0

  local class="${1-}" classes character
  local handler

  handler="_${FUNCNAME[0]}"
  IFS=$'\n' read -r -d '' -a classes < <(characterClasses) || :
  inArray "$class" "${classes[@]}" || __throwArgument "$handler" "Invalid class: $class" || return $?
  shift
  while [ $# -gt 0 ]; do
    character="${1:0:1}"
    character="$(escapeBash "$character")"
    # Not sure how you can hack this function with single character eval injections.
    # evalCheck: SAFE 2024-01-29 KMD
    if ! eval "case $character in [[:$class:]]) ;; *) return 1 ;; esac"; then
      return 1
    fi
    shift || __throwArgument "$handler" "shift $character failed" || return $?
  done
}
_isCharacterClass() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
