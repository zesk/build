#!/usr/bin/env bash
#
# node-tests.sh
#
# node tests
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Tag: package-install
testNodeInstallation() {
  __checkFunctionInstallsAndUninstallsPackage nodejs nodeInstall nodeUninstall || return $?
}
