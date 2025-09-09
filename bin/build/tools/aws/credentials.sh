#!/usr/bin/env bash
#
# Amazon Web Services: awsCredentialsFile
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__awsCredentialsFile() {
  local handler="$1" && shift

  local home="" verbose=false createFlag=false checkFlag=true

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --create)
      createFlag=true
      ;;
    --path)
      checkFlag=false
      ;;
    --home)
      shift
      home=$(usageArgumentDirectory "$handler" "home" "${1-}") || return $?
      ;;
    --verbose)
      verbose=true
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  usageRequireBinary "$handler" mkdir chmod touch || return $?

  if [ -z "$home" ]; then
    home="$(__catch "$handler" userHome)" || return $?
  fi
  if [ ! -d "$home" ]; then
    # Argument is validated above MUST be environment
    ! "$verbose" || __throwEnvironment "$handler" "HOME environment \"$(decorate value "$home")\" directory not found" || return $?
    return 1
  fi
  local credentialsPath credentials="$HOME/.aws/credentials"
  if $checkFlag && [ ! -f "$credentials" ]; then
    if ! $createFlag; then
      ! $verbose || __throwEnvironment "$handler" "No credentials file ($(decorate value "$credentials")) found" || return $?
      return 1
    fi
    credentialsPath="${credentials%/*}"
    __catchEnvironment "$handler" mkdir -p "$credentialsPath" || return $?
    __catchEnvironment "$handler" chmod 0700 "$credentialsPath" || return $?
    __catchEnvironment "$handler" touch "$credentials" || return $?
    __catchEnvironment "$handler" chmod 0600 "$credentials" || return $?
  fi
  printf "%s\n" "$credentials"
  return 0
}

__awsEnvironmentFromCredentials() {
  local handler="$1" && shift

  local credentials profileName="" name value

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # IDENTICAL --profileHandler 5
    --profile)
      shift
      [ -z "$profileName" ] || __throwArgument "$handler" "--profile already specified" || return $?
      profileName="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      ;;
    *)
      [ -z "$profileName" ] || __throwArgument "$handler" "profileName already supplied" || return $?
      profileName="$1"
      ;;
    esac
    shift
  done
  [ -n "$profileName" ] || profileName="default"

  credentials="$(__catch "$handler" awsCredentialsFile)" || return $?
  while read -r name value; do
    __catch "$handler" environmentValueWrite "$(uppercase "$name")" "$value" || return $?
  done < <(__awsCredentialsExtractProfile "$profileName" <"$credentials")
}

__awsCredentialsExtractProfile() {
  grep -v -e '^\s*#' | awk -F= '/\[/{prefix=$0; next} $1 {print prefix " " $0}' | grep "\[$1\]" | awk '{ print $2 " " $4 }' OFS=''
}

__awsCredentialsHasProfile() {
  local handler="$1" && shift
  local credentials profileName=${1:-default} name value
  local foundValues=()
  __help "$handler" "$@" || return 0
  [ -n "$profileName" ] || __throwArgument "$handler" "profileName is somehow blank" || return $?
  credentials="$(__catch "$handler" awsCredentialsFile)" || return $?
  while read -r name value; do
    foundValues+=("$(uppercase "$name")")
  done < <(__awsCredentialsExtractProfile "$profileName" <"$credentials")
  [ "${#foundValues[@]}" -gt 0 ] || return 1
  if [ "${#foundValues[@]}" -lt 2 ]; then
    __throwEnvironment "$handler" "${#foundValues[@]} minimum 2 values found in $(decorate value "$credentials")" || return $?
  fi
  inArray AWS_ACCESS_KEY_ID "${foundValues[@]}" && inArray AWS_SECRET_ACCESS_KEY "${foundValues[@]}"
}

