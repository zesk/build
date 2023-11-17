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
#  ▄▄    ▄▄      ▄▄   ▄▄▄▄
# ████   ██      ██ ▄█▀▀▀▀█
# ████   ▀█▄ ██ ▄█▀ ██▄
#   ██  ██   ██ ██ ██   ▀████▄
#   ██████   ███▀▀███       ▀██
#  ▄██  ██▄  ███  ███  █▄▄▄▄▄█▀
#  ▀▀    ▀▀  ▀▀▀  ▀▀▀   ▀▀▀▀▀
#
#------------------------------------------------------------------------------

#
# Get the credentials file path, optionally outputting errors
#
# awsCredentialsFile [ true ]
#
# Pass a trueish value to output warnings to stderr on failure
#
# Returns 0 if succeeds
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
    echo "$credentials"
}

#
# For security we gotta update our keys every 90 days
#
# This value would be better encrypted and tied to the AWS_ACCESS_KEY_ID so developers
# can not just update the value to avoid the security issue.
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
# Exits successfully if either AWS_ACCESS_KEY_ID or AWS_SECRET_ACCESS_KEY is blank
#
needAWSEnvironment() {
    if [ -z ${AWS_ACCESS_KEY_ID+x} ] || [ -z ${AWS_SECRET_ACCESS_KEY+x} ]; then
        return 0
    fi
    return 1
}

#
# Usage: awsEnvironment groupName
#
# Output the AWS credentials extracted for groupName
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
