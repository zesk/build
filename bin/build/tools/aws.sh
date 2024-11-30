#!/usr/bin/env bash
#
# Amazon Web Services
#
# Copyright &copy; 2024 Market Acumen, Inc.
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

  local start
  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  __usageEnvironment "$usage" packageWhich unzip unzip || return $?
  __usageEnvironment "$usage" packageWhich curl curl "$@" || return $?

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
    local buildDir quietLog clean
    clean=()
    {
      buildDir="$(__usageEnvironment "$usage" buildCacheDirectory awsCache.$$)" &&
        quietLog="$(__usageEnvironment "$usage" buildQuietLog awsInstall)" &&
        buildDir=$(__usageEnvironment "$usage" requireDirectory "$buildDir")
    } || return $?
    clean+=("$buildDir" "$quietLog")
    {
      local zipFile=awscliv2.zip
      local version
      __usageEnvironmentQuiet "$usage" "$quietLog" curl -s "$url" -o "$buildDir/$zipFile" &&
        __usageEnvironmentQuiet "$usage" "$quietLog" unzip -d "$buildDir" "$buildDir/$zipFile" &&
        __usageEnvironmentQuiet "$usage" "$quietLog" "$buildDir/aws/install" &&
        version="$(__usageEnvironment "$usage" aws --version)" &&
        printf "%s %s\n" "$version" "$(__usageEnvironment "$usage" reportTiming "$start" OK)"
    }
    _clean $? "${clean[@]}" || return $?
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
# Example:     credentials=$(awsCredentialsFile) || __failEnvironment "$usage" "No credentials file found" || return $?
# Exit Code: 1 - If `$HOME` is not a directory or credentials file does not exist
# Exit Code: 0 - If credentials file is found and output to stdout
#
# shellcheck disable=SC2120
awsCredentialsFile() {
  local usage="_${FUNCNAME[0]}"

  usageRequireBinary "$usage" mkdir chmod touch || return $?

  local home="" verbose=false createFlag=false nArguments=$# checkFlag=true
  while [ $# -gt 0 ]; do
    local argument argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
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
        __failArgument "$usage" "unknown argument #$argumentIndex: $argument" || return $?
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument" || return $?
  done
  if [ -z "$home" ]; then
    export HOME
    __usageEnvironment "$usage" buildEnvironmentLoad HOME || return $?
    home="$HOME"
  fi
  if [ ! -d "$home" ]; then
    # Argument is validated above MUST be environment
    ! "$verbose" || _environment "HOME environment \"$(decorate value "$home")\" directory not found" || return $?
    return 1
  fi
  local credentialsPath credentials="$HOME/.aws/credentials"
  if $checkFlag && [ ! -f "$credentials" ]; then
    if ! $createFlag; then
      ! $verbose || __failEnvironment "$usage" "No credentials file ($(decorate value "$credentials")) found" || return $?
      return 1
    fi
    credentialsPath="${credentials%/*}"
    __usageEnvironment "$usage" mkdir -p "$credentialsPath" || return $?
    __usageEnvironment "$usage" chmod 0700 "$credentialsPath" || return $?
    __usageEnvironment "$usage" touch "$credentials" || return $?
    __usageEnvironment "$usage" chmod 0600 "$credentials" || return $?
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
  __usageEnvironment "$usage" buildEnvironmentLoad AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY || return $?
  [ -n "${AWS_ACCESS_KEY_ID-}" ] && [ -n "${AWS_SECRET_ACCESS_KEY-}" ]
}
_awsHasEnvironment() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List AWS profiles available in the credentials file
# See: awsCredentialsFile
awsProfilesList() {
  local usage="_${FUNCNAME[0]}"
  local file

  file=$(__usageEnvironment "$usage" awsCredentialsFile --path) || return $?
  [ -f "$file" ] || return 0
  grep -e '\[[^]]*\]' "$file" | sed 's/[]\[]//g' | sort -u || :
}
_awsProfilesList() {
  # IDENTICAL usageDocument 1
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
  local argument nArguments argumentIndex saved

  local credentials profileName="" name value

  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
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
        [ -z "$profileName" ] || __failArgument "$usage" "profileName already supplied" || return $?
        profileName="$1"
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done
  [ -n "$profileName" ] || profileName="default"

  credentials="$(__usageEnvironment "$usage" awsCredentialsFile)" || return $?
  while read -r name value; do
    __usageEnvironment "$usage" environmentValueWrite "$(uppercase "$name")" "$value" || return $?
  done < <(__awsCredentialsExtractProfile "$profileName" <"$credentials")
}
_awsEnvironmentFromCredentials() {
  # IDENTICAL usageDocument 1
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
  [ -n "$profileName" ] || __failArgument "$usage" "profileName is somehow blank" || return $?
  credentials="$(__usageEnvironment "$usage" awsCredentialsFile)" || return $?
  while read -r name value; do
    foundValues+=("$(uppercase "$name")")
  done < <(__awsCredentialsExtractProfile "$profileName" <"$credentials")
  [ "${#foundValues[@]}" -gt 0 ] || return 1
  if [ "${#foundValues[@]}" -lt 2 ]; then
    __failEnvironment "$usage" "${#foundValues[@]} minimum 2 values found in $(decorate value "$credentials")" || return $?
  fi
  inArray AWS_ACCESS_KEY_ID "${foundValues[@]}" && inArray AWS_SECRET_ACCESS_KEY "${foundValues[@]}"
}
_awsCredentialsHasProfile() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Write the credentials to the AWS credentials file.
#
# If the AWS credentials file is not found, it is created
#
# Summary: Write an AWS profile to the AWS credentials file
# Usage: {fn} [ --help ] [ --profile profileName ] [ --force ] id secret
# Argument: --profile profileName - String. Optional. The credentials profile to write (default value is `default`)
# Argument: --force - Flag. Optional. Write the credentials file even if the profile already exists
# Argument: id - The AWS_ACCESS_KEY_ID to write
# Argument: key - The AWS_SECRET_ACCESS_KEY to write
awsCredentialsAdd() {
  local usage="_${FUNCNAME[0]}"

  local forceFlag=false saved=("$@") nArguments=$# profileName="" key="" secret=""
  while [ $# -gt 0 ]; do
    local argument argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --force)
        forceFlag=true
        ;;
      # IDENTICAL --profileHandler 5
      --profile)
        shift
        [ -z "$profileName" ] || __failArgument "$usage" "--profile already specified" || return $?
        profileName="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      *)
        if [ -z "$key" ]; then
          key=$(usageArgumentString "$usage" "key" "$1") || return $?
        elif [ -z "$secret" ]; then
          secret=$(usageArgumentString "$usage" "secret" "$1") || return $?
        else
        # IDENTICAL argumentUnknown 1
        __failArgument "$usage" "unknown argument #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
        fi
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done
  # IDENTICAL profileNameArgumentValidation 4
  if [ -z "$profileName" ]; then
    profileName="$(__usageEnvironment "$usage" buildEnvironmentGet AWS_PROFILE)" || return $?
    [ -n "$profileName" ] || profileName="default"
  fi

  local credentials
  credentials="$(__usageEnvironment "$usage" awsCredentialsFile --create)" || return $?
  if awsCredentialsHasProfile "$profileName"; then
    $forceFlag || __failEnvironment "$usage" "Profile $(decorate value "$profileName") exists in $(decorate code "$credentials")" || return $?
    _awsCredentialsRemoveSection "$usage" "$credentials" "$profileName" || return $?
  fi
  local lines=(
    ""
    "# ${FUNCNAME[0]} Added profile $profileName ($(date))"
    "[$profileName]"
    "aws_access_key_id = $key"
    "aws_secret_access_key = $secret"
  )
  printf -- "%s\n" "${lines[@]}" >>"$credentials" || return $?
}
_awsCredentialsAdd() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Remove credentials from the AWS credentials file
#
# If the AWS credentials file is not found, succeeds.
#
# Usage: {fn} [ --help ] [ --profile profileName ] [ --force ] [ profileName ]
# Argument: --profile profileName - String. Optional. The credentials profile to write (default value is `default`)
awsCredentialsRemove() {
  local usage="_${FUNCNAME[0]}"

  export AWS_PROFILE

  __usageEnvironment "$usage" buildEnvironmentLoad AWS_PROFILE || return $?

  local forceFlag=false saved=("$@") nArguments=$# profileName="" key="" secret=""
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
        if [ -z "$profileName" ]; then
          profileName="$(usageArgumentString "$usage" "$argument" "$1")" || return $?
        else
        # IDENTICAL argumentUnknown 1
        __failArgument "$usage" "unknown argument #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
        fi
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done
  # IDENTICAL profileNameArgumentValidation 4
  if [ -z "$profileName" ]; then
    profileName="$(__usageEnvironment "$usage" buildEnvironmentGet AWS_PROFILE)" || return $?
    [ -n "$profileName" ] || profileName="default"
  fi

  local credentials
  credentials="$(__usageEnvironment "$usage" awsCredentialsFile --path)" || return $?
  [ -f "$credentials" ] || return 0
  if awsCredentialsHasProfile "$profileName"; then
    _awsCredentialsRemoveSection "$usage" "$credentials" "$profileName" || return $?
  fi
}
_awsCredentialsRemove() {
  # IDENTICAL usageDocument 1
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
  __usageEnvironment "$usage" buildEnvironmentLoad AWS_PROFILE AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY || return $?
  awsHasEnvironment || __failEnvironment "$usage" "Requires AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY" || return $?
  __usageEnvironment "$usage" awsCredentialsAdd "$@" "$AWS_ACCESS_KEY_ID" "$AWS_SECRET_ACCESS_KEY" || return $?
}
_awsCredentialsFromEnvironment() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_awsCredentialsRemoveSection() {
  local usage="$1" credentials="$2" profileName=$3
  local pattern="\[\s*$profileName\s*\]" temp lines total
  total=$((0 + $(__usageEnvironment "$usage" wc -l <"$credentials"))) || return $?
  temp=$(__usageEnvironment "$usage" mktemp) || return $?
  lines=$((0 + $(grep -m 1 -B 32767 "$credentials" -e "$pattern" | grep -v -e "$pattern" | __usageEnvironment "$usage" tee "$temp" | wc -l))) || _clean $? "$temp" || return $?
  printf -- "# Removed profile %s (%s)\n" "$profileName" "$(date)" >>"$temp"
  __usageEnvironment "$usage" grep -v -e "$pattern" <"$credentials" | tail -n "$((total - lines + 2))" | awk '/\[[^]]+\]/{flag=1} flag' >>"$temp" || _clean $? "$temp" || return $?
  __usageEnvironment "$usage" cp -f "$temp" "$credentials" || _clean $? "$temp" || return $?
  __usageEnvironment "$usage" rm -rf "$temp" || return $?
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
#
#
awsSecurityGroupIPModify() {
  local usage="_${FUNCNAME[0]}"
  local start

  start=$(__usageEnvironment "$usage" beginTiming) || __failEnvironment "$usage" "beginTiming" || return $?

  local pp=() saved=("$@") nArguments=$# profileName="" group="" port="" description="" ip="" foundIP mode="--add" verb="Adding (default)" tempErrorFile region=""
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
        [ -z "$region" ] || __failArgument "$usage" "$argument already specified: $region"
        region=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
        ;;
      *)
        __failArgument "unknown argument: $argument" || return $?
        ;;
    esac
    shift || __failArgument "$usage" "shift argument $(decorate label "$argument")" || return $?
  done

  # IDENTICAL regionArgumentValidation 7
  if [ -z "$region" ]; then
    export AWS_REGION
    __usageEnvironment "$usage" buildEnvironmentLoad AWS_REGION || return $?
    region="${AWS_REGION-}"
    [ -n "$region" ] || __failArgument "$usage" "AWS_REGION or --region is required" || return $?
  fi
  awsRegionValid "$region" || __failArgument "$usage" "--region $region is not a valid region" || return $?

  [ -n "$mode" ] || __failArgument "$usage" "--add, --remove, or --register is required" || return $?

  for argument in group description region; do
    if [ -z "${!argument}" ]; then
      __failArgument "$usage" "--$argument is required (${saved[*]})" || return $?
    fi
  done

  if [ "$mode" != "--remove" ]; then
    for argument in ip port; do
      [ -n "${!argument}" ] || __failArgument "$usage" "--$argument is required for $mode (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
    done
  fi

  tempErrorFile=$(mktemp) || __failEnvironment mktemp || return $?

  #
  # 3 modes: Add, Remove, Register
  #

  #
  # Remove + Register
  #
  # Fetch our current IP registered with this description
  #
  if [ "$mode" != "--add" ]; then
    __echo aws "${pp[@]+"${pp[@]}"}" ec2 describe-security-groups --region "$region" --group-id "$group" --output text --query "SecurityGroups[*].IpPermissions[*]" >"$tempErrorFile" || __failEnvironment "$usage" "aws ec2 describe-security-groups failed" || return $?
    foundIP=$(grep "$description" "$tempErrorFile" | head -1 | awk '{ print $2 }') || :
    rm -f "$tempErrorFile" || :

    if [ -z "$foundIP" ]; then
      # Remove: If no IP found in security group, if we are Removing (NOT adding), we are done
      if [ "$mode" = '--remove' ]; then
        return 0
      fi
      # Register: No IP found, add it
      mode="--add"
    elif [ "$mode" = "--register" ] && [ "$foundIP" = "$ip" ]; then
      __awwSGOutput "$(decorate success "IP already registered:")" "$foundIP" "$group" "$port"
      return 0
    else
      __awwSGOutput "$(decorate info "Removing old IP:")" "$foundIP" "$group" "$port"
      if ! aws "${pp[@]+"${pp[@]}"}" --output json ec2 revoke-security-group-ingress --region "$region" --group-id "$group" --protocol tcp --port "$port" --cidr "$foundIP" >/dev/null; then
        __failEnvironment "$usage" "revoke-security-group-ingress FAILED" || return $?
      fi
    fi
  fi
  if [ "$mode" = "--add" ]; then
    local json
    json="[{\"IpProtocol\": \"tcp\", \"FromPort\": $port, \"ToPort\": $port, \"IpRanges\": [{\"CidrIp\": \"$ip\", \"Description\": \"$description\"}]}]"
    __awwSGOutput "$(decorate info "$verb new IP:")" "$ip" "$group" "$port"
    if ! __echo aws "${pp[@]+"${pp[@]}"}" --output json ec2 authorize-security-group-ingress --region "$region" --group-id "$group" --ip-permissions "$json" >/dev/null 2>"$tempErrorFile"; then
      if grep -q "Duplicate" "$tempErrorFile"; then
        rm -f "$tempErrorFile" || :
        printf "%s %s\n" "$(decorate yellow "duplicate")" "$(reportTiming "$start" "found in")"
        return 0
      else
        wrapLines "$(decorate error "ERROR : : : : ") $(decorate code)" "$(decorate blue ": : : : ERROR")$(consoleReset)" <"$tempErrorFile" 1>&2
        rm -f "$tempErrorFile" || :
        __failEnvironment "$usage" "Failed to authorize-security-group-ingress" || return $?
      fi
    fi
  fi
  reportTiming "$start" "Completed in"
}
_awsSecurityGroupIPModify() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Helper for awsSecurityGroupIPModify
__awwSGOutput() {
  local title="$1" ip="$2" group="$3" port="$4"
  printf "%s %s %s %s %s %s\n" "$title" "$(decorate red "$foundIP")" "$(decorate label "in group-id:")" "$(decorate value "$group")" "$(decorate label "port:")" "$(decorate value "$port")"
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
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --services)
        shift || __failArgument "$usage" "missing $argument argument" || return $?
        IFS=', ' read -r -a services <<<"$1" || :
        ;;
      # IDENTICAL profileNameArgumentHandlerCase 6
      --profile)
        shift
        [ ${#pp[@]} -eq 0 ] || __failArgument "$usage" "$argument already specified: ${pp[*]}"
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
        shift || __failArgument "$usage" "missing $argument argument" || return $?
        securityGroups+=("$1")
        ;;
      --ip)
        shift || __failArgument "$usage" "missing $argument argument" || return $?
        currentIP="$1"
        ;;
      --id)
        shift || __failArgument "$usage" "missing $argument argument" || return $?
        developerId="$1"
        ;;
      *)
        break
        ;;
    esac
    shift || __failArgument "$usage" "shift failed" || return $?
  done

  buildDebugStart || :
  [ -n "$developerId" ] || __failArgument "$usage" "Empty --id or DEVELOPER_ID environment" || return $?

  [ "${#services[@]}" -gt 0 ] || __failArgument "$usage" "Supply one or more services" || return $?

  [ ${#securityGroups[@]} -gt 0 ] || __failArgument "$usage" "One or more --group is required" || return $?
  if [ -z "$currentIP" ]; then
    if ! currentIP=$(ipLookup) || [ -z "$currentIP" ]; then
      __failEnvironment "$usage" "Unable to determine IP address" || return $?
    fi
  fi
  currentIP="$currentIP/32"

  __usageEnvironment "$usage" awsInstall || return $?

  if ! awsHasEnvironment; then
  # IDENTICAL profileNameArgumentValidation 4
  if [ -z "$profileName" ]; then
    profileName="$(__usageEnvironment "$usage" buildEnvironmentGet AWS_PROFILE)" || return $?
    [ -n "$profileName" ] || profileName="default"
  fi
    ! $verboseFlag || statusMessage decorate info "Need AWS credentials: $profileName" || :
    if awsCredentialsHasProfile "$profileName"; then
      # __usageEnvironment "$usage" eval "$(awsEnvironmentFromCredentials "$profileName")" || return $?
      pp=("--profile" "$profileName")
    else
      __failEnvironment "$usage" "No AWS credentials available: $profileName" || return $?
    fi
  fi

  if [ ${#pp[@]} -eq 0 ]; then
    usageRequireEnvironment "$usage" AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_REGION || return $?
  fi

  if $verboseFlag; then
    clearLine
    if $optionRevoke; then
      bigText "Closing ..." | wrapLines "$(decorate magenta)" "$(consoleReset)"
    else
      bigText "Opening ..." | wrapLines "$(decorate blue)" "$(consoleReset)"
    fi
    local width=40

    consoleNameValue "$width" ID "$developerId" || :
    consoleNameValue "$width" IP "$currentIP" || :
    consoleNameValue "$width" "Security Groups" "${securityGroups[@]}" || :
    consoleNameValue "$width" Region "$AWS_REGION" || :
    if [ ${#pp[@]} -eq 0 ]; then
      consoleNameValue "$width" AWS_ACCESS_KEY_ID "$AWS_ACCESS_KEY_ID" || :
    else
      consoleNameValue "$width" Profile "${pp[1]}" || :
    fi
  fi
  local service
  for service in "${services[@]}"; do
    if ! isPositiveInteger "$service" && ! serviceToPort "$service" >/dev/null; then
      __failArgument "$usage" "Invalid service $(decorate code "$service")" || return $?
    fi
  done

  local securityGroupId sgArgs port
  for securityGroupId in "${securityGroups[@]}"; do
    for service in "${services[@]}"; do
      if isPositiveInteger "$service"; then
        port="$service"
      else
        port=$(serviceToPort "$service") || __failEnvironment "$usage" "serviceToPort $service failed 2nd round?" || return $?
      fi
      sgArgs=(--group "$securityGroupId" --port "$port" --description "$developerId-$service" --ip "$currentIP")
      if $optionRevoke; then
        __usageEnvironment "$usage" awsSecurityGroupIPModify "${pp[@]+"${pp[@]}"}" --remove "${sgArgs[@]}" || return $?
      else
        __usageEnvironment "$usage" awsSecurityGroupIPModify "${pp[@]+"${pp[@]}"}" --register "${sgArgs[@]}" || return $?
      fi
    done
  done
}
_awsIPAccess() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
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
