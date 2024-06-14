#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh text.sh
# bin: test echo date
#

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

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
# Exit Code: if `aptInstall` fails, the exit code is returned
# Depends: apt-get
#
# shellcheck disable=SC2120
awsInstall() {
  local zipFile=awscliv2.zip
  local url buildDir quietLog

  if ! aptInstall unzip curl "$@"; then
    return "$errorEnvironment"
  fi

  if which aws >/dev/null; then
    return 0
  fi

  consoleInfo -n "Installing aws-cli ... "
  start=$(beginTiming)
  case "${HOSTTYPE-}" in
    arm64 | aarch64)
      url="https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip"
      ;;
    *)
      url="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
      ;;
  esac

  buildDir="$(buildCacheDirectory awsCache.$$)"
  quietLog="$(buildQuietLog awsInstall)"
  if ! buildDir=$(requireDirectory "$buildDir"); then
    return "$errorEnvironment"
  fi
  if ! curl -s "$url" -o "$buildDir/$zipFile" >>"$quietLog"; then
    buildFailed "$quietLog"
  fi
  if ! unzip -d "$buildDir" "$buildDir/$zipFile" >>"$quietLog"; then
    buildFailed "$quietLog"
  fi
  if ! "$buildDir/aws/install" >>"$quietLog"; then
    buildFailed "$quietLog"
  fi
  # This failed once, not sure why, .build will be deleted
  rm -rf "$buildDir" 2>/dev/null || :
  consoleValue -n "$(aws --version) "
  reportTiming "$start" OK

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
# Usage:  awsCredentialsFile [ verboseFlag ]
# Example:     if ! awsCredentialsFile 1 >/dev/null; then
# Example:     consoleError "No AWS credentials"
# Example:     exit 1
# Example:     fi
# Example:     file=$(awsCredentialsFile)
# Exit Code: 1 - If `$HOME` is not a directory or credentials file does not exist
# Exit Code: 0 - If credentials file is found and output to stdout
#
awsCredentialsFile() {
  local credentials=$HOME/.aws/credentials verbose=${1-}

  if [ ! -d "$HOME" ]; then
    if test "$verbose"; then
      consoleWarning "No $HOME directory found" 1>&2
    fi
    return "$errorEnvironment"
  fi
  if [ ! -f "$credentials" ]; then
    if test "$verbose"; then
      consoleWarning "No $credentials file found" 1>&2
    fi
    return "$errorEnvironment"
  fi
  printf %s "$credentials"
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
# Example:     if !{fn} 90; then
# Example:         bigText Failed, update key and reset date
# Example:         exit 99
# Example:     fi
# Environment: AWS_ACCESS_KEY_DATE - Read-only. Date. A `YYYY-MM-DD` formatted date which represents the date that the key was generated.
#
awsIsKeyUpToDate() {
  if ! buildEnvironmentLoad AWS_ACCESS_KEY_DATE; then
    return $errorEnvironment
  fi
  isUpToDate "${AWS_ACCESS_KEY_DATE-}" "$@"
}

#
# This tests `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` and if both are non-empty, returns exit code 0 (success), otherwise returns exit code 1.
# Fails if either AWS_ACCESS_KEY_ID or AWS_SECRET_ACCESS_KEY is blank
#
# Exit Code: 0 - If environment needs to be updated
# Exit Code: 1 - If the environment seems to be set already
# Environment: AWS_ACCESS_KEY_ID - Read-only. If blank, this function succeeds (environment needs to be updated)
# Environment: AWS_SECRET_ACCESS_KEY - Read-only. If blank, this function succeeds (environment needs to be updated)
# Example:     if awsHasEnvironment; then
# Example:    ...
# Example:     fi
# Summary: Test whether the AWS environment variables are set or not
#
awsHasEnvironment() {
  export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
  # shellcheck source=/dev/null
  if ! buildEnvironmentLoad AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY; then
    return $errorEnvironment
  fi
  [ -n "${AWS_ACCESS_KEY_ID-}" ] && [ -n "${AWS_SECRET_ACCESS_KEY-}" ]
}

#
# Load the credentials supplied from the AWS credentials file and output shell commands to set the appropriate `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` values.
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
# Example:     consoleError "Need $profile profile in aws credentials file"`
# Example:     exit 1
# Example:     fi
#
awsEnvironment() {
  local credentials groupName=${1:-default} aws_access_key_id aws_secret_access_key

  if awsCredentialsFile 1 >/dev/null; then
    credentials=$(awsCredentialsFile)
    eval "$(awk -F= '/\[/{prefix=$0; next} $1 {print prefix " " $0}' "$credentials" | grep "\[$groupName\]" | awk '{ print $2 $3 $4 }' OFS='')"
    if [ -n "${aws_access_key_id:-}" ] && [ -n "${aws_secret_access_key:-}" ]; then
      echo AWS_ACCESS_KEY_ID="${aws_access_key_id}"
      echo AWS_SECRET_ACCESS_KEY="$aws_secret_access_key"
      return 0
    fi
  fi
  return "$errorEnvironment"
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
  local argument group port description start region ip foundIP mode verb tempErrorFile
  local savedArgs
  local usage

  usage="_${FUNCNAME[0]}"

  savedArgs=("$@")

  __usageEnvironment "$usage" buildEnvironmentLoad AWS_REGION || return $?

  start=$(beginTiming) || __failEnvironment "$usage" "beginTiming" || return $?

  group=
  port=
  description=
  region="${AWS_REGION-}"
  ip=

  mode=--add
  verb="Adding (default)"

  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "Blank argument" || return $?
    case "$argument" in
      --help)
        "$usage" 0
        return $?
        ;;
      --group)
        shift || __failArgument "$usage" "Missing $argument argument" || return $?
        group="$1"
        ;;
      --port)
        shift || __failArgument "$usage" "Missing $argument argument" || return $?
        port="$1"
        ;;
      --description)
        shift || __failArgument "$usage" "Missing $argument argument" || return $?
        description="$1"
        ;;
      --ip)
        shift || __failArgument "$usage" "Missing $argument argument" || return $?
        ip="$1"
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
      --region)
        shift || _awsSecurityGroupIPModify "$errorArgument" "$argument shift failed" || return $?
        region="$1"
        ;;
      *)
        __failArgument "Unknown argument: $argument" || return $?
        ;;
    esac
    shift || __failArgument "$usage" "$errorArgument" "$argument shift failed" || return $?
  done
  [ -n "$mode" ] || __failArgument "$usage" "--add, --remove, or --register is required" || return $?

  for argument in group description region; do
    if [ -z "${!argument}" ]; then
      __failArgument "$usage" "--$argument is required (${savedArgs[*]})" || return $?
    fi
  done

  if [ "$mode" != "--remove" ]; then
    for argument in ip port; do
      [ -n "${!argument}" ] || __failArgument "$usage" "--$argument is required for $mode (${savedArgs[*]})" || return $?
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
    aws ec2 describe-security-groups --region "$region" --group-id "$group" --output text --query "SecurityGroups[*].IpPermissions[*]" >"$tempErrorFile" || __failEnvironment "$usage" "aws ec2 describe-security-groups failed" || return $?
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
      __awwSGOutput "$(consoleSuccess "IP already registered:")" "$foundIP" "$group" "$port"
      return 0
    else
      __awwSGOutput "$(consoleInfo "Removing old IP:")" "$foundIP" "$group" "$port"
      if ! aws --output json ec2 revoke-security-group-ingress --region "$region" --group-id "$group" --protocol tcp --port "$port" --cidr "$foundIP" >/dev/null; then
        __failEnvironment "$usage" "revoke-security-group-ingress FAILED" || return $?
      fi
    fi
  fi
  if [ "$mode" = "--add" ]; then
    json="[{\"IpProtocol\": \"tcp\", \"FromPort\": $port, \"ToPort\": $port, \"IpRanges\": [{\"CidrIp\": \"$ip\", \"Description\": \"$description\"}]}]"
    __awwSGOutput "$(consoleInfo "$verb new IP:")" "$ip" "$group" "$port"
    if ! aws --output json ec2 authorize-security-group-ingress --region "$region" --group-id "$group" --ip-permissions "$json" >/dev/null 2>"$tempErrorFile"; then
      if grep -q "Duplicate" "$tempErrorFile"; then
        rm -f "$tempErrorFile" || :
        printf "%s %s\n" "$(consoleYellow "duplicate")" "$(reportTiming "$start" "found in")"
        return 0
      else
        wrapLines "$(consoleError "ERROR : : : : ") $(consoleCode)" "$(consoleBlue ": : : : ERROR")$(consoleReset)" <"$tempErrorFile" 1>&2
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
  printf "%s %s %s %s %s %s\n" "$title" "$(consoleRed "$foundIP")" "$(consoleLabel "in group-id:")" "$(consoleValue "$group")" "$(consoleLabel "port:")" "$(consoleValue "$port")"
}

