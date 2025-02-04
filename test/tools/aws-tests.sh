#!/usr/bin/env bash
#
# aws-tests.sh
#
# AWS tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

_testAWSIPAccessUsage() {
  decorate error "$@"
  return "$1"
}

# Tag: slow
testAWSIPAccess() {
  local quietLog=$1 id key start

  local oldHome oldAWSProfile

  export HOME AWS_PROFILE

  oldAWSProfile=${AWS_PROFILE-unset}
  oldHome=$HOME

  HOME=$(__environment mktemp -d) || return $?
  usageRequireEnvironment _return TEST_AWS_SECURITY_GROUP AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_REGION HOME || return $?

  if [ -z "$quietLog" ]; then
    _argument "testAWSIPAccess missing log" || return $?
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
  if ! awsIPAccess --revoke --services 22,3306 --id robot@zesk/build --ip 10.0.0.1 --group "$TEST_AWS_SECURITY_GROUP" >>"$quietLog"; then
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
  echo "AWS_CONFIG_FILE: ${AWS_CONFIG_FILE-}"
  echo "AWS_SHARED_CREDENTIALS_FILE: ${AWS_SHARED_CREDENTIALS_FILE-}"
  echo "AWS_PROFILE: ${AWS_PROFILE-}"
  # Work using environment variables
  assertExitCode --line "$LINENO" 0 awsIPAccess --services ssh,http --id robot@zesk/build --ip 10.0.0.1 --group "$TEST_AWS_SECURITY_GROUP" || return $?
  assertExitCode --line "$LINENO" 0 awsIPAccess --revoke --services ssh,http --id robot@zesk/build --ip 10.0.0.1 --group "$TEST_AWS_SECURITY_GROUP" || return $?

  __testSection "Generated IP and file system credentials"
  # Work using environment variables
  assertExitCode --line "$LINENO" 0 awsIPAccess --services ssh,http --id robot@zesk/build-autoip --group "$TEST_AWS_SECURITY_GROUP" || return $?
  assertExitCode --line "$LINENO" 0 awsIPAccess --revoke --services ssh,http --id robot@zesk/build-autoip --group "$TEST_AWS_SECURITY_GROUP" || return $?

  rm "$HOME/.aws/credentials"
  rmdir "$HOME/.aws"

  # restore all set for other tests
  export AWS_ACCESS_KEY_ID=$id
  export AWS_SECRET_ACCESS_KEY=$key

  if [ "$oldAWSProfile" = "unset" ]; then
    unset AWS_PROFILE
  else
    AWS_PROFILE="$oldAWSProfile"
  fi
  HOME="$oldHome"
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

testAWSExpiration() {
  local thisYear thisMonth expirationDays start
  local oldDate

  oldDate="${AWS_ACCESS_KEY_DATE-NOPE}"

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

  if [ "$oldDate" = "NOPE" ]; then
    unset AWS_ACCESS_KEY_DATE
  else
    AWS_ACCESS_KEY_DATE="$oldDate"
  fi
}

testAwsRegionValid() {
  local r

  for r in us-east-1 us-east-2 us-west-1 us-west-2; do
    assertExitCode --line "$LINENO" 0 awsRegionValid "$r" || return $?
    assertNotExitCode --line "$LINENO" 0 awsRegionValid "$r" "FAKE" || return $?
  done
  assertNotExitCode --line "$LINENO" 0 awsRegionValid || return $?
  assertNotExitCode --line "$LINENO" 0 awsRegionValid bad || return $?
  assertNotExitCode --line "$LINENO" 0 awsRegionValid us-east-1000 || return $?
}

testAwsEnvironmentFromCredentials() {
  local savedHome credFile firstKey firstId year matches savedID savedKey

  export HOME AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_PROFILE
  local oldHome savedProfile

  savedProfile=${AWS_PROFILE-NONE}
  oldHome=$HOME

  savedID=${AWS_ACCESS_KEY_ID-NONE}
  savedKey=${AWS_SECRET_ACCESS_KEY-NONE}

  AWS_ACCESS_KEY_ID=
  AWS_SECRET_ACCESS_KEY=
  savedHome=$HOME

  year=$(date +%Y)
  HOME=$(__environment mktemp -d) || return $?
  # Fake home
  credFile="$HOME/.aws/credentials"

  assertNotExitCode --line "$LINENO" 0 awsHasEnvironment || return $?
  assertNotExitCode --line "$LINENO" --stderr-match awsCredentialsFile 0 awsCredentialsHasProfile || return $?

  assertNotExitCode --line "$LINENO" --stderr-match awsCredentialsFile 0 awsEnvironmentFromCredentials || return $?
  assertNotExitCode --line "$LINENO" --stderr-match AWS_ACCESS_KEY_ID --stderr-match AWS_SECRET_ACCESS_KEY 0 awsCredentialsFromEnvironment || return $?

  AWS_ACCESS_KEY_ID=
  AWS_SECRET_ACCESS_KEY=

  assertFileDoesNotExist --line "$LINENO" "$credFile" || return $?

  assertNotExitCode --line "$LINENO" --stderr-match awsCredentialsFile 0 awsEnvironmentFromCredentials || return $?
  assertNotExitCode --line "$LINENO" --stderr-match AWS_ACCESS_KEY_ID --stderr-match AWS_SECRET_ACCESS_KEY 0 awsCredentialsFromEnvironment || return $?

  assertFileDoesNotExist --line "$LINENO" "$credFile" || return $?

  AWS_ACCESS_KEY_ID=AKIAZ0123456789ABCDE
  AWS_SECRET_ACCESS_KEY="VAcpL47ZIqi3NLzsBuSImsXl4n6r9UpQpTmNz3p1"

  assertNotExitCode --line "$LINENO" --stderr-match "awsCredentialsFile" 0 awsCredentialsHasProfile || return $?
  assertNotExitCode --line "$LINENO" --stderr-match "awsCredentialsFile" 0 awsCredentialsHasProfile default || return $?

  assertExitCode --line "$LINENO" 0 awsHasEnvironment || return $?

  assertFileDoesNotExist --line "$LINENO" "$credFile" || return $?

  assertExitCode --line "$LINENO" 0 awsCredentialsFromEnvironment || return $?

  assertFileExists --line "$LINENO" "$credFile" || return $?

  assertEquals --line "$LINENO" --display "More than one [default] line in credentials" 1 $((0 + $(grep -c '\[default\]' "$credFile"))) || return $?
  assertEquals --line "$LINENO" --display "No [hello-world] line in credentials" 0 $((0 + $(grep -c '\[hello-world\]' "$credFile"))) || return $?

  assertExitCode --line "$LINENO" 0 awsCredentialsHasProfile || return $?
  assertExitCode --line "$LINENO" 0 awsCredentialsHasProfile default || return $?

  assertFileContains --line "$LINENO" "$credFile" "[default]" "$AWS_ACCESS_KEY_ID" "$AWS_SECRET_ACCESS_KEY" || return $?
  assertEquals --line "$LINENO" --display "More than one [default] line in credentials" 1 $((0 + $(grep -c '\[default\]' "$credFile"))) || return $?

  assertNotExitCode --line "$LINENO" --stderr-match "Profile" --stderr-match "exists in" 0 awsCredentialsFromEnvironment || return $?

  firstId=$AWS_ACCESS_KEY_ID
  firstKey=$AWS_SECRET_ACCESS_KEY

  AWS_ACCESS_KEY_ID=AKIAZZZZZZZZZ789ABCDE

  assertExitCode --line "$LINENO" 0 awsCredentialsFromEnvironment --force || return $?

  # dumpPipe credentials post --force <"$credFile"

  assertFileContains --line "$LINENO" "$credFile" "$AWS_ACCESS_KEY_ID" "$AWS_SECRET_ACCESS_KEY" "Removed profile default" "$year" || return $?
  assertEquals --line "$LINENO" --display "More than one [default] line in credentials" 1 $((0 + $(grep -c '\[default\]' "$credFile"))) || return $?
  assertEquals --line "$LINENO" --display "No [hello-world] line in credentials" 0 $((0 + $(grep -c '\[hello-world\]' "$credFile"))) || return $?

  assertFileDoesNotContain --line "$LINENO" "$credFile" "$firstId" || return $?

  AWS_SECRET_ACCESS_KEY="VaAaAaAaAaAaAaAaAzZBzZzZzZzZzZzZzZzZzZzZ"

  assertExitCode --line "$LINENO" 0 awsCredentialsFromEnvironment --profile hello-world || return $?

  # dumpPipe credentials post hello-world <"$credFile"

  assertFileContains --line "$LINENO" "$credFile" "[default]" "[hello-world]" "$AWS_ACCESS_KEY_ID" "$AWS_SECRET_ACCESS_KEY" || return $?

  assertEquals --line "$LINENO" --display "More than one [default] line in credentials" 1 $((0 + $(grep -c '\[default\]' "$credFile"))) || return $?
  assertEquals --line "$LINENO" --display "More than one [hello-world] line in credentials" 1 $((0 + $(grep -c '\[hello-world\]' "$credFile"))) || return $?

  assertNotExitCode --line "$LINENO" --stderr-match "Profile" --stderr-match "exists in" 0 awsCredentialsFromEnvironment --profile hello-world || return $?

  assertExitCode --line "$LINENO" 0 awsCredentialsFromEnvironment --profile hello-world --force || return $?

  # dumpPipe credentials post hello-world 2 <"$credFile"

  assertEquals --line "$LINENO" --display "More than one [default] line in credentials" 1 $((0 + $(grep -c '\[default\]' "$credFile"))) || return $?
  assertEquals --line "$LINENO" --display "More than one [hello-world] line in credentials" 1 $((0 + $(grep -c '\[hello-world\]' "$credFile"))) || return $?

  assertFileContains --line "$LINENO" "$credFile" "$firstKey" "$AWS_ACCESS_KEY_ID" "$AWS_SECRET_ACCESS_KEY" "Removed profile default" "Removed profile hello-world" "$year" '[default]' '[hello-world]' || return $?
  assertFileDoesNotContain --line "$LINENO" "$credFile" "$firstId" || return $?

  matches=(
    --stdout-match AWS_SECRET_ACCESS_KEY
    --stdout-match "$AWS_SECRET_ACCESS_KEY"
    --stdout-match AWS_ACCESS_KEY_ID
    --stdout-match "$AWS_ACCESS_KEY_ID"
  )
  __echo awsCredentialsFile
  __echo __awsCredentialsExtractProfile "hello-world" <"$(awsCredentialsFile)"
  awsEnvironmentFromCredentials hello-world | dumpPipe "awsEnvironmentFromCredentials hello-world"
  assertExitCode --line "$LINENO" "${matches[@]}" 0 awsEnvironmentFromCredentials --profile hello-world || return $?
  matches=(
    --stdout-match AWS_SECRET_ACCESS_KEY
    --stdout-match "$firstKey"
    --stdout-match AWS_ACCESS_KEY_ID
    --stdout-match "$AWS_ACCESS_KEY_ID"
  )
  awsEnvironmentFromCredentials default | dumpPipe "awsEnvironmentFromCredentials default"
  assertExitCode --line "$LINENO" "${matches[@]}" 0 awsEnvironmentFromCredentials --profile default || return $?
  HOME="$savedHome"

  if [ "$savedID" = "NONE" ]; then
    unset AWS_ACCESS_KEY_ID
  else
    AWS_ACCESS_KEY_ID=$savedID
  fi
  if [ "$savedKey" = "NONE" ]; then
    unset AWS_SECRET_ACCESS_KEY
  else
    AWS_SECRET_ACCESS_KEY=$savedKey
  fi
  if [ "$savedProfile" = "NONE" ]; then
    unset AWS_PROFILE
  else
    AWS_PROFILE=$savedProfile
  fi

}

testAWSProfiles() {
  local list firstName='test-aws' secondName='never-gonna-let-you-down'
  export HOME AWS_PROFILE
  local savedHome savedAWS_PROFILE

  savedAWS_PROFILE=${AWS_PROFILE-none}
  savedHome=$HOME
  HOME=$(__environment mktemp -d) || return $?

  list=$(__environment mktemp) || return $?

  AWS_PROFILE=

  assertExitCode --line "$LINENO" 0 awsCredentialsRemove "$firstName" || return $?

  __environment awsProfilesList >"$list" || return $?
  assertFileDoesNotContain --line "$LINENO" "$list" "$firstName" || return $?
  assertFileDoesNotContain --line "$LINENO" "$list" "$secondName" || return $?

  assertExitCode --line "$LINENO" 0 awsCredentialsAdd --profile "$firstName" AKIAZ0123456789ABCDE haaaaaaanrNGhaaaaaaanrNGhaaaaaaanrNGABYU || return $?
  # Exists
  assertNotExitCode --stderr-match 'exists in' --line "$LINENO" 0 awsCredentialsAdd --profile "$firstName" AKIAZ0123456789ABCDE haaaaaaanrNGhaaaaaaanrNGhaaaaaaanrNGABYU || return $?
  assertExitCode --line "$LINENO" 0 awsCredentialsAdd --force --profile "$firstName" AKIAZ0123456789ABCDE haaaaaaanrNGhaaaaaaanrNGhaaaaaaanrNGABYU || return $?

  __environment awsProfilesList >"$list" || return $?
  assertFileContains --line "$LINENO" "$list" "$firstName" || return $?
  assertFileDoesNotContain --line "$LINENO" "$list" "$secondName" || return $?
  assertExitCode --line "$LINENO" 0 awsCredentialsAdd --profile "$secondName" AKIAZ0123456789ABCDE haaaaaaanrNGhaaaaaaanrNGhaaaaaaanrNGABYU || return $?

  __environment awsProfilesList >"$list" || return $?
  assertFileContains --line "$LINENO" "$list" "$firstName" || return $?
  assertFileContains --line "$LINENO" "$list" "$secondName" || return $?

  assertExitCode --line "$LINENO" 0 awsCredentialsRemove "$firstName" || return $?

  __environment awsProfilesList >"$list" || return $?
  assertFileDoesNotContain --line "$LINENO" "$list" "$firstName" || return $?
  assertFileContains --line "$LINENO" "$list" "$secondName" || return $?

  assertExitCode --line "$LINENO" 0 awsCredentialsRemove "$firstName" || return $?
  decorate info removed first name

  __environment awsProfilesList >"$list" || return $?
  assertFileDoesNotContain --line "$LINENO" "$list" "$firstName" || return $?
  assertFileContains --line "$LINENO" "$list" "$secondName" || return $?

  assertExitCode --line "$LINENO" 0 awsCredentialsRemove --profile "$secondName" || return $?
  decorate info removed second name

  dumpPipe "awsProfiles saved" <"$list"
  dumpPipe "credentials" <"$(awsCredentialsFile)"
  __environment awsProfilesList >"$list" || return $?
  assertFileDoesNotContain --line "$LINENO" "$list" "$firstName" || return $?
  assertFileDoesNotContain --line "$LINENO" "$list" "$secondName" || return $?

  HOME="$savedHome"
  if [ "$savedAWS_PROFILE" != "none" ]; then
    AWS_PROFILE=$savedAWS_PROFILE
  else
    unset AWS_PROFILE
  fi
}
