#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Shell Dependencies: awk sed date echo sort printf
#
# Docs: o ./documentation/source/tools/decoration.md
# Test: o ./test/tools/decoration-tests.sh

# Display large text in the console for banners and important messages
#
# `BUILD_TEXT_BINARY` can be `figlet` or `toilet`
#
# Usage: bigText [ --bigger ] Text to output
#
# standard (figlet)
#
#      _     _      _____         _
#     | |__ (_) __ |_   _|____  _| |_
#     | '_ \| |/ _` || |/ _ \ \/ / __|
#     | |_) | | (_| || |  __/>  <| |_
#     |_.__/|_|\__, ||_|\___/_/\_\\__|
#              |___/
#
# --bigger (figlet)
#
#      _     _    _______        _
#     | |   (_)  |__   __|      | |
#     | |__  _  __ _| | _____  _| |_
#     | '_ \| |/ _` | |/ _ \ \/ / __|
#     | |_) | | (_| | |  __/>  <| |_
#     |_.__/|_|\__, |_|\___/_/\_\\__|
#               __/ |
#              |___/
#
# smblock (regular) toilet
#
#     ▌  ▗   ▀▛▘     ▐
#     ▛▀▖▄ ▞▀▌▌▞▀▖▚▗▘▜▀
#     ▌ ▌▐ ▚▄▌▌▛▀ ▗▚ ▐ ▖
#     ▀▀ ▀▘▗▄▘▘▝▀▘▘ ▘ ▀
#
# smmono12 (--bigger) toilet
#
#     ▗▖     █       ▗▄▄▄▖
#     ▐▌     ▀       ▝▀█▀▘           ▐▌
#     ▐▙█▙  ██   ▟█▟▌  █   ▟█▙ ▝█ █▘▐███
#     ▐▛ ▜▌  █  ▐▛ ▜▌  █  ▐▙▄▟▌ ▐█▌  ▐▌
#     ▐▌ ▐▌  █  ▐▌ ▐▌  █  ▐▛▀▀▘ ▗█▖  ▐▌
#     ▐█▄█▘▗▄█▄▖▝█▄█▌  █  ▝█▄▄▌ ▟▀▙  ▐▙▄
#     ▝▘▀▘ ▝▀▀▀▘ ▞▀▐▌  ▀   ▝▀▀ ▝▀ ▀▘  ▀▀
#                ▜█▛▘
# Environment: BUILD_TEXT_BINARY
bigText() {
  local handler="_${FUNCNAME[0]}"

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local fonts binary index=0

  binary=$(__catch "$handler" buildEnvironmentGet BUILD_TEXT_BINARY) || return $?
  [ -n "$binary" ] || binary="$(__catch "$handler" __bigTextBinary)" || return $?
  [ -n "$binary" ] || __throwEnvironment "$handler" "Need BUILD_TEXT_BINARY" || return $?
  case "$binary" in
  figlet) fonts=("standard" "big") ;;
  toilet) fonts=("smblock" "smmono12") ;;
  *)
    __throwEnvironment "$handler" "Unknown BUILD_TEXT_BINARY $(decorate code "$binary")" || return $?
    ;;
  esac
  if ! whichExists "$binary"; then
    decorate green "BIG TEXT: $*"
    return 0
  fi
  if [ "${1-}" = "--bigger" ]; then
    index=1
    shift
  fi
  "$binary" -w "$(consoleColumns)" -f "${fonts[index]}" "$@"
}
_bigText() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Experimental
# Place bigText at a position on the console
bigTextAt() {
  local handler="_${FUNCNAME[0]}"
  local message="" x="" y=""

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
      if [ -z "$x" ]; then
        x=$(usageArgumentInteger "$handler" "xOffset" "$argument") || return $?
      elif [ -z "$y" ]; then
        y=$(usageArgumentInteger "$handler" "yOffset" "$argument") || return $?
      else
        message=$(__catchEnvironment "$handler" bigText "$@") || return $?
      fi
      ;;
    esac
    shift
  done

  [ -n "$x" ] || __throwArgument "$handler" "Missing x" || return $?
  [ -n "$y" ] || __throwArgument "$handler" "Missing y" || return $?
  local maxX maxY theX="$x" theY="$y" saveX saveY
  maxX=$(__catch "$handler" consoleColumns) || return $?
  maxY=$(__catch "$handler" consoleRows) || return $?
  [ "$x" -lt "$maxX" ] || __throwArgument "$handler" "$x -gt $maxX exceeds column width" || return $?
  [ "$y" -lt "$maxY" ] || __throwArgument "$handler" "$y -gt $maxY exceeds row height" || return $?
  [ "$x" -gt "-$maxX" ] || __throwArgument "$handler" "$x -lt -$maxX exceeds negative column width" || return $?
  [ "$y" -gt "-$maxY" ] || __throwArgument "$handler" "$y -lt -$maxY exceeds negative row height" || return $?
  IFS=$'\n' read -r -d '' saveX saveY < <(cursorGet)
  [ "$theX" -ge 0 ] || theX=$((maxX + theX))
  [ "$theY" -ge 0 ] || theY=$((maxY + theY))
  local outputLine
  while read -r outputLine; do
    __catchEnvironment "$handler" cursorSet "$theX" "$theY" || return $?
    printf -- "%s" "$outputLine"
    theY=$((theY + 1))
    [ "$theY" -le "$maxY" ] || break
  done < <(printf "%s\n" "$message")
  __catchEnvironment "$handler" cursorSet "$saveX" "$saveY" || return $?
}
_bigTextAt() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} [ --top | --bottom ] [ --prefix prefix ] label Text ...
# Argument: --top - Optional. Flag. Place label at the top.
# Argument: --bottom - Optional. Flag. Place label at the bottom.
# Argument: --prefix prefixText - Optional. String. Optional prefix on each line.
# Argument: --tween tweenText - Optional. String. Optional between text after label and before `bigText` on each line (allows coloring or other decorations).
# Argument: --suffix suffixText - Optional. String. Optional suffix on each line.
# Argument: label - Required. String. Label to place on the left of big text.
# Argument: text - Required. String. Text for `bigText`.
#
# Outputs a label before a bigText for output.
#
# This function will strip any ANSI from the label to calculate correct string sizes.
#
# Example:     > bin/build/tools.sh labeledBigText --top "Neat: " Done
# Example:     Neat: ▛▀▖
# Example:           ▌ ▌▞▀▖▛▀▖▞▀▖
# Example:           ▌ ▌▌ ▌▌ ▌▛▀
# Example:           ▀▀ ▝▀ ▘ ▘▝▀▘
# Example:     > bin/build/tools.sh labeledBigText --bottom "Neat: " Done
# Example:           ▛▀▖
# Example:           ▌ ▌▞▀▖▛▀▖▞▀▖
# Example:           ▌ ▌▌ ▌▌ ▌▛▀
# Example:     Neat: ▀▀ ▝▀ ▘ ▘▝▀▘
labeledBigText() {
  local handler="_${FUNCNAME[0]}"

  local plainLabel="" label="" isBottom=true linePrefix="" lineSuffix="" tweenLabel="" tweenNonLabel=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --top)
      isBottom=false
      ;;
    --bottom)
      isBottom=true
      ;;
    --prefix)
      shift || :
      linePrefix="${1-}"
      ;;
    --suffix)
      shift || :
      lineSuffix="${1-}"
      ;;
    --tween)
      shift || :
      tweenLabel="${1-}"
      tweenNonLabel="${1-}"
      ;;
    *)
      if [ "$argument" != "${argument#-}" ]; then
        # _IDENTICAL_ argumentUnknownHandler 1
        __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      label="$argument"
      plainLabel="$(printf -- "%s\n" "$label" | stripAnsi)" || __throwArgument "$handler" "Unable to clean label" || return $?
      shift
      break
      ;;
    esac
    shift
  done

  local banner nLines
  banner="$(bigText "$@")"
  nLines=$(printf -- "%s\n" "$banner" | fileLineCount)
  plainLabel="$(printf -- "%s\n" "$label" | stripAnsi)"
  tweenNonLabel="$(repeat "$((${#plainLabel}))" " ")$tweenNonLabel"
  if $isBottom; then
    printf -- "%s%s\n""%s%s%s\n" \
      "$(printf -- "%s\n" "$banner" | decorate wrap "$linePrefix$tweenNonLabel" "$lineSuffix" | head -n "$((nLines - 1))")" "$lineSuffix" \
      "$linePrefix$label$tweenLabel" "$(printf -- "%s\n" "$banner" | tail -n 1)" "$lineSuffix"
  else
    printf -- "%s%s%s\n""%s%s\n" \
      "$linePrefix$label$tweenLabel" "$(printf -- "%s\n" "$banner" | head -n 1)" "$lineSuffix" \
      "$(printf -- "%s\n" "$banner" | decorate wrap "$linePrefix$tweenNonLabel" "$lineSuffix" | tail -n "$((nLines - 1))")" "$lineSuffix"
  fi
}
_labeledBigText() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: repeat count string [ ... ]
# Argument: `count` - Required, integer count of times to repeat
# Argument: `string` - A sequence of characters to repeat
# Argument: ... - Additional arguments are output using shell expansion of `$*`
# Example:     echo $(repeat 80 =)
# Example:     echo Hello world
# Example:     echo $(repeat 80 -)
# Internal: Uses power of 2 strings to minimize the number of print statements. Nerd.
# Repeat a string
repeat() {
  local handler="_${FUNCNAME[0]}"

  local count=""

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
      if [ -z "$count" ]; then
        count="$(usageArgumentUnsignedInteger "$handler" "count" "$1")" || return $?
      else
        local powers curPow
        powers=("$*")
        curPow=${#powers[@]}
        while [ $((2 ** curPow)) -le "$count" ]; do
          powers["$curPow"]="${powers[$curPow - 1]}${powers[$curPow - 1]}"
          curPow=$((curPow + 1))
        done
        curPow=0
        while [ "$count" -gt 0 ] && [ $curPow -lt ${#powers[@]} ]; do
          if [ $((count & (2 ** curPow))) -ne 0 ]; then
            printf -- "%s" "${powers[$curPow]}"
            count=$((count - (2 ** curPow)))
          fi
          curPow=$((curPow + 1))
        done
        return 0
      fi
      ;;
    esac
    shift
  done
  __throwArgument "$handler" "missing repeat string" || return $?
}
_repeat() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: echoBar [ alternateChar [ offset ] ]
# Output a bar as wide as the console using the `=` symbol.
# Argument: alternateChar - Use an alternate character or string output
# Argument: offset - an integer offset to increase or decrease the size of the bar (default is `0`)
# Environment: Console width is captured using `tput cols` or if no `TERM` set, then uses the value 80.
# Example:     decorate success $(echoBar =-)
# Example:     decorate success $(echoBar "- Success ")
# Example:     decorate magenta $(echoBar +-)
echoBar() {
  local handler="_${FUNCNAME[0]}"

  local barText="" width count delta=""

  width=$(consoleColumns) || __throwEnvironment "$handler" consoleColumns || return $?
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
        __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      barText="$argument"
      shift
      if [ -n "${1-}" ]; then
        delta=$(usageArgumentInteger "$handler" "delta" "$1") || return $?
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
  [ $count -gt 0 ] || __throwArgument "$handler" "count $count (delta $delta) less than zero?" || return $?
  printf -- "%s\n" "$(repeat "$count" "$barText")"
}
_echoBar() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Output a line and fill columns with a character
# Argument: barText - String. Required. Text to fill line with, repeated. If not specified uses `-`
# Argument: displayText - String. Optional.  Text to display on the line before the fill bar.
lineFill() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local text cleanText width barText

  width=$(__catch "$handler" consoleColumns) || return $?
  barText=$(usageArgumentString "$handler" "$barText" "${1:--}") || return $?
  shift || :

  text="$*"
  cleanText=$(stripAnsi <<<"$text")
  local barWidth=$((width - ${#cleanText}))
  if [ $barWidth -gt 0 ]; then
    local count=$((barWidth / ${#barText}))
    if [ $count -gt 0 ]; then
      barText="$(repeat "$((count + 1))" "$barText")"
      printf "%s%s\n" "$text" "${barText:0:$barWidth}"
      return 0
    fi
  fi
  printf "%s\n" "${text:0:$width}"
}
_lineFill() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Format text and align it right using spaces.
#
# Usage: alignRight characterWidth text [ ... ]
# Summary: align text right
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: characterWidth - Characters to align right
# Argument: text ... - Text to align right
# Example:     printf "%s: %s\n" "$(alignRight 20 Name)" "$name"
# Example:     printf "%s: %s\n" "$(alignRight 20 Profession)" "$occupation"
# Example:                 Name: Juanita
# Example:           Profession: Engineer
#
alignRight() {
  local handler="_${FUNCNAME[0]}"
  local n
  __help "$handler" "$@" || return 0
  n=$(usageArgumentUnsignedInteger "$handler" "characterWidth" "${1-}") && shift || return $?
  printf "%${n}s" "$*"
}
_alignRight() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Format text and align it left using spaces.
#
# Summary: align text left
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: characterWidth - Characters to align left
# Argument: text ... - Text to align left
#
# Example:     printf "%s: %s\n" "$(alignLeft 14 Name)" "$name"
# Example:     printf "%s: %s\n" "$(alignLeft 14 Profession)" "$occupation"
# Example:     Name          : Tyrone
# Example:     Profession    : Engineer
#
alignLeft() {
  local handler="_${FUNCNAME[0]}"
  local n
  __help "$handler" "$@" || return 0
  n=$(usageArgumentUnsignedInteger "$handler" "characterWidth" "${1-}") && shift || return $?
  printf "%-${n}s" "$*"
}
_alignLeft() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Heading for section output
#
# Summary: Text heading decoration
# Argument: --size size - Optional. Integer. Number of liens to output. Defaults to 1.
# Argument: --outside outsideStyle - Optional. String. Style to apply to the outside border.
# Argument: --inside insideStyle - Optional. String. Style to apply to the inside spacing.
# Argument: --shrink characterCount - Optional. UnsignedInteger. Reduce the box by this many characters wide.
# Argument: --size lineCount - Optional. UnsignedInteger. Print this many blank lines between the header and title.
# Argument: text ... - Text to put in the box
# Example:     boxedHeading Moving ...
# Output: +================================================================================================+
# Output: |                                                                                                |
# Output: | Moving ...                                                                                     |
# Output: |                                                                                                |
# Output: +================================================================================================+
#
boxedHeading() {
  local handler="_${FUNCNAME[0]}"

  local text=() decoration="decoration" inside="decoration" shrink=0 nLines=1

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --outside)
      shift
      decoration=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --inside)
      shift
      inside=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --shrink)
      shift
      shrink=$(usageArgumentUnsignedInteger "$handler" "$argument" "${1-}") || return $?
      ;;
    --size)
      shift
      nLines=$(usageArgumentUnsignedInteger "$handler" "$argument" "${1-}") || return $?
      ;;
    *)
      text+=("$1")
      ;;
    esac
    shift
  done

  local bar

  # Default is -2
  shrink=$((-(shrink + 2)))
  bar="+$(echoBar '' $shrink)+"

  local textString

  # convert to string
  textString="${text[*]}"

  local spaces width

  width=${#bar}
  spaces=$((width - $(plainLength "$textString") - 4))
  if [ "$spaces" -gt 0 ]; then
    spaces="$(repeat "$spaces" " ")"
  else
    textString="${textString:0:$((width - 4))}"
    spaces=""
  fi

  local endBar emptyBar

  endBar="$(decorate "$decoration" "|")"
  if [ -n "$inside" ]; then
    textString="$(decorate "$inside" " $textString ")"
    spaces="$(decorate "$inside" "$spaces")"
    emptyBar="$endBar$(decorate "$inside" "$(echoBar ' ' "$shrink")")$endBar"
  else
    emptyBar="|$(echoBar ' ' $shrink)|"
    textString=" $textString "
  fi

  bar=$(decorate "$decoration" "$bar")
  printf "%s\n" "$bar"
  runCount "$nLines" decorate "$decoration" "$emptyBar"
  printf "%s%s%s\n" "$endBar" "$textString$spaces" "$endBar"
  runCount "$nLines" decorate "$decoration" "$emptyBar"
  printf "%s\n" "$bar"
}
_boxedHeading() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Replace an absolute path prefix with an icon if it matches HOME, BUILD_HOME or TMPDIR
decoratePath() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  export HOME BUILD_HOME TMPDIR
  while [ $# -gt 0 ]; do
    local display="$1"
    display=${display//${BUILD_HOME-}/🍎}
    display=${display//${HOME-}/🏠}
    display=${display//${TMPDIR-}/💣}
    printf "%s\n" "$display"
    shift
  done
}
_decoratePath() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
