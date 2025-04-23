#!/bin/bash
#
# Identical template
#
# Arguments used throughout Zesk Build
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# This function is not used is are here simply to provide documentation.

# fn: errorHandler
# Argument: exitCode - Integer. Required. The exit code to handle.
# Argument: message ... - EmptyString. Optional. The message to display to the user about what caused the error.
# The main error handler signature used in Zesk Build.
#
# Some code patterns:
#
#     usageRequireBinary "$handler" mariadb || return $?
#
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
# DOC TEMPLATE: assert-common 16
# Argument: --help - Optional. Flag. Display this help.
# Argument: --line lineNumber - Optional. Integer. Line number of calling function.
# Argument: --line-depth depth - Optional. Integer. The depth in the stack of function calls to find the line number of the calling function.
# Argument: --debug - Optional. Flag. Debugging enabled for the assertion function.
# Argument: --debug-lines - Optional. Flag. Debugging of SOLELY differences between --line passed in and the computed line from the --line-depth parameter.
# Argument: --display - Optional. String. Display name for the condition.
# Argument: --success - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
# Argument: --stderr-match - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
# Argument: --stdout-no-match - Optional. String. One or more strings which must match stderr.
# Argument: --stdout-match - Optional. String. One or more strings which must match stdout.
# Argument: --stdout-no-match - Optional. String. One or more strings which must match stdout.
# Argument: --stderr-ok - Optional. Flag. Output to stderr will not cause the test to fail.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
# Argument: --skip-plumber - Optional. Flag. Skip plumber check for function calls.
# Argument: --dump - Optional. Flag. Output stderr and stdout after test regardless.
# Argument: --dump-binary - Optional. Flag. Output stderr and stdout after test regardless, and output binary.
# This function serves as a sample for all other templates. DOES NOT NEED TO MAKE SENSE. Do not add a Requires: to this function.
__documentTemplateFunction() {
  local usage="_${FUNCNAME[0]}"

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
      # IDENTICAL profileNameArgumentHandlerCase 6
      --profile)
        shift
        [ ${#pp[@]} -eq 0 ] || __throwArgument "$usage" "$argument already specified: ${pp[*]}"
        profileName="$(usageArgumentString "$usage" "$argument" "$1")" || return $?
        pp=("$argument" "$profileName")
        ;;
      # IDENTICAL regionArgumentHandler 5
      --region)
        shift
        [ -z "$region" ] || __throwArgument "$usage" "$argument already specified: $region"
        region=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
        ;;
      *)
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  local start

  # IDENTICAL startBeginTiming 1
  start=$(timingStart) || return $?

  # IDENTICAL profileNameArgumentValidation 4
  if [ -z "$profileName" ]; then
    profileName="$(__catchEnvironment "$usage" buildEnvironmentGet AWS_PROFILE)" || return $?
    [ -n "$profileName" ] || profileName="default"
  fi

  # IDENTICAL regionArgumentValidation 7
  if [ -z "$region" ]; then
    export AWS_REGION
    __catchEnvironment "$usage" buildEnvironmentLoad AWS_REGION || return $?
    region="${AWS_REGION-}"
    [ -n "$region" ] || __throwArgument "$usage" "AWS_REGION or --region is required" || return $?
  fi
  awsRegionValid "$region" || __throwArgument "$usage" "--region $region is not a valid region" || return $?

  timingReport "$start" "Completed in"
}

___documentTemplateFunction() {
  local usage="_${FUNCNAME[0]}"

  # _IDENTICAL_ argument-case-blank-argument-header 4
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      # IDENTICAL profileNameArgumentHandlerCase 6
      --profile)
        shift
        [ ${#pp[@]} -eq 0 ] || __throwArgument "$usage" "$argument already specified: ${pp[*]}"
        profileName="$(usageArgumentString "$usage" "$argument" "$1")" || return $?
        pp=("$argument" "$profileName")
        ;;
      # IDENTICAL regionArgumentHandler 5
      --region)
        shift
        [ -z "$region" ] || __throwArgument "$usage" "$argument already specified: $region"
        region=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
        ;;
      *)
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  local start

  # IDENTICAL startBeginTiming 1
  start=$(timingStart) || return $?

  # IDENTICAL profileNameArgumentValidation 4
  if [ -z "$profileName" ]; then
    profileName="$(__catchEnvironment "$usage" buildEnvironmentGet AWS_PROFILE)" || return $?
    [ -n "$profileName" ] || profileName="default"
  fi

  # IDENTICAL regionArgumentValidation 7
  if [ -z "$region" ]; then
    export AWS_REGION
    __catchEnvironment "$usage" buildEnvironmentLoad AWS_REGION || return $?
    region="${AWS_REGION-}"
    [ -n "$region" ] || __throwArgument "$usage" "AWS_REGION or --region is required" || return $?
  fi
  awsRegionValid "$region" || __throwArgument "$usage" "--region $region is not a valid region" || return $?

  timingReport "$start" "Completed in"
}

__documentTemplateFunction2() {
  # Source _IDENTICAL_ usageDocument HERE
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

___documentTemplateFunctionSimple() {
  # _IDENTICAL_ usageDocumentSimple 1
  usageDocumentSimple "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
