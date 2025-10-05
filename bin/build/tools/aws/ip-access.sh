#!/usr/bin/env bash
#
# Amazon Web Services: awsIPAccess
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__awsIPAccess() {
  local handler="$1" && shift

  export AWS_ACCESS_KEY_ID
  export AWS_SECRET_ACCESS_KEY

  local services=() optionRevoke=false currentIP="" developerId="" securityGroups=() verboseFlag=false profileName="" pp=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --services)
      shift || throwArgument "$handler" "missing $argument argument" || return $?
      IFS=', ' read -r -a services <<<"$1" || :
      ;;
    # IDENTICAL profileNameArgumentHandlerCase 6
    --profile)
      shift
      [ ${#pp[@]} -eq 0 ] || throwArgument "$handler" "$argument already specified: ${pp[*]}"
      profileName="$(usageArgumentString "$handler" "$argument" "$1")" || return $?
      pp=("$argument" "$profileName")
      ;;
    --revoke) optionRevoke=true ;;
    --verbose) verboseFlag=true ;;
    --group) shift && securityGroups+=("$1") ;;
    --ip) shift && currentIP="$1" ;;
    --id) shift && developerId="$1" ;;
    *)
      break
      ;;
    esac
    shift
  done

  [ -n "$developerId" ] || throwArgument "$handler" "Empty --id or DEVELOPER_ID environment" || return $?

  [ "${#services[@]}" -gt 0 ] || throwArgument "$handler" "Supply one or more services" || return $?

  [ ${#securityGroups[@]} -gt 0 ] || throwArgument "$handler" "One or more --group is required" || return $?
  if [ -z "$currentIP" ]; then
    if ! currentIP=$(ipLookup) || [ -z "$currentIP" ]; then
      throwEnvironment "$handler" "Unable to determine IP address" || return $?
    fi
  fi
  currentIP="$currentIP/32"

  returnCatch "$handler" awsInstall || return $?

  if ! awsHasEnvironment; then
    # IDENTICAL profileNameArgumentValidation 4
    if [ -z "$profileName" ]; then
      profileName="$(returnCatch "$handler" buildEnvironmentGet AWS_PROFILE)" || return $?
      [ -n "$profileName" ] || profileName="default"
    fi
    ! $verboseFlag || statusMessage decorate info "Need AWS credentials: $profileName" || :
    if awsCredentialsHasProfile "$profileName"; then
      # catchEnvironment "$handler" eval "$(awsEnvironmentFromCredentials "$profileName")" || return $?
      pp=("--profile" "$profileName")
    else
      throwEnvironment "$handler" "No AWS credentials available: $profileName" || return $?
    fi
  fi

  if [ ${#pp[@]} -eq 0 ]; then
    usageRequireEnvironment "$handler" AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_REGION || return $?
  fi

  if $verboseFlag; then
    if $optionRevoke; then
      bigText "Closing ..." | decorate magenta
    else
      bigText "Opening ..." | decorate blue
    fi
    local width=40

    decorate pair "$width" ID "$developerId" || :
    decorate pair "$width" IP "$currentIP" || :
    decorate pair "$width" "Security Groups" "${securityGroups[@]}" || :
    decorate pair "$width" Region "$AWS_REGION" || :
    if [ ${#pp[@]} -eq 0 ]; then
      decorate pair "$width" AWS_ACCESS_KEY_ID "$AWS_ACCESS_KEY_ID" || :
      decorate pair "$width" AWS_SECRET_ACCESS_KEY "${#AWS_SECRET_ACCESS_KEY} characters" || :
    else
      decorate pair "$width" Profile "${pp[1]-NO PROFILE}" || :
    fi
  fi
  local service
  for service in "${services[@]}"; do
    if ! isPositiveInteger "$service" && ! serviceToPort "$service" >/dev/null; then
      throwArgument "$handler" "Invalid service $(decorate code "$service")" || return $?
    fi
  done

  local securityGroupId sgArgs port
  for securityGroupId in "${securityGroups[@]}"; do
    for service in "${services[@]}"; do
      if isPositiveInteger "$service"; then
        port="$service"
      else
        port=$(serviceToPort "$service") || throwEnvironment "$handler" "serviceToPort $service failed 2nd round?" || return $?
      fi
      sgArgs=(--group "$securityGroupId" --port "$port" --description "$developerId-$service" --ip "$currentIP")

      local actionArg="--register" && ! $optionRevoke || actionArg="--remove"
      returnCatch "$handler" awsSecurityGroupIPModify "${pp[@]+"${pp[@]}"}" "$actionArg" "${sgArgs[@]}" || return $?
    done
  done
}
