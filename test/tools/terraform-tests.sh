#!/usr/bin/env bash
#
# terraform-tests.sh
#
# Terraform tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

testInstallTerraform() {
  __checkFunctionInstallsAndUninstallsBinary terraform terraformInstall terraformUninstall || return $?
}
