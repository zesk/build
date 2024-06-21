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

  usageRequireEnvironment _testAWSIPAccessUsage TEST_AWS_SECURITY_GROUP AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_REGION HOME

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
  testSection "CLI IP and env credentials"
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

  testSection "CLI IP and no credentials - fails"
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

  testSection "CLI IP and file system credentials"
  start=$(beginTiming)
  # Work using environment variables
  if ! awsIPAccess --services ssh,http --id robot@zesk/build --ip 10.0.0.1 --group "$TEST_AWS_SECURITY_GROUP" >>"$quietLog"; then
    buildFailed "$quietLog" || return $?
  fi
  if ! awsIPAccess --revoke --services ssh,http --id robot@zesk/build --ip 10.0.0.1 --group "$TEST_AWS_SECURITY_GROUP" >>"$quietLog"; then
    buildFailed "$quietLog" || return $?
  fi
  reportTiming "$start" "Succeeded in"

  testSection "Generated IP and file system credentials"
  start=$(beginTiming)
  # Work using environment variables
  if ! awsIPAccess --services ssh,http --id robot@zesk/build-autoip --group "$TEST_AWS_SECURITY_GROUP" >>"$quietLog"; then
    buildFailed "$quietLog" || return $?
  fi
  if ! awsIPAccess --revoke --services ssh,http --id robot@zesk/build-autoip --group "$TEST_AWS_SECURITY_GROUP" >>"$quietLog"; then
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
  local pass=$1

  shift || :
  if [ "$pass" = "1" ]; then
    if ! awsIsKeyUpToDate "$@"; then
      _environment "awsIsKeyUpToDate $* should be up to date (AWS_ACCESS_KEY_DATE=${AWS_ACCESS_KEY_DATE-null})" || return $?
    fi
    printf "%s\n" "$(consoleSuccess "Success: ")$(consoleCode "awsIsKeyUpToDate $*")"
  else
    if awsIsKeyUpToDate "$@"; then
      _environment "awsIsKeyUpToDate $* should NOT be up to date (AWS_ACCESS_KEY_DATE=${AWS_ACCESS_KEY_DATE-null})" || return $?
    fi
    printf "%s\n" "$(consoleSuccess "Correctly failed: ")$(consoleCode "awsIsKeyUpToDate $*")"
  fi
}

tests=(testAWSExpiration "${tests[@]}")
testAWSExpiration() {
  local thisYear thisMonth expirationDays start
  local oldDate

  oldDate="${AWS_ACCESS_KEY_DATE-}"

  start=$(beginTiming)
  testSection "AWS_ACCESS_KEY_DATE/awsIsKeyUpToDate testing"
  thisYear=$(($(date +%Y) + 0))
  thisMonth="$(date +%m)"

  testSection null AWS_ACCESS_KEY_DATE
  unset AWS_ACCESS_KEY_DATE
  _isAWSKeyUpToDateTest 0 || return $?

  testSection blank AWS_ACCESS_KEY_DATE
  export AWS_ACCESS_KEY_DATE=
  _isAWSKeyUpToDateTest 0 || return $?

  testSection bad AWS_ACCESS_KEY_DATE
  AWS_ACCESS_KEY_DATE=99999
  _isAWSKeyUpToDateTest 0 || return $?

  testSection OLD AWS_ACCESS_KEY_DATE
  AWS_ACCESS_KEY_DATE=2020-01-01
  _isAWSKeyUpToDateTest 0 || return $?

  testSection THIS-01-01 366
  AWS_ACCESS_KEY_DATE="$thisYear-01-01"
  expirationDays=366
  _isAWSKeyUpToDateTest 1 "$expirationDays" || return $?

  testSection LAST-01-01 365
  AWS_ACCESS_KEY_DATE="$((thisYear - 1))-01-01"
  expirationDays=365
  _isAWSKeyUpToDateTest 0 "$expirationDays" || return $?

  testSection THIS-THIS-01 365
  AWS_ACCESS_KEY_DATE="$thisYear-$thisMonth-01"
  _isAWSKeyUpToDateTest 1 "$expirationDays" || return $?

  testSection yesterdayDate 0
  AWS_ACCESS_KEY_DATE=$(yesterdayDate)
  expirationDays=0
  _isAWSKeyUpToDateTest 0 $expirationDays || return $?

  testSection yesterdayDate 1
  expirationDays=1
  _isAWSKeyUpToDateTest 1 $expirationDays || return $?

  testSection yesterdayDate 2
  expirationDays=2
  _isAWSKeyUpToDateTest 1 $expirationDays || return $?

  AWS_ACCESS_KEY_DATE=$(todayDate)

  expirationDays=0
  testSection todayDate $expirationDays
  _isAWSKeyUpToDateTest 1 $expirationDays || return $?
  expirationDays=1
  testSection todayDate $expirationDays
  _isAWSKeyUpToDateTest 1 $expirationDays || return $?
  expirationDays=2
  testSection todayDate $expirationDays
  _isAWSKeyUpToDateTest 1 $expirationDays || return $?

  reportTiming "$start" Done

  AWS_ACCESS_KEY_DATE="$oldDate"
}
