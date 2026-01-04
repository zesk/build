#!/bin/bash
#
# Identical template
#
# Arguments used throughout Zesk Build
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# This function is not used. It's here simply to provide documentation.

# fn: errorHandler
# Argument: exitCode - Integer. Required. The exit code to handle.
# Argument: message ... - EmptyString. Optional. The message to display to the user about what caused the error.
# The main error handler signature used in Zesk Build.
#
# Example: Here, `handler` is a string variable which references our `errorHandler` function – when used in your code:
# Example
# Example:     tempFile=$(fileTemporaryName "$handler") || return $?
# Example:     catchEnvironment "$handler" rm -f "$tempFile" || return $?
# Example:     usageRequireBinary "$handler" curl sftp || return $?
__errorHandler() {
  return 0
}

# IDENTICAL zesk-build-hook-header 3
set -eou pipefail
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/../tools.sh"

# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# DOC TEMPLATE: --env-file 1
# Argument: --env-file envFile - Optional. File. Environment file to load - can handle any format.
# DOC TEMPLATE: assert-common 18
# Argument: --help - Optional. Flag. Display this help.
# Argument: --line lineNumber - Optional. Integer. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
# Argument: --line-depth depth - Optional. Integer. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Optional. Flag. Debugging enabled for the assertion function.
# Argument: --debug-lines - Optional. Flag. Debugging of SOLELY differences between `--line` passed in and the computed line from the `--line-depth` parameter.
# Argument: --display - Optional. String. Display name for the condition.
# Argument: --success - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`) - most functions have this already baked in.
# Argument: --stderr-match - Optional. String. One or more strings which must match `stderr` output. Implies `--stderr-ok`
# Argument: --stdout-no-match - Optional. String. One or more strings which must match NOT `stderr` output.
# Argument: --stdout-match - Optional. String. One or more strings which must match `stdout` output.
# Argument: --stdout-no-match - Optional. String. One or more strings which must match `stdout` output.
# Argument: --stderr-ok - Optional. Flag. Output to `stderr` will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Optional. Flag. Skip plumber check for function calls.
# Argument: --dump - Optional. Flag. Output `stderr` and `stdout` after test regardless.
# Argument: --dump-binary - Optional. Flag. Output `stderr` and `stdout` after test regardless, displayed as binary.
# Argument: --head - Optional. Flag. When outputting `stderr` or `stdout`, output the head of the file.
# Argument: --tail - Optional. Flag. When outputting `stderr` or `stdout`, output the tail of the file. (Default)
# This function serves as a sample for all other templates. DOES NOT NEED TO MAKE SENSE. Do not add a Requires: to this function.
__documentTemplateFunction() {
  local handler="_${FUNCNAME[0]}"

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
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    # IDENTICAL profileNameArgumentHandlerCase 6
    --profile)
      shift
      [ ${#pp[@]} -eq 0 ] || throwArgument "$handler" "$argument already specified: ${pp[*]}"
      profileName="$(usageArgumentString "$handler" "$argument" "$1")" || return $?
      pp=("$argument" "$profileName")
      ;;
    # IDENTICAL regionArgumentHandler 5
    --region)
      shift
      [ -z "$region" ] || throwArgument "$handler" "$argument already specified: $region"
      region=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local start

  # IDENTICAL startBeginTiming 1
  start=$(timingStart) || return $?

  # IDENTICAL profileNameArgumentValidation 4
  if [ -z "$profileName" ]; then
    profileName="$(catchReturn "$handler" buildEnvironmentGet AWS_PROFILE)" || return $?
    [ -n "$profileName" ] || profileName="default"
  fi

  # IDENTICAL regionArgumentValidation 7
  if [ -z "$region" ]; then
    export AWS_REGION
    catchReturn "$handler" buildEnvironmentLoad AWS_REGION || return $?
    region="${AWS_REGION-}"
    [ -n "$region" ] || throwArgument "$handler" "AWS_REGION or --region is required" || return $?
  fi
  awsRegionValid "$region" || throwArgument "$handler" "--region $region is not a valid region" || return $?

  timingReport "$start" "Completed in"
}

___documentTemplateFunction() {
  local handler="_${FUNCNAME[0]}"

  # _IDENTICAL_ argumentBlankLoopHandler 4
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # IDENTICAL profileNameArgumentHandlerCase 6
    --profile)
      shift
      [ ${#pp[@]} -eq 0 ] || throwArgument "$handler" "$argument already specified: ${pp[*]}"
      profileName="$(usageArgumentString "$handler" "$argument" "$1")" || return $?
      pp=("$argument" "$profileName")
      ;;
    # IDENTICAL regionArgumentHandler 5
    --region)
      shift
      [ -z "$region" ] || throwArgument "$handler" "$argument already specified: $region"
      region=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local start

  # IDENTICAL startBeginTiming 1
  start=$(timingStart) || return $?

  # IDENTICAL profileNameArgumentValidation 4
  if [ -z "$profileName" ]; then
    profileName="$(catchReturn "$handler" buildEnvironmentGet AWS_PROFILE)" || return $?
    [ -n "$profileName" ] || profileName="default"
  fi

  # IDENTICAL regionArgumentValidation 7
  if [ -z "$region" ]; then
    export AWS_REGION
    catchReturn "$handler" buildEnvironmentLoad AWS_REGION || return $?
    region="${AWS_REGION-}"
    [ -n "$region" ] || throwArgument "$handler" "AWS_REGION or --region is required" || return $?
  fi
  awsRegionValid "$region" || throwArgument "$handler" "--region $region is not a valid region" || return $?

  timingReport "$start" "Completed in"
}

__documentTemplateFunction2() {
  # Source __IDENTICAL__ usageDocument HERE
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

___documentTemplateFunctionSimple() {
  # __IDENTICAL__ usageDocumentSimple 1
  usageDocumentSimple "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
