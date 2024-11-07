#!/bin/bash
#
# Identical template
#
# Arguments used throughout Zesk Build
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
# shellcheck source=/dev/null
set -eou pipefail
source "${BASH_SOURCE[0]%/*}/../tools.sh"

# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# DOC TEMPLATE: --env 1
# Argument: --env envFile - Optional. File. Environment file to load - can handle any format.
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
# This function serves as a sample for all other templates.
__documentTemplateFunction() {
  local usage="_${FUNCNAME[0]}"
  local start

  # IDENTICAL startBeginTiming 1
  start=$(__usageEnvironment "$usage" beginTiming) || return $?

  local saved=("$@") nArguments=$# region="" profileName="" pp=()
  while [ $# -gt 0 ]; do
    local argument argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
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
        # IDENTICAL argumentUnknown 1
        __failArgument "$usage" "unknown argument #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done

  # IDENTICAL profileNameArgumentValidation 6
  if [ -z "$profileName" ]; then
    export AWS_PROFILE
    __usageEnvironment "$usage" buildEnvironmentLoad AWS_PROFILE || return $?
    profileName="${AWS_PROFILE-}"
    [ -n "$profileName" ] || profileName="default"
  fi

  # IDENTICAL regionArgumentValidation 6
  if [ -z "$region" ]; then
    export AWS_REGION
    __usageEnvironment "$usage" buildEnvironmentLoad AWS_REGION || return $?
    region="${AWS_REGION-}"
  fi
  awsRegionValid "$region" || __failArgument "$usage" "--region $region is not a valid region" || return $?

  reportTiming "$start" "Completed in"
}
___documentTemplateFunction() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__documentTemplateFunction2() {
  local usage="_${FUNCNAME[0]}"

  local saved=("$@") nArguments=$# region="" profileName=""
  while [ $# -gt 0 ]; do
    local argument argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
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
        # IDENTICAL argumentUnknown 1
        __failArgument "$usage" "unknown argument #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done

  reportTiming "$start" "Completed in"
}
___documentTemplateFunction2() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
