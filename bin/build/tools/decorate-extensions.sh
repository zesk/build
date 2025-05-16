#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Argument: style - Required. String. The style to fetch or replace.
# Argument: newFormat - Optional. String. The new style formatting options as a string:
#   `lp dp label` where
decorateStyle() {
  local usage="_${FUNCNAME[0]}"
  local style="" newFormat="" oldFormat

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
      if [ -z "$style" ]; then
        style=$(usageArgumentString "$usage" "style" "$1") || return $?
      else
        export __BUILD_COLORS
        newFormat=$(usageArgumentString "$usage" "newFormat" "$1") || return $?
        if oldFormat=$(_decorateStyle "$style"); then
          __BUILD_COLORS="$(_decorateStyleReplace "$__BUILD_COLORS" "$style" "$newFormat")"
        else
          __BUILD_COLORS="$__BUILD_COLORS$style=$newFormat"$'\n'
        fi
      fi
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  if [ -n "$style" ]; then
    if ! oldFormat=$(_decorateStyle "$style"); then
      return 1
    fi
    printf "%s\n" "$oldFormat"
  fi
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
  echo "$result"
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
# Exit Code: 0 - stdout contains input wrapped with text
# Exit Code: 1 - Environment error
# Exit Code: 2 - Argument error
# Argument: prefix - String. Required. Prefix each line with this text
# Argument: suffix - String. Required. Prefix each line with this text
# Example:     cat "$file" | decorate wrap "CODE> " " <EOL>"
# Example:     cat "$errors" | decorate wrap "    ERROR: [" "]"
#
__decorateExtensionWrap() {
  local usage="_${FUNCNAME[0]}"
  local argument fill prefix=$'\1' suffix width

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
        shift
        suffix="${*-}"
        [ $# -gt 0 ] || break
      fi
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  if [ "$prefix" = $'\1' ]; then
    __catchEnvironment "$usage" cat || return $?
    return 0
  fi
  if ! isUnsignedInteger "$width"; then
    width=$(consoleColumns) || __throwEnvironment "$usage" "consoleColumns" || return $?
  fi

  local actualWidth
  if [ -n "$width" ]; then
    local strippedText
    strippedText="$(printf "%s" "$prefix$suffix" | stripAnsi)"
    actualWidth=$((width - ${#strippedText}))
    if [ "$actualWidth" -lt 0 ]; then
      __throwArgument "$usage" "$width is too small to support prefix and suffix characters (${#prefix} + ${#suffix}):"$'\n'"prefix=$prefix"$'\n'"suffix=$suffix" || return $?
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
  # _IDENTICAL_ usageDocument 1
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
      printf "%s\n" "[SIZE $size]\n"
    fi
    shift
  done
}
