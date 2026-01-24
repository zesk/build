#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Heading for section output
#
# Summary: Text heading decoration
# Argument: --outside outsideStyle - String. Optional. Style to apply to the outside border. (Default `decoration`)
# Argument: --inside insideStyle - String. Optional. Style to apply to the inside spacing. (Default blank)
# Argument: --shrink characterCount - UnsignedInteger. Optional. Reduce the box by this many characters wide. (Default 0)
# Argument: --size lineCount - UnsignedInteger. Optional. Print this many blank lines between the header and title. (Default 1)
# Argument: text ... - Text to put in the box
# Example:     consoleHeadingBoxed Moving ...
# Output: +==========================================================================+
# Output: |                                                                          |
# Output: | Moving ...                                                               |
# Output: |                                                                          |
# Output: +==========================================================================+
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
consoleHeadingBoxed() {
  local handler="_${FUNCNAME[0]}"

  local text=() outside="decoration" inside="" shrink=0 nLines=1

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --outside) shift && outside=$(validate "$handler" EmptyString "$argument" "${1-}") || return $? ;;
    --inside) shift && inside=$(validate "$handler" EmptyString "$argument" "${1-}") || return $? ;;
    --shrink) shift && shrink=$(validate "$handler" UnsignedInteger "$argument" "${1-}") || return $? ;;
    --size) shift && nLines=$(validate "$handler" UnsignedInteger "$argument" "${1-}") || return $? ;;
    *) text+=("$argument") ;;
    esac
    shift
  done

  # Default is -2
  shrink=$((-(shrink + 2)))

  local bar && bar="+$(consoleLine '' "$shrink")+"
  local width=${#bar}
  local endBar && endBar="|"
  local emptyBar

  if [ -n "$inside" ]; then
    emptyBar="$endBar$(decorate "$inside" "$(consoleLine ' ' "$shrink")")$endBar"
  else
    emptyBar="|$(consoleLine ' ' $shrink)|"
  fi

  local run=(printf "%s\n")
  [ -z "$outside" ] || run=(decorate "$outside")
  local head && head=$(
    [ "$nLines" -eq 0 ] || catchReturn "$handler" runCount "$nLines" "${run[@]}" "$emptyBar" || return $?
  ) || return $?
  catchReturn "$handler" "${run[@]}" "$bar" || return $?
  catchReturn "$handler" printf "%s" "$head" || return $?
  endBar="$("${run[@]}" "$endBar")"
  if [ "${#text[@]}" -eq 0 ]; then
    local finished=false && while ! $finished; do
      local textLine && read -r textLine || finished=true
      [ -n "$textLine" ] || ! $finished || continue
      __boxLine "$handler" "$width" "$textLine" "$endBar" || return $?
    done
  else
    __boxLine "$handler" "$width" "${text[*]}" "$endBar" || return $?
  fi
  catchReturn "$handler" printf "%s" "$head" || return $?
  catchReturn "$handler" "${run[@]}" "$bar" || return $?
}
_consoleHeadingBoxed() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__boxLine() {
  local handler="$1" && shift
  local width="$1" && shift
  local textLine="$1" && shift
  local endBar="$1" && shift
  local allSpaces && allSpaces=$(textRepeat "$width" " ")

  textLine=$(consoleTrimWidth "$((width - 4))" "$textLine$allSpaces")
  if [ -n "$inside" ]; then
    textLine="$(decorate "$inside" " $textLine ")" || return $?
  else
    textLine=" $textLine "
  fi
  catchReturn "$handler" printf -- "%s\n" "$endBar$textLine$endBar" || return $?
}
