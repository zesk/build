#!/usr/bin/env bash
#
# aws-tests.sh
#
# AWS tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

_testAWSIPAccessUsage() {
  consoleError "$@"
  return "$1"
}

declare -a tests
tests+=(testAWSIPAccess)
testAWSIPAccess() {
  local quietLog=$1 id key start

  usageRequireEnvironment _return TEST_AWS_SECURITY_GROUP AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_REGION HOME || return $?

  if [ -z "$quietLog" ]; then
    _argument "testAWSIPAccess missing log" || return $?
  fi
  if [ ! -d "$HOME" ]; then
    _environment "No HOME defined or exists: $HOME" || return $?
  fi
  if [ -d "$HOME/.aws" ]; then
    _environment "No .aws directory should exist already" || return $?
  fi

  # Work using environment variables
  __testSection "CLI IP and env credentials"
  start=$(beginTiming)
  if ! awsIPAccess --services ssh,mysql --id robot@zesk/build --ip 10.0.0.1 --group "$TEST_AWS_SECURITY_GROUP" >>"$quietLog"; then
    buildFailed "$quietLog" || return $?
  fi
  if ! awsIPAccess --revoke --services ssh,mysql --id robot@zesk/build --ip 10.0.0.1 --group "$TEST_AWS_SECURITY_GROUP" >>"$quietLog"; then
    buildFailed "$quietLog" || return $?
  fi
  reportTiming "$start" "Succeeded in"

  # copy env to locals
  id=$AWS_ACCESS_KEY_ID
  key=$AWS_SECRET_ACCESS_KEY

  # delete them
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY

  __testSection "CLI IP and no credentials - fails"
  start=$(beginTiming)
  if awsIPAccess --services ssh,http --id robot@zesk/build --ip 10.0.0.1 --group "$TEST_AWS_SECURITY_GROUP" >>"$quietLog"; then
    buildFailed "$quietLog" || return $?
  fi
  reportTiming "$start" "Succeeded in"

  mkdir "$HOME/.aws"
  {
    echo "[default]"
    echo "aws_access_key_id = $id"
    echo "aws_secret_access_key = $key"
  } >"$HOME/.aws/credentials"

  __testSection "CLI IP and file system credentials"
  start=$(beginTiming)
  # Work using environment variables
  if ! __echo awsIPAccess --services ssh,http --id robot@zesk/build --ip 10.0.0.1 --group "$TEST_AWS_SECURITY_GROUP" >>"$quietLog"; then
    buildFailed "$quietLog" || return $?
  fi
  if ! __echo awsIPAccess --revoke --services ssh,http --id robot@zesk/build --ip 10.0.0.1 --group "$TEST_AWS_SECURITY_GROUP" >>"$quietLog"; then
    buildFailed "$quietLog" || return $?
  fi
  reportTiming "$start" "Succeeded in"

  __testSection "Generated IP and file system credentials"
  start=$(beginTiming)
  # Work using environment variables
  if ! __echo awsIPAccess --services ssh,http --id robot@zesk/build-autoip --group "$TEST_AWS_SECURITY_GROUP" >>"$quietLog"; then
    buildFailed "$quietLog" || return $?
  fi
  if ! __echo awsIPAccess --revoke --services ssh,http --id robot@zesk/build-autoip --group "$TEST_AWS_SECURITY_GROUP" >>"$quietLog"; then
    buildFailed "$quietLog" || return $?
  fi
  reportTiming "$start" "Succeeded in"

  rm "$HOME/.aws/credentials"
  rmdir "$HOME/.aws"

  # restore all set for other tests
  export AWS_ACCESS_KEY_ID=$id
  export AWS_SECRET_ACCESS_KEY=$key

  unset BUILD_DEBUG
}

_isAWSKeyUpToDateTest() {
  local line=$1 pass=$2

  shift 2 || :

  if [ "$pass" = "true" ]; then
    assertExitCode --line "$line" 0 awsIsKeyUpToDate "$@" || return $?
  else
    assertNotExitCode --line "$line" --stderr-ok 0 awsIsKeyUpToDate "$@" || return $?
  fi
}

tests=(testAWSExpiration "${tests[@]}")
testAWSExpiration() {
  local thisYear thisMonth expirationDays start
  local oldDate

  oldDate="${AWS_ACCESS_KEY_DATE-}"

  start=$(beginTiming)
  __testSection "AWS_ACCESS_KEY_DATE/awsIsKeyUpToDate testing"
  thisYear=$(($(date +%Y) + 0))
  thisMonth="$(date +%m)"

  __testSection null AWS_ACCESS_KEY_DATE
  unset AWS_ACCESS_KEY_DATE
  _isAWSKeyUpToDateTest "$LINENO" false || return $?

  __testSection blank AWS_ACCESS_KEY_DATE
  export AWS_ACCESS_KEY_DATE=
  _isAWSKeyUpToDateTest "$LINENO" false || return $?

  __testSection bad AWS_ACCESS_KEY_DATE
  AWS_ACCESS_KEY_DATE=99999
  _isAWSKeyUpToDateTest "$LINENO" false || return $?

  __testSection OLD AWS_ACCESS_KEY_DATE
  AWS_ACCESS_KEY_DATE=2020-01-01
  _isAWSKeyUpToDateTest "$LINENO" false || return $?

  __testSection THIS-01-01 366
  AWS_ACCESS_KEY_DATE="$thisYear-01-01"
  expirationDays=366
  _isAWSKeyUpToDateTest "$LINENO" true "$expirationDays" || return $?

  __testSection LAST-01-01 365
  AWS_ACCESS_KEY_DATE="$((thisYear - 1))-01-01"
  expirationDays=365
  _isAWSKeyUpToDateTest "$LINENO" false "$expirationDays" || return $?

  __testSection THIS-THIS-01 365
  AWS_ACCESS_KEY_DATE="$thisYear-$thisMonth-01"
  _isAWSKeyUpToDateTest "$LINENO" true "$expirationDays" || return $?

  __testSection yesterdayDate 0
  AWS_ACCESS_KEY_DATE=$(yesterdayDate)
  expirationDays=0
  _isAWSKeyUpToDateTest "$LINENO" false $expirationDays || return $?

  __testSection yesterdayDate 1
  expirationDays=1
  _isAWSKeyUpToDateTest "$LINENO" true $expirationDays || return $?

  __testSection yesterdayDate 2
  expirationDays=2
  _isAWSKeyUpToDateTest "$LINENO" true $expirationDays || return $?

  AWS_ACCESS_KEY_DATE=$(todayDate)

  expirationDays=0
  __testSection todayDate $expirationDays
  _isAWSKeyUpToDateTest "$LINENO" true $expirationDays || return $?
  expirationDays=1
  __testSection todayDate $expirationDays
  _isAWSKeyUpToDateTest "$LINENO" true $expirationDays || return $?
  expirationDays=2
  __testSection todayDate $expirationDays
  _isAWSKeyUpToDateTest "$LINENO" true $expirationDays || return $?

  reportTiming "$start" Done

  AWS_ACCESS_KEY_DATE="$oldDate"
}
