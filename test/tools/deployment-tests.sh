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

tests+=(deployRemoteFinish)
testDeployRemoteFinish() {
  return 0
}

tests+=(testDeployBuildEnvironment)
testDeployBuildEnvironment() {
  return 0
}
