#!/usr/bin/env bash
#
# deploy-tests.sh
#
# Deploy tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
declare -a tests
tests+=(testDeployToRemote)

testDeployToRemote() {
  return 0
}

tests+=(testDeployRemoteFinish)
testDeployRemoteFinish() {
  return 0
}

tests+=(testDeployBuildEnvironment)
testDeployBuildEnvironment() {
  local d args matches

  d=$(mktemp -d)
  __environment pushd "$d" >/dev/null || return $?

  assertExitCode --stderr-match "blank" 2 deployBuildEnvironment --id || return $?

  assertExitCode --stdout-match "deployBuildEnvironment" 0 deployBuildEnvironment --help || return $?

  assertExitCode --stderr-match "blank" 2 deployBuildEnvironment "" --id || return $?

  assertExitCode --stderr-match "APPLICATION_ID" 2 deployBuildEnvironment || return $?

  local sampleHome sampleId sampleHosts

  sampleHome=/var/DEPLOY
  sampleApplication=/var/app
  sampleId=abcdef

  args=(--id "$sampleId")
  matches=(--stderr-match home --stderr-match non-blank --stderr-match "DEPLOY_REMOTE_PATH")
  assertExitCode "${matches[@]}" 2 deployBuildEnvironment "${args[@]}" || return $?
  APPLICATION_ID="$sampleId" assertExitCode "${matches[@]}" 2 deployBuildEnvironment || return $?

  args=(--id "$sampleId" --home "$sampleHome")
  matches=(--stderr-match home --stderr-match non-blank --stderr-match "APPLICATION_REMOTE_PATH")
  assertExitCode "${matches[@]}" 2 deployBuildEnvironment "${args[@]}" || return $?
  DEPLOY_REMOTE_PATH="$sampleHome" APPLICATION_ID="$sampleId" assertExitCode "${matches[@]}" 2 deployBuildEnvironment || return $?

  args=(--id "$sampleId" --home "$sampleHome" --application "$sampleApplication")
  matches=(--stderr-match "user hosts" --stderr-match non-blank --stderr-match "DEPLOY_USER_HOSTS")
  assertExitCode "${matches[@]}" 2 deployBuildEnvironment "${args[@]}" || return $?
  APPLICATION_REMOTE_PATH="$sampleApplication" DEPLOY_REMOTE_PATH="$sampleHome" APPLICATION_ID="$sampleId"  assertExitCode "${matches[@]}" 2 deployBuildEnvironment || return $?
}
  args=(--id "$sampleId" --home "$sampleHome" --application "$sampleApplication" --host "www-data@remote0" --host "www-data@remote1")
  matches=(--stderr-match "user hosts" --stderr-match non-blank --stderr-match "DEPLOY_USER_HOSTS")
  assertExitCode "${matches[@]}" 2 deployBuildEnvironment "${args[@]}" || return $?

  DEPLOY_USER_HOSTS="www-data@remote0 www-data@remote1" APPLICATION_REMOTE_PATH="$sampleApplication" DEPLOY_REMOTE_PATH="$sampleHome" APPLICATION_ID="$sampleId" assertExitCode "${matches[@]}" 2 deployBuildEnvironment || return $?
}
