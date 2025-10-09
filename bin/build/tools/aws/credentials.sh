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
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
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
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  usageRequireBinary "$handler" mkdir chmod touch || return $?

  if [ -z "$home" ]; then
    home="$(catchReturn "$handler" userHome)" || return $?
  fi
  if [ ! -d "$home" ]; then
    # Argument is validated above MUST be environment
    ! "$verbose" || throwEnvironment "$handler" "HOME environment \"$(decorate value "$home")\" directory not found" || return $?
    return 1
  fi
  local credentialsPath credentials="$HOME/.aws/credentials"
  if $checkFlag && [ ! -f "$credentials" ]; then
    if ! $createFlag; then
      ! $verbose || throwEnvironment "$handler" "No credentials file ($(decorate value "$credentials")) found" || return $?
      return 1
    fi
    credentialsPath="${credentials%/*}"
    catchEnvironment "$handler" mkdir -p "$credentialsPath" || return $?
    catchEnvironment "$handler" chmod 0700 "$credentialsPath" || return $?
    catchEnvironment "$handler" touch "$credentials" || return $?
    catchEnvironment "$handler" chmod 0600 "$credentials" || return $?
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
    *)
      [ -z "$profileName" ] || throwArgument "$handler" "profileName already supplied" || return $?
      profileName="$1"
      ;;
    esac
    shift
  done
  [ -n "$profileName" ] || profileName="default"

  credentials="$(catchReturn "$handler" awsCredentialsFile)" || return $?
  while read -r name value; do
    catchReturn "$handler" environmentValueWrite "$(uppercase "$name")" "$value" || return $?
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
  [ -n "$profileName" ] || throwArgument "$handler" "profileName is somehow blank" || return $?
  credentials="$(catchReturn "$handler" awsCredentialsFile)" || return $?
  while read -r name value; do
    foundValues+=("$(uppercase "$name")")
  done < <(__awsCredentialsExtractProfile "$profileName" <"$credentials")
  [ "${#foundValues[@]}" -gt 0 ] || return 1
  if [ "${#foundValues[@]}" -lt 2 ]; then
    throwEnvironment "$handler" "${#foundValues[@]} minimum 2 values found in $(decorate value "$credentials")" || return $?
  fi
  inArray AWS_ACCESS_KEY_ID "${foundValues[@]}" && inArray AWS_SECRET_ACCESS_KEY "${foundValues[@]}"
}
