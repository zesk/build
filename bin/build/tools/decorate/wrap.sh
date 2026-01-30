#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# fn: decorate wrap
# Wrap lines with a string, useful to format output or add color codes to
# consoles which do not honor colors line-by-line. Intended to be used as a pipe.
#
# Summary: Prefix output lines with a string
# Return Code: 0 - stdout contains input wrapped with text
# Return Code: 1 - Environment error
# Return Code: 2 - Argument error
# Argument: prefix - EmptyString. Required. Prefix each line with this text
# Argument: suffix - String. Optional. Prefix each line with this text
# Argument: --fill fillCharacter - Character. Optional. Fill entire line with this character.
# Example:     cat "$file" | decorate wrap "CODE> " " <EOL>"
# Example:     cat "$errors" | decorate wrap "    ERROR: [" "]"
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
      shift || throwArgument "$handler" "missing $argument argument" || return $?
      [ 1 -eq "${#1}" ] || throwArgument "$handler" "Fill character must be single character" || return $?
      fill="$1"
      width="${width:-needed}"
      ;;
    --width)
      shift || throwArgument "$handler" "missing $argument argument" || return $?
      isUnsignedInteger "$1" && [ "$1" -gt 0 ] || throwArgument "$handler" "$argument requires positive integer" || return $?
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
    width=$(consoleColumns) || throwEnvironment "$handler" "consoleColumns" || return $?
  fi

  local actualWidth
  if [ -n "$width" ]; then
    local strippedText
    strippedText="$(printf "%s" "$prefix$suffix" | consoleToPlain)"
    actualWidth=$((width - ${#strippedText}))
    if [ "$actualWidth" -lt 0 ]; then
      throwArgument "$handler" "$width is too small to support prefix and suffix characters (${#prefix} + ${#suffix}):"$'\n'"prefix=$prefix"$'\n'"suffix=$suffix" || return $?
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
      cleanLine="$(printf "%s" "$line" | consoleToPlain)"
      padWidth=$((actualWidth - ${#cleanLine}))
      if [ $padWidth -gt 0 ]; then
        pad=$(textRepeat "$padWidth" "$fill")
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
