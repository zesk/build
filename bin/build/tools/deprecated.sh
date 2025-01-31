#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Graveyard for code
#
# You should stop using these. Soon. Now. Yesterday.
#
# This file *should* be ignored by the other deprecated.sh
#

#
#   ____                                _           _
#  |  _ \  ___ _ __  _ __ ___  ___ __ _| |_ ___  __| |
#  | | | |/ _ \ '_ \| '__/ _ \/ __/ _` | __/ _ \/ _` |
#  | |_| |  __/ |_) | | |  __/ (_| (_| | ||  __/ (_| |
#  |____/ \___| .__/|_|  \___|\___\__,_|\__\___|\__,_|
#             |_|
#

# DEPRECATED 2024-11-29
_integer() {
  _deprecated "${FUNCNAME[0]}"
  isUnsignedInteger "$@"
}

# Not keeping this around will break old scripts, so don't be a ...
# Deprecated: 2025-01-15
runHook() {
  _deprecated "${FUNCNAME[0]}"
  hookRun "$@"
}

# Deprecated: 2025-01-15
runHookOptional() {
  _deprecated "${FUNCNAME[0]}"
  hookRunOptional "$@"
}

# Deprecated: 2025-01-25
__failArgument() {
  _deprecated "${FUNCNAME[0]}"
  __throwArgument "$@" || return $?
}

# Deprecated: 2025-01-25
__failEnvironment() {
  _deprecated "${FUNCNAME[0]}"
  __throwEnvironment "$@" || return $?
}

# Deprecated: 2025-01-25
__usageEnvironment() {
  _deprecated "${FUNCNAME[0]}"
  __catchEnvironment "$@" || return $?
}

# Deprecated: 2025-01-25
__usageArgument() {
  _deprecated "${FUNCNAME[0]}"
  __catchArgument "$@" || return $?
}

# Deprecated: 2025-01-30
# Deprecated: v0.22.0
# Summary: Output a name value pair
#
# Utility function which is similar to `usageGenerator` except it operates on a line at a time. The name is output
# right-aligned to the `characterWidth` given and colored using `decorate label`; the value colored using `decorate value`.
#
# Usage: decorate pair characterWidth name [ value ... ]
# Argument: characterWidth - Required. Number of characters to format the value for spacing
# Argument: name - Required. Name to output
# Argument: value ... - Optional. One or more Value to output
#
# Use: decorate pair
# shellcheck disable=SC2120
consoleNameValue() {
  _deprecated "${FUNCNAME[0]}"
  local characterWidth=$1 name=$2
  shift 2 && printf "%s %s\n" "$(decorate label "$(alignLeft "$characterWidth" "$name")")" "$(decorate value "$@")"
}

# Deprecated: v0.22.0
# Deprecated: 2025-01-30
# Usage: {fn} [ separator [ prefix [ suffix [ title [ item ... ] ] ] ]
# Formats a titled list as {title}{separator}{prefix}{item}{suffix}{prefix}{item}{suffix}...
# Argument: separator - Optional. String.
# Argument: prefix - Optional. String.
# Argument: suffix - Optional. String.
# Argument: title - Optional. String.
# Argument: item - Optional. String. One or more items to list.
# Requires: printf
_format() {
  _deprecated "${FUNCNAME[0]}"
  local sep="${1-}" prefix="${2-}" suffix="${3-}" title="${4-"§"}" n=/dev/null
  sep="${sep//%/%%}" && prefix="${prefix//%/%%}" && suffix="${suffix//%/%%}"
  # shellcheck disable=SC2015
  shift 2>"$n" && shift 2>"$n" && shift 2>"$n" && shift 2>"$n" || :
  if [ $# -eq 0 ]; then
    printf -- "%s\n" "$title"
  else
    printf -- "%s$sep%s\n" "$title" "$(printf -- "$prefix%s$suffix" "$@")"
  fi
}

# Deprecated: 2025-01-30
# Deprecated: v0.22.0
# Output a titled list
# Usage: {fn} title [ items ... ]
# Requires: _format
_list() {
  _deprecated "${FUNCNAME[0]}"
  _format "\n" "- " "\n" "$@"
}

# Deprecated: 2025-01-30
# Deprecated: v0.22.0
# Output a command, quoting individual arguments
# Usage: {fn} command [ argument ... ]
# Requires: _format
_command() {
  _deprecated "${FUNCNAME[0]}"
  _format "" " \"" "\"" "$@"
}
