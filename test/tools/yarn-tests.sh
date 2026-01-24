#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# yarn-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Tag: package-install
testYarnInstallation() {
  if executableExists yarn; then
    decorate warning "Yarn is already installed, skipping"
    return 0
  fi
  assertExitCode 0 nodeUninstall || return $?
  __checkFunctionInstallsBinary yarn yarnInstall || return $?
  assertExitCode 0 executableExists node || return $?
}
