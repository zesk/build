#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
#     ▌              ▐
#  ▞▀▖▛▀▖▝▀▖▙▀▖▝▀▖▞▀▖▜▀ ▞▀▖▙▀▖
#  ▌ ▖▌ ▌▞▀▌▌  ▞▀▌▌ ▖▐ ▖▛▀ ▌
#  ▝▀ ▘ ▘▝▀▘▘  ▝▀▘▝▀  ▀ ▝▀▘▘
#

__characterLoader() {
  __buildFunctionLoader __characterClassReport character "$@"
}

# Write a report of the character classes
# TODO: This is super-slow
# Argument: --class - Flag. Optional. Show class and then characters in that class.
# Argument: --char - Flag. Optional. Show characters and then class for that character.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
characterClassReport() {
  __characterLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_characterClassReport() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Ensure that every character in a text string passes all character class tests
# Argument: text - Text to validate
# Argument: class0 ... - One or more character classes that the characters in string should match
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Note: This is slow.
stringValidate() {
  local handler="_${FUNCNAME[0]}"

  [ "${1-}" != "--help" ] || helpArgument "_${FUNCNAME[0]}" "$@" || return 0

  local text="${1-}" && shift || throwArgument "$handler" "missing text" || return $?

  [ $# -gt 0 ] || throwArgument "$handler" "missing class" || return $?
  local character && for character in $(printf "%s" "$text" | grep -o .); do
    if ! isCharacterClasses "$character" "$@"; then
      return 1
    fi
  done
}
_stringValidate() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Convert a character to the corresponding ASCII code
# Argument: character - String. Optional. One or more characters to convert to their ASCII equivalent.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Convert one or more characters from their ascii representation to an integer value.
# Requires a single character to be passed
characterToInteger() {
  local index

  index=0
  while [ $# -gt 0 ]; do
    [ "$1" != "--help" ] || helpArgument "_${FUNCNAME[0]}" "$@" || return 0
    index=$((index + 1))
    [ "${#1}" = 1 ] || throwArgument "$handler" "Single characters only (argument #$index): \"$1\" (${#1} characters)" || return $?
    LC_CTYPE=C printf '%d' "'$1" || throwEnvironment "$handler" "Single characters only (argument #$index): \"$1\" (${#1} characters)" || return $?
    shift
  done
}
_characterToInteger() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Does this character match one or more character classes?
#
# Argument: character - Required. Single character to test.
# Argument: class ... - String. Optional. A class name or a character to match. If more than is supplied, a single value must match to succeed (any).
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
isCharacterClasses() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || helpArgument "_${FUNCNAME[0]}" "$@" || return 0

  local character="${1-}" class

  [ "${#character}" -eq 1 ] || throwArgument "$handler" "Non-single character: \"$character\"" || return $?
  if ! shift || [ $# -eq 0 ]; then
    throwArgument "$handler" "Need at least one class" || return $?
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
    shift
  done
  return 1
}
_isCharacterClasses() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Given a list of integers, output the character codes associated with them (e.g. `chr` in other languages)
# Credit: dsmsk80
#
# Source: https://mywiki.wooledge.org/BashFAQ/071
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
characterFromInteger() {
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
    *)
      isUnsignedInteger "$argument" || throwArgument "$handler" "Argument is not unsigned integer: $(decorate code "$argument")" || return $?
      [ "$argument" -lt 256 ] || throwArgument "$handler" "Integer out of range: \"$argument\"" || return $?
      case "$argument" in
      *)
        # shellcheck disable=SC2059
        printf "\\$(printf '%03o' "$argument")\n"
        ;;
      esac
      ;;
    esac
    shift
  done
}
_characterFromInteger() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List the classes allowed in `isCharacterClass`
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: character ... - String. Optional. Output the character classes associated with this character. Uses the first character only. Multiple parameters are output without a delimiter.
characterClasses() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  if [ $# -eq 0 ]; then
    printf "%s\n" alnum alpha ascii blank cntrl digit graph lower print punct space upper word xdigit
  else
    while [ $# -gt 0 ]; do
      local character="${1:0:1}"
      # ${#1} is zero for certain control characters like 0xe and 0x4 it seems
      local matchedClasses=()
      case "$character" in [[:alnum:]]) matchedClasses+=("alnum") ;; esac
      case "$character" in [[:alpha:]]) matchedClasses+=("alpha") ;; esac
      case "$character" in [[:ascii:]]) matchedClasses+=("ascii") ;; esac
      case "$character" in [[:blank:]]) matchedClasses+=("blank") ;; esac
      case "$character" in [[:cntrl:]]) matchedClasses+=("cntrl") ;; esac
      case "$character" in [[:digit:]]) matchedClasses+=("digit") ;; esac
      case "$character" in [[:graph:]]) matchedClasses+=("graph") ;; esac
      case "$character" in [[:lower:]]) matchedClasses+=("lower") ;; esac
      case "$character" in [[:print:]]) matchedClasses+=("print") ;; esac
      case "$character" in [[:punct:]]) matchedClasses+=("punct") ;; esac
      case "$character" in [[:space:]]) matchedClasses+=("space") ;; esac
      case "$character" in [[:upper:]]) matchedClasses+=("upper") ;; esac
      case "$character" in [[:word:]]) matchedClasses+=("word") ;; esac
      case "$character" in [[:xdigit:]]) matchedClasses+=("xdigit") ;; esac
      printf "%s\n" "${matchedClasses[@]}"
      shift
    done
  fi
}
_characterClasses() {
  true || characterClasses --help
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Poor-man's bash character class matching
#
# Returns true if all `characters` are of `className`
#
# `className` can be one of:
#     alnum   alpha   ascii   blank   cntrl   digit   graph   lower
#     print   punct   space   upper   word    xdigit
#
# Argument: className - String. Required. Class to check.
# Argument: character ... - String. Optional. Characters to test.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
isCharacterClass() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0

  local class="${1-}"
  case "$class" in alnum | alpha | ascii | blank | cntrl | digit | graph | lower | print | punct | space | upper | word | xdigit) ;; *) throwArgument "$handler" "Invalid class: $class" || return $? ;; esac
  shift
  while [ $# -gt 0 ]; do
    local character="${1:0:1}"
    character="$(escapeBash "$character")"
    # Not sure how you can hack this function with single character eval injections.
    # evalCheck: SAFE 2024-01-29 KMD
    if ! eval "case $character in [[:$class:]]) ;; *) return 1 ;; esac"; then
      return 1
    fi
    shift
  done
}
_isCharacterClass() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
