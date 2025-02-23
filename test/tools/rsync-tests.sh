#!/usr/bin/env bash
#
# rsync-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Tag: package-install
testRsyncInstall() {
  rsyncInstall rsync || return $?
}
