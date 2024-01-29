#!/usr/bin/env bash
#
# prettier.sh
#
# Depends: apt npm
#
# prettier install if needed
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Test: o test/tools/prettier-tools.sh
# Docs: o docs/_templates/tools/prettier.md
#

# IDENTICAL errorEnvironment 1
errorEnvironment=1

#
# Environment: BUILD_NPM_VERSION - Read-only. Default version. If not specified, uses `latest`.
# Summary: Install prettier in the build environment
# Install prettier in the build environment
# If this fails it will output the installation log.
# When this tool succeeds the `prettier` binary is available in the local operating system.
# Environment: - `BUILD_NPM_VERSION` - String. Default to `latest`. Used to install `npm -i npm@$BUILD_NPM_VERSION` on install.
# Exit Code: 1 - If installation of prettier or npm fails
# Exit Code: 0 - If npm is already installed or installed without error
# Binary: prettier.sh
# Usage: prettierInstall [ npmVersion ]
# Argument: npmVersion - Optional. String. npm version to install.
#
prettierInstall() {
  local start quietLog

  if which prettier 2>/dev/null 1>&2; then
    return 0
  fi

  start=$(beginTiming)
  if ! npmInstall "$@"; then
    return "$errorEnvironment"
  fi
  consoleInfo -n "Installing prettier ..."
  if ! quietLog=$(buildQuietLog prettierInstall); then
    return "$errorEnvironment"
  fi
  if ! npm install -g prettier >>"$quietLog" 2>&1; then
    buildFailed "$quietLog"
    return "$errorEnvironment"
  fi
  reportTiming "$start" OK
}
