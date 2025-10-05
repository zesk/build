#!/usr/bin/env bash
#
# Amazon Web Services
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__awsLoader() {
  __functionLoader __awsInstall aws "$@"
}

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
# Installs x86 or aarch64 binary based on `HOSTTYPE`.
#
# Requires: packageInstall urlFetch
awsInstall() {
  __awsLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_awsInstall() {
  # __IDENTICAL__ usageDocument 1
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
# Example:     credentials=$(awsCredentialsFile) || throwEnvironment "$handler" "No credentials file found" || return $?
# Return Code: 1 - If `$HOME` is not a directory or credentials file does not exist
# Return Code: 0 - If credentials file is found and output to stdout
#
# shellcheck disable=SC2120
awsCredentialsFile() {
  __awsLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_awsCredentialsFile() {
  # __IDENTICAL__ usageDocument 1
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
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  export AWS_ACCESS_KEY_DATE
  returnCatch "$handler" buildEnvironmentLoad AWS_ACCESS_KEY_DATE || return $?
  isUpToDate "${AWS_ACCESS_KEY_DATE-}" "$@"
}
_awsIsKeyUpToDate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# This tests `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` and if both are non-empty, returns exit code 0 (success), otherwise returns exit code 1.
# Fails if either `AWS_ACCESS_KEY_ID` or `AWS_SECRET_ACCESS_KEY` is blank
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Return Code: 0 - If environment needs to be updated
# Return Code: 1 - If the environment seems to be set already
# Environment: AWS_ACCESS_KEY_ID - Read-only. If blank, this function succeeds (environment needs to be updated)
# Environment: AWS_SECRET_ACCESS_KEY - Read-only. If blank, this function succeeds (environment needs to be updated)
# Example:     if awsHasEnvironment; then
# Example:     ...
# Example:     fi
# Summary: Test whether the AWS environment variables are set or not
#
awsHasEnvironment() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
  # shellcheck source=/dev/null
  returnCatch "$handler" buildEnvironmentLoad AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY || return $?
  [ -n "${AWS_ACCESS_KEY_ID-}" ] && [ -n "${AWS_SECRET_ACCESS_KEY-}" ]
}
_awsHasEnvironment() {
  true || awsHasEnvironment --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List AWS profiles available in the credentials file
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# See: awsCredentialsFile
awsProfilesList() {
  local handler="_${FUNCNAME[0]}"
  local file

  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  file=$(returnCatch "$handler" awsCredentialsFile --path) || return $?
  [ -f "$file" ] || return 0
  grep -e '\[[^]]*\]' "$file" | sed 's/[]\[]//g' | sort -u || :
}
_awsProfilesList() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

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
# Example:     setFile=$(fileTemporaryName "$handler") || return $?
# Example:     if awsEnvironment "$profile" > "$setFile"; then
# Example:     eval $(cat "$setFile")
# Example:     rm "$setFile"
# Example:     else
# Example:     decorate error "Need $profile profile in aws credentials file"`
# Example:     exit 1
# Example:     fi
awsEnvironmentFromCredentials() {
  __awsLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_awsEnvironmentFromCredentials() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
# Example:     setFile=$(fileTemporaryName "$handler") || return $?
# Example:     if awsEnvironment "$profile" > "$setFile"; then
# Example:     eval $(cat "$setFile")
# Example:     rm "$setFile"
# Example:     else
# Example:     decorate error "Need $profile profile in aws credentials file"`
# Example:     exit 1
# Example:     fi
awsCredentialsHasProfile() {
  __awsLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_awsCredentialsHasProfile() {
  # __IDENTICAL__ usageDocument 1
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
  __awsLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_awsCredentialsAdd() {
  # __IDENTICAL__ usageDocument 1
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
  __awsLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_awsCredentialsRemove() {
  # __IDENTICAL__ usageDocument 1
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
  local handler="_${FUNCNAME[0]}"

  __help "$handler" "$@" || return 0
  export AWS_PROFILE AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
  returnCatch "$handler" buildEnvironmentLoad AWS_PROFILE AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY || return $?
  awsHasEnvironment || throwEnvironment "$handler" "Requires AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY" || return $?
  returnCatch "$handler" awsCredentialsAdd "$@" "$AWS_ACCESS_KEY_ID" "$AWS_SECRET_ACCESS_KEY" || return $?
}
_awsCredentialsFromEnvironment() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
  __awsLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_awsSecurityGroupIPModify() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
  __awsLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_awsIPAccess() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Check an AWS region code for validity
# Checks an AWS region identifier for validity as of September 2024.
# Note that passing no parameters returns success.
# Usage: {fn} region
# Argument: region ... - String. Required. The AWS Region to validate.
# Return Code: 0 - All regions are valid AWS region
# Return Code: 1 - One or more regions are NOT a valid AWS region
# Checked: 2024-09-02
awsRegionValid() {
  local handler="_${FUNCNAME[0]}"
  [ $# -gt 0 ] || throwArgument "$handler" "Requires at least one region" || return $?
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
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
_awsRegionValid() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
