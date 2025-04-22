#!/usr/bin/env bash
#
# Amazon Web Services
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

###############################################################################
#
# ....▄▄    ▄▄      ▄▄   ▄▄▄▄
# ...████   ██      ██ ▄█▀▀▀▀█
# ...████   ▀█▄ ██ ▄█▀ ██▄
# ..██  ██   ██ ██ ██   ▀████▄
# ..██████   ███▀▀███       ▀██
# .▄██  ██▄  ███  ███  █▄▄▄▄▄█▀
# .▀▀    ▀▀  ▀▀▀  ▀▀▀   ▀▀▀▀▀
#
#------------------------------------------------------------------------------

#
# aws Command-Line install
#
# Installs x86 or aarch64 binary based on `$HOSTTYPE`.
#
# Usage: awsInstall [ package ... ]
# Argument: package - One or more packages to install using `apt-get` prior to installing AWS
# Exit Code: if `packageInstall` fails, the exit code is returned
# Depends: apt-get
#
# shellcheck disable=SC2120
awsInstall() {
  local usage="_${FUNCNAME[0]}"

  if whichExists aws; then
    return 0
  fi

  if isAlpine; then
    packageInstall aws-cli "$@" || return $?
    return 0
  fi

  local start
  start=$(timingStart) || return $?
  __catchEnvironment "$usage" packageWhich unzip unzip || return $?
  __catchEnvironment "$usage" packageWhich curl curl "$@" || return $?

  local url
  statusMessage decorate info "Installing aws-cli ... " || :
  case "${HOSTTYPE-}" in
    arm64 | aarch64)
      url="https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip"
      ;;
    *)
      url="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
      ;;
  esac
  {
    local buildDir quietLog clean=()
    buildDir="$(__catchEnvironment "$usage" buildCacheDirectory awsCache.$$)" || return $?
    clean+=("$buildDir")
    quietLog="$(__catchEnvironment "$usage" buildQuietLog awsInstall)" || _clean $? "${clean[@]}" || return $?
    clean+=("$quietLog")
    buildDir=$(__catchEnvironment "$usage" requireDirectory "$buildDir") || _clean $? "${clean[@]}" || return $?
    clean+=("$buildDir")

    local zipFile=awscliv2.zip version
    __catchEnvironmentQuiet "$usage" "$quietLog" curl -s "$url" -o "$buildDir/$zipFile" || _clean $? "${clean[@]}" || return $?
    __catchEnvironmentQuiet "$usage" "$quietLog" unzip -d "$buildDir" "$buildDir/$zipFile" || _clean $? "${clean[@]}" || return $?
    __catchEnvironmentQuiet "$usage" "$quietLog" "$buildDir/aws/install" || _clean $? "${clean[@]}" || return $?
    version="$(__catchEnvironment "$usage" __awsWrapper --version)" || _clean $? "${clean[@]}" || return $?
    printf "%s %s\n" "$version" "$(__catchEnvironment "$usage" timingReport "$start" OK)" || return $?
    __catchEnvironment "$usage" rm -rf "${clean[@]}" || return $?
  }
}
_awsInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Get the credentials file path, optionally outputting errors
#
# Pass a true-ish value to output warnings to stderr on failure
#
# Pass any value to output warnings if the environment or file is not found; otherwise
# output the credentials file path.
#
# If not found, returns with exit code 1.
#
# Summary: Get the path to the AWS credentials file
# Usage:  {fn} [ --verbose ] [ --help ] [ --home homeDirectory ]
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --verbose - Flag. Optional. Verbose mode
# Argument: --create - Optional. Flag. Create the directory and file if it does not exist
# Argument: --home homeDirectory - Optional. Directory. Home directory to use instead of `$HOME`.
# Example:     credentials=$(awsCredentialsFile) || __throwEnvironment "$usage" "No credentials file found" || return $?
# Exit Code: 1 - If `$HOME` is not a directory or credentials file does not exist
# Exit Code: 0 - If credentials file is found and output to stdout
#
# shellcheck disable=SC2120
awsCredentialsFile() {
  local usage="_${FUNCNAME[0]}"

  local home="" verbose=false createFlag=false checkFlag=true

  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --create)
        createFlag=true
        ;;
      --path)
        checkFlag=false
        ;;
      --home)
        shift
        home=$(usageArgumentDirectory "$usage" "home" "${1-}") || return $?
        ;;
      --verbose)
        verbose=true
        ;;
      *)
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  usageRequireBinary "$usage" mkdir chmod touch || return $?

  if [ -z "$home" ]; then
    home="$(__catchEnvironment "$usage" userHome)" || return $?
  fi
  if [ ! -d "$home" ]; then
    # Argument is validated above MUST be environment
    ! "$verbose" || __throwEnvironment "$usage" "HOME environment \"$(decorate value "$home")\" directory not found" || return $?
    return 1
  fi
  local credentialsPath credentials="$HOME/.aws/credentials"
  if $checkFlag && [ ! -f "$credentials" ]; then
    if ! $createFlag; then
      ! $verbose || __throwEnvironment "$usage" "No credentials file ($(decorate value "$credentials")) found" || return $?
      return 1
    fi
    credentialsPath="${credentials%/*}"
    __catchEnvironment "$usage" mkdir -p "$credentialsPath" || return $?
    __catchEnvironment "$usage" chmod 0700 "$credentialsPath" || return $?
    __catchEnvironment "$usage" touch "$credentials" || return $?
    __catchEnvironment "$usage" chmod 0600 "$credentials" || return $?
  fi
  printf "%s\n" "$credentials"
  return 0
}
_awsCredentialsFile() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# For security we gotta update our keys every 90 days
#
# This value would be better encrypted and tied to the AWS_ACCESS_KEY_ID so developers
# can not just update the value to avoid the security issue.
#
# This tool checks the environment `AWS_ACCESS_KEY_DATE` and ensures it's within `upToDateDays` of today; if not this fails.
#
# It will also fail if:
#
# - `upToDateDays` is less than zero or greater than 366
# - `AWS_ACCESS_KEY_DATE` is empty or has an invalid value
#
# Otherwise, the tool *may* output a message to the console warning of pending days, and returns exit code 0 if the `AWS_ACCESS_KEY_DATE` has not exceeded the number of days.
#
# Environment: AWS_ACCESS_KEY_DATE - Variable used to test
# Summary: Test whether the AWS keys do not need to be updated
# Usage: {fn} upToDateDays
# Example:     if ! {fn} 90; then
# Example:         bigText Failed, update key and reset date
# Example:         exit 99
# Example:     fi
# Environment: AWS_ACCESS_KEY_DATE - Read-only. Date. A `YYYY-MM-DD` formatted date which represents the date that the key was generated.
#
awsIsKeyUpToDate() {
  export AWS_ACCESS_KEY_DATE
  __environment buildEnvironmentLoad AWS_ACCESS_KEY_DATE || return $?
  isUpToDate "${AWS_ACCESS_KEY_DATE-}" "$@"
}

