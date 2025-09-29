#!/usr/bin/env bash
#
# Web protocol tools
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__networkConfigurationFiltered() {
  local patternNotGNU patternGNU handler="$1" && shift

  patternNotGNU=$(usageArgumentString "$handler" "patternNotGNU" "${1-}") && shift || return $?
  patternGNU=$(usageArgumentString "$handler" "patternGNU" "${1-}") && shift || return $?

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --install)
      __catch "$handler" packageWhich ifconfig net-tools || return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  whichExists ifconfig || __throwEnvironment "$handler" "Need ifconfig (net-tools) installed. not available in PATH: $PATH" || return $?

  case "$(lowercase "${OSTYPE-}")" in
  linux) ifconfig | grep "$patternNotGNU" | cut -f 2 -d : | trimSpace | cut -f 1 -d ' ' ;;
  linux-gnu | darwin* | freebsd*) ifconfig | grep "$patternGNU " | trimSpace | cut -f 2 -d ' ' ;;
  *) __throwEnvironment "$handler" "networkIPList Unsupported OSTYPE \"${OSTYPE-}\"" || return $? ;;
  esac
}

# List IPv4 Addresses associated with this system using `ifconfig`
# Output: lines:IPv4
# Argument: --install - Flag. Optional. Install any packages required to get `ifconfig` installed first.
# Argument: --help - Flag. Optional. This help.
networkIPList() {
  local handler="_${FUNCNAME[0]}"

  __networkConfigurationFiltered "$handler" 'inet addr:' 'inet' "$@" || return $?
}
_networkIPList() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List MAC addresses associated with this system using `ifconfig`
# Output: lines:IPv4
# Argument: --install - Flag. Optional. Install any packages required to get `ifconfig` installed first.
# Argument: --help - Flag. Optional. This help.
networkMACAddressList() {
  local handler="_${FUNCNAME[0]}"

  __networkConfigurationFiltered "$handler" 'ether:' 'ether' "$@" || return $?
}
_networkMACAddressList() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
