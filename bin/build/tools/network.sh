#!/usr/bin/env bash
#
# Web protocol tools
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__networkConfigurationFiltered() {
  local patternNotGNU patternGNU usage="$1" && shift

  patternNotGNU=$(usageArgumentString "$usage" "patternNotGNU" "${1-}") && shift || return $?
  patternGNU=$(usageArgumentString "$usage" "patternGNU" "${1-}") && shift || return $?

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
    --install)
      __catchEnvironment "$usage" packageWhich ifconfig net-tools || return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  export OSTYPE

  __catchEnvironment "$usage" buildEnvironmentLoad OSTYPE || return $?

  whichExists ifconfig || __throwEnvironment "$usage" "Need ifconfig (net-tools) installed. not available in PATH: $PATH" || return $?

  case "$(lowercase "$OSTYPE")" in
  linux) ifconfig | grep "$patternNotGNU" | cut -f 2 -d : | trimSpace | cut -f 1 -d ' ' ;;
  linux-gnu | darwin* | freebsd*) ifconfig | grep "$patternGNU " | trimSpace | cut -f 2 -d ' ' ;;
  *) __throwEnvironment "$usage" "networkIPList Unsupported OSTYPE \"$OSTYPE\"" || return $? ;;
  esac
}

# List IPv4 Addresses associated with this system using `ifconfig`
# Output: lines:IPv4
# Argument: --install - Flag. Optional. Install any packages required to get `ifconfig` installed first.
# Argument: --help - Flag. Optional. This help.
networkIPList() {
  local usage="_${FUNCNAME[0]}"

  __networkConfigurationFiltered "$usage" 'inet addr:' 'inet' "$@" || return $?
}
_networkIPList() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List MAC addresses associated with this system using `ifconfig`
# Output: lines:IPv4
# Argument: --install - Flag. Optional. Install any packages required to get `ifconfig` installed first.
# Argument: --help - Flag. Optional. This help.
networkMACAddressList() {
  local usage="_${FUNCNAME[0]}"

  __networkConfigurationFiltered "$usage" 'ether:' 'ether' "$@" || return $?
}
_networkMACAddressList() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
