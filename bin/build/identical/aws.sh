#!/usr/bin/env bash
#
# Original of aws Identical templates
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__awsFunction() {
  local handler="_${FUNCNAME[0]}"
  # IDENTICAL profileNameArgumentLocal 1
  local pp=() profileName=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # IDENTICAL profileNameArgumentHandler 1
    --profile) shift && profileName="$(validate "$handler" string "$argument" "$1")" && pp=("$argument" "$profileName") || return $? ;;
    # IDENTICAL regionArgumentHandler 1
    --region) shift && region=$(validate "$handler" AWSRegion "$argument" "${1-}") || return $? ;;
    esac
    shift
  done

  [ -n "$profileName" ] || awsHasEnvironment || throwEnvironment "$handler" "Need AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY" || return $?

  ! executableExists aws || catchReturn "$handler" awsInstall || return $?

  # IDENTICAL profileNameArgumentEnvironment 1
  [ -n "$profileName" ] || profileName="$(catchReturn "$handler" buildEnvironmentGet --quiet AWS_PROFILE)" || return $?

  # IDENTICAL profileNameArgumentDefault 2
  [ -n "$profileName" ] || profileName="default"
  pp=(--profile "$profileName")

  # IDENTICAL regionArgumentValidation 5
  if [ -z "$region" ]; then
    export AWS_REGION && catchReturn "$handler" buildEnvironmentLoad --quiet AWS_REGION || return $?
    region="${AWS_REGION-}" && [ -n "$region" ] || throwArgument "$handler" "AWS_REGION or --region is required" || return $?
    awsRegionValid "$region" || throwArgument "$handler" "AWS_REGION $region is not a valid region" || return $?
  fi

  : "${pp[@]}"
}

# IDENTICAL __validateTypeAWSRegion EOF

# Requires: awsRegionValid _validateThrow
__validateTypeAWSRegion() {
  awsRegionValid "${1-}" || _validateThrow "Not a valid AWS Region: \"${1-}\"" || return $?
  printf "%s\n" "${1#+}"
}
