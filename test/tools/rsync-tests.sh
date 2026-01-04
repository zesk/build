#!/usr/bin/env bash
#
# rsync-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Tag: package-install
testRsyncInstall() {
  __checkFunctionInstallsBinary rsync rsyncInstall || return $?
}
