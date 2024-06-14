#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Shell Dependencies: awk sed date echo sort printf
#
# Docs: o ./docs/_templates/tools/decoration.md
# Test: o ./test/tools/decoration-tests.sh
# Depends: debug.sh whichApt apt.sh

# IDENTICAL errorArgument 1
errorArgument=2

#
# Usage: bigText [ --bigger ] Text to output
#
# smblock (regular)
#
# ▌  ▗   ▀▛▘     ▐
# ▛▀▖▄ ▞▀▌▌▞▀▖▚▗▘▜▀
# ▌ ▌▐ ▚▄▌▌▛▀ ▗▚ ▐ ▖
# ▀▀ ▀▘▗▄▘▘▝▀▘▘ ▘ ▀
#
# smmono12 (--bigger)
#
# ▗▖     █       ▗▄▄▄▖
# ▐▌     ▀       ▝▀█▀▘           ▐▌
# ▐▙█▙  ██   ▟█▟▌  █   ▟█▙ ▝█ █▘▐███
# ▐▛ ▜▌  █  ▐▛ ▜▌  █  ▐▙▄▟▌ ▐█▌  ▐▌
# ▐▌ ▐▌  █  ▐▌ ▐▌  █  ▐▛▀▀▘ ▗█▖  ▐▌
# ▐█▄█▘▗▄█▄▖▝█▄█▌  █  ▝█▄▄▌ ▟▀▙  ▐▙▄
# ▝▘▀▘ ▝▀▀▀▘ ▞▀▐▌  ▀   ▝▀▀ ▝▀ ▀▘  ▀▀
#         ▜█▛▘
#
bigText() {
  local font=smblock
  if ! whichApt toilet toilet; then
    consoleGreen "BIG TEXT: $*"
    return 0
  fi
  if [ "$1" = "--bigger" ]; then
    font=smmono12
    shift
  fi
  toilet -f $font "$@"
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
# Exaxmple:     > bin/build/tools.sh labeledBigText --top "Neat: " Done
# Exaxmple:     Neat: ▛▀▖
# Exaxmple:           ▌ ▌▞▀▖▛▀▖▞▀▖
# Exaxmple:           ▌ ▌▌ ▌▌ ▌▛▀
# Exaxmple:           ▀▀ ▝▀ ▘ ▘▝▀▘
# Exaxmple:     > bin/build/tools.sh labeledBigText --bottom "Neat: " Done
# Exaxmple:           ▛▀▖
# Exaxmple:           ▌ ▌▞▀▖▛▀▖▞▀▖
# Exaxmple:           ▌ ▌▌ ▌▌ ▌▛▀
# Exaxmple:     Neat: ▀▀ ▝▀ ▘ ▘▝▀▘
labeledBigText() {
  local label banner linePrefix lineSuffix tweenLabel tweenNonLabel nLines plainLabel isBottom

  label=
  isBottom=1
  linePrefix=
  lineSuffix=
  tweenLabel=
  tweenNonLabel=""
  while [ $# -gt 0 ]; do
    if [ -z "$1" ]; then
      _labeledBigText "$errorArgument" "blank argument" || return $?
    fi
    case "$1" in
      --help)
        "_${FUNCNAME[0]}" 0 && return $?
        ;;
      --top)
        isBottom=
        ;;
      --bottom)
        isBottom=1
        ;;
      --prefix)
        shift || :
        linePrefix="$1"
        ;;
      --suffix)
        shift || :
        lineSuffix="$1"
        ;;
      --tween)
        shift || :
        tweenLabel="$1"
        tweenNonLabel="$1"
        ;;
      *)
        if [ "$1" != "${1#-}" ]; then
          _labeledBigText "$errorArgument" "Unknown option $1" || return $?
        fi
        if [ -z "$label" ]; then
          label="$1"
          if ! plainLabel="$(printf "%s\n" "$label" | stripAnsi)"; then
            _labeledBigText "$errorArgument" "Unable to clean label" || return $?
          fi
        else
          break
        fi
        ;;
    esac
    shift
  done
  banner="$(bigText "$@")"
  nLines=$(printf "%s\n" "$banner" | wc -l)
  plainLabel="$(printf "%s\n" "$label" | stripAnsi)"
  tweenNonLabel="$(repeat "$((${#plainLabel}))" " ")$tweenNonLabel"
  if test $isBottom; then
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
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        if [ -z "$count" ]; then
          count="$(usageArgumentUnsignedInteger "$usage" "count" "$1")" || _argument "$(debugBacktrace)" || return $?
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
# Example:     consoleSuccess $(echoBar =-)
# Example:     consoleSuccess $(echoBar "- Success ")
# Example:     consoleMagenta $(echoBar +-)
echoBar() {
  local usage="_${FUNCNAME[0]}"
  local barText width count delta

  width=$(consoleColumns) || __failEnvironment "$usage" consoleColumns || return $?
  barText="${1:-=}"
  if [ -z "$barText" ]; then
    barText="="
  fi
  shift || :
  delta=$((${1:-0} + 0))
  isInteger "$delta" || __failArgument "$usage" "delta is not integer $(consoleCode "$delta")" || return $?
  count=$((width / "${#barText}"))
  count=$((count + delta))
  [ $count -gt 0 ] || __failArgument "$usage" "count $count (delta $delta) less than zero?" || return $?
  printf "%s\n" "$(repeat "$count" "$barText")"
}
_echoBar() {
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
# Example:     cat "$file" | wrapLines "$(consoleCode)" "$(consoleReset)"
# Example:     cat "$errors" | wrapLines "    ERROR: [" "]"
#
wrapLines() {
  local usage="_${FUNCNAME[0]}"
  local argument fill prefix suffix width actualWidth actualIxes cleanLine pad line

  prefix=$'\1'
  suffix=$'\1'
  fill=
  width=
  while [ $# -gt 0 ]; do
    argument="$1"
    case "$argument" in
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
    actualIxes="$(printf "%s" "$prefix$suffix" | stripAnsi)"
    actualWidth=$((width - ${#actualIxes}))
    if [ "$actualWidth" -lt 0 ]; then
      __failArgument "$usage" "$width is too small to support prefix and suffix characters"
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
  local arg bar spaces text=() textString emptyBar nLines shrink

  nLines=1
  shrink=0
  while [ $# -gt 0 ]; do
    arg="$1"
    if [ -z "$arg" ]; then
      _boxedHeading "$errorArgument" "blank argument" || return $?
    fi
    case "$arg" in
      --help)
        _boxedHeading 0
        return 0
        ;;
      --shrink)
        shift || _boxedHeading "$errorArgument" "Missing $arg" || return $?
        shrink=$(usageArgumentUnsignedInteger "_${FUNCNAME[0]}" "shrink" "$1") || return $?
        ;;
      --size)
        shift
        nLines="$1"
        if ! isUnsignedNumber "$nLines"; then
          _boxedHeading "$errorArgument" "--size requires an unsigned integer" || return $?
        fi
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

  spaces=$((${#bar} - ${#textString} - 4))
  consoleDecoration "$bar"
  runCount "$nLines" consoleDecoration "$emptyBar"
  printf "%s%s%s%s\n" "$(consoleDecoration -n "| ")" "$(consoleDecoration "$textString")" "$(consoleDecoration "$(repeat $spaces " ")")" "$(consoleDecoration -n " |")"
  runCount "$nLines" consoleDecoration "$emptyBar"
  consoleDecoration "$bar"
}
_boxedHeading() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
