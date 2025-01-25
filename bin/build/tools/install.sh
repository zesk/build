#!/usr/bin/env bash
#
# npm functions
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Depends: colors.sh os.sh apt.sh
# bin: npm
# Binary paths are at bin/build/install
#

# Install `mariadb`
#
# If this fails it will output the installation log.
#
# Usage: mariadbInstall [ package ]
# Usage: {fn} [ package ... ]
# Argument: package - Additional packages to install
# Summary: Install `mariadb`
# When this tool succeeds the `mariadb` binary is available in the local operating system.
# Environment: - `BUILD_NPM_VERSION` - String. Default to `latest`. Used to install `npm -i npm@$BUILD_NPM_VERSION` on install.
# Exit Code: 1 - If installation fails
# Exit Code: 0 - If installation succeeds
# Binary: mariadb-client.sh
#
mariadbInstall() {
  packageWhich mariadb mariadb-common mariadb-client "$@"
}

# Uninstall mariadb
mariadbUninstall() {
  packageWhichUninstall mariadb mariadb-common mariadb-client "$@"
}

# Install `python`
#
# If this fails it will output the installation log.
#
# Usage: {fn} [ package ]
# Argument: package - Additional packages to install
# Summary: Install `python`
# When this tool succeeds the `python` binary is available in the local operating system.
# Exit Code: 1 - If installation fails
# Exit Code: 0 - If installation succeeds
# Binary: python.sh
#
pythonInstall() {
  packageWhich python python-is-python3 python3 python3-pip "$@"
}

# Uninstall python
pythonUninstall() {
  packageWhichUninstall python python-is-python3 python3 python3-pip "$@"
}

# Utility to install python dependencies via pip
# Usage: {fn} pipPackage [ ... additional packages ]
_pipInstall() {
  local usage="${1-}"
  local quietLog start name

  shift
  name="$(usageArgumentString "$usage" "name" "${1-}")"
  shift
  if whichExists "$name"; then
    return 0
  fi
  start=$(__catchEnvironment "$usage" beginTiming) || return $?
  quietLog=$(__catchEnvironment "$usage" buildQuietLog "$usage") || return $?
  __catchEnvironment "$usage" pythonInstall || return $?
  statusMessage decorate info "Installing $name ... "
  __catchEnvironmentQuiet "$usage" "$quietLog" pip install "$name" "$@" || return $?
  whichExists "$name" || __throwEnvironment "$usage" "$name not found after install" || return $?
  statusMessage --last reportTiming "$start" "Installed $name in"
}

# Utility to install python dependencies via pip
# Usage: {fn} pipPackage [ ... additional packages ]
_pipUninstall() {
  local usage="${1-}"
  local quietLog start

  shift
  name="$(usageArgumentString "$usage" "name" "${1-}")"
  shift
  if ! whichExists "$name"; then
    return 0
  fi
  packageWhich pip python3-pip || __throwEnvironment "$usage" "Need pip to uninstall - not found?" || return $?
  start=$(__catchEnvironment "$usage" beginTiming) || return $?
  quietLog=$(__catchEnvironment "$usage" buildQuietLog "$usage") || return $?
  statusMessage decorate info "Removing $name ... "
  __catchEnvironmentQuiet "$usage" "$quietLog" pip uninstall "$name" || return $?
  ! whichExists "$name" || __throwEnvironment "$usage" "$name was still found after uninstall" || return $?
  statusMessage --last reportTiming "$start" "Uninstalled $name in"
}

# Install `docker-compose`
#
# If this fails it will output the installation log.
#
# Usage: {fn} [ package ... ]
# Argument: package - Additional packages to install (using apt)
# Summary: Install `docker-compose`
# When this tool succeeds the `docker-compose` binary is available in the local operating system.
# Exit Code: 1 - If installation fails
# Exit Code: 0 - If installation succeeds
# Binary: docker-compose.sh
#
dockerComposeInstall() {
  _pipInstall "_${FUNCNAME[0]}" "docker-compose" "$@"
}
_dockerComposeInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Install `docker-compose`
#
# If this fails it will output the installation log.
#
# Usage: {fn} [ package ... ]
# Argument: package - Additional packages to install (using apt)
# Summary: Install `docker-compose`
# When this tool succeeds the `docker-compose` binary is available in the local operating system.
# Exit Code: 1 - If installation fails
# Exit Code: 0 - If installation succeeds
# Binary: docker-compose.sh
#
dockerComposeUninstall() {
  local usage="_${FUNCNAME[0]}"
  local quietLog start name="docker-compose"

  if ! whichExists "$name"; then
    return 0
  fi
  packageWhich pip python3-pip || __throwEnvironment "$usage" "Need pip to uninstall - not found?" || return $?
  start=$(__catchEnvironment "$usage" beginTiming) || return $?
  quietLog=$(__catchEnvironment "$usage" buildQuietLog "$usage") || return $?
  statusMessage decorate info "Removing $name ... "
  __catchEnvironmentQuiet "$usage" "$quietLog" pip uninstall "$name" || return $?
  ! whichExists "$name" || __throwEnvironment "$usage" "$name was still found after uninstall" || return $?
  statusMessage --last reportTiming "$start" "Uninstalled $name in"
}
_dockerComposeUninstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
