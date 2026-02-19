#!/bin/bash
#
# Identical template
#
# Original of __usageMessage
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL __usageMessage EOF

# Summary: Icon for usage messages
# - `0` - meaning no error, icon is `🏆`
# - non-`0` - Error, icon is `❌`
__usageMessageIcon() {
  [ "$1" -eq 0 ] && printf -- "%s" "🏆" || printf -- "%s" "❌"
}

# Summary: Style usage messages
# Format arguments using the usage message return code to style output.
# Argument: returnCode - UnsignedInteger. Required. Return code to use as the basis for styling output.
# - `0` - meaning no error, style is `info`
# - `1` - Environment error, style is `error`
# - `2` - Argument error, style is `red`
# - `*` - All additional errors, style is `orange`
__usageMessageStyle() {
  local color="info" && case "$1" in 0) ;; 1) color="error" ;; 2) color="red" ;; *) color="orange" ;; esac && shift
  decorate "$color" "$@"
}

# Output the message for usage consistently
# Argument: returnCode - UnsignedInteger. Optional. Exit code to possibly display with message.
# Argument: message ... - String. Optional. Display this message which describes why `exitCode` occurred.
# Requires: decorate returnCodeString
__usageMessage() {
  local returnCode="${1-0}"
  [ $# -eq 0 ] || shift
  local suffix="$*"
  if [ "$returnCode" -eq 0 ]; then
    [ -n "$suffix" ] || return 0
    __usageMessageStyle "$returnCode" "$suffix"
  elif [ "$returnCode" != 2 ]; then
    [ -z "$suffix" ] || suffix=" $(decorate code "$suffix")"
    printf "%s %s%s\n" "$(__usageMessageIcon "$returnCode")" "$(__usageMessageStyle "$returnCode" "[$(returnCodeString "$returnCode")]")" "$suffix"
  else
    [ -z "$suffix" ] || suffix=" $(decorate code "$suffix")"
    printf "%s %s%s\n" "$(__usageMessageIcon "$returnCode")" "$(__usageMessageStyle "$returnCode" "[$(returnCodeString "$returnCode")]")" "$suffix"
  fi
}
