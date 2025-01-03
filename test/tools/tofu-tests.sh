#!/usr/bin/env bash
#
# tofu-tests.sh
#
# OpenTOFU tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testInstallOpenTofu() {
  __checkFunctionInstallsAndUninstallsBinary tofu tofuInstall tofuUninstall || return $?
}