#
# This tests `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` and if both are non-empty, returns exit code 0 (success), otherwise returns exit code 1.
# Fails if either `AWS_ACCESS_KEY_ID` or `AWS_SECRET_ACCESS_KEY` is blank
#
# Exit Code: 0 - If environment needs to be updated
# Exit Code: 1 - If the environment seems to be set already
# Environment: AWS_ACCESS_KEY_ID - Read-only. If blank, this function succeeds (environment needs to be updated)
# Environment: AWS_SECRET_ACCESS_KEY - Read-only. If blank, this function succeeds (environment needs to be updated)
# Example:     if awsHasEnvironment; then
# Example:     ...
# Example:     fi
# Summary: Test whether the AWS environment variables are set or not
#
awsHasEnvironment() {
  local usage="_${FUNCNAME[0]}"
  export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
  # shellcheck source=/dev/null
  __catchEnvironment "$usage" buildEnvironmentLoad AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY || return $?
  [ -n "${AWS_ACCESS_KEY_ID-}" ] && [ -n "${AWS_SECRET_ACCESS_KEY-}" ]
}
_awsHasEnvironment() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List AWS profiles available in the credentials file
# See: awsCredentialsFile
awsProfilesList() {
  local usage="_${FUNCNAME[0]}"
  local file

  file=$(__catchEnvironment "$usage" awsCredentialsFile --path) || return $?
  [ -f "$file" ] || return 0
  grep -e '\[[^]]*\]' "$file" | sed 's/[]\[]//g' | sort -u || :
}
_awsProfilesList() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Load the credentials supplied from the AWS credentials file and output shell commands to set the appropriate `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` values.
#
# If the AWS credentials file is not found, returns exit code 1 and outputs nothing.
# If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.
#
# Summary: Get credentials and output environment variables for AWS authentication
# Usage: {fn} [ profileName ] | [ --profile profileName ]
# Argument: profileName - String. Optional. The credentials profile to load (default value is `default` and loads section identified by `[default]` in `~/.aws/credentials`)
# Argument: --profile profileName - String. Optional. The credentials profile to load (default value is `default` and loads section identified by `[default]` in `~/.aws/credentials`)
# Argument: --comments - Flag. Optional. Write comments to the credentials file (in addition to updating the record).
# Both forms can be used, but the profile should be supplied once and only once.
# Example:     setFile=$(mktemp)
# Example:     if awsEnvironment "$profile" > "$setFile"; then
# Example:     eval $(cat "$setFile")
# Example:     rm "$setFile"
# Example:     else
# Example:     decorate error "Need $profile profile in aws credentials file"`
# Example:     exit 1
# Example:     fi
awsEnvironmentFromCredentials() {
  local usage="_${FUNCNAME[0]}"

  local credentials profileName="" name value

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
      # IDENTICAL --profileHandler 5
      --profile)
        shift
        [ -z "$profileName" ] || __throwArgument "$usage" "--profile already specified" || return $?
        profileName="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      *)
        [ -z "$profileName" ] || __throwArgument "$usage" "profileName already supplied" || return $?
        profileName="$1"
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  [ -n "$profileName" ] || profileName="default"

  credentials="$(__catchEnvironment "$usage" awsCredentialsFile)" || return $?
  while read -r name value; do
    __catchEnvironment "$usage" environmentValueWrite "$(uppercase "$name")" "$value" || return $?
  done < <(__awsCredentialsExtractProfile "$profileName" <"$credentials")
}
_awsEnvironmentFromCredentials() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__awsCredentialsExtractProfile() {
  grep -v -e '^\s*#' | awk -F= '/\[/{prefix=$0; next} $1 {print prefix " " $0}' | grep "\[$1\]" | awk '{ print $2 " " $4 }' OFS=''
}

