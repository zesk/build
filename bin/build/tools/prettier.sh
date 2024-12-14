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
  local quietLog start

  if whichExists prettier; then
    return 0
  fi

  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  statusMessage decorate info "Installing npm (to get prettier) ... " || return $?
  local home
  home=$(__usageEnvironment "$usage" buildHome) || return $?
  __usageEnvironment "$usage" nodePackageManagerInstall "$@" || return $?
  quietLog=$(__usageEnvironment "$usage" buildQuietLog "$usage") || return $?
  __usageEnvironment "$usage" muzzle pushd "$home" || return $?
  statusMessage decorate info "Installing prettier ... " ||
    __usageEnvironmentQuiet "$usage" "$quietLog" nodePackageManager install -g prettier || _undo $? muzzle popd || return $?
  __usageEnvironment "$usage" muzzle popd || return $?
  __usageEnvironment "$usage" rm -rf "$quietLog" || return $?
  statusMessage reportTiming "$start" "Installed prettier in" || return $?
}
_prettierInstall() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Uninstall the `prettier` binary using `NODE_PACKAGE_MANAGER`
# Environment: NODE_PACKAGE_MANAGER
prettierUninstall() {
  if ! whichExists npm; then
    return 0
  fi
  if ! whichExists prettier; then
    return 0
  fi
  local usage="_${FUNCNAME[0]}"

  local quietLog start
  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  local home
  home=$(__usageEnvironment "$usage" buildHome) || return $?
  # TODO: Should statusMessage fail everything? No effect on outcome.
  statusMessage --first decorate info "Removing prettier ... " || return $?
  quietLog=$(__usageEnvironment "$usage" buildQuietLog "$usage") || return $?
  __usageEnvironment "$usage" muzzle pushd "$home" || return $?
  __usageEnvironmentQuiet "$usage" "$quietLog" nodePackageManager uninstall -g prettier || _undo $? muzzle popd || return $?
  __usageEnvironment "$usage" muzzle popd || return $?
  __usageEnvironment "$usage" rm -rf "$quietLog" || return $?
  statusMessage --last reportTiming "$start" "removed in" || return $?
}
_prettierUninstall() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
