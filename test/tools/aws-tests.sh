#!/usr/bin/env bash
#
# aws-tests.sh
#
# AWS tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
errorEnvironment=1
errorArgument=2

_testAWSIPAccessUsage() {
  consoleError "$@"
  return "$1"
}

declare -a tests
tests+=(testAWSIPAccess)
testAWSIPAccess() {
  local quietLog=$1 id key

  usageRequireEnvironment _testAWSIPAccessUsage TEST_AWS_SECURITY_GROUP AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_REGION HOME

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
  if ! awsIPAccess --services ssh,mysql --id robot@zesk/build --ip 10.0.0.1 --group "$TEST_AWS_SECURITY_GROUP" >>"$quietLog"; then
    buildFailed "$quietLog"
    return "$errorEnvironment"
  fi
  if ! awsIPAccess --revoke --services ssh,mysql --id robot@zesk/build --ip 10.0.0.1 --group "$TEST_AWS_SECURITY_GROUP" >>"$quietLog"; then
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
  if awsIPAccess --services ssh,http --id robot@zesk/build --ip 10.0.0.1 --group "$TEST_AWS_SECURITY_GROUP" 2>/dev/null >>"$quietLog"; then
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
  if ! awsIPAccess --services ssh,http --id robot@zesk/build --ip 10.0.0.1 --group "$TEST_AWS_SECURITY_GROUP" >>"$quietLog"; then
    buildFailed "$quietLog"
    return "$errorEnvironment"
  fi
  if ! awsIPAccess --revoke --services ssh,http --id robot@zesk/build --ip 10.0.0.1 --group "$TEST_AWS_SECURITY_GROUP" >>"$quietLog"; then
    buildFailed "$quietLog"
    return "$errorEnvironment"
  fi
  reportTiming "$start" "Succeeded in"

  testSection "Generated IP and file system credentials"
  start=$(beginTiming)
  # Work using environment variables
  if ! awsIPAccess --services ssh,http --id robot@zesk/build-autoip --group "$TEST_AWS_SECURITY_GROUP" >>"$quietLog"; then
    buildFailed "$quietLog"
    return "$errorEnvironment"
  fi
  if ! awsIPAccess --revoke --services ssh,http --id robot@zesk/build-autoip --group "$TEST_AWS_SECURITY_GROUP" >>"$quietLog"; then
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

_isAWSKeyUpToDateTest() {
  local pass=$1

  shift
  if [ "$pass" = "1" ]; then
    if ! isAWSKeyUpToDate "$@"; then
      consoleError "isAWSKeyUpToDate $* should be up to date (AWS_ACCESS_KEY_DATE=${AWS_ACCESS_KEY_DATE+null})" 1>&2
      return "$errorEnvironment"
    fi
  else
    if isAWSKeyUpToDate "$@"; then
      consoleError "isAWSKeyUpToDate $* should NOT be up to date (AWS_ACCESS_KEY_DATE=${AWS_ACCESS_KEY_DATE+null})" 1>&2
      return "$errorEnvironment"
    fi
  fi
}

tests=(testAWSExpiration "${tests[@]}")
testAWSExpiration() {
  local thisYear thisMonth expirationDays start

  start=$(beginTiming)
  testSection "AWS_ACCESS_KEY_DATE/isAWSKeyUpToDate testing"
  thisYear=$(($(date +%Y) + 0))
  thisMonth="$(date +%m)"
  unset AWS_ACCESS_KEY_DATE
  _isAWSKeyUpToDateTest 0 || return $?
  export AWS_ACCESS_KEY_DATE=
  _isAWSKeyUpToDateTest 0 || consoleError "invalid $AWS_ACCESS_KEY_DATE" 1>&2 && return $?
  _isAWSKeyUpToDateTest 0 || return $?
  AWS_ACCESS_KEY_DATE=99999
  _isAWSKeyUpToDateTest 0 || consoleError "invalid $AWS_ACCESS_KEY_DATE" 1>&2 && return $?
  AWS_ACCESS_KEY_DATE=2020-01-01
  _isAWSKeyUpToDateTest 0 || consoleError "should be expired" 1>&2 && return $?
  AWS_ACCESS_KEY_DATE="$thisYear-01-01"
  expirationDays=366
  _isAWSKeyUpToDateTest 0 "$expirationDays" || return $?
  AWS_ACCESS_KEY_DATE="$((thisYear - 1))-01-01"
  expirationDays=365
  _isAWSKeyUpToDateTest 1 "$expirationDays" || return $?
  AWS_ACCESS_KEY_DATE="$thisYear-$thisMonth-01"
  _isAWSKeyUpToDateTest 1 "$expirationDays" || return $?

  AWS_ACCESS_KEY_DATE=$(yesterdayDate)
  expirationDays=0
  _isAWSKeyUpToDateTest 0 $expirationDays || return $?
  expirationDays=1
  _isAWSKeyUpToDateTest 1 $expirationDays || return $?
  expirationDays=2
  _isAWSKeyUpToDateTest 1 $expirationDays || return $?

  AWS_ACCESS_KEY_DATE=$(todayDate)
  expirationDays=0
  _isAWSKeyUpToDateTest 1 $expirationDays || return $?
  expirationDays=1
  _isAWSKeyUpToDateTest 1 $expirationDays || return $?
  expirationDays=2
  _isAWSKeyUpToDateTest 1 $expirationDays || return $?

  reportTiming "$start" Done
}
