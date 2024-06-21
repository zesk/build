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
  local usage="_${FUNCNAME[0]}"
  local start quietLog

  if which prettier 2>/dev/null 1>&2; then
    return 0
  fi

  start=$(beginTiming) || __failEnvironment "$usage" beginTiming || return $?
  __usageEnvironment "$usage" npmInstall "$@" || return $?
  consoleInfo -n "Installing prettier ... " || :
  quietLog=$(buildQuietLog "$usage") || __failEnvironment "$usage" buildQuietLog "$usage" || return $?
  __usageEnvironment "$usage" npm install -g prettier >>"$quietLog" 2>&1 || buildFailed "$quietLog" || return $?
  reportTiming "$start" OK
}
_prettierInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
