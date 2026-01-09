#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# rsync-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Tag: package-install
testRsyncInstall() {
  __checkFunctionInstallsBinary rsync rsyncInstall || return $?
}
