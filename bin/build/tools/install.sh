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
  packageGroupInstall mariadb
}

# Uninstall mariadb
mariadbUninstall() {
  packageGroupUninstall mariadb
}

# Install `python`
#
# If this fails it will output the installation log.
#
# Summary: Install `python`
# When this tool succeeds the `python` binary is available in the local operating system.
# Exit Code: 1 - If installation fails
# Exit Code: 0 - If installation succeeds
# Binary: python.sh
#
pythonInstall() {
  local usage="_${FUNCNAME[0]}"

  if ! whichExists python; then
    __catchEnvironment "$usage" packageGroupInstall "$@" python || return $?
  fi
}
_pythonInstall() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Uninstall python
pythonUninstall() {
  packageGroupUninstall "$@" python
}

# Utility to install python dependencies via pip
# Usage: {fn} pipPackage [ ... additional packages ]
_pipInstall() {
  local usage="${1-}"
  local quietLog start name

  shift
  name="$(usageArgumentString "$usage" "name" "${1-}")" || return $?
  shift
  if whichExists "$name"; then
    return 0
  fi
  start=$(timingStart) || return $?
  quietLog=$(__catchEnvironment "$usage" buildQuietLog "$usage") || return $?
  __catchEnvironment "$usage" pythonInstall || return $?
  if ! whichExists pip; then
    __catchEnvironment "$usage" python -m ensurepip --upgrade || return $?
  fi
  statusMessage decorate info "Installing $name ... "
  __catchEnvironmentQuiet "$usage" "$quietLog" pip install "$name" "$@" || return $?
  whichExists "$name" || __throwEnvironment "$usage" "$name not found after install" || return $?
  statusMessage --last timingReport "$start" "Installed $name in"
}

# Utility to install python dependencies via pip
# Usage: {fn} pipPackage [ ... additional packages ]
_pipUninstall() {
  local usage="${1-}"
  local quietLog start

  shift
  name="$(usageArgumentString "$usage" "name" "${1-}")" || return $?
  shift
  if ! whichExists "$name"; then
    return 0
  fi
  packageWhich pip python3-pip || __throwEnvironment "$usage" "Need pip to uninstall - not found?" || return $?
  start=$(timingStart) || return $?
  quietLog=$(__catchEnvironment "$usage" buildQuietLog "$usage") || return $?
  statusMessage decorate info "Removing $name ... "
  __catchEnvironmentQuiet "$usage" "$quietLog" pip uninstall "$name" || return $?
  ! whichExists "$name" || __throwEnvironment "$usage" "$name was still found after uninstall" || return $?
  statusMessage --last timingReport "$start" "Uninstalled $name in"
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
  start=$(timingStart) || return $?
  quietLog=$(__catchEnvironment "$usage" buildQuietLog "$usage") || return $?
  statusMessage decorate info "Removing $name ... "
  __catchEnvironmentQuiet "$usage" "$quietLog" pip uninstall "$name" || return $?
  ! whichExists "$name" || __throwEnvironment "$usage" "$name was still found after uninstall" || return $?
  statusMessage --last timingReport "$start" "Uninstalled $name in"
}
_dockerComposeUninstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
