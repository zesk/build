#!/usr/bin/env bash
#
# Amazon Web Services: awsCredentialsAdd awsCredentialsRemove
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__awsCredentialsAdd() {
  local handler="$1" && shift
  # IDENTICAL profileNameArgumentLocal 1
  local pp=() profileName=""
  local forceFlag=false key="" secret="" addComments=false

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
      profileName="$(validate "$handler" String "$argument" "${1-}")" || return $?
      ;;
    *)
      if [ -z "$key" ]; then
        key=$(validate "$handler" String "key" "$1") || return $?
      elif [ -z "$secret" ]; then
        secret=$(validate "$handler" String "secret" "$1") || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done
  # IDENTICAL profileNameArgumentEnvironment 1
  [ -n "$profileName" ] || profileName="$(catchReturn "$handler" buildEnvironmentGet --quiet AWS_PROFILE)" || return $?
  # IDENTICAL profileNameArgumentDefault 2
  [ -n "$profileName" ] || profileName="default"
  pp=(--profile "$profileName")

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
    catchEnvironment "$handler" printf -- "%s\n" "${lines[@]}" | textTrimHead >>"$credentials" || return $?
  fi
}

__awsCredentialsRemove() {
  local handler="$1" && shift

  local forceFlag=false key="" secret="" addComments=false
  # IDENTICAL profileNameArgumentLocal 1
  local pp=() profileName=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # IDENTICAL profileNameArgumentHandler 1
    --profile) shift && profileName="$(validate "$handler" string "$argument" "$1")" && pp=("$argument" "$profileName") || return $? ;;
    --comments)
      addComments=true
      ;;
    *)
      if [ -z "$profileName" ]; then
        profileName="$(validate "$handler" String "$argument" "$1")" || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  # IDENTICAL profileNameArgumentEnvironment 1
  [ -n "$profileName" ] || profileName="$(catchReturn "$handler" buildEnvironmentGet --quiet AWS_PROFILE)" || return $?
  # IDENTICAL profileNameArgumentDefault 2
  [ -n "$profileName" ] || profileName="default"
  pp=(--profile "$profileName")

  local credentials && credentials="$(catchReturn "$handler" awsCredentialsFile --path)" || return $?
  [ -f "$credentials" ] || return 0
  if awsCredentialsHasProfile "$profileName"; then
    _awsCredentialsRemoveSectionInPlace "$handler" "$credentials" "${pp[1]}" "" || return $?
  fi
}

_awsCredentialsRemoveSection() {
  local handler="$1" credentials="$2" profileName="$3" newCredentials="${4-}"
  local pattern="\[\s*$profileName\s*\]" lines total
  total=$((0 + $(catchReturn "$handler" fileLineCount "$credentials"))) || return $?
  exec 3>&1
  lines=$(catchEnvironment "$handler" grepSafe -m 1 -B 32767 "$credentials" -e "$pattern" | catchEnvironment "$handler" grepSafe -v -e "$pattern" | catchEnvironment "$handler" textTrimTail | tee >(cat >&3) | fileLineCount) || return $?
  [ -z "$newCredentials" ] || printf -- "\n%s\n" "$newCredentials" | catchEnvironment "$handler" textTrimTail || return $?
  local remain=$((total - lines - 2))
  printf -- "\n"
  tail -n "$remain" <"$credentials" | awk '/\[[^]]+\]/{flag=1} flag' | catchEnvironment "$handler" textTrimTail || return $?
}

_awsCredentialsRemoveSectionInPlace() {
  local handler="$1" credentials="$2" profileName="$3" newCredentials="${4-}"

  local temp
  temp=$(fileTemporaryName "$handler") || return $?
  _awsCredentialsRemoveSection "$handler" "$credentials" "$profileName" "$newCredentials" | textTrimBoth >"$temp" || returnClean $? "$temp" || return $?
  catchEnvironment "$handler" cp "$temp" "$credentials" || returnClean $? "$temp" || return $?
  catchEnvironment "$handler" rm -rf "$temp" || return $?
}
