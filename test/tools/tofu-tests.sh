#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# tofu-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# OpenTOFU tests
#

# Tag: package-install
testInstallOpenTofu() {
  __checkFunctionInstallsAndUninstallsBinary tofu tofuInstall tofuUninstall || return $?
}
