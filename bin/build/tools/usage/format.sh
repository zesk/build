#!/usr/bin/env bash
#
# usage - Just the stuff to output console or markdown text
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

###############################################################################
#
# ▐▌ ▐▌▗▟██▖ ▟██▖ ▟█▟▌ ▟█▙
# ▐▌ ▐▌▐▙▄▖▘ ▘▄▟▌▐▛ ▜▌▐▙▄▟▌
# ▐▌ ▐▌ ▀▀█▖▗█▀▜▌▐▌ ▐▌▐▛▀▀▘
# ▐▙▄█▌▐▄▄▟▌▐▙▄█▌▝█▄█▌▝█▄▄▌
#  ▀▀▝▘ ▀▀▀  ▀▀▝▘ ▞▀▐▌ ▝▀▀
#              ▜█▛▘
#------------------------------------------------------------------------------
#

# Output usage messages to console
#
# Should look into an actual file template, probably
# See: usageDocument
#
# Do not call usage functions here to avoid recursion
# Usage: {fn} binName options delimiter description exitCode
# Argument: binaryName - String. Required. The function name
# Argument: argumentsText - String. Required. The argument definition.
# Argument: argumentsDelimiter - String. Required. The argument delimiter.
# Argument: description - String. Required. The function description
# Argument: exitCode - Integer. Required. The exit code of the function prior to showing usage
# Argument: ... - String. Any additional description - output directly.
# Requires: exitString __throwArgument trimSpace usageArgumentUnsignedInteger __throwArgument decorate printf
usageTemplate() {
  local usage="_${FUNCNAME[0]}" __saved=("$@")

  [ $# -ge 5 ] || __throwArgument "$usage" "Requires 5 or more arguments" || return $?

  local binName options="$2" delimiter="$3" description="$4" exitCode

  binName="$(trimSpace "$1")"
  exitCode=$(usageArgumentUnsignedInteger "$usage" "exitCode" "$5") || return $?
  shift 5 || __throwArgument "$usage" "shift 5" || return $?

  local usageString
  if [ "$exitCode" -eq 0 ]; then
    usageString="$(decorate bold-green Usage)"
  else
    usageString="$(decorate bold-red Usage)"
  fi
  if [ $# -gt 0 ] && [ -n "$*" ]; then
    if [ "$exitCode" -eq 0 ]; then
      printf "%s\n\n" "$(decorate success "$@")"
    elif [ "$exitCode" != 2 ]; then
      printf "%s %s\n" "$(decorate error "[$(exitString "$exitCode")]")" "$(decorate code "$@")"
      return "$exitCode"
    else
      printf "%s %s\n" "$(decorate warning "[$(exitString "$exitCode")]")" "$(decorate code "$@")"
    fi
  fi
  description=${description:-"No description"}
  nSpaces=$(printf %s "$options" | maximumFieldLength 1 "$delimiter")

  if [ -n "$delimiter" ] && [ -n "$options" ]; then
    printf -- "%s: %s%s\n\n%s\n\n%s\n" \
      "$usageString" \
      "$(decorate info "$binName")" \
      "$(printf "%s" "$options" | usageFormatArguments "$delimiter")" \
      "$(printf "%s" "$options" | usageGenerator "$((nSpaces + 2))" "$delimiter" | simpleMarkdownToConsole | trimTail | wrapLines "    " "$(decorate reset)")" \
      "$(simpleMarkdownToConsole <<<"$description")" |
      trimBoth
  else
    printf "%s: %s\n\n%s\n\n" \
      "$usageString" \
      "$(decorate info "$binName")" \
      "$description" |
      trimBoth
  fi
  if buildDebugEnabled usage; then
    debuggingStack
  fi
  return "$exitCode"
}
_usageTemplate() {
  # _IDENTICAL_ usageDocumentSimple 1
  usageDocumentSimple "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Parses input stream and generates an argument documentation list
# Input is in the format with "{argument}{delimiter}{description}{newline}" and generates a list of arguments (optionally decorated) color-coded based
# on whether the word "require" appears in the description.
#
# Usage: usageFormatArguments delimiter
# Argument: delimiter - Required. String. The character to separate name value pairs in the input
usageFormatArguments() {
  local handler="_${FUNCNAME[0]}"
  [ $# -le 3 ] || __throwArgument "$handler" "Requires 3 or fewer arguments" || return $?

  local separatorChar="${1-" "}" optionalDecoration="${2-blue}" requiredDecoration="${3-bold-magenta}"

  local lineTokens=() lastLine=false
  while true; do
    if ! IFS="$separatorChar" read -r -a lineTokens; then
      lastLine=true
    fi
    if [ ${#lineTokens[@]} -gt 0 ]; then
      local __value="${lineTokens[0]}"

      # printf "lineTokens-0: %s\n" "${lineTokens[@]}"
      unset "lineTokens[0]"
      # printf "lineTokens-1: %s\n" "${lineTokens[@]}"
      lineTokens=("${lineTokens[@]+${lineTokens[@]}}")
      local __description
      # printf "lineTokens-2: %s\n" "${lineTokens[@]}"
      __description=$(lowercase "${lineTokens[*]-}")
      # Looks for `Required.` in the description
      if [ "${__description%*required.*}" = "$__description" ]; then
        __value="[ $__value ]"
        [ -z "$optionalDecoration" ] || __value="$(decorate "$optionalDecoration" "$__value")"
      else
        [ -z "$requiredDecoration" ] || __value="$(decorate "$requiredDecoration" "$__value")"
      fi
      printf " %s" "$__value"
    fi
    if $lastLine; then
      break
    fi
  done
}

# Formats name value pairs separated by separatorChar (default " ") and uses
# $nSpaces width for first field
#
# usageGenerator nSpaces separatorChar labelPrefix valuePrefix < formatFile
#
# use with maximumFieldLength 1 to generate widths
#
# Argument: nSpaces - Required. Integer. Number of spaces to indent arguments.
# Argument: separatorChar - Optional. String. Default is space.
# Argument: labelPrefix - Optional. String. Defaults to blue color text.
# Argument: valuePrefix - Optional. String. Defaults to red color text.
usageGenerator() {
  local nSpaces=$((${1-30} + 0)) separatorChar=${2-" "} labelPrefix valuePrefix labelOptionalPrefix labelRequiredPrefix capsLine lastLine

  labelOptionalPrefix=${3-"$(decorate blue)"}
  labelRequiredPrefix=${4-"$(decorate red)"}
  # shellcheck disable=SC2119
  valuePrefix=${5-"$(decorate value)"}
  lastLine=
  blankLine=false

  while true; do
    if ! IFS= read -r line; then
      lastLine=1
    fi
    if [ -z "$(trimSpace "$line")" ]; then
      blankLine=true
    else
      capsLine="$(lowercase "$line")"
      if [ "${capsLine##*required}" != "$capsLine" ]; then
        labelPrefix=$labelRequiredPrefix
      else
        labelPrefix=$labelOptionalPrefix
      fi
      if $blankLine; then
        printf "\n"
        blankLine=false
      fi
      printf "%s\n" "$line" | awk "-F$separatorChar" "{ print \"$labelPrefix\" sprintf(\"%-\" $nSpaces \"s\", \$1) \"$valuePrefix\" substr(\$0, index(\$0, \"$separatorChar\") + 1) }"
    fi
    if test $lastLine; then
      break
    fi
  done
}
