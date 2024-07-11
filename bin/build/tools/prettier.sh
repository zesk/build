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
  local quietLog

  if whichExists prettier; then
    return 0
  fi

  statusMessage consoleInfo "Installing npm (to get prettier) ... " || :
  __usageEnvironment "$usage" npmInstall "$@" || return $?
  quietLog=$(__usageEnvironment "$usage" buildQuietLog "$usage") || return $?
  statusMessage consoleInfo "Installing prettier ... " || :
  __usageEnvironmentQuiet "$usage" "$quietLog" npm install -g prettier || return $?
  rm -f "$quietLog" || :
  clearLine || :
}
_prettierInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

prettierUninstall() {
  local usage="_${FUNCNAME[0]}"
  local quietLog

  if ! whichExists npm; then
    return 0
  fi
  if ! whichExists prettier; then
    return 0
  fi
  statusMessage consoleInfo "Removing prettier ... " || :
  quietLog=$(__usageEnvironment "$usage" buildQuietLog "$usage") || return $?
  __usageEnvironmentQuiet "$usage" "$quietLog" npm uninstall -g prettier || return $?
  rm -rf "$quietLog" || :
  clearLine || :
}
_prettierUninstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