#
# Usage:
#
awsSecurityGroupIPRegister() {
  awsSecurityGroupIPModify --register "$@" || :
}

# Summary: Grant access to AWS security group for this IP only using Amazon IAM credentials
# Usage: {fn} --services service0,service1,... [ --profile awsProfile ] [ --id developerId ] [ --group securityGroup ] [ --ip ip ] [ --revoke ] [ --debug ] [ --help ]
# Argument: --profile awsProfile - Use this AWS profile when connecting using ~/.aws/credentials
# Argument: --services service0,service1,... - Required. List of services to add or remove (maps to ports)
# Argument: --id developerId - Optional. Specify an developer id manually (uses DEVELOPER_ID from environment by default)
# Argument: --group securityGroup - Required. String. Specify one or more security groups to modify. Format: `sg-` followed by hexadecimal characters.
# Argument: --ip ip - Optional. Specify bn IP manually (uses ipLookup tool from tools.sh by default)
# Argument: --revoke - Flag. Remove permissions
# Argument: --help - Flag. Show this help
#
# Register current IP address in listed security groups to allow for access to deployment systems from a specific IP.
# Use this during deployment to grant temporary access to your systems during deployment only.
# Build scripts should have a $(consoleCode --revoke) step afterward, always.
# services are looked up in /etc/services and match /tcp services only for port selection
#
# If no `/etc/services` matches the default values are supported within the script: `mysql`,`postgres`,`ssh`,`http`,`https`
#
# Environment: AWS_REGION - Where to update the security group
# Environment: DEVELOPER_ID - Developer used to register rules in Amazon
# Environment: AWS_ACCESS_KEY_ID - Amazon IAM ID
# Environment: AWS_SECRET_ACCESS_KEY - Amazon IAM Secret
#
awsIPAccess() {
  local argument services optionRevoke awsProfile developerId currentIP securityGroups securityGroupId
  local sgArgs
  export AWS_ACCESS_KEY_ID
  export AWS_SECRET_ACCESS_KEY
  local usage

  usage="_${FUNCNAME[0]}"

  services=()
  optionRevoke=
  awsProfile=
  currentIP=
  developerId=
  securityGroups=()

  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "Blank argument" || return $?
    case "$argument" in
      --help)
        "$usage" 0
        return $?
        ;;
      --services)
        shift || __failArgument "$usage" "Missing $argument argument" || return $?
        IFS=', ' read -r -a services <<<"$1" || :
        ;;
      --profile)
        [ -z "$awsProfile" ] || __failArgument "$usage" "$argument already specified: $awsProfile"
        shift || __failArgument "$usage" "Missing $argument argument" || return $?
        awsProfile="$1"
        ;;
      --revoke)
        optionRevoke=1
        ;;
      --group)
        shift || __failArgument "$usage" "Missing $argument argument" || return $?
        securityGroups+=("$1")
        ;;
      --ip)
        shift || __failArgument "$usage" "Missing $argument argument" || return $?
        currentIP="$1"
        ;;
      --id)
        shift || __failArgument "$usage" "Missing $argument argument" || return $?
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
  awsProfile=${awsProfile:=default}

  [ ${#securityGroups[@]} -gt 0 ] || __failArgument "$usage" "One or more --group is required" || return $?
  if [ -z "$currentIP" ]; then
    if ! currentIP=$(ipLookup) || [ -z "$currentIP" ]; then
      __failEnvironment "$usage" "Unable to determine IP address" || return $?
    fi
  fi
  currentIP="$currentIP/32"

  # shellcheck disable=SC2119
  __usageEnvironment "$usage" awsInstall || return $?

  if ! awsHasEnvironment; then
    consoleInfo "Need AWS Environment: $awsProfile" || :
    if awsEnvironment "$awsProfile" >/dev/null; then
      __usageEnvironment "$usage" eval "$(awsEnvironment "$awsProfile")" || return $?
    else
      __failEnvironment "$usage" "No AWS credentials available: $awsProfile" || return $?
    fi
  fi

  usageRequireEnvironment _awsIPAccess AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_REGION || return $?
  usageRequireBinary _awsIPAccess aws || return $?

  clearLine || :
  if test $optionRevoke; then
    bigText "Closing ..." | wrapLines "$(consoleMagenta)" "$(consoleReset)"
  else
    bigText "Opening ..." | wrapLines "$(consoleBlue)" "$(consoleReset)"
  fi
  consoleNameValue 40 ID "$developerId" || :
  consoleNameValue 40 IP "$currentIP" || :
  consoleNameValue 40 "Security Groups" "${securityGroups[@]}" || :
  consoleNameValue 40 Region "$AWS_REGION" || :
  consoleNameValue 40 AWS_ACCESS_KEY_ID "$AWS_ACCESS_KEY_ID" || :

  for s in "${services[@]}"; do
    if ! serviceToPort "$s" >/dev/null; then
      _awsIPAccess "$errorArgument" "Invalid service $s provided"
    fi
  done
  for securityGroupId in "${securityGroups[@]}"; do
    for s in "${services[@]}"; do
      port=$(serviceToPort "$s") || __failEnvironment "$usage" "serviceToPort $s failed 2nd round?" || return $?
      sgArgs=(--group "$securityGroupId" --port "$port" --description "$developerId-$s" --ip "$currentIP")
      if test $optionRevoke; then
        __usageEnvironment "$usage" awsSecurityGroupIPModify --remove "${sgArgs[@]}" || return $?
      else
        __usageEnvironment "$usage" awsSecurityGroupIPRegister "${sgArgs[@]}" || return $?
      fi
    done
  done
  buildDebugStop || :
}
_awsIPAccess() {
  buildDebugStop || :
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} region
# Argument: region - The AWS Region to validate
# Exit Code: 0 - Region is a valid AWS region
# Exit Code: 1 - Region is NOT a valid AWS region
# Checked: 2023-12-31
awsValidRegion() {
  case "${1-}" in
    eu-north-1) return 0 ;;
    eu-central-1) return 0 ;;
    eu-west-1 | eu-west-2 | eu-west-3) return 0 ;;
    ap-south-1) return 0 ;;
    ap-southeast-1 | ap-southeast-2) return 0 ;;
    ap-northeast-3 | ap-northeast-2 | ap-northeast-1) return 0 ;;
    ca-central-1) return 0 ;;
    sa-east-1) return 0 ;;
    us-east-1 | us-east-2 | us-west-1 | us-west-2) return 0 ;;
  esac
  return 1
}
