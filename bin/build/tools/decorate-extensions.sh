#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Fetch
# Argument: style - Required. String. The style to fetch or replace.
# Argument: newFormat - Optional. String. The new style formatting options as a string in the form `lp dp label`
decorateStyle() {
  local handler="_${FUNCNAME[0]}"
  local style="" newFormat="" oldFormat

  _decorateInitialize || return $?
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || returnThrowArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      if [ -z "$style" ]; then
        style=$(usageArgumentString "$handler" "style" "$1") || return $?
      else
        export __BUILD_COLORS
        newFormat=$(usageArgumentString "$handler" "newFormat" "$1") || return $?
        if oldFormat=$(__decorateStyle "$style"); then
          __BUILD_COLORS="$(_decorateStyleReplace "$__BUILD_COLORS" "$style" "$newFormat")"
        else
          __BUILD_COLORS="$__BUILD_COLORS$style=$newFormat"$'\n'
        fi
      fi
      ;;
    esac
    shift
  done
  if [ -n "$style" ]; then
    if ! oldFormat=$(__decorateStyle "$style"); then
      return 1
    fi
    printf "%s\n" "$oldFormat"
  fi
}
_decorateStyle() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: styleList - String. Required. Structure to modify.
# Argument: style - String. Required. Style to modify.
# Argument: newFormat - String. Required. New format for the style
_decorateStyleReplace() {
  local colors="$1" style="$2" newFormat="$3" result
  local pattern=$'\n'"$style="
  # Suffix first
  result="${colors#*"$pattern"}"
  result="${colors%%"$pattern"*}$pattern$newFormat"$'\n'"${result#*$'\n'}"
  printf "%s\n" "$result"
}

# fn: decorate pair
# Summary: Output a name value pair (decorate extension)
#
# The name is output left-aligned to the `characterWidth` given and colored using `decorate label`; the value colored using `decorate value`.
#
# Usage: decorate pair [ characterWidth ] name [ value ... ]
# Argument: characterWidth - Optional. Number of characters to format the value for spacing. Uses environment variable BUILD_PAIR_WIDTH if not set.
# Argument: name - Required. Name to output
# Argument: value ... - Optional. One or more Values to output as values for `name` (single line)
# Environment: BUILD_PAIR_WIDTH
# shellcheck disable=SC2120
__decorateExtensionPair() {
  local width="" name
  if isUnsignedInteger "${1-}"; then
    width="$1" && shift
  fi
  if [ -z "$width" ]; then
    width=$(buildEnvironmentGet BUILD_PAIR_WIDTH) || width=40
  fi
  name="${1-}"
  shift 2>/dev/null || :
  if [ -z "$name" ]; then
    return 0
  fi
  printf "%s %s%s\n" "$(decorate label "$(alignLeft "$width" "$name")")" "$(decorate each value "$@")" "$(decorate reset --)"
}

# fn: decorate wrap
# Wrap lines with a string, useful to format output or add color codes to
# consoles which do not honor colors line-by-line. Intended to be used as a pipe.
#
# Summary: Prefix output lines with a string
# Usage: decorate wrap [ --fill ] [ prefix [ suffix ... ] ] < fileToWrapLines
# Return Code: 0 - stdout contains input wrapped with text
# Return Code: 1 - Environment error
# Return Code: 2 - Argument error
# Argument: prefix - String. Required. Prefix each line with this text
# Argument: suffix - String. Required. Prefix each line with this text
# Example:     cat "$file" | decorate wrap "CODE> " " <EOL>"
# Example:     cat "$errors" | decorate wrap "    ERROR: [" "]"
#
__decorateExtensionWrap() {
  local handler="_${FUNCNAME[0]}"
  local prefix=$'\1' suffix

  local fill="" width=""
  # _IDENTICAL_ argumentBlankLoopHandler 4
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --fill)
      shift || returnThrowArgument "$handler" "missing $argument argument" || return $?
      [ 1 -eq "${#1}" ] || returnThrowArgument "$handler" "Fill character must be single character" || return $?
      fill="$1"
      width="${width:-needed}"
      ;;
    --width)
      shift || returnThrowArgument "$handler" "missing $argument argument" || return $?
      isUnsignedInteger "$1" && [ "$1" -gt 0 ] || returnThrowArgument "$handler" "$argument requires positive integer" || return $?
      width="$1"
      ;;
    *)
      if [ "$prefix" = $'\1' ]; then
        prefix="$1"
        shift
        suffix="${*-}"
        [ $# -gt 0 ] || break
      fi
      ;;
    esac
    shift
  done

  if [ "$prefix" = $'\1' ]; then
    catchEnvironment "$handler" cat || return $?
    return 0
  fi
  if ! isUnsignedInteger "$width"; then
    width=$(consoleColumns) || returnThrowEnvironment "$handler" "consoleColumns" || return $?
  fi

  local actualWidth
  if [ -n "$width" ]; then
    local strippedText
    strippedText="$(printf "%s" "$prefix$suffix" | stripAnsi)"
    actualWidth=$((width - ${#strippedText}))
    if [ "$actualWidth" -lt 0 ]; then
      returnThrowArgument "$handler" "$width is too small to support prefix and suffix characters (${#prefix} + ${#suffix}):"$'\n'"prefix=$prefix"$'\n'"suffix=$suffix" || return $?
    fi
    if [ "$actualWidth" -eq 0 ]; then
      # If we are doing nothing then do not do nothing
      fill=
    fi
  fi
  local pad="" line
  while IFS= read -r line; do
    if [ -n "$fill" ]; then
      local cleanLine
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
___decorateExtensionWrap() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# fn: decorate size
# Argument: size - UnsignedInteger. Optional. Size to display.
# Mostly $ and " are problematic within a string
# Requires: printf decorate isUnsignedInteger
__decorateExtensionSize() {
  while [ $# -gt 0 ]; do
    local size="$1"

    # Skip any `--`
    [ "$size" != "--" ] || continue

    if isUnsignedInteger "$size"; then
      if [ "$size" -lt 4096 ]; then
        printf "%db\n" "$size"
      elif [ "$size" -lt 4194304 ]; then
        printf "%dk (%d)\n" "$((size / 1024))" "$size"
      elif [ "$size" -lt 4294967296 ]; then
        printf "%dM (%d)\n" "$((size / 1048576))" "$size"
      else
        printf "%dG (%d)\n" "$((size / 1073741824))" "$size"
      fi
    else
      printf "%s\n" "[SIZE $size]"
    fi
    shift
  done
}
