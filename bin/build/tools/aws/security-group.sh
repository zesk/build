#!/usr/bin/env bash
#
# Amazon Web Services: awsSecurityGroupIPModify
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__awsSecurityGroupIPModify() {
  local handler="$1" && shift

  local pp=() profileName="" group="" port="" description="" ip="" foundIP mode="--add" verb="Adding (default)" tempErrorFile region=""

  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # IDENTICAL profileNameArgumentHandlerCase 6
    --profile)
      shift
      [ ${#pp[@]} -eq 0 ] || __throwArgument "$handler" "$argument already specified: ${pp[*]}"
      profileName="$(usageArgumentString "$handler" "$argument" "$1")" || return $?
      pp=("$argument" "$profileName")
      ;;
    --group)
      shift
      group=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --port)
      shift
      port=$(usageArgumentPositiveInteger "$handler" "$argument" "${1-}") || return $?
      ;;
    --description)
      shift
      description=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --ip)
      shift
      ip=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --add)
      verb="Adding"
      mode="$argument"
      ;;
    --remove)
      verb="Removing"
      mode="$argument"
      ;;
    --register)
      verb="Registering"
      mode="$argument"
      ;;
    # IDENTICAL regionArgumentHandler 5
    --region)
      shift
      [ -z "$region" ] || __throwArgument "$handler" "$argument already specified: $region"
      region=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    *)
      __throwArgument "unknown argument: $argument" || return $?
      ;;
    esac
    shift
  done

  [ -n "$profileName" ] || awsHasEnvironment || __throwEnvironment "$handler" "Need AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY" || return $?

  ! whichExists aws || __catch "$handler" awsInstall || return $?

  # IDENTICAL regionArgumentValidation 7
  if [ -z "$region" ]; then
    export AWS_REGION
    __catch "$handler" buildEnvironmentLoad AWS_REGION || return $?
    region="${AWS_REGION-}"
    [ -n "$region" ] || __throwArgument "$handler" "AWS_REGION or --region is required" || return $?
  fi
  awsRegionValid "$region" || __throwArgument "$handler" "--region $region is not a valid region" || return $?

  [ -n "$mode" ] || __throwArgument "$handler" "--add, --remove, or --register is required" || return $?

  for argument in group description region; do
    if [ -z "${!argument}" ]; then
      __throwArgument "$handler" "--$argument is required ($(decorate each code "${__saved[@]}"))" || return $?
    fi
  done

  if [ "$mode" != "--remove" ]; then
    for argument in ip port; do
      [ -n "${!argument}" ] || __throwArgument "$handler" "--$argument is required for $mode (Arguments: $(decorate each code "${handler#_}" "${__saved[@]}"))" || return $?
    done
  fi

  #
  # 3 modes: Add, Remove, Register
  #
  # PAGER=cat "aws" "--no-paginate" "ec2" "describe-security-groups" "--region" "us-east-2" "--group-id" "sg-01bbe46ae4419a3ec" "--output" "text" "--query" "SecurityGroups[*].IpPermissions[*]"
  # PAGER=cat aws --no-paginate ec2 describe-security-groups --region us-east-2 --group-id sg-01bbe46ae4419a3ec --output text --query 'SecurityGroups[*].IpPermissions[*]'
  #
  # Remove + Register
  #
  # Fetch our current IP registered with this description
  #
  if [ "$mode" != "--add" ]; then
    tempErrorFile=$(fileTemporaryName "$handler") || return $?
    __catch "$handler" __awsWrapper "${pp[@]+"${pp[@]}"}" ec2 describe-security-groups --region "$region" --group-id "$group" --output text --query "SecurityGroups[*].IpPermissions[*]" >"$tempErrorFile" || returnClean "$?" "$tempErrorFile" || return $?
    foundIP=$(grep -e "$(quoteGrepPattern "$description")" <"$tempErrorFile" | head -1 | awk '{ print $2 }') || :
    __catchEnvironment "$handler" rm -f "$tempErrorFile" || return $?

    if [ -z "$foundIP" ]; then
      # Remove: If no IP found in security group, if we are Removing (NOT adding), we are done
      if [ "$mode" = '--remove' ]; then
        return 0
      fi
      # Register: No IP found, add it
      mode="--add"
    elif [ "$mode" = "--register" ] && [ "$foundIP" = "$ip" ]; then
      __awsSGOutput "$(decorate success "IP already registered:")" "$foundIP" "$group" "$port"
      return 0
    else
      __awsSGOutput "$(decorate info "Removing old IP:")" "$foundIP" "$group" "$port"
      __catch "$handler" __awsWrapper "${pp[@]+"${pp[@]}"}" --output json ec2 revoke-security-group-ingress --region "$region" --group-id "$group" --protocol tcp --port "$port" --cidr "$foundIP" | __awsReturnTrue || return $?
    fi
  fi
  if [ "$mode" != "--remove" ]; then
    local json
    json="[{\"IpProtocol\": \"tcp\", \"FromPort\": $port, \"ToPort\": $port, \"IpRanges\": [{\"CidrIp\": \"$ip\", \"Description\": \"$description\"}]}]"
    __awsSGOutput "$(decorate info "$verb new IP:")" "$ip" "$group" "$port"

    tempErrorFile=$(fileTemporaryName "$handler") || return $?
    if ! __awsWrapper "${pp[@]+"${pp[@]}"}" --output json ec2 authorize-security-group-ingress --region "$region" --group-id "$group" --ip-permissions "$json" 2>"$tempErrorFile" | __awsReturnTrue; then
      if grep -q "Duplicate" "$tempErrorFile"; then
        printf "%s\n" "$(decorate yellow "duplicate")"
      else
        __throwEnvironment "$handler" "Failed to authorize-security-group-ingress $(dumpPipe "Errors:" <"$tempErrorFile")" || returnClean $? "$tempErrorFile" || return $?
      fi
    fi
    __catchEnvironment "$handler" rm -f "$tempErrorFile" || return $?
  fi
}

# Pipe output into this
__awsReturnTrue() {
  [ "$(jq ".Return")" = "true" ]
}

# Helper for awsSecurityGroupIPModify
__awsSGOutput() {
  local title="$1" ip="$2" group="$3" port="$4"
  printf "%s %s %s %s %s %s\n" "$title" "$(decorate red "$ip")" "$(decorate label "in group-id:")" "$(decorate value "$group")" "$(decorate label "port:")" "$(decorate value "$port")"
}


