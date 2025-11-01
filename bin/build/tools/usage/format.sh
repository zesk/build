#!/usr/bin/env bash
#
# handler - Just the stuff to output console or markdown text
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

# Output handler messages to console
#
# Should look into an actual file template, probably
# See: usageDocument
#
# Do not call handler functions here to avoid recursion
# handler: {fn} binName options delimiter description exitCode
# Argument: binaryName - String. Required. The function name
# Argument: argumentsText - String. Required. The argument definition.
# Argument: argumentsDelimiter - String. Required. The argument delimiter.
# Argument: description - String. Required. The function description
# Argument: exitCode - Integer. Required. The exit code of the function prior to showing handler
# Argument: ... - String. Any additional description - output directly.
# Requires: returnCodeString throwArgument trimSpace usageArgumentUnsignedInteger throwArgument decorate printf
# BUILD_DEBUG: handler - For all `--help` and any function which uses `usageTemplate` to output documentation (upon error), the stack will be displayed
__usageTemplate() {
  local handler="_${FUNCNAME[0]}" __saved=("$@")

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  [ $# -ge 5 ] || throwArgument "$handler" "Requires 5 or more arguments" || return $?

  local binName options="$2" delimiter="$3" description="$4" exitCode

  binName="$(trimSpace "$1")"
  exitCode=$(usageArgumentUnsignedInteger "$handler" "exitCode" "$5") || return $?
  shift 5 || throwArgument "$handler" "shift 5" || return $?

  if ! muzzle decorateStyle bold-green; then
    export __BUILD_COLORS
    dumpPipe __BUILD_COLORS <<<"${__BUILD_COLORS-}"
    debuggingStack
    __decorateStylesDefault
  fi

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
      printf "%s %s\n" "$(decorate error "[$(returnCodeString "$exitCode")]")" "$(decorate code "$@")"
      return "$exitCode"
    else
      printf "%s %s\n" "$(decorate warning "[$(returnCodeString "$exitCode")]")" "$(decorate code "$@")"
    fi
  fi
  description=${description:-"No description"}
  nSpaces=$(printf %s "$options" | maximumFieldLength 1 "$delimiter")

  if [ -n "$delimiter" ] && [ -n "$options" ] && [ "$options" != "none" ]; then
    printf -- "%s: %s%s\n\n%s\n\n%s\n" \
      "$usageString" \
      "$(decorate info "$binName")" \
      "$(printf "%s" "$options" | __documentationFormatArguments "$delimiter")" \
      "$(printf "%s" "$options" | __usageGenerator "$((nSpaces + 2))" "$delimiter" | simpleMarkdownToConsole | trimTail | decorate wrap "    " "$(decorate reset --)")" \
      "$(simpleMarkdownToConsole <<<"$description")" |
      trimBoth
  else
    printf "%s: %s\n\n%s\n\n" \
      "$usageString" \
      "$(decorate info "$binName")" \
      "$(simpleMarkdownToConsole <<<"$description")" |
      trimBoth
  fi
  if buildDebugEnabled handler; then
    debuggingStack
  fi
  return "$exitCode"
}
___usageTemplate() {
  # __IDENTICAL__ usageDocumentSimple 1
  usageDocumentSimple "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Formats name value pairs separated by separatorChar (default " ") and uses
# $nSpaces width for first field
#
# Example:     {fn} nSpaces separatorChar labelPrefix valuePrefix < formatFile
#
# use with maximumFieldLength 1 to generate widths
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: nSpaces - Required. Integer. Number of spaces to indent arguments.
# Argument: separatorChar - Optional. String. Default is space.
# Argument: labelPrefix - Optional. String. Defaults to blue color text.
# Argument: valuePrefix - Optional. String. Defaults to red color text.
__usageGenerator() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local nSpaces=$((${1-30} + 0)) separatorChar=${2-" "} labelPrefix valuePrefix labelOptionalPrefix labelRequiredPrefix capsLine lastLine

  labelOptionalPrefix=${3-"$(decorate blue --)"}
  labelRequiredPrefix=${4-"$(decorate red --)"}
  # shellcheck disable=SC2119
  valuePrefix=${5-"$(decorate value --)"}
  lastLine=
  blankLine=false

  while true; do
    if ! IFS= read -r line; then
      lastLine=1
    fi
    if [ -z "$(trimSpace "$line")" ]; then
      blankLine=true
    else
      capsLine="$(lowercase -- "$line")"
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
___usageGenerator() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
