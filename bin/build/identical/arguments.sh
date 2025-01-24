#!/bin/bash
#
# Identical template
#
# Arguments used throughout Zesk Build
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
# shellcheck source=/dev/null
set -eou pipefail
source "${BASH_SOURCE[0]%/*}/../tools.sh"

# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# DOC TEMPLATE: --env-file 1
# Argument: --env-file envFile - Optional. File. Environment file to load - can handle any format.
# DOC TEMPLATE: assert-common 14
# Argument: --help - Optional. Flag. Display this help.
# Argument: --line lineNumber - Optional. Integer. Line number of calling function.
# Argument: --debug - Optional. Flag. Debugging
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
    [ -n "$argument" ] || __failArgument "$usage" "blank #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      # IDENTICAL profileNameArgumentHandlerCase 6
      --profile)
        shift
        [ ${#pp[@]} -eq 0 ] || __failArgument "$usage" "$argument already specified: ${pp[*]}"
        profileName="$(usageArgumentString "$usage" "$argument" "$1")" || return $?
        pp=("$argument" "$profileName")
        ;;
      # IDENTICAL regionArgumentHandler 5
      --region)
        shift
        [ -z "$region" ] || __failArgument "$usage" "$argument already specified: $region"
        region=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
        ;;
      *)
        # _IDENTICAL_ argumentUnknown 1
        __failArgument "$usage" "unknown #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift || __failArgument "$usage" "missing #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
  done

  local start

  # IDENTICAL startBeginTiming 1
  start=$(__usageEnvironment "$usage" beginTiming) || return $?

  # IDENTICAL profileNameArgumentValidation 4
  if [ -z "$profileName" ]; then
    profileName="$(__usageEnvironment "$usage" buildEnvironmentGet AWS_PROFILE)" || return $?
    [ -n "$profileName" ] || profileName="default"
  fi

  # IDENTICAL regionArgumentValidation 7
  if [ -z "$region" ]; then
    export AWS_REGION
    __usageEnvironment "$usage" buildEnvironmentLoad AWS_REGION || return $?
    region="${AWS_REGION-}"
    [ -n "$region" ] || __failArgument "$usage" "AWS_REGION or --region is required" || return $?
  fi
  awsRegionValid "$region" || __failArgument "$usage" "--region $region is not a valid region" || return $?

  reportTiming "$start" "Completed in"
}
___documentTemplateFunction() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__documentTemplateFunction2() {
  local usage="_${FUNCNAME[0]}"

  # _IDENTICAL_ argument-case-header-blank 4
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      # IDENTICAL --profileHandler 5
      --profile)
        shift
        [ -z "$profileName" ] || __failArgument "$usage" "--profile already specified" || return $?
        profileName="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      *)
        # _IDENTICAL_ argumentUnknown 1
        __failArgument "$usage" "unknown #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift || __failArgument "$usage" "missing #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
  done

  reportTiming "$start" "Completed in"
}
___documentTemplateFunction2() {
  # Source IDENTICAL usageDocument HERE
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
