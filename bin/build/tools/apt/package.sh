#!/usr/bin/env bash
#
# apt functions
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/apt.md
# Test: o ./test/tools/apt-tests.sh

################################################################################################################################
#
#             ▌                ▌
#    ▛▀▖▝▀▖▞▀▖▌▗▘▝▀▖▞▀▌▞▀▖  ▞▀▘▛▀▖
#    ▙▄▘▞▀▌▌ ▖▛▚ ▞▀▌▚▄▌▛▀ ▗▖▝▀▖▌ ▌
#    ▌  ▝▀▘▝▀ ▘ ▘▝▀▘▗▄▘▝▀▘▝▘▀▀ ▘ ▘
#

__aptNonInteractive() {
  local handler="$1" && shift
  DEBIAN_FRONTEND=noninteractive NEEDRESTART_MODE=l __catchEnvironment "$handler" apt-get "$@" || return $?
}

# Install apt packages
___aptInstall() {
  local handler="$1" && shift
  # No way to hide the message
  #
  #     debconf: delaying package configuration, since apt-utils is not installed
  #
  # so just hide it always
  __aptNonInteractive "$handler" install -y "$@" 2> >(grep -v 'apt-utils is not installed' 1>&2) || return $?
}

__aptDefault() {
  while [ $# -gt 0 ]; do
    case "$1" in
    mysqldump) printf -- "%s\n" "mariadb-dump" ;;
    mysql) printf -- "%s\n" "mariadb" ;;
    *) printf -- "%s\n" "$1" ;;
    esac
    shift
  done
}

# Uninstall apt packages
___aptUninstall() {
  local handler="$1" && shift
  __aptNonInteractive "$handler" remove -y "$@" || return $?
}

#
# Usage: {fn}
# OS upgrade and potential restart
# Progress is written to stderr
# Result is `ok` or `restart` written to stdout
#
# Exit code: 0 - Success
# Exit code: 1 - Failed due to issues with environment
# Artifact: `{fn}.log` is left in the `buildCacheDirectory`
# Artifact: `packageUpdate.log` is left in the `buildCacheDirectory`
# Artifact: `packageInstall.log` is left in the `buildCacheDirectory`
___aptUpgrade() {
  local handler="$1" && shift
  __aptNonInteractive "$handler" dist-upgrade -y "$@" || return $?
}

# Update the global database
# See: packageUpdate
# package.sh: true
___aptUpdate() {
  local handler="$1" && shift
  __aptNonInteractive "$handler" update -y "$@" || return $?
}

# Usage: {fn}
# List installed packages
# package.sh: true
___aptInstalledList() {
  local handler="$1" && shift
  [ $# -eq 0 ] || __throwArgument "$handler" "Unknown argument $*" || return $?
  __catchEnvironment "$handler" dpkg --get-selections | grepSafe -v deinstall | awk '{ print $1 }' || return $?
}

# Usage: {fn}
# List available packages
# package.sh: true
___aptAvailableList() {
  local handler="$1" && shift
  __catchEnvironment "$handler" apt-cache pkgnames || return $?
}

# Usage: {fn}
# Output list of apt standard packages (constant)
# See: _packageStandardPackages
# package.sh: true
___aptStandardPackages() {
  local handler="$1" && shift
  printf "%s\n" apt-utils toilet toilet-fonts jq
  export BUILD_TEXT_BINARY
  [ -n "${BUILD_TEXT_BINARY-}" ] || BUILD_TEXT_BINARY="$(__bigTextBinary)"
}

# See: brew.sh apk.sh apt.sh macports.sh
# See: https://packages.ubuntu.com/search?mode=filename&section=all&arch=any&searchon=contents&keywords=sha1sum
___aptPackageMapping() {
  local handler="$1" && shift
  case "$1" in
  "python")
    printf "%s\n" python-is-python3 python3 python3-pip
    ;;
  "mariadb")
    printf "%s\n" mariadb-common mariadb-client
    ;;
  "mariadb-server")
    printf "%s\n" mariadb-common mariadb-server
    ;;
  "mysql")
    printf "%s\n" mysql-client
    ;;
  "mysql-server")
    printf "%s\n" mysql-server
    ;;
  "sha1sum")
    printf "%s\n" "coreutils"
    ;;
  *)
    printf "%s\n" "$1"
    ;;
  esac
}
