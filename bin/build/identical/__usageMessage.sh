#!/usr/bin/env bash
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
# Local: icon
__usageMessageIcon() {
  [ "$1" -eq 0 ] && icon="🏆" || icon="❌"
}

# Summary: Style usage messages
# Format arguments using the usage message return code to style output.
# Argument: returnCode - UnsignedInteger. Required. Return code to use as the basis for styling output.
# - `0` - meaning no error, style is `info`
# - `1` - Environment error, style is `error`
# - `2` - Argument error, style is `red`
# - `*` - All additional errors, style is `orange`
# Local: style
__usageMessageStyle() {
  style="info" && case "$1" in 0) ;; 1) style="error" ;; 2) style="red" ;; *) style="orange" ;; esac && shift
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
    [ -z "$suffix" ] || suffix=" $(decorate warning "$suffix")"
    local icon && __usageMessageIcon "$returnCode"
    local style && __usageMessageStyle "$returnCode"
    printf "%s %s%s\n" "$icon" "$(decorate "$style" "[$(returnCodeString "$returnCode")]")" "$suffix"
  else
    [ -z "$suffix" ] || suffix=" $(decorate error "$suffix")"
    local icon && __usageMessageIcon "$returnCode"
    local style && __usageMessageStyle "$returnCode"
    printf "%s %s%s\n" "$icon" "$(decorate "$style" "[$(returnCodeString "$returnCode")]")" "$suffix"
  fi
}
