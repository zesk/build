#!/usr/bin/env bash
#
# npm functions
#
# Copyright &copy; 2024 Market Acumen, Inc.
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
  whichApt mariadb mariadb-common mariadb-client "$@"
}

# Uninstall mariadb
mariadbUninstall() {
  whichAptUninstall mariadb mariadb-common mariadb-client "$@"
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
  whichApt python python-is-python3 python3 python3-pip "$@"
}

# Uninstall python
pythonUninstall() {
  whichAptUninstall python python-is-python3 python3 python3-pip "$@"
}

# Utility to install python dependencies via pip
# Usage: {fn} pipPackage [ ... additional packages ]
_pipInstall() {
  local usage="${1-}"
  local quietLog start name

  shift
  name="$(usageArgumentRequired "$usage" "name" "${1-}")"
  shift
  if whichExists "$name"; then
    return 0
  fi
  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  quietLog=$(__usageEnvironment "$usage" buildQuietLog "$usage") || return $?
  __usageEnvironment "$usage" pythonInstall || return $?
  statusMessage consoleInfo "Installing $name ... "
  __usageEnvironmentQuiet "$usage" "$quietLog" pip install "$name" "$@" || return $?
  whichExists "$name" || __failEnvironment "$usage" "$name not found after install" || return $?
  statusMessage reportTiming "$start" "Installed $name in"
  clearLine || :

}

# Utility to install python dependencies via pip
# Usage: {fn} pipPackage [ ... additional packages ]
_pipUninstall() {
  local usage="${1-}"
  local quietLog start

  shift
  name="$(usageArgumentRequired "$usage" "name" "${1-}")"
  shift
  if ! whichExists "$name"; then
    return 0
  fi
  whichApt pip python3-pip || __failEnvironment "$usage" "Need pip to uninstall - not found?" || return $?
  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  quietLog=$(__usageEnvironment "$usage" buildQuietLog "$usage") || return $?
  statusMessage consoleInfo "Removing $name ... "
  __usageEnvironmentQuiet "$usage" "$quietLog" pip uninstall "$name" || return $?
  ! whichExists "$name" || __failEnvironment "$usage" "$name was still found after uninstall" || return $?
  statusMessage reportTiming "$start" "Uninstalled $name in"
  clearLine || :
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
  whichApt pip python3-pip || __failEnvironment "$usage" "Need pip to uninstall - not found?" || return $?
  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  quietLog=$(__usageEnvironment "$usage" buildQuietLog "$usage") || return $?
  statusMessage consoleInfo "Removing $name ... "
  __usageEnvironmentQuiet "$usage" "$quietLog" pip uninstall "$name" || return $?
  ! whichExists "$name" || __failEnvironment "$usage" "$name was still found after uninstall" || return $?
  statusMessage reportTiming "$start" "Uninstalled $name in"
  clearLine || :
}
_dockerComposeUninstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
