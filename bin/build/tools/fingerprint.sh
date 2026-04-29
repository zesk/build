#!/usr/bin/env bash
#
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Update file from `APPLICATION_JSON` with application fingerprint.
#
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# Argument: --cached fingerprint - String. Optional. Instead of computing the `application-fingerprint` using the hook, use this value.
# Argument: --verbose - Flag. Optional. Be verbose. Default based on value of `fingerprint` in `BUILD_DEBUG`.
# Argument: --quiet - Flag. Optional. Be quiet (turns verbose off).
# Argument: --check - Flag. Optional. Check if the fingerprint is up to date and output the current value.
# Argument: --key - String. Optional. Update this key in the JSON file.
# BUILD_DEBUG: fingerprint - By default be verbose even if the flag is not specified. (Use `--quiet` to silence if needed)
# Environment: BUILD_DEBUG
fingerprint() {
  local handler="_${FUNCNAME[0]}"
  local key="" verboseFlag=false checkFlag=false prefix="" fingerprint=""

  ! buildDebugEnabled fingerprint || verboseFlag=true

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --check) checkFlag=true ;;
    --cached) shift && fingerprint=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --verbose) verboseFlag=true ;;
    --quiet) verboseFlag=false ;;
    --key) shift && key=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --prefix) shift && prefix=$(validate "$handler" EmptyString "$argument" "${1-}") || return $? ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  [ -n "$prefix" ] || prefix=$(catchReturn "$handler" buildEnvironmentGet APPLICATION_JSON_PREFIX) || return $?
  [ -n "$key" ] || key="fingerprint"

  local jqPath && jqPath=$(catchReturn "$handler" jsonPath "$prefix" "$key") || return $?

  local home && home=$(catchReturn "$handler" buildHome) || return $?
  local jsonFile && jsonFile="$home/$(catchReturn "$handler" buildEnvironmentGet APPLICATION_JSON)" || return $?

  [ -f "$jsonFile" ] || throwEnvironment "$handler" "Missing $(decorate file "$jsonFile")" || return $?

  local savedFingerprint && savedFingerprint="$(catchReturn "$handler" jsonFileGet "$jsonFile" "$jqPath")" || return $?
  [ -n "$fingerprint" ] || fingerprint=$(catchReturn "$handler" hookRun application-fingerprint) || return $?
  if [ "$fingerprint" = "$savedFingerprint" ]; then
    if $checkFlag; then
      printf -- "%s\n" "$fingerprint"
    else
      ! $verboseFlag || decorate subtle "Fingerprint is unchanged."
    fi
    return 0
  else
    if $checkFlag; then
      printf -- "%s\n" "$fingerprint"
      return 1
    fi
    catchEnvironment "$handler" jsonFileSet "$jsonFile" "$jqPath" "$fingerprint" || return $?
    ! $verboseFlag || decorate subtle "Fingerprint updated to $(decorate code "$fingerprint") [$savedFingerprint]. (path: $(decorate value "$jqPath"))"
  fi
}
_fingerprint() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Validates an application fingerprint
# fn: validate "$handler" Fingerprint name "value"
# Example usage:
#
#     case "$argument" in
#     ...
#     --fingerprint) fingerprint=$(validate "$handler" Fingerprint "fingerprint" "deprecated") || return "$(convertValue $? 120 0)" ;;
#     ...
#     esac
#
#     [ -z "$fingerprint" ] || fingerprint --cached "$fingerprint" --verbose
#
# Return code: 120 - Exit when fingerprint matches.
# Argument: value - Key value to use. Required.
__validateTypeFingerprint() {
  local fingerprint=""

  [ -n "${1-}" ] || _validateThrow "validate Fingerprint requires non-zero key" || return $?
  export __VALIDATE_FINGERPRINT_CACHE
  local returnCode=0
  if [ -n "${__VALIDATE_FINGERPRINT_CACHE-}" ]; then
    if fingerprint=$(fingerprint --check --cached "$__VALIDATE_FINGERPRINT_CACHE" --key "$1"); then
      returnExit || returnCode=$?
    fi
  else
    if fingerprint=$(fingerprint --check --key "$1"); then
      returnExit || returnCode=$?
    fi
  fi
  if [ -n "$fingerprint" ]; then
    printf "%s\n" "$fingerprint"
    __VALIDATE_FINGERPRINT_CACHE="$fingerprint"
  fi
  return "$returnCode"
}
