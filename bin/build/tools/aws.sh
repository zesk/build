#!/usr/bin/env bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Depends: colors.sh text.sh
# bin: test echo date
#
errorEnvironment=1

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
    if ! requireDirectory "$buildDir"; then
        return "$errorEnvironment"
    fi
    if ! requireFileDirectory "$quietLog"; then
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
# Pass a trueish value to output warnings to stderr on failure
#
# Pass any value to output warnings if the environment or file is not found; otherwise
# output the credentials file path.
#
# If not found, returns with exit code 1.
#
# Short Description: Get the path to the AWS credentials file
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
# Short Description: Test whether the AWS keys do not need to be updated
# Usage: isAWSKeyUpToDate upToDateDays
# Example:     if !isAWSKeyUpToDate 90; then
# Example:     bigText Failed, update key and reset date
# Example:     exit 99
# Example:     fi
# Environment: AWS_ACCESS_KEY_DATE - Read-only. Date. A `YYYY-MM-DD` formatted date which represents the date that the key was generated.
#
isAWSKeyUpToDate() {
    local upToDateDays=${1:-90} accessKeyTimestamp todayTimestamp deltaDays maxDays daysAgo pluralDays

    if [ -z "${AWS_ACCESS_KEY_DATE:-}" ]; then
        return 1
    fi
    shift
    maxDays=366
    upToDateDays=$((upToDateDays + 0))
    if [ $upToDateDays -gt $maxDays ]; then
        consoleError "isAWSKeyUpToDate $upToDateDays - values not allowed greater than $maxDays" 1>&2
        return 1
    fi
    if [ $upToDateDays -le 0 ]; then
        consoleError "isAWSKeyUpToDate $upToDateDays - negative or zero values not allowed" 1>&2
        return 1
    fi
    if ! dateToTimestamp "$AWS_ACCESS_KEY_DATE" >/dev/null; then
        consoleError "Invalid date $AWS_ACCESS_KEY_DATE" 1>&2
        return 1
    fi
    accessKeyTimestamp=$(($(dateToTimestamp "$AWS_ACCESS_KEY_DATE") + 0))

    todayTimestamp=$(($(date +%s) + 0))
    deltaDays=$(((todayTimestamp - accessKeyTimestamp) / 86400))
    daysAgo=$((deltaDays - upToDateDays))
    if [ $daysAgo -gt 0 ]; then
        pluralDays=$(plural $daysAgo day days)
        consoleError "Access key expired $AWS_ACCESS_KEY_DATE, $daysAgo $pluralDays" 1>&2
        return 1
    fi
    daysAgo=$((-daysAgo))
    pluralDays=$(plural $daysAgo day days)
    if [ $daysAgo -lt 14 ]; then
        bigText "$daysAgo $pluralDays" | prefixLines "$(consoleError)"
    fi
    if [ $daysAgo -lt 30 ]; then
        consoleWarning "Access key expires on $AWS_ACCESS_KEY_DATE, in $daysAgo $pluralDays"
        return 0
    fi
    return 0
}

#
# This tests `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` and if either is empty, returns exit code 0 (success), otherwise returns exit code 1.
# Exits successfully if either AWS_ACCESS_KEY_ID or AWS_SECRET_ACCESS_KEY is blank
#
# Exit Code: 0 - If environment needs to be updated
# Exit Code: 1 - If the environment seems to be set already
# Environment: AWS_ACCESS_KEY_ID - Read-only. If blank, this function succeeds (enironment needs to be updated)
# Environment: AWS_SECRET_ACCESS_KEY - Read-only. If blank, this function succeeds (enironment needs to be updated)
# Example:     if needAWSEnvironment; then
# Example:    ...
# Example:     fi
# Short Description: Test whether the AWS environment variables are set or not
#
needAWSEnvironment() {
    export AWS_ACCESS_KEY_ID
    export AWS_SECRET_ACCESS_KEY
    if [ -z ${AWS_ACCESS_KEY_ID+x} ] || [ -z ${AWS_SECRET_ACCESS_KEY+x} ]; then
        return 0
    fi
    return 1
}

#
# Load the credentials supplied from the AWS credentials file and output shell commands to set the appropriate `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` values.
#
# If the AWS credentials file is not found, returns exit code 1 and outputs nothing.
# If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.
#
# Short Description: Get credentials and output environment variables for AWS authentication
# Usage: awsEnvironment profileName
# Argument: profileName - The credentials profile to load (default value is `default` and loads section identified by `[default]` in `~/.aws/credentials`)
# Example:     setFile=$(mktemp)
# Example:     if awsEnvironment "$profile" > "$setFile"; then
# Example:     eval $(cat "$setFile")
# Example:     rm "$setFile"
# Example:     else
# Example:     consoleError "Need $profile profile in aws credentials file"
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
