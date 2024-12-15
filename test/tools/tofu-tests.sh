#!/usr/bin/env bash
#
# tofu-tests.sh
#
# OpenTOFU tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

testInstallOpenTofu() {
  __checkFunctionInstallsAndUninstallsBinary tofu tofuInstall tofuUninstall || return $?
}
