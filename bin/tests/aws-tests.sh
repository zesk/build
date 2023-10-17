#!/usr/bin/env bash
#
# aws-tests.sh
#
# AWS tests
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
errorEnvironment=1
errorArgument=2

testAWSIPAccess() {
    local quietLog=$1 id key

    usageEnvironment TEST_AWS_SECURITY_GROUP AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_REGION HOME

    if [ -z "$quietLog" ]; then
        consoleError "testAWSIPAccess missing log"
        return $errorArgument
    fi
    if [ ! -d "$HOME" ]; then
        consoleError "No HOME defined or exists: $HOME"
        return $errorEnvironment
    fi
    if [ -d "$HOME/.aws" ]; then
        consoleError "No .aws directory should exist already"
        return $errorEnvironment
    fi

    # Work using environment variables
    testSection "CLI IP and env credentials"
    start=$(beginTiming)
    if ! bin/build/pipeline/aws-ip-access.sh --services ssh,mysql --id robot@zesk/build --ip 10.0.0.1 "$TEST_AWS_SECURITY_GROUP" >>"$quietLog"; then
        buildFailed "$quietLog"
        return "$errorEnvironment"
    fi
    if ! bin/build/pipeline/aws-ip-access.sh --revoke --services ssh,mysql --id robot@zesk/build --ip 10.0.0.1 "$TEST_AWS_SECURITY_GROUP" >>"$quietLog"; then
        buildFailed "$quietLog"
        return "$errorEnvironment"
    fi
    reportTiming "$start" "Succeeded in"

    # copy env to locals
    id=$AWS_ACCESS_KEY_ID
    key=$AWS_SECRET_ACCESS_KEY

    # delete them
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY

    testSection "CLI IP and no credentials - fails"
    start=$(beginTiming)
    if bin/build/pipeline/aws-ip-access.sh --services ssh,http --id robot@zesk/build --ip 10.0.0.1 "$TEST_AWS_SECURITY_GROUP" 2>/dev/null >>"$quietLog"; then
        buildFailed "$quietLog"
        return "$errorEnvironment"
    fi
    reportTiming "$start" "Succeeded in"

    mkdir "$HOME/.aws"
    {
        echo "[default]"
        echo "aws_access_key_id = $id"
        echo "aws_secret_access_key = $key"
    } >"$HOME/.aws/credentials"

    testSection "CLI IP and file system credentials"
    start=$(beginTiming)
    # Work using environment variables
    if ! bin/build/pipeline/aws-ip-access.sh --services ssh,http --id robot@zesk/build --ip 10.0.0.1 "$TEST_AWS_SECURITY_GROUP" >>"$quietLog"; then
        buildFailed "$quietLog"
        return "$errorEnvironment"
    fi
    if ! bin/build/pipeline/aws-ip-access.sh --revoke --services ssh,http --id robot@zesk/build --ip 10.0.0.1 "$TEST_AWS_SECURITY_GROUP" >>"$quietLog"; then
        buildFailed "$quietLog"
        return "$errorEnvironment"
    fi
    reportTiming "$start" "Succeeded in"

    testSection "Generated IP and file system credentials"
    start=$(beginTiming)
    # Work using environment variables
    if ! bin/build/pipeline/aws-ip-access.sh --services ssh,http --id robot@zesk/build-autoip "$TEST_AWS_SECURITY_GROUP" >>"$quietLog"; then
        buildFailed "$quietLog"
        return "$errorEnvironment"
    fi
    if ! bin/build/pipeline/aws-ip-access.sh --revoke --services ssh,http --id robot@zesk/build-autoip "$TEST_AWS_SECURITY_GROUP" >>"$quietLog"; then
        buildFailed "$quietLog"
        return "$errorEnvironment"
    fi
    reportTiming "$start" "Succeeded in"

    rm "$HOME/.aws/credentials"
    rmdir "$HOME/.aws"

    # restore all set for other tests
    export AWS_ACCESS_KEY_ID=$id
    export AWS_SECRET_ACCESS_KEY=$key
}

testAWSExpiration() {
    local thisYear thisMonth expirationDays start

    start=$(beginTiming)
    testSection "AWS_ACCESS_KEY_DATE/isAWSKeyUpToDate testing"
    thisYear=$(($(date +%Y) + 0))
    thisMonth="$(date +%m)"
    unset AWS_ACCESS_KEY_DATE
    if isAWSKeyUpToDate; then
        consoleError "unset AWS_ACCESS_KEY_DATE should NOT be up to date"
        return "$errorEnvironment"
    fi
    export AWS_ACCESS_KEY_DATE=
    if isAWSKeyUpToDate; then
        consoleError "blank AWS_ACCESS_KEY_DATE should NOT be up to date"
        return "$errorEnvironment"
    fi
    AWS_ACCESS_KEY_DATE=99999
    if isAWSKeyUpToDate; then
        consoleError "invalid AWS_ACCESS_KEY_DATE ($AWS_ACCESS_KEY_DATE) should NOT be up to date"
        return "$errorEnvironment"
    fi
    AWS_ACCESS_KEY_DATE=2020-01-01
    if isAWSKeyUpToDate; then
        consoleError "$AWS_ACCESS_KEY_DATE should NOT be up to date"
        return "$errorEnvironment"
    fi
    AWS_ACCESS_KEY_DATE="$thisYear-01-01"
    expirationDays=366
    if ! isAWSKeyUpToDate $expirationDays; then
        consoleError "$AWS_ACCESS_KEY_DATE should be up to date $expirationDays"
        return "$errorEnvironment"
    fi
    AWS_ACCESS_KEY_DATE="$((thisYear - 1))-01-01"
    expirationDays=365
    if isAWSKeyUpToDate $expirationDays; then
        consoleError "$AWS_ACCESS_KEY_DATE should NOT be up to date $expirationDays"
        return "$errorEnvironment"
    fi
    AWS_ACCESS_KEY_DATE="$thisYear-$thisMonth-01"
    if ! isAWSKeyUpToDate; then
        consoleError "$AWS_ACCESS_KEY_DATE should be up to date"
        return "$errorEnvironment"
    fi
    reportTiming "$start" Done
}
