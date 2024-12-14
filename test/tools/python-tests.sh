#!/usr/bin/env bash
#
# python-tests.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

testPythonInstallation() {
  __doesScriptInstallUninstall python pythonInstall pythonUninstall || return $?
}
