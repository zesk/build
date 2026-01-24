#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#


# Summary: Output a bar as wide as the console
# Output a bar as wide as the console using the `=` symbol.
# Argument: alternateChar - String. Optional. Use an alternate character or string output
# Argument: offset - Integer. Optional. an integer offset to increase or decrease the size of the bar (default is `0`)
# See: consoleColumns
# Example:     decorate success $(consoleLine =-)
# Example:     decorate success $(consoleLine "- Success ")
# Example:     decorate magenta $(consoleLine +-)
consoleLine() {
  local handler="_${FUNCNAME[0]}"

  local barText="" width count delta=""

  width=$(catchReturn "$handler" consoleColumns) || return $?
  # _IDENTICAL_ argumentBlankLoopHandler 4
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      if [ $# -gt 2 ]; then
        # _IDENTICAL_ argumentUnknownHandler 1
        throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      barText="$argument"
      shift
      if [ -n "${1-}" ]; then
        delta=$(validate "$handler" Integer "delta" "$1") || return $?
      else
        delta=0
        break
      fi
      ;;
    esac
    shift
  done
  [ -n "$barText" ] || barText="="
  [ -n "$delta" ] || delta=0

  count=$((width / ${#barText}))
  count=$((count + delta))
  [ $count -gt 0 ] || throwArgument "$handler" "count $count (delta $delta) less than zero?" || return $?
  printf -- "%s\n" "$(textRepeat "$count" "$barText")"
}
_consoleLine() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Output a line and fill columns with a character
# Argument: barText - String. Required. Text to fill line with, repeated. If not specified uses `-`
# Argument: displayText - String. Optional.  Text to display on the line before the fill bar.
consoleHeadingLine() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local text cleanText width barText

  width=$(catchReturn "$handler" consoleColumns) || return $?
  barText=$(validate "$handler" String "barText" "${1:--}") || return $?
  shift || :

  text="$*"
  cleanText=$(stripAnsi <<<"$text")
  local barWidth=$((width - ${#cleanText}))
  if [ $barWidth -gt 0 ]; then
    local count=$((barWidth / ${#barText}))
    if [ $count -gt 0 ]; then
      barText="$(textRepeat "$((count + 1))" "$barText")"
      printf "%s%s\n" "$text" "${barText:0:$barWidth}"
      return 0
    fi
  fi
  printf "%s\n" "${text:0:$width}"
}
_consoleHeadingLine() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
