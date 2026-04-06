#!/usr/bin/env bash
#
# Web protocol tools
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__networkConfigurationFiltered() {
  local patternNotGNU patternGNU handler="$1" && shift

  patternNotGNU=$(validate "$handler" String "patternNotGNU" "${1-}") && shift || return $?
  patternGNU=$(validate "$handler" String "patternGNU" "${1-}") && shift || return $?

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --install)
      catchReturn "$handler" packageWhich ifconfig net-tools || return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  executableExists ifconfig || throwEnvironment "$handler" "Need ifconfig (net-tools) installed. not available in PATH: $PATH" || return $?

  case "$(stringLowercase "${OSTYPE-}")" in
  linux) ifconfig | grep "$patternNotGNU" | cut -f 2 -d : | textTrim | cut -f 1 -d ' ' ;;
  linux-gnu | darwin* | freebsd*) ifconfig | grep "$patternGNU " | textTrim | cut -f 2 -d ' ' ;;
  *) throwEnvironment "$handler" "networkIPList Unsupported OSTYPE \"${OSTYPE-}\"" || return $? ;;
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
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Get the current IP address of a host
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Environment: IP_URL
# Environment: IP_URL_FILTER
# shellcheck disable=SC2120
networkIPLookup() {
  local handler="_${FUNCNAME[0]}"

  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"

  local url jqFilter
  url=$(catchReturn "$handler" buildEnvironmentGet IP_URL) || return $?
  [ -n "$url" ] || throwEnvironment "$handler" "$(decorate value "IP_URL") is required for $(decorate code "${handler#_}")" || return $?
  urlValid "$url" || throwEnvironment "$handler" "URL $(decorate error "$url") is not a valid URL" || return $?

  local jqFilter
  jqFilter=$(catchReturn "$handler" buildEnvironmentGet IP_URL_FILTER) || return $?
  local pp=(cat)
  [ -z "$jqFilter" ] || pp=(jq -r "$jqFilter")
  catchReturn "$handler" urlFetch "$url" - | catchEnvironment "$handler" "${pp[@]}" || return $?
}
_networkIPLookup() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
