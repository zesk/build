#!/usr/bin/env bash
#
# terraform-tests.sh
#
# Terraform tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Tag: package-install
testInstallTerraform() {
  __checkFunctionInstallsAndUninstallsBinary terraform terraformInstall terraformUninstall || return $?
}
