#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Shell Dependencies: awk sed date echo sort printf
#
# Docs: o ./docs/_templates/tools/decoration.md
# Test: o ./test/tools/decoration-tests.sh

# Display large text in the console for banners and important messages
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
#
bigText() {
  local usage="_${FUNCNAME[0]}"
  local fonts binary index=0

  binary=$(__catchEnvironment "$usage" buildEnvironmentGet BUILD_TEXT_BINARY) || return $?
  if [ -z "$binary" ]; then
    __catchEnvironment "$usage" muzzle packageInstall || return $?
    binary=$(__catchEnvironment "$usage" buildEnvironmentGet BUILD_TEXT_BINARY) || return $?
  fi
  case "$binary" in
    figlet) fonts=("standard" "big") ;;
    toilet) fonts=("smblock" "smmono12") ;;
    *)
      __throwEnvironment "$usage" "Unknown BUILD_TEXT_BINARY $(decorate code "$binary")" || return $?
      ;;
  esac
  if ! muzzle packageWhich "$binary" "$binary"; then
    decorate green "BIG TEXT: $*"
    return 0
  fi
  if [ "$1" = "--bigger" ]; then
    index=1
    shift
  fi
  "$binary" -f "${fonts[index]}" "$@"
}
_bigText() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

bigTextAt() {
  local usage="_${FUNCNAME[0]}"
  local message="" x="" y=""

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        if [ -z "$x" ]; then
          x=$(usageArgumentInteger "$usage" "xOffset" "$argument") || return $?
        elif [ -z "$y" ]; then
          y=$(usageArgumentInteger "$usage" "yOffset" "$argument") || return $?
        else
          message=$(__catchEnvironment "$usage" bigText "$@") || return $?
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ -n "$x" ] || __throwArgument "$usage" "Missing x" || return $?
  [ -n "$y" ] || __throwArgument "$usage" "Missing y" || return $?
  local maxX maxY theX="$x" theY="$y" saveX saveY
  maxX=$(__catchEnvironment "$usage" consoleColumns) || return $?
  maxY=$(__catchEnvironment "$usage" consoleRows) || return $?
  [ "$x" -lt "$maxX" ] || __throwArgument "$usage" "$x -gt $maxX exceeds column width" || return $?
  [ "$y" -lt "$maxY" ] || __throwArgument "$usage" "$y -gt $maxY exceeds row height" || return $?
  [ "$x" -gt "-$maxX" ] || __throwArgument "$usage" "$x -lt -$maxX exceeds negative column width" || return $?
  [ "$y" -gt "-$maxY" ] || __throwArgument "$usage" "$y -lt -$maxY exceeds negative row height" || return $?
  IFS=$'\n' read -r -d '' saveX saveY < <(cursorGet)
  [ "$theX" -ge 0 ] || theX=$((maxX + theX))
  [ "$theY" -ge 0 ] || theY=$((maxY + theY))
  local outputLine
  while read -r outputLine; do
    __catchEnvironment "$usage" cursorSet "$theX" "$theY" || return $?
    __catchEnvironment "$usage" printf "%s" "$outputLine" || return $?
    theY=$((theY + 1))
    [ "$theY" -le "$maxY" ] || break
  done < <(printf "%s\n" "$message")
  __catchEnvironment "$usage" cursorSet "$saveX" "$saveY" || return $?
}
_bigTextAt() {
  # _IDENTICAL_ usageDocument 1
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
  local usage="_${FUNCNAME[0]}"

  local plainLabel="" label="" isBottom=true linePrefix="" lineSuffix="" tweenLabel="" tweenNonLabel=""

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
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
          # _IDENTICAL_ argumentUnknown 1
          __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        fi
        label="$argument"
        plainLabel="$(printf -- "%s\n" "$label" | stripAnsi)" || __throwArgument "$usage" "Unable to clean label" || return $?
        shift
        break
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  local banner nLines
  banner="$(bigText "$@")"
  nLines=$(printf -- "%s\n" "$banner" | wc -l)
  plainLabel="$(printf -- "%s\n" "$label" | stripAnsi)"
  tweenNonLabel="$(repeat "$((${#plainLabel}))" " ")$tweenNonLabel"
  if $isBottom; then
    printf -- "%s%s\n""%s%s%s\n" \
      "$(printf -- "%s\n" "$banner" | wrapLines "$linePrefix$tweenNonLabel" "$lineSuffix" | head -n "$((nLines - 1))")" "$lineSuffix" \
      "$linePrefix$label$tweenLabel" "$(printf -- "%s\n" "$banner" | tail -n 1)" "$lineSuffix"
  else
    printf -- "%s%s%s\n""%s%s\n" \
      "$linePrefix$label$tweenLabel" "$(printf -- "%s\n" "$banner" | head -n 1)" "$lineSuffix" \
      "$(printf -- "%s\n" "$banner" | wrapLines "$linePrefix$tweenNonLabel" "$lineSuffix" | tail -n "$((nLines - 1))")" "$lineSuffix"
  fi
}
_labeledBigText() {
  # _IDENTICAL_ usageDocument 1
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
  local usage="_${FUNCNAME[0]}"
  local argument
  local count
  local powers

  count=
  while [ $# -gt 0 ]; do
    argument="$1"
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        if [ -z "$count" ]; then
          count="$(usageArgumentUnsignedInteger "$usage" "count" "$1")" || return $?
        else
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
    shift || __throwArgument "$usage" "shift argument $argument" || return $?
  done
  __throwArgument "$usage" "missing repeat string" || return $?
}
_repeat() {
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
  local usage="_${FUNCNAME[0]}"

  local barText="" width count delta=""

  width=$(consoleColumns) || __throwEnvironment "$usage" consoleColumns || return $?
  # _IDENTICAL_ argument-case-header-blank 4
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        if [ $# -gt 2 ]; then
          # _IDENTICAL_ argumentUnknown 1
          __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        fi
        barText="$argument"
        shift
        if [ -n "${1-}" ]; then
          delta=$(usageArgumentInteger "$usage" "delta" "$1")
        else
          delta=0
          break
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  [ -n "$barText" ] || barText="="
  [ -n "$delta" ] || delta=0

  count=$((width / ${#barText}))
  count=$((count + delta))
  [ $count -gt 0 ] || __throwArgument "$usage" "count $count (delta $delta) less than zero?" || return $?
  printf -- "%s\n" "$(repeat "$count" "$barText")"
}
_echoBar() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Output a line and fill columns with a character
lineFill() {
  local usage="_${FUNCNAME[0]}"
  local text cleanText width barText

  width=$(__catchEnvironment "$usage" consoleColumns) || return $?
  barText="${1:--}"
  shift || :
  text="$*"
  cleanText=$(stripAnsi <<<"$text")
  count=$((width - ${#cleanText}))
  count=$((count / ${#barText}))
  if [ $count -gt 0 ]; then
    printf "%s%s\n" "$text" "$(repeat "$count" "$barText")"
  else
    printf "%s\n" "${text:0:$width}"
  fi
}
_lineFill() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Wrap lines with a string, useful to format output or add color codes to
# consoles which do not honor colors line-by-line. Intended to be used as a pipe.
#
# Summary: Prefix output lines with a string
# Usage: wrapLines [ --fill ] [ prefix [ suffix ... ] ] < fileToWrapLines
# Exit Code: 0
# Argument: `prefix` - Prefix each line with this text
# Argument: `suffix` - Prefix each line with this text
# Example:     cat "$file" | wrapLines "$(decorate code)" "$(decorate reset)"
# Example:     cat "$errors" | wrapLines "    ERROR: [" "]"
#
wrapLines() {
  local usage="_${FUNCNAME[0]}"
  local argument fill prefix suffix width actualWidth strippedText cleanLine pad line

  prefix=$'\1'
  suffix=$'\1'
  fill=
  width=
  while [ $# -gt 0 ]; do
    argument="$1"
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --fill)
        shift || __throwArgument "$usage" "missing $argument argument" || return $?
        [ 1 -eq "${#1}" ] || __throwArgument "$usage" "Fill character must be single character" || return $?
        fill="$1"
        width="${width:-needed}"
        ;;
      --width)
        shift || __throwArgument "$usage" "missing $argument argument" || return $?
        isUnsignedInteger "$1" && [ "$1" -gt 0 ] || __throwArgument "$usage" "$argument requires positive integer" || return $?
        width="$1"
        ;;
      *)
        if [ "$prefix" = $'\1' ]; then
          prefix="$1"
        elif [ "$suffix" = $'\1' ]; then
          suffix="$1"
        else
          suffix="$suffix $1"
        fi
        ;;
    esac
    shift || __throwArgument "$usage" shift || return $?
  done
  if ! isUnsignedInteger "$width"; then
    width=$(consoleColumns) || __throwEnvironment "$usage" "consoleColumns" || return $?
  fi
  if [ -n "$width" ]; then
    strippedText="$(printf "%s" "$prefix$suffix" | stripAnsi)"
    actualWidth=$((width - ${#strippedText}))
    if [ "$actualWidth" -lt 0 ]; then
      __throwArgument "$usage" "$width is too small to support prefix and suffix characters (${#strippedText})" || return $?
    fi
    if [ "$actualWidth" -eq 0 ]; then
      # If we are doing nothing then do not do nothing
      fill=
    fi
  fi
  pad=
  while IFS= read -r line; do
    if [ -n "$fill" ]; then
      cleanLine="$(printf "%s" "$line" | stripAnsi)"
      padWidth=$((actualWidth - ${#cleanLine}))
      if [ $padWidth -gt 0 ]; then
        pad=$(repeat "$padWidth" "$fill")
      else
        pad=
      fi
    fi
    printf "%s%s%s%s\n" "$prefix" "$line" "$pad" "$suffix"
  done
}
_wrapLines() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Format text and align it right using spaces.
#
# Usage: alignRight characterWidth text [ ... ]
# Summary: align text right
# Argument: `characterWidth` - Characters to align right
# Argument: `text ...` - Text to align right
# Example:     printf "%s: %s\n" "$(alignRight 20 Name)" "$name"
# Example:     printf "%s: %s\n" "$(alignRight 20 Profession)" "$occupation"
# Example:                 Name: Juanita
# Example:           Profession: Engineer
#
alignRight() {
  local n=$(($1 + 0))
  shift
  printf "%${n}s" "$*"
}

#
# Format text and align it left using spaces.
#
# Usage: alignLeft characterWidth text [ ... ]
#
# Summary: align text left
# Argument: - characterWidth - Characters to align left
# Argument: - `text ...` - Text to align left
#
# Example:     printf "%s: %s\n" "$(alignLeft 14 Name)" "$name"
# Example:     printf "%s: %s\n" "$(alignLeft 14 Profession)" "$occupation"
# Example:     Name          : Tyrone
# Example:     Profession    : Engineer
#
alignLeft() {
  local n=$(($1 + 0))
  shift
  printf "%-${n}s" "$*"
}

#
# Heading for section output
#
# Summary: Text heading decoration
# Usage: boxedHeading [ --size size ] text [ ... ]
# Argument: --size size - Optional. Integer. Number of liens to output. Defaults to 1.
# Argument: text ... - Text to put in the box
# Example:     boxedHeading Moving ...
# Output: +================================================================================================+
# Output: |                                                                                                |
# Output: | Moving ...                                                                                     |
# Output: |                                                                                                |
# Output: +================================================================================================+
#
boxedHeading() {
  local usage="_${FUNCNAME[0]}"

  local bar spaces text=() textString emptyBar nLines shrink width

  nLines=1
  shrink=0
  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --shrink)
        shift
        shrink=$(usageArgumentUnsignedInteger "$usage" "$argument" "${1-}") || return $?
        ;;
      --size)
        shift
        nLines=$(usageArgumentUnsignedInteger "$usage" "$argument" "${1-}") || return $?
        ;;
      *)
        text+=("$1")
        ;;
    esac
    shift
  done
  # Default is -2
  shrink=$((-(shrink + 2)))
  bar="+$(echoBar '' $shrink)+"
  emptyBar="|$(echoBar ' ' $shrink)|"

  # convert to string
  textString="${text[*]}"

  width=${#bar}
  spaces=$((width - ${#textString} - 4))
  if [ "$spaces" -gt 0 ]; then
    spaces="$(repeat "$spaces" " ")"
  else
    textString="${textString:0:$((width - 4))}"
    spaces=""
  fi
  decorate decoration "$bar"
  runCount "$nLines" decorate decoration "$emptyBar"
  printf "%s%s%s\n" "$(decorate decoration "| ")" "$(decorate decoration "$textString")" "$(decorate decoration "$spaces |")"
  runCount "$nLines" decorate decoration "$emptyBar"
  decorate decoration "$bar"
}
_boxedHeading() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Replace an absolute path prefix with an icon if it matches HOME or BUILD_HOME
decoratePath() {
  export HOME BUILD_HOME
  while [ $# -gt 0 ]; do
    local display="$1"
    display=${display//${BUILD_HOME-}/🍎}
    display=${display//${HOME-}/🏠}
    printf "%s\n" "$display"
    shift
  done
}
