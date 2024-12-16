#!/usr/bin/env bash
#
# yarn-tests.sh
#
# yarn tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

testYarnInstallation() {
  if whichExists yarn; then
    decorate warning "Yarn is already installed, skipping"
    return 0
  fi
  assertExitCode 0 nodeUninstall || return $?
  __checkFunctionInstallsBinary yarn yarnInstall || return $?
  assertExitCode 0 whichExists node || return $?
}
