#!/usr/bin/env bash
#
# python-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Tag: package-install
testPythonInstallation() {
  __checkFunctionInstallsAndUninstallsBinary python pythonInstall pythonUninstall || return $?
}
