#!/usr/bin/env bash
#
# npm-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

#
# Side-effect: installs and uninstalls scripts
#
testNPMInstallations() {
  # npm 18 installed in this image
  if ! whichExists npm; then
    # Part of core install in some systems, so no uninstall
    __checkFunctionInstallsBinary npm npmInstall || return $?
  fi
  if ! whichExists docker-compose; then
    # Part of core install in some systems, so no uninstall
    __checkFunctionInstallsBinary docker-compose dockerComposeInstall || return $?
  fi
}
