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
  whichApt mariadb mariadb-client "$@"
}

# Install `python`
#
# If this fails it will output the installation log.
#
# Usage: pythonInstall [ package ]
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

# Install `docker-compose`
#
# If this fails it will output the installation log.
#
# Usage: dockerComposeInstall [ package ... ]
# Argument: package - Additional packages to install (using apt)
# Summary: Install `docker-compose`
# When this tool succeeds the `docker-compose` binary is available in the local operating system.
# Exit Code: 1 - If installation fails
# Exit Code: 0 - If installation succeeds
# Binary: docker-compose.sh
#
dockerComposeInstall() {
  local quietLog start

  if which docker-compose 2>/dev/null 1>&2; then
    return 0
  fi
  quietLog=$(buildQuietLog dockerComposeInstall) || _environment "buildQuietLog dockerComposeInstall failed" || return $?
  __environment pythonInstall "$@" || return $?

  consoleInfo -n "Installing docker-compose ... "
  start=$(beginTiming)
  if ! pip install docker-compose >"$quietLog" 2>&1; then
    buildFailed "$quietLog"
    _environment "pip install docker-compose failed" || return $?
  fi
  if ! which docker-compose 2>/dev/null; then
    buildFailed "$quietLog"
    _environment "docker-compose not found after install" || return $?
  fi
  reportTiming "$start" OK
}
