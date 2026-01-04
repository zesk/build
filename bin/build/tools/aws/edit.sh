#!/usr/bin/env bash
#
# Amazon Web Services: awsCredentialsAdd awsCredentialsRemove
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__awsCredentialsAdd() {
  local handler="$1" && shift

  local forceFlag=false profileName="" key="" secret="" addComments=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --force)
      forceFlag=true
      ;;
    --comments)
      addComments=true
      ;;
    # IDENTICAL --profileHandler 5
    --profile)
      shift
      [ -z "$profileName" ] || throwArgument "$handler" "--profile already specified" || return $?
      profileName="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      ;;
    *)
      if [ -z "$key" ]; then
        key=$(usageArgumentString "$handler" "key" "$1") || return $?
      elif [ -z "$secret" ]; then
        secret=$(usageArgumentString "$handler" "secret" "$1") || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done
  # IDENTICAL profileNameArgumentValidation 4
  if [ -z "$profileName" ]; then
    profileName="$(catchReturn "$handler" buildEnvironmentGet AWS_PROFILE)" || return $?
    [ -n "$profileName" ] || profileName="default"
  fi
  [ -n "$key" ] || throwArgument "$handler" "key is required" || return $?
  [ -n "$secret" ] || throwArgument "$handler" "secret is required" || return $?

  local lines=(
    "[$profileName]"
    "aws_access_key_id = $key"
    "aws_secret_access_key = $secret"
  )
  local credentials name="${FUNCNAME[0]#__}"
  credentials="$(catchReturn "$handler" awsCredentialsFile --create)" || return $?
  if awsCredentialsHasProfile "$profileName"; then
    ! "$addComments" || lines+=("# $name replaced $profileName on $(date -u)")
    $forceFlag || throwEnvironment "$handler" "Profile $(decorate value "$profileName") exists in $(decorate code "$credentials")" || return $?
    _awsCredentialsRemoveSectionInPlace "$handler" "$credentials" "$profileName" "$(printf -- "%s\n" "${lines[@]}")" || return $?
  else
    ! "$addComments" || lines+=("# $name added $profileName on $(date -u)") || throwEnvironment "$handler" "Generating comment line failed" || return $?
    catchEnvironment "$handler" printf -- "%s\n" "${lines[@]}" | trimHead >>"$credentials" || return $?
  fi
}

# Remove credentials from the AWS credentials file
#
# If the AWS credentials file is not found, succeeds.
#
# Usage: {fn} [ --help ] [ --profile profileName ] [ --force ] [ profileName ]
# Argument: --profile profileName - String. Optional. The credentials profile to write (default value is `default`)
# Argument: --comments - Flag. Optional. Write comments to the credentials file (in addition to updating the record).
__awsCredentialsRemove() {
  local handler="$1" && shift

  local forceFlag=false profileName="" key="" secret="" addComments=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # IDENTICAL --profileHandler 5
    --profile)
      shift
      [ -z "$profileName" ] || throwArgument "$handler" "--profile already specified" || return $?
      profileName="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      ;;
    --comments)
      addComments=true
      ;;
    *)
      if [ -z "$profileName" ]; then
        profileName="$(usageArgumentString "$handler" "$argument" "$1")" || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  # IDENTICAL profileNameArgumentValidation 4
  if [ -z "$profileName" ]; then
    profileName="$(catchReturn "$handler" buildEnvironmentGet AWS_PROFILE)" || return $?
    [ -n "$profileName" ] || profileName="default"
  fi

  export AWS_PROFILE

  catchReturn "$handler" buildEnvironmentLoad AWS_PROFILE || return $?

  local credentials
  credentials="$(catchReturn "$handler" awsCredentialsFile --path)" || return $?
  [ -f "$credentials" ] || return 0
  if awsCredentialsHasProfile "$profileName"; then
    _awsCredentialsRemoveSectionInPlace "$handler" "$credentials" "$profileName" "" || return $?
  fi
}

_awsCredentialsRemoveSection() {
  local handler="$1" credentials="$2" profileName="$3" newCredentials="${4-}"
  local pattern="\[\s*$profileName\s*\]" lines total
  total=$((0 + $(catchReturn "$handler" fileLineCount "$credentials"))) || return $?
  exec 3>&1
  lines=$(catchEnvironment "$handler" grepSafe -m 1 -B 32767 "$credentials" -e "$pattern" | catchEnvironment "$handler" grepSafe -v -e "$pattern" | catchEnvironment "$handler" trimTail | tee >(cat >&3) | fileLineCount) || return $?
  [ -z "$newCredentials" ] || printf -- "\n%s\n" "$newCredentials" | catchEnvironment "$handler" trimTail || return $?
  local remain=$((total - lines - 2))
  printf -- "\n"
  tail -n "$remain" <"$credentials" | awk '/\[[^]]+\]/{flag=1} flag' | catchEnvironment "$handler" trimTail || return $?
}

_awsCredentialsRemoveSectionInPlace() {
  local handler="$1" credentials="$2" profileName="$3" newCredentials="${4-}"

  local temp
  temp=$(fileTemporaryName "$handler") || return $?
  _awsCredentialsRemoveSection "$handler" "$credentials" "$profileName" "$newCredentials" | trimBoth >"$temp" || returnClean $? "$temp" || return $?
  catchEnvironment "$handler" cp "$temp" "$credentials" || returnClean $? "$temp" || return $?
  catchEnvironment "$handler" rm -rf "$temp" || return $?
}
