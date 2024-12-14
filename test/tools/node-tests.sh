#!/usr/bin/env bash
#
# node-tests.sh
#
# node tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

testNodeInstallation() {
  __doesScriptInstallUninstall node nodeInstall nodeUninstall || return $?
}
