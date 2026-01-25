#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# fn: decorate diff
# Removes most diff character decoration and replaces with colors
#
# Argument: leftStyle - String. Required. Style for left file lines
# Argument: rightStyle - String. Required. Style for right file lines
__decorateExtensionDiff() {
  local handler="returnMessage"

  local leftStyle && leftStyle=$(validate "$handler" String "leftStyle" "${1-}") && shift || return $?
  local rightStyle && rightStyle=$(validate "$handler" String "leftStyle" "${1-}") && shift || return $?

  local finished=false
  while ! $finished; do
    local line && IFS="" read -r -d $'\n' line || finished=true
    [ -n "$line" ] || continue
    case "${line:0:3}" in
    "---") decorate "$leftStyle" "${line#--- }" ;;
    "-"*) decorate "$leftStyle" "${line:1}" ;;
    '+++') decorate "$rightStyle" "${line#+++ }" ;;
    "+"*) decorate "$rightStyle" "${line:1}" ;;
    "@"*) line="${line% @@*}" && decorate "subtle" "${line#@@* }" ;;
    " "*) printf "%s\n" "${line:1}" ;;
    *) printf "%s\n" "$line" ;;
    esac
  done
}
