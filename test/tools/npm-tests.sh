#!/usr/bin/env bash
#
# npm-tests.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

#
# Side-effect: installs and uninstalls scripts
#
testNPMInstallations() {
  # npm 18 installed in this image
  if ! whichExists npm; then
    # Part of core install in some systems, so no uninstall
    __doesScriptInstall npm npmInstall || return $?
  fi
  if ! whichExists docker-compose; then
    # Part of core install in some systems, so no uninstall
    __doesScriptInstall docker-compose dockerComposeInstall || return $?
  fi
  __doesScriptInstallUninstall prettier prettierInstall prettierUninstall || return $?
}
