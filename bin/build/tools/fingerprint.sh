#!/usr/bin/env bash
#
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Update file from `APPLICATION_JSON` with application fingerprint.
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Optional. Function. Use this error handler instead of the default error handler.
# Argument: --verbose - Flag. Optional. Be verbose.
# Argument: --check - Flag. Optional. Check if the fingerprint is up to date and output the current value.
# Argument: --key - String. Optional. Update this key in the JSON file.
fingerprint() {
  local handler="_${FUNCNAME[0]}"
  local key="" verboseFlag=false checkFlag=false

  ! buildDebugEnabled fingerprint || verboseFlag=true

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --check) checkFlag=true ;;
    --verbose) verboseFlag=true ;;
    --key) shift && key=$(usageArgumentString "$handler" "$argument" "${1-}") || return $? ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  [ -n "$key" ] || key="fingerprint"

  local home
  home=$(__catch "$handler" buildHome) || return $?
  jsonFile="$home/$(__catch "$handler" buildEnvironmentGet APPLICATION_JSON)" || return $?

  [ -f "$jsonFile" ] || __throwEnvironment "$handler" "Missing $(decorate file "$jsonFile")" || return $?

  local fingerprint appFingerprint
  fingerprint="$(__catch "$handler" jq -r ".$key" <"$jsonFile")" || return $?
  appFingerprint=$(__catch "$handler" hookRun application-fingerprint) || return $?
  if [ "$appFingerprint" = "$fingerprint" ]; then
    if $checkFlag; then
      printf -- "%s\n" "$appFingerprint"
    else
      ! $verboseFlag || decorate subtle "Fingerprint is unchanged."
    fi
    return 0
  else
    if $checkFlag; then
      printf -- "%s\n" "$appFingerprint"
      return 1
    fi
    __catchEnvironment "$handler" jq ".$key = \"$appFingerprint\"" <"$jsonFile" >"$jsonFile.new" || returnClean $? "$jsonFile.new" || return $?
    __catchEnvironment "$handler" mv -f "$jsonFile.new" "$jsonFile" || returnClean $? "$jsonFile.new" || return $?
    ! $verboseFlag || decorate subtle "Fingerprint updated to $(decorate code "$appFingerprint") [$fingerprint]."
  fi
}
_fingerprint() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
