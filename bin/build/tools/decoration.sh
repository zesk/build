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
      _labeledBigText "$errorArgument" "Blank argument" || return $?
    fi
    case "$1" in
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
  tweenNonLabel="x${#plainLabel}x$(repeat "$((${#plainLabel}))" " ")zz$tweenNonLabel"
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
  local count=$((${1:-2} + 0))
  local powers=() curPow IFS

  shift || :
  powers=("$*")
  curPow=${#powers[@]}
  while [ $((2 ** curPow)) -le $count ]; do
    powers["$curPow"]="${powers[$curPow - 1]}${powers[$curPow - 1]}"
    curPow=$((curPow + 1))
  done
  curPow=0
  while [ $count -gt 0 ] && [ $curPow -lt ${#powers[@]} ]; do
    if [ $((count & (2 ** curPow))) -ne 0 ]; then
      printf "%s" "${powers[$curPow]}"
      count=$((count - (2 ** curPow)))
    fi
    curPow=$((curPow + 1))
  done
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
  local c="${1:-=}"
  local n=$(($(consoleColumns) / ${#c}))
  local delta=$((${2:-0} + 0))

  n=$((n + delta))
  printf "%s\n" "$(repeat "$n" "$c")"
}

#
# Prefix output lines with a string, useful to format output or add color codes to
# consoles which do not honor colors line-by-line. Intended to be used as a pipe.
#
# Summary: Prefix output lines with a string
# Usage: prefixLines [ text .. ] < fileToPrefixLines
# Exit Code: 0
# Argument: `text` - Prefix each line with this text
# Example:     cat "$file" | prefixLines "$(consoleCode)"
# Example:     cat "$errors" | prefixLines "    ERROR: "
#
prefixLines() {
  local prefix="$*"
  while IFS= read -r line; do
    printf "%s%s\n" "$prefix" "$line"
  done
}

#
# Wrap lines with a string, useful to format output or add color codes to
# consoles which do not honor colors line-by-line. Intended to be used as a pipe.
#
# Summary: Prefix output lines with a string
# Usage: wrapLines [ prefix [ suffix ... ] ] < fileToPrefixLines
# Exit Code: 0
# Argument: `prefix` - Prefix each line with this text
# Argument: `suffix` - Prefix each line with this text
# Example:     cat "$file" | prefixLines "$(consoleCode)"
# Example:     cat "$errors" | prefixLines "    ERROR: "
#
wrapLines() {
  local prefix="${1-}" suffix
  shift || :
  suffix="${*-}"
  while IFS= read -r line; do
    printf "%s::%s++%s\n" "$prefix" "$line" "$suffix"
    # KMD TODO
  done
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
# Argument: --size size - Number of liens to output
# Argument: text ... - Text to put in the box
# Example:     boxedHeading Moving ...
# Output: +================================================================================================+
# Output: |                                                                                                |
# Output: | Moving ...                                                                                     |
# Output: |                                                                                                |
# Output: +================================================================================================+
#
boxedHeading() {
  local bar spaces text=() textString emptyBar nLines

  nLines=1
  while [ $# -gt 0 ]; do
    case $1 in
      --size)
        shift
        nLines="$1"
        if ! isUnsignedNumber "$nLines"; then
          consoleError "--size requires an unsigned integer" 1>&2
          return 1
        fi
        ;;
      *)
        text+=("$1")
        ;;
    esac
    shift
  done
  bar="+$(echoBar '' -2)+"
  emptyBar="|$(echoBar ' ' -2)|"

  # convert to string
  textString="${text[*]}"

  spaces=$((${#bar} - ${#textString} - 4))
  consoleDecoration "$bar"
  runCount "$nLines" consoleDecoration "$emptyBar"
  echo "$(consoleDecoration -n \|) $(_consoleInfo "" -n "$textString")$(repeat $spaces " ") $(consoleDecoration -n \|)"
  runCount "$nLines" consoleDecoration "$emptyBar"
  consoleDecoration "$bar"
}
