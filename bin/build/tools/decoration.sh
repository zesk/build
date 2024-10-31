#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
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

  __usageEnvironment "$usage" packageUpdate || return $?
  __usageEnvironment "$usage" packageInstall || return $?
  binary=$(__usageEnvironment "$usage" buildEnvironmentGet BUILD_TEXT_BINARY) || return $?
  case "$binary" in
    figlet) fonts=("standard" "big") ;;
    toilet) fonts=("smblock" "smmono12") ;;
    *) __failEnvironment "$usage" "Unknown binary $binary" || return $? ;;
  esac
  if ! packageWhich "$binary" "$binary" >/dev/null; then
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
  # IDENTICAL usageDocument 1
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
  local argument nArguments argumentIndex
  local label banner linePrefix lineSuffix tweenLabel tweenNonLabel nLines plainLabel isBottom

  label=
  isBottom=true
  linePrefix=
  lineSuffix=
  tweenLabel=
  tweenNonLabel=
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="${1-}"
    case "$argument" in
      # IDENTICAL --help 4
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
        [ "$argument" = "${argument#-}" ] || __failArgument "$usage" "Unknown argument #$argumentIndex: $argument" || return $?
        label="$argument"
        plainLabel="$(printf "%s\n" "$label" | stripAnsi)" || __failArgument "$usage" "Unable to clean label" || return $?
        shift
        break
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument" || return $?
  done
  banner="$(bigText "$@")"
  nLines=$(printf "%s\n" "$banner" | wc -l)
  plainLabel="$(printf "%s\n" "$label" | stripAnsi)"
  tweenNonLabel="$(repeat "$((${#plainLabel}))" " ")$tweenNonLabel"
  if $isBottom; then
    printf "%s%s\n""%s%s%s\n" \
      "$(printf "%s\n" "$banner" | wrapLines "$linePrefix$tweenNonLabel" "$lineSuffix" | head -n "$((nLines - 1))")" "$lineSuffix" \
      "$linePrefix$label$tweenLabel" "$(printf "%s\n" "$banner" | tail -n 1)" "$lineSuffix"
  else
    printf "%s%s%s\n""%s%s\n" \
      "$linePrefix$label$tweenLabel" "$(printf "%s\n" "$banner" | head -n 1)" "$lineSuffix" \
      "$(printf "%s\n" "$banner" | wrapLines "$linePrefix$tweenNonLabel" "$lineSuffix" | tail -n "$((nLines - 1))")" "$lineSuffix"
  fi
}
_labeledBigText() {
  # IDENTICAL usageDocument 1
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
repeat() {
  local usage="_${FUNCNAME[0]}"
  local argument
  local count
  local powers

  count=
  while [ $# -gt 0 ]; do
    argument="$1"
    case "$argument" in
      # IDENTICAL --help 4
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
              printf "%s" "${powers[$curPow]}"
              count=$((count - (2 ** curPow)))
            fi
            curPow=$((curPow + 1))
          done
          return 0
        fi
        ;;
    esac
    shift || __failArgument "$usage" "shift argument $argument" || return $?
  done
  __failArgument "$usage" "missing repeat string" || return $?
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
  local argument nArguments argumentIndex saved
  local barText="" width count delta=""

  width=$(consoleColumns) || __failEnvironment "$usage" consoleColumns || return $?
  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$1"
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        if [ $# -gt 2 ]; then
          __failArgument "$usage" "unknown argument #3: $3 (Arguments: $(_command "${saved[@]}"))" || return $?
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
    shift
  done
  [ -n "$barText" ] || barText="="
  [ -n "$delta" ] || delta=0

  count=$((width / ${#barText}))
  count=$((count + delta))
  [ $count -gt 0 ] || __failArgument "$usage" "count $count (delta $delta) less than zero?" || return $?
  printf "%s\n" "$(repeat "$count" "$barText")"
}
_echoBar() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Output a line and fill columns with a character
lineFill() {
  local usage="_${FUNCNAME[0]}"
  local text cleanText width barText

  width=$(__usageEnvironment "$usage" consoleColumns) || return $?
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
  # IDENTICAL usageDocument 1
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
# Example:     cat "$file" | wrapLines "$(decorate code)" "$(consoleReset)"
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
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --fill)
        shift || __failArgument "$usage" "missing $argument argument" || return $?
        [ 1 -eq "${#1}" ] || __failArgument "$usage" "Fill character must be single character" || return $?
        fill="$1"
        width="${width:-needed}"
        ;;
      --width)
        shift || __failArgument "$usage" "missing $argument argument" || return $?
        isUnsignedInteger "$1" && [ "$1" -gt 0 ] || __failArgument "$usage" "$argument requires positive integer" || return $?
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
    shift || __failArgument "$usage" shift || return $?
  done
  if ! isUnsignedInteger "$width"; then
    width=$(consoleColumns) || __failEnvironment "$usage" "consoleColumns" || return $?
  fi
  if [ -n "$width" ]; then
    strippedText="$(printf "%s" "$prefix$suffix" | stripAnsi)"
    actualWidth=$((width - ${#strippedText}))
    if [ "$actualWidth" -lt 0 ]; then
      __failArgument "$usage" "$width is too small to support prefix and suffix characters (${#strippedText})"
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
  local argument nArguments argumentIndex saved
  local bar spaces text=() textString emptyBar nLines shrink width

  nLines=1
  shrink=0
  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
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
