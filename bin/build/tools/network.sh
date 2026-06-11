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

# An IP address (IPv4 or IPv6)
__validateTypeIP() {
  networkIPValid "${1-}" || return $?
  printf "%s\n" "${1#+}"
}

# A network name
__validateTypeHost() {
  networkNameValid "${1-}" || return $?
  printf "%s\n" "${1#+}"
}

# Summary: Is a network IP valid?
# Must be valid IPv4 or IPv6 address.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: ip - String. IP to test for validity.
# Return Code: 0 - All network IPs passed in are valid.
# Return Code: 1 - One or more network IPs passed in are not valid
# stdin: line:String - Network IPs to test for validity.
networkIPValid() {
  local handler="_${FUNCNAME[0]}"

  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0

  if [ $# -eq 0 ]; then
    local name && while read -r name; do
      __networkIPValid "$handler" "$name" || return $?
    done || return $?
  else
    while [ $# -gt 0 ]; do
      local name="$1"
      __networkIPValid "$handler" "$name" || return $?
      shift
    done || return $?
  fi
}
_networkIPValid() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__networkIPValid() {
  local handler="$1" && shift
  local ip="$1" && shift

  local minPart=0 maxPart=255
  local ip4parts=() && IFS="." read -r -a ip4parts <<<"$ip"
  local ip6parts=() && IFS=":" read -r -a ip6parts <<<"$ip"

  if [ "${#ip6parts[@]}" -gt 1 ]; then
    [ "${#ip6parts[@]}" -ne 2 ] || throwEnvironment "$handler" "invalid IP6 address ${#ip6parts[@]}" || return $?
    local index=1 part && for part in "${ip6parts[@]+"${ip6parts[@]}"}"; do
      case "$part" in "") ;; *[!%[:alnum:]]*) throwEnvironment "$handler" "invalid IP6 segment: $part (#$index)" || return $? ;; esac && ((++index))
    done
  else
    [ "${#ip4parts[@]}" -eq 4 ] || throwEnvironment "$handler" "IP syntax: \"$ip\" -> v4=${#ip4parts[@]} v6=${#ip6parts[@]}" || return $?
    local index=1 part && for part in "${ip4parts[@]+"${ip4parts[@]}"}"; do
      isUnsignedInteger "$part" && [ "$part" -ge "$minPart" ] && [ "$part" -le "$maxPart" ] && ((++index)) || throwEnvironment "$handler" "invalid IP4 address: $part (#$index)" || return $?
    done
  fi
}

# Summary: Is a network host name valid?
# Must be valid name containing alphabetic characters, dashes, or dots.
# Dotted sections must be no longer than 63 characters; total name must be no longer than 253 characters.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: name - String. Network name to test for validity.
# Return Code: 0 - All network names passed in are valid.
# Return Code: 1 - One or more network names passed in are not valid
# stdin: line:String - Network names to test for validity.
networkNameValid() {
  local handler="_${FUNCNAME[0]}"

  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0

  if [ $# -eq 0 ]; then
    local name && while read -r name; do
      __networkNameValid "$handler" "$name" || return $?
    done || return $?
  else
    while [ $# -gt 0 ]; do
      local name="$1"
      __networkNameValid "$handler" "$name" || return $?
      shift
    done || return $?
  fi
}
_networkNameValid() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__networkNameValid() {
  local handler="$1" && shift
  local maxTotal=253 maxPart=63
  case "$1" in "["*"]") local new="${1:1:$((${#1} - 2))}" && set -- "$new" ;; esac
  case "$1" in
  [[:digit:]]*) networkIPValid "$1" && return $? || throwEnvironment "$handler" "$1 invalid IP" || return $? ;;
  "" | *[!-.%:[:alnum:]]* | -*) throwEnvironment "$handler" "$1 invalid characters" || return $? ;;
  esac
  [ "${#1}" -le "$maxTotal" ] || throwEnvironment "$handler" "$1 greater than $maxTotal chars" || return $?
  local parts=() && IFS="." read -r -a parts <<<"$1"
  local part && for part in "${parts[@]+"${parts[@]}"}"; do
    [ "${#part}" -le "$maxPart" ] || throwEnvironment "$handler" "$part greater than $maxPart chars" || return $?
  done
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

  [ $# -eq 0 ] || helpArgument --only "$handler" "$@" || return "$(convertValue $? 1 0)"

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