__awsCredentialsAdd() {
  local handler="$1" && shift

  local forceFlag=false profileName="" key="" secret="" addComments=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
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
      [ -z "$profileName" ] || __throwArgument "$handler" "--profile already specified" || return $?
      profileName="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      ;;
    *)
      if [ -z "$key" ]; then
        key=$(usageArgumentString "$handler" "key" "$1") || return $?
      elif [ -z "$secret" ]; then
        secret=$(usageArgumentString "$handler" "secret" "$1") || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done
  # IDENTICAL profileNameArgumentValidation 4
  if [ -z "$profileName" ]; then
    profileName="$(__catch "$handler" buildEnvironmentGet AWS_PROFILE)" || return $?
    [ -n "$profileName" ] || profileName="default"
  fi
  [ -n "$key" ] || __throwArgument "$handler" "key is required" || return $?
  [ -n "$secret" ] || __throwArgument "$handler" "secret is required" || return $?

  local lines=(
    "[$profileName]"
    "aws_access_key_id = $key"
    "aws_secret_access_key = $secret"
  )
  local credentials
  credentials="$(__catch "$handler" awsCredentialsFile --create)" || return $?
  if awsCredentialsHasProfile "$profileName"; then
    ! "$addComments" || lines+=("# ${FUNCNAME[0]} replaced $profileName on $(date -u)")
    $forceFlag || __throwEnvironment "$handler" "Profile $(decorate value "$profileName") exists in $(decorate code "$credentials")" || return $?
    _awsCredentialsRemoveSectionInPlace "$handler" "$credentials" "$profileName" "$(printf -- "%s\n" "${lines[@]}")" || return $?
  else
    ! "$addComments" || lines+=("# ${FUNCNAME[0]} added $profileName on $(date -u)") || __throwEnvironment "$handler" "Generating comment line failed" || return $?
    __catchEnvironment "$handler" printf -- "%s\n" "${lines[@]}" | trimHead >>"$credentials" || return $?
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
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # IDENTICAL --profileHandler 5
    --profile)
      shift
      [ -z "$profileName" ] || __throwArgument "$handler" "--profile already specified" || return $?
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
        __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  # IDENTICAL profileNameArgumentValidation 4
  if [ -z "$profileName" ]; then
    profileName="$(__catch "$handler" buildEnvironmentGet AWS_PROFILE)" || return $?
    [ -n "$profileName" ] || profileName="default"
  fi

  export AWS_PROFILE

  __catch "$handler" buildEnvironmentLoad AWS_PROFILE || return $?

  local credentials
  credentials="$(__catch "$handler" awsCredentialsFile --path)" || return $?
  [ -f "$credentials" ] || return 0
  if awsCredentialsHasProfile "$profileName"; then
    _awsCredentialsRemoveSectionInPlace "$handler" "$credentials" "$profileName" "" || return $?
  fi
}

_awsCredentialsRemoveSection() {
  local handler="$1" credentials="$2" profileName="$3" newCredentials="${4-}"
  local pattern="\[\s*$profileName\s*\]" temp lines total
  total=$((0 + $(__catch "$handler" fileLineCount "$credentials"))) || return $?
  exec 3>&1
  lines=$(__catchEnvironment "$handler" grepSafe -m 1 -B 32767 "$credentials" -e "$pattern" | __catchEnvironment "$handler" grepSafe -v -e "$pattern" | __catchEnvironment "$handler" trimTail | tee >(cat >&3) | fileLineCount) || return $?
  [ -z "$newCredentials" ] || printf -- "\n%s\n" "$newCredentials" | __catchEnvironment "$handler" trimTail || return $?
  local remain=$((total - lines - 2))
  printf -- "\n"
  tail -n "$remain" <"$credentials" | awk '/\[[^]]+\]/{flag=1} flag' | __catchEnvironment "$handler" trimTail || return $?
}

_awsCredentialsRemoveSectionInPlace() {
  local handler="$1" credentials="$2" profileName="$3" newCredentials="${4-}"

  temp=$(fileTemporaryName "$handler") || return $?
  _awsCredentialsRemoveSection "$handler" "$credentials" "$profileName" "$newCredentials" | trimBoth >"$temp" || returnClean $? "$temp" || return $?
  __catchEnvironment "$handler" cp "$temp" "$credentials" || returnClean $? "$temp" || return $?
  __catchEnvironment "$handler" rm -rf "$temp" || return $?
}