#
# Extract a profile from a credentials file
#
# If the AWS credentials file is not found, returns exit code 1 and outputs nothing.
# If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.
#
# Summary: Get credentials and output environment variables for AWS authentication
# Usage: awsEnvironment profileName
# Argument: profileName - The credentials profile to load (default value is `default` and loads section identified by `[default]` in `~/.aws/credentials`)
# Example:     setFile=$(mktemp)
# Example:     if awsEnvironment "$profile" > "$setFile"; then
# Example:     eval $(cat "$setFile")
# Example:     rm "$setFile"
# Example:     else
# Example:     decorate error "Need $profile profile in aws credentials file"`
# Example:     exit 1
# Example:     fi
awsCredentialsHasProfile() {
  local usage="_${FUNCNAME[0]}"
  local credentials profileName=${1:-default} name value
  local foundValues=()
  [ -n "$profileName" ] || __throwArgument "$usage" "profileName is somehow blank" || return $?
  credentials="$(__catchEnvironment "$usage" awsCredentialsFile)" || return $?
  while read -r name value; do
    foundValues+=("$(uppercase "$name")")
  done < <(__awsCredentialsExtractProfile "$profileName" <"$credentials")
  [ "${#foundValues[@]}" -gt 0 ] || return 1
  if [ "${#foundValues[@]}" -lt 2 ]; then
    __throwEnvironment "$usage" "${#foundValues[@]} minimum 2 values found in $(decorate value "$credentials")" || return $?
  fi
  inArray AWS_ACCESS_KEY_ID "${foundValues[@]}" && inArray AWS_SECRET_ACCESS_KEY "${foundValues[@]}"
}
_awsCredentialsHasProfile() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Write the credentials to the AWS credentials file.
#
# If the AWS credentials file is not found, it is created
#
# Summary: Write an AWS profile to the AWS credentials file
# Argument: --profile profileName - String. Optional. The credentials profile to write (default value is `default`)
# Argument: --force - Flag. Optional. Write the credentials file even if the profile already exists
# Argument: --comments - Flag. Optional. Write comments to the credentials file (in addition to updating the record).
# Argument: key - The AWS_ACCESS_KEY_ID to write
# Argument: secret - The AWS_SECRET_ACCESS_KEY to write
awsCredentialsAdd() {
  local usage="_${FUNCNAME[0]}"

  local forceFlag=false profileName="" key="" secret="" addComments=false

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
      --force)
        forceFlag=true
        ;;
      --comments)
        addComments=true
        ;;
      # IDENTICAL --profileHandler 5
      --profile)
        shift
        [ -z "$profileName" ] || __throwArgument "$usage" "--profile already specified" || return $?
        profileName="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      *)
        if [ -z "$key" ]; then
          key=$(usageArgumentString "$usage" "key" "$1") || return $?
        elif [ -z "$secret" ]; then
          secret=$(usageArgumentString "$usage" "secret" "$1") || return $?
        else
          # _IDENTICAL_ argumentUnknown 1
          __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  # IDENTICAL profileNameArgumentValidation 4
  if [ -z "$profileName" ]; then
    profileName="$(__catchEnvironment "$usage" buildEnvironmentGet AWS_PROFILE)" || return $?
    [ -n "$profileName" ] || profileName="default"
  fi
  [ -n "$key" ] || __throwArgument "$usage" "key is required" || return $?
  [ -n "$secret" ] || __throwArgument "$usage" "secret is required" || return $?

  local lines=(
    "[$profileName]"
    "aws_access_key_id = $key"
    "aws_secret_access_key = $secret"
  )
  local credentials
  credentials="$(__catchEnvironment "$usage" awsCredentialsFile --create)" || return $?
  if awsCredentialsHasProfile "$profileName"; then
    ! "$addComments" || lines+=("# ${FUNCNAME[0]} replaced $profileName on $(date -u)")
    $forceFlag || __throwEnvironment "$usage" "Profile $(decorate value "$profileName") exists in $(decorate code "$credentials")" || return $?
    _awsCredentialsRemoveSectionInPlace "$usage" "$credentials" "$profileName" "$(printf -- "%s\n" "${lines[@]}")" || return $?
  else
    ! "$addComments" || lines+=("# ${FUNCNAME[0]} added $profileName on $(date -u)") || __throwEnvironment "$usage" "Generating comment line failed" || return $?
    __catchEnvironment "$usage" printf -- "%s\n" "${lines[@]}" | trimHead >>"$credentials" || return $?
  fi
}
_awsCredentialsAdd() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Remove credentials from the AWS credentials file
#
# If the AWS credentials file is not found, succeeds.
#
# Usage: {fn} [ --help ] [ --profile profileName ] [ --force ] [ profileName ]
# Argument: --profile profileName - String. Optional. The credentials profile to write (default value is `default`)
# Argument: --comments - Flag. Optional. Write comments to the credentials file (in addition to updating the record).
awsCredentialsRemove() {
  local usage="_${FUNCNAME[0]}"

  export AWS_PROFILE

  __catchEnvironment "$usage" buildEnvironmentLoad AWS_PROFILE || return $?

  local forceFlag=false profileName="" key="" secret="" addComments=false

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
      # IDENTICAL --profileHandler 5
      --profile)
        shift
        [ -z "$profileName" ] || __throwArgument "$usage" "--profile already specified" || return $?
        profileName="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      --comments)
        addComments=true
        ;;
      *)
        if [ -z "$profileName" ]; then
          profileName="$(usageArgumentString "$usage" "$argument" "$1")" || return $?
        else
          # _IDENTICAL_ argumentUnknown 1
          __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  # IDENTICAL profileNameArgumentValidation 4
  if [ -z "$profileName" ]; then
    profileName="$(__catchEnvironment "$usage" buildEnvironmentGet AWS_PROFILE)" || return $?
    [ -n "$profileName" ] || profileName="default"
  fi

  local credentials
  credentials="$(__catchEnvironment "$usage" awsCredentialsFile --path)" || return $?
  [ -f "$credentials" ] || return 0
  if awsCredentialsHasProfile "$profileName"; then
    _awsCredentialsRemoveSectionInPlace "$usage" "$credentials" "$profileName" "" || return $?
  fi
}
_awsCredentialsRemove() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Write the credentials to the AWS credentials file.
#
# If the AWS credentials file is not found, returns exit code 1 and outputs nothing.
# If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.
#
# Summary: Write an AWS profile to the AWS credentials file
# Usage: {fn} [ --help ] [ --profile profileName ] [ --force ]
# Argument: --profile profileName - String. Optional. The credentials profile to write (default value is `default`)
# Argument: --force - Flag. Optional. Write the credentials file even if the profile already exists
awsCredentialsFromEnvironment() {
  local usage="_${FUNCNAME[0]}"

  export AWS_PROFILE AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
  __catchEnvironment "$usage" buildEnvironmentLoad AWS_PROFILE AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY || return $?
  awsHasEnvironment || __throwEnvironment "$usage" "Requires AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY" || return $?
  __catchEnvironment "$usage" awsCredentialsAdd "$@" "$AWS_ACCESS_KEY_ID" "$AWS_SECRET_ACCESS_KEY" || return $?
}

