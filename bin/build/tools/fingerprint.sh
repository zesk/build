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
# Argument: --audit - Flag. Optional. Keep a record of the files between fingerprints and show what changed to see if certain files are changing often and shouldn't; or should be ignored.
# Argument: --check - Flag. Optional. Check if the fingerprint is up to date and output the current value.
# Argument: --key - String. Optional. Update this key in the JSON file.
# BUILD_DEBUG: fingerprint - By default be verbose even if the flag is not specified. (Use `--quiet` to silence if needed)
# Environment: BUILD_DEBUG
fingerprint() {
  local handler="_${FUNCNAME[0]}"
  local key="" verboseFlag=false checkFlag=false prefix="" fingerprint="" hookName="" aa=()

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
    --audit) aa+=("$argument") ;;
    --cached) shift && fingerprint=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --hook) shift && hookName=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
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

  ! buildDebugEnabled fingerprint-audit || aa+=("--audit")

  [ -n "$prefix" ] || prefix=$(catchReturn "$handler" buildEnvironmentGet APPLICATION_JSON_PREFIX) || return $?
  [ -n "$key" ] || key="fingerprint"
  [ -n "$hookName" ] || hookName="application-fingerprint"

  local jqPath && jqPath=$(catchReturn "$handler" jsonPath "$prefix" "$key") || return $?

  local home && home=$(catchReturn "$handler" buildHome) || return $?
  local jsonFile && jsonFile="$home/$(catchReturn "$handler" buildEnvironmentGet APPLICATION_JSON)" || return $?

  [ -f "$jsonFile" ] || throwEnvironment "$handler" "Missing $(decorate file "$jsonFile")" || return $?

  local savedFingerprint && savedFingerprint="$(catchReturn "$handler" jsonFileGet "$jsonFile" "$jqPath")" || return $?
  [ -n "$fingerprint" ] || fingerprint=$(catchReturn "$handler" hookRun "$hookName" "${aa[@]+"${aa[@]}"}") || return $?
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
    ! $verboseFlag || decorate info "Fingerprint updated to $(decorate code "$fingerprint") $(decorate subtle "[${savedFingerprint:0:8}...]"). (path: $(decorate value "$jqPath"))"
  fi
}
_fingerprint() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Validates an application fingerprint
# Argument: name - Use `-` for the default hook, or pass in a hook name to use to calculate the fingerprint.
# Argument: value - String. Path. The value used is the stored fingerprint path in the application JSON file. Specify `hookName:jsonPath` to specify a custom hook name for the value.
# Default hook is `application-fingerprint`.
# fn: validate "$handler" Fingerprint name "value"
# Example usage:
#
#     case "$argument" in
#     ...
#     --fingerprint) fingerprint=$(validate "$handler" Fingerprint "name" "hookName:jsonPath") || return "$(convertValue $? 120 0)" ;;
#     ...
#     esac
#
#     [ -z "$fingerprint" ] || fingerprint --cached "$fingerprint" --verbose
#
# Return code: 120 - Exit when fingerprint matches.
# Argument: value - Key value to use. Required.
__validateTypeFingerprint() {
  local fingerprint=""

  local argument="${1-}" && [ -n "$argument" ] || _validateThrow "validate Fingerprint requires non-blank key" || return $?
  local hookName="${argument%:*}" keyName="${argument##*:}" hh=()
  [ "$keyName" = "$hookName" ] || hh=(--hook "$hookName")
  export __VALIDATE_FINGERPRINT_CACHE
  local returnCode=0
  if [ ${#hh[@]} -eq 0 ] && [ -n "${__VALIDATE_FINGERPRINT_CACHE-}" ]; then
    if fingerprint=$(fingerprint --check "${hh[@]+"${hh[@]}"}" --key "$keyName" --cached "$__VALIDATE_FINGERPRINT_CACHE"); then
      returnExit || returnCode=$?
    fi
  else
    if fingerprint=$(fingerprint --check "${hh[@]+"${hh[@]}"}" --key "$keyName"); then
      returnExit || returnCode=$?
    fi
  fi
  if [ -n "$fingerprint" ]; then
    printf "%s\n" "$fingerprint"
    [ ${#hh[@]} -gt 0 ] || __VALIDATE_FINGERPRINT_CACHE="$fingerprint"
  fi
  return "$returnCode"
}
