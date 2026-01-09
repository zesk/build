#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# terraform-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Tag: package-install
testInstallTerraform() {
  __checkFunctionInstallsAndUninstallsBinary terraform terraformInstall terraformUninstall || return $?
}