_awsCredentialsFromEnvironment() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_awsCredentialsRemoveSection() {
  local usage="$1" credentials="$2" profileName="$3" newCredentials="${4-}"
  local pattern="\[\s*$profileName\s*\]" temp lines total
  total=$((0 + $(__catchEnvironment "$usage" wc -l <"$credentials"))) || return $?
  exec 3>&1
  lines=$(($(__catchEnvironment "$usage" grepSafe -m 1 -B 32767 "$credentials" -e "$pattern" | __catchEnvironment "$usage" grepSafe -v -e "$pattern" | trimTail | tee >(cat >&3) | wc -l) + 0)) || return $?
  [ -z "$newCredentials" ] || __catchEnvironment "$usage" printf -- "\n%s\n" "$newCredentials" | trimTail || return $?
  local remain=$((total - lines - 2))
  printf -- "\n"
  tail -n "$remain" <"$credentials" | awk '/\[[^]]+\]/{flag=1} flag' | trimTail || return $?
}

_awsCredentialsRemoveSectionInPlace() {
  local usage="$1" credentials="$2" profileName="$3" newCredentials="${4-}"

  temp=$(fileTemporaryName "$usage") || return $?
  _awsCredentialsRemoveSection "$usage" "$credentials" "$profileName" "$newCredentials" | trimBoth >"$temp" || _clean $? "$temp" || return $?
  __catchEnvironment "$usage" cp "$temp" "$credentials" || _clean $? "$temp" || return $?
  __catchEnvironment "$usage" rm -rf "$temp" || return $?
}

