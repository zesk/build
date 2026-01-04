#!/usr/bin/env bash
#
# tofu-tests.sh
#
# OpenTOFU tests
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Tag: package-install
testInstallOpenTofu() {
  __checkFunctionInstallsAndUninstallsBinary tofu tofuInstall tofuUninstall || return $?
}
