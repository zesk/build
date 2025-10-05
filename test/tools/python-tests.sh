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

# Tag: package-install
testPythonStuff() {
  local handler="returnMessage"
  local temp

  temp=$(fileTemporaryName "$handler" -d) || return $?

  assertExitCode 1 pythonPackageInstalled mkdocs || return $?
  assertExitCode 0 pythonVirtual --application "$temp" mkdocs || return $?
  assertExitCode 0 pipInstall mkdocs || return $?
  assertExitCode 0 pipUpgrade || return $?
  assertExitCode 0 pythonPackageInstalled mkdocs || return $?
  assertExitCode --stdout-match "mkdocs" 0 pipWrapper list || return $?
  assertExitCode 0 pipUninstall mkdocs || return $?
  assertExitCode 1 pythonPackageInstalled mkdocs || return $?
}