# Usage: {fn} --add --group group [ --region region ] --port port --description description --ip ip
# Usage: {fn} --remove --group group [ --region region ] --description description
# Argument: --remove - Optional. Flag. Remove instead of add - only `group`, and `description` required.
# Argument: --add - Optional. Flag. Add to security group (default).
# Argument: --register - Optional. Flag. Add it if not already added.
# Argument: --group group - Required. String. Security Group ID
# Argument: --region region - Optional. String. AWS region, defaults to `AWS_REGION`. Must be supplied.
# Argument: --port port - Required for `--add` only. Integer. service port
# Argument: --description description - Required. String. Description to identify this record.
# Argument: --ip ip - Required for `--add` only. String. IP Address to add or remove.
# Modify an EC2 Security Group and add or remove an IP/port combination to the group.
# Summary: Modify an EC2 Security Group
awsSecurityGroupIPModify() {
  local usage="_${FUNCNAME[0]}"
  local start

  local pp=() profileName="" group="" port="" description="" ip="" foundIP mode="--add" verb="Adding (default)" tempErrorFile region=""

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
      --group)
        shift
        group=$(usageArgumentString "$usage" "$argument" "${1-}")
        ;;
      --port)
        shift
        port=$(usageArgumentPositiveInteger "$usage" "$argument" "${1-}")
        ;;
      --description)
        shift
        description=$(usageArgumentString "$usage" "$argument" "${1-}")
        ;;
      --ip)
        shift
        ip=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
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
        [ -z "$region" ] || __throwArgument "$usage" "$argument already specified: $region"
        region=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
        ;;
      *)
        __throwArgument "unknown argument: $argument" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ -n "$profileName" ] || awsHasEnvironment || __throwEnvironment "$usage" "Need AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY" || return $?

  ! whichExists aws || __catchEnvironment "$usage" awsInstall || return $?

  # IDENTICAL regionArgumentValidation 7
  if [ -z "$region" ]; then
    export AWS_REGION
    __catchEnvironment "$usage" buildEnvironmentLoad AWS_REGION || return $?
    region="${AWS_REGION-}"
    [ -n "$region" ] || __throwArgument "$usage" "AWS_REGION or --region is required" || return $?
  fi
  awsRegionValid "$region" || __throwArgument "$usage" "--region $region is not a valid region" || return $?

  [ -n "$mode" ] || __throwArgument "$usage" "--add, --remove, or --register is required" || return $?

  for argument in group description region; do
    if [ -z "${!argument}" ]; then
      __throwArgument "$usage" "--$argument is required ($(decorate each code "${__saved[@]}"))" || return $?
    fi
  done

  if [ "$mode" != "--remove" ]; then
    for argument in ip port; do
      [ -n "${!argument}" ] || __throwArgument "$usage" "--$argument is required for $mode (Arguments: $(decorate each code "${usage#_}" "${__saved[@]}"))" || return $?
    done
  fi

  tempErrorFile=$(fileTemporaryName "$usage") || return $?

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
    __catchEnvironment "$usage" __awsWrapper "${pp[@]+"${pp[@]}"}" ec2 describe-security-groups --region "$region" --group-id "$group" --output text --query "SecurityGroups[*].IpPermissions[*]" >"$tempErrorFile" || _clean "$?" "$tempErrorFile" || return $?

    foundIP=$(grep -e "$(quoteGrepPattern "$description")" <"$tempErrorFile" | head -1 | awk '{ print $2 }') || :

    __catchEnvironment "$usage" rm -f "$tempErrorFile" || return $?

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
      __catchEnvironment "$usage" __awsWrapper "${pp[@]+"${pp[@]}"}" --output json ec2 revoke-security-group-ingress --region "$region" --group-id "$group" --protocol tcp --port "$port" --cidr "$foundIP" || return $?
    fi
  fi
  if [ "$mode" != "--remove" ]; then
    local json
    json="[{\"IpProtocol\": \"tcp\", \"FromPort\": $port, \"ToPort\": $port, \"IpRanges\": [{\"CidrIp\": \"$ip\", \"Description\": \"$description\"}]}]"
    __awsSGOutput "$(decorate info "$verb new IP:")" "$ip" "$group" "$port"

    if ! __awsWrapper "${pp[@]+"${pp[@]}"}" --output json ec2 authorize-security-group-ingress --region "$region" --group-id "$group" --ip-permissions "$json" 2>"$tempErrorFile"; then
      if grep -q "Duplicate" "$tempErrorFile"; then
        printf "%s\n" "$(decorate yellow "duplicate")"
        rm -f "$tempErrorFile"
      else
        __throwEnvironment "$usage" "Failed to authorize-security-group-ingress $(dumpPipe "Errors:" <"$tempErrorFile")" || _clean $? "$tempErrorFile" || return $?
      fi
    fi
  fi
}
_awsSecurityGroupIPModify() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Helper for awsSecurityGroupIPModify
__awsSGOutput() {
  local title="$1" ip="$2" group="$3" port="$4"
  printf "%s %s %s %s %s %s\n" "$title" "$(decorate red "$foundIP")" "$(decorate label "in group-id:")" "$(decorate value "$group")" "$(decorate label "port:")" "$(decorate value "$port")"
}

