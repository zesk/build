#!/usr/bin/env bash
#
# yarn-tests.sh
#
# yarn tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

testYarnInstallation() {
  assertExitCode 0 nodeUninstall || return $?
  __doesScriptInstall yarn yarnInstall || return $?
  assertExitCode 0 whichExists node || return $?
}
