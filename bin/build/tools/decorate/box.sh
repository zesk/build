#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__decorateExtensionBoxLineStyle() {
  case "$1" in
  ascii) lineStyleCodes="++++-|" ;;
  line) lineStyleCodes="┌┐└┘─│" ;;
  double-line) lineStyleCodes="╔╗╚╝═║" ;;
  *) return 1 ;;
  esac
}

# TODO: Plenty, see who else does this better
#      ─	━	│	┃	┄	┅	┆	┇	┈	┉	┊	┋
#      ┌	┍	┎	┏      ┐	┑	┒	┓      └	┕	┖	┗      ┘	┙	┚	┛
#      ├	┝	┞	┟      ┠	┡	┢	┣      ┤	┥	┦	┧      ┨	┩	┪	┫
#      ┬	┭	┮	┯ ┰ ┱	┲	┳	┴	┵	┶	┷	┸	┹	┺	┻
#      ┼	┽	┾	┿	╀	╁	╂	╃	╄	╅	╆	╇	╈	╉	╊	╋
#      ╌	╍	╎	╏ ═	║
#      ╒	╓	╔	╕	╖	╗	╘	╙	╚	╛	╜	╝
#      ╞	╟ ╠	╡	╢	╣
#      ╤	╥	╦	╧	╨	╩
#      ╪	╫	╬
#      ╭	╮	╯ ╰
#      ╱	╲	╳
#      ╴	╵	╶	╷	╸	╹	╺	╻	╼	╽	╾	╿

# fn: decorate box
# Summary: Box around content
# The `.Pure` extension means this function knows how to deal with standard input.
# Argument: --type (ascii|line|double-line) - String. Optional. Line style. Default `line`
# Argument: --outside outsideStyle - String. Optional. Style to apply to the outside border. (Default `decoration`)
# Argument: --inside insideStyle - String. Optional. Style to apply to the inside content. (Default `decoration`)
# Argument: --width characterCount - UnsignedInteger|String. Optional. Box width. Specify "auto" to make size of content, or "console" for `consoleWidth`. Defaults to `console`.
# Argument: --size lineCount - UnsignedInteger. Optional. Print this many blank lines between the header and title. (Default none)
# Argument: --fill fileCharacter - String. Optional. Use this character to fill empty space in the box.
# Argument: text ... - String. Optional. Text to put in the box, one per line.
# Example:     {fn} Moving ...
# Output:     +==========================================================================+
# Output:     |                                                                          |
# Output:     | Moving ...                                                               |
# Output:     |                                                                          |
# Output:     +==========================================================================+
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
__decorateExtensionBox.Pure() {
  local handler="_${FUNCNAME[0]}"

  local textLines=() outside="decoration" inside="decoration" nLines=0 lineStyleCodes="" lineStyle="line" fill=" " argumentWidth="console" maxWidth=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --style) shift && lineStyle="${1-}" && __decorateExtensionBoxLineStyle "$lineStyle" || throwArgument "$handler" "Invalid style: ${1-}" || return $? ;;
    --width) shift && argumentWidth="$1" && case "$argumentWidth" in "terminal" | "auto") ;; *) isPositiveInteger "$argumentWidth" || throwArgument "$handler" "Invalid width: $argumentWidth" || return $? ;; esac ;;
    --outside) shift && outside=$(validate "$handler" EmptyString "$argument" "${1-}") || return $? ;;
    --inside) shift && inside=$(validate "$handler" EmptyString "$argument" "${1-}") || return $? ;;
    --size) shift && nLines=$(validate "$handler" UnsignedInteger "$argument" "${1-}") || return $? ;;
    --fill) shift && fill=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    *)
      if [ "$argument" = "--" ] && [ $# -eq 1 ]; then
        break
      fi
      textLines+=("$argument")
      if [ -z "$maxWidth" ]; then
        maxWidth="${#argument}"
      elif [ ${#argument} -gt "$maxWidth" ]; then
        maxWidth="${#argument}"
      fi
      ;;
    esac
    shift
  done
  if [ -z "$lineStyleCodes" ]; then
    __decorateExtensionBoxLineStyle "$lineStyle" || throwArgument "$handler" "Invalid --style $lineStyle" || return $?
  fi

  if [ "$argumentWidth" = "auto" ]; then
    width="$((maxWidth + 2))"
  elif [ "$argumentWidth" = "console" ]; then
    width=$(($(consoleColumns) - 2))
  elif isUnsignedInteger "$argumentWidth"; then
    width=$argumentWidth
  else
    throwArgument "$handler" "argumentWidth is invalid: $argumentWidth" || return $?
  fi

  local header && header="${lineStyleCodes:0:1}$(textRepeat "$width" "${lineStyleCodes:4:1}")${lineStyleCodes:1:1}"
  local footer && footer="${lineStyleCodes:2:1}$(textRepeat "$width" "${lineStyleCodes:4:1}")${lineStyleCodes:3:1}"
  local sideBar && sideBar="${lineStyleCodes:5:1}"

  local run=(printf "%s\n")
  [ -z "$outside" ] || run=(decorate "$outside" --)
  sideBar="$("${run[@]}" "$sideBar")"
  local emptyBar
  if [ -n "$inside" ]; then
    emptyBar="$sideBar$(decorate "$inside" "$(textRepeat "$width" "${fill:0:1}")")$sideBar"
  else
    emptyBar="$sideBar$(textRepeat "$width" "${fill:0:1}")$sideBar"
  fi
  local head && head=$(
    [ "$nLines" -eq 0 ] || catchReturn "$handler" executeCount "$nLines" "${run[@]}" "$emptyBar" || return $?
  ) || return $?
  catchReturn "$handler" "${run[@]}" "$header" || return $?
  [ -z "$head" ] || catchReturn "$handler" printf "%s\n" "$head" || return $?
  if [ "${#textLines[@]}" -eq 0 ]; then
    local finished=false && while ! $finished; do
      local textLine && IFS="" read -r textLine || finished=true
      [ -n "$textLine" ] || ! $finished || continue
      __boxLine "$handler" "$width" "$textLine" "$sideBar" || return $?
    done
  else
    local textLine && for textLine in "${textLines[@]}"; do
      __boxLine "$handler" "$width" "$textLine" "$sideBar" || return $?
    done
  fi
  [ -z "$head" ] || catchReturn "$handler" printf "%s\n" "$head" || return $?
  catchReturn "$handler" "${run[@]}" "$footer" || return $?
}
___decorateExtensionBox.Pure() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__boxLine() {
  local handler="$1" && shift
  local width="$1" && shift
  local textLine="$1" && shift
  local sideBar="$1" && shift
  local allSpaces && allSpaces=$(textRepeat "$width" " ")

  textLine=$(consoleTrimWidth "$((width - 2))" "$textLine$allSpaces")
  if [ -n "$inside" ]; then
    textLine="$(decorate "$inside" " $textLine ")" || return $?
  else
    textLine=" $textLine "
  fi
  catchReturn "$handler" printf -- "%s\n" "$sideBar$textLine$sideBar" || return $?
}