# Requires: aws env
__awsWrapper() {
  local command=(aws --no-paginate) configFile=".aws/config"

  # AWS_SHARED_CREDENTIALS_FILE
  # AWS_CONFIG_FILE
  home=$(userHome) || return $?
  [ -f "$configFile" ] || configFile=""
  # env -u unsets a variable name
  [ -n "${AWS_PROFILE-}" ] || command=(env -u AWS_PROFILE "${command[@]}")
  AWS_CONFIG_FILE="$configFile" AWS_PROFILE="${AWS_PROFILE-}" AWS_PAGER="" "${command[@]}" "$@"
}

# Summary: Grant access to AWS security group for this IP only using Amazon IAM credentials
# Usage: {fn} --services service0,service1,... [ --profile profileName ] [ --id developerId ] [ --group securityGroup ] [ --ip ip ] [ --revoke ] [ --debug ] [ --help ]
# Argument: --profile profileName - String. Optional. Use this AWS profile when connecting using ~/.aws/credentials
# Argument: --services service0,service1,... - List. Required. List of services to add or remove (service names or port numbers)
# Argument: --id developerId - String. Optional. Specify an developer id manually (uses DEVELOPER_ID from environment by default)
# Argument: --group securityGroup - String. Required. String. Specify one or more security groups to modify. Format: `sg-` followed by hexadecimal characters.
# Argument: --ip ip - Optional. IP. Specify bn IP manually (uses ipLookup tool from tools.sh by default)
# Argument: --revoke - Flag. Optional. Remove permissions
# Argument: --help - Flag. Optional. Show this help
#
# Register current IP address in listed security groups to allow for access to deployment systems from a specific IP.
# Use this during deployment to grant temporary access to your systems during deployment only.
# Build scripts should have a $(decorate code --revoke) step afterward, always.
# services are looked up in /etc/services and match /tcp services only for port selection
#
# If no `/etc/services` matches the default values are supported within the script: `mysql`,`postgres`,`ssh`,`http`,`https`
# You can also simply supply a list of port numbers, and mix and match: `--services ssh,http,3306,12345` is valid
#
# Environment: AWS_REGION - Where to update the security group
# Environment: DEVELOPER_ID - Developer used to register rules in Amazon
# Environment: AWS_ACCESS_KEY_ID - Amazon IAM ID
# Environment: AWS_SECRET_ACCESS_KEY - Amazon IAM Secret
#
awsIPAccess() {
  local usage="_${FUNCNAME[0]}"

  export AWS_ACCESS_KEY_ID
  export AWS_SECRET_ACCESS_KEY

  local services=() optionRevoke=false currentIP="" developerId="" securityGroups=() verboseFlag=false profileName="" pp=()

  while [ $# -gt 0 ]; do
    local argument="$1"
    [ -n "$argument" ] || __throwArgument "$usage" "blank argument" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --services)
        shift || __throwArgument "$usage" "missing $argument argument" || return $?
        IFS=', ' read -r -a services <<<"$1" || :
        ;;
      # IDENTICAL profileNameArgumentHandlerCase 6
      --profile)
        shift
        [ ${#pp[@]} -eq 0 ] || __throwArgument "$usage" "$argument already specified: ${pp[*]}"
        profileName="$(usageArgumentString "$usage" "$argument" "$1")" || return $?
        pp=("$argument" "$profileName")
        ;;
      --revoke)
        optionRevoke=true
        ;;
      --verbose)
        verboseFlag=true
        ;;
      --group)
        shift || __throwArgument "$usage" "missing $argument argument" || return $?
        securityGroups+=("$1")
        ;;
      --ip)
        shift || __throwArgument "$usage" "missing $argument argument" || return $?
        currentIP="$1"
        ;;
      --id)
        shift || __throwArgument "$usage" "missing $argument argument" || return $?
        developerId="$1"
        ;;
      *)
        break
        ;;
    esac
    shift || __throwArgument "$usage" "shift failed" || return $?
  done

  [ -n "$developerId" ] || __throwArgument "$usage" "Empty --id or DEVELOPER_ID environment" || return $?

  [ "${#services[@]}" -gt 0 ] || __throwArgument "$usage" "Supply one or more services" || return $?

  [ ${#securityGroups[@]} -gt 0 ] || __throwArgument "$usage" "One or more --group is required" || return $?
  if [ -z "$currentIP" ]; then
    if ! currentIP=$(ipLookup) || [ -z "$currentIP" ]; then
      __throwEnvironment "$usage" "Unable to determine IP address" || return $?
    fi
  fi
  currentIP="$currentIP/32"

  __catchEnvironment "$usage" awsInstall || return $?

  if ! awsHasEnvironment; then
    # IDENTICAL profileNameArgumentValidation 4
    if [ -z "$profileName" ]; then
      profileName="$(__catchEnvironment "$usage" buildEnvironmentGet AWS_PROFILE)" || return $?
      [ -n "$profileName" ] || profileName="default"
    fi
    ! $verboseFlag || statusMessage decorate info "Need AWS credentials: $profileName" || :
    if awsCredentialsHasProfile "$profileName"; then
      # __catchEnvironment "$usage" eval "$(awsEnvironmentFromCredentials "$profileName")" || return $?
      pp=("--profile" "$profileName")
    else
      __throwEnvironment "$usage" "No AWS credentials available: $profileName" || return $?
    fi
  fi

  if [ ${#pp[@]} -eq 0 ]; then
    usageRequireEnvironment "$usage" AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_REGION || return $?
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
      __throwArgument "$usage" "Invalid service $(decorate code "$service")" || return $?
    fi
  done

  local securityGroupId sgArgs port
  for securityGroupId in "${securityGroups[@]}"; do
    for service in "${services[@]}"; do
      if isPositiveInteger "$service"; then
        port="$service"
      else
        port=$(serviceToPort "$service") || __throwEnvironment "$usage" "serviceToPort $service failed 2nd round?" || return $?
      fi
      sgArgs=(--group "$securityGroupId" --port "$port" --description "$developerId-$service" --ip "$currentIP")

      local actionArg="--register" && ! $optionRevoke || actionArg="--remove"
      __catchEnvironment "$usage" awsSecurityGroupIPModify "${pp[@]+"${pp[@]}"}" "$actionArg" "${sgArgs[@]}" || return $?
    done
  done
}
_awsIPAccess() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Check an AWS region code for validity
# Checks an AWS region identifier for validity as of September 2024.
# Note that passing no parameters returns success.
# Usage: {fn} region
# Argument: region ... - String. Required. The AWS Region to validate.
# Exit Code: 0 - All regions are valid AWS region
# Exit Code: 1 - One or more regions are NOT a valid AWS region
# Checked: 2024-09-02
awsRegionValid() {
  [ $# -gt 0 ] || return 1
  while [ $# -gt 0 ]; do
    case "$1" in
      eu-north-1) ;;
      eu-central-1) ;;
      eu-west-1 | eu-west-2 | eu-west-3) ;;
      ap-south-1) ;;
      ap-southeast-1 | ap-southeast-2) ;;
      ap-northeast-3 | ap-northeast-2 | ap-northeast-1) ;;
      ca-central-1) ;;
      sa-east-1) ;;
      us-east-1 | us-east-2 | us-west-1 | us-west-2) ;;
      *)
        return 1
        ;;
    esac
    shift
  done
  return 0
}
