#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
#
#                                   ██
#    ▄███▄██  ██    ██   ▄████▄   ███████    ▄████▄
#   ██▀  ▀██  ██    ██  ██▀  ▀██    ██      ██▄▄▄▄██
#   ██    ██  ██    ██  ██    ██    ██      ██▀▀▀▀▀▀
#   ▀██▄▄███  ██▄▄▄███  ▀██▄▄██▀    ██▄▄▄   ▀██▄▄▄▄█
#     ▀▀▀ ██   ▀▀▀▀ ▀▀    ▀▀▀▀       ▀▀▀▀     ▀▀▀▀▀
#         ██
#

#
# Quote bash strings for inclusion as single-quoted for eval
# Usage: quoteBashString text
# Argument: text - Text to quote
# Output: string quoted and appropriate to assign to a value in the shell
# Depends: sed
# Example:     name="$(quoteBashString "$name")"
quoteBashString() {
  printf "%s\n" "$@" | sed 's/\([$`<>'\'']\)/\\\1/g'
}


# Quote grep -e patterns for shell use
#
# Quotes: " . [ ] | \n with a backslash
# Argument: text - EmptyString. Required. Text to quote.
# Output: string quoted and appropriate to insert in a grep search or replacement phrase
# Example:     grep -e "$(quoteGrepPattern "$pattern")" < "$filterFile"
# Requires: printf sed
# DOC TEMPLATE: noArgumentsForHelp 1
# Without arguments, displays help.
quoteGrepPattern() {
  # __IDENTICAL__ --help-when-blank 1
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
  local value="${1-}"
  value="${value//\"/\\\"}"
  value="${value//./\\.}"
  value="${value//[/\\[}"
  value="${value//]/\\]}"
  value="${value//|/\\|}"
  value="${value//$'\n'/\\n}"
  printf "%s\n" "$value"
}
_quoteGrepPattern() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Quote strings for inclusion in shell quoted strings
# Usage: escapeSingleQuotes text
# Argument: text - Text to quote
# Output: Single quotes are prefixed with a backslash
# Example:     {fn} "Now I can't not include this in a bash string."
# DOC TEMPLATE: noArgumentsForHelp 1
# Without arguments, displays help.
escapeDoubleQuotes() {
  # __IDENTICAL__ --help-when-blank 1
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
  while [ $# -gt 0 ]; do
    printf "%s\n" "${1//\"/\\\"}"
    shift
  done
}
_escapeDoubleQuotes() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Converts strings to shell escaped strings
# Argument: string - String. Optional. String to convert to a bash-compatible string.
# stdin: text - Optional.
# stdout: bash-compatible string
escapeBash() {
  local jqArgs

  jqArgs=(-r --raw-input '@sh')
  if [ $# -gt 0 ]; then
    printf "%s\n" "$@" | jq "${jqArgs[@]}"
  else
    jq "${jqArgs[@]}"
  fi
}
_escapeBash() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Quote strings for inclusion in shell quoted strings
#
# DOC TEMPLATE: noArgumentsForHelp 1
# Without arguments, displays help.
# Argument: text - Text to quote
# Output: Single quotes are prefixed with a backslash
# Example:     {fn} "Now I can't not include this in a bash string."
escapeSingleQuotes() {
  # __IDENTICAL__ --help-when-blank 1
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
  printf "%s\n" "$@" | sed "s/'/\\\'/g"
}
_escapeSingleQuotes() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Unquote a string
# Argument: quote - String. Required. Must match beginning and end of string.
# Argument: value - String. Required. Value to unquote.
unquote() {
  [ "$1" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local quote="$1" value="$2"
  if [ "$value" != "${value#"$quote"}" ] && [ "$value" != "${value%"$quote"}" ]; then
    value="${value#"$quote"}"
    value="${value%"$quote"}"
  fi
  printf "%s\n" "$value"
}
_unquote() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Primary case to unquote quoted things "" ''
__unquote() {
  local value="${1-}"
  case "${value:0:1}" in
  "'") value="$(unquote "'" "$value")" ;;
  '"') value="$(unquote '"' "$value")" ;;
  *) ;;
  esac
  printf "%s\n" "$value"
}


