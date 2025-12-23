#!/usr/bin/env bash
#
# yum functions
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/yum.md
# Test: o ./test/tools/yum-tests.sh

#
# Is yum installed?
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
yumIsInstalled() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  [ -x "/usr/bin/yum" ]
}
_yumIsInstalled() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__yumNonInteractive() {
  local handler="returnMessage"
  catchEnvironment "$handler" yum -y -q "$@" || return $?
}

# Install yum packages
__yumInstall() {
  # No way to hide the message
  #
  #     debconf: delaying package configuration, since yum-utils is not installed
  #
  # so just hide it always
  __yumNonInteractive install "$@" 2> >(grep -v 'yum-utils is not installed' 1>&2) || return $?
}

__yumDefault() {
  while [ $# -gt 0 ]; do
    case "$1" in
    mysqldump) printf -- "%s\n" "mariadb-dump" ;;
    mysql) printf -- "%s\n" "mariadb" ;;
    *) printf -- "%s\n" "$1" ;;
    esac
    shift
  done
}

# Uninstall yum packages
__yumUninstall() {
  __yumNonInteractive remove "$@" || return $?
}

#
# Usage: {fn}
# OS upgrade and potential restart
# Progress is written to stderr
# Result is `ok` or `restart` written to stdout
#
# Return Code: 0 - Success
# Return Code: 1 - Failed due to issues with environment
# Artifact: `{fn}.log` is left in the `buildCacheDirectory`
# Artifact: `packageUpdate.log` is left in the `buildCacheDirectory`
# Artifact: `packageInstall.log` is left in the `buildCacheDirectory`
__yumUpgrade() {
  __yumNonInteractive upgrade -y "$@" || return $?
}

# Update the global database
# See: packageUpdate
# package.sh: true
__yumUpdate() {
  __yumNonInteractive update "$@" || return $?
}

# Usage: {fn}
# List installed packages
# package.sh: true
__yumInstalledList() {
  __yumNonInteractive list --installed | sed 1d || return $?
}

# Usage: {fn}
# List available packages
# package.sh: true
__yumAvailableList() {
  __yumNonInteractive list --available | sed 1d || return $?
}

# Usage: {fn}
# Output list of yum standard packages (constant)
# See: _packageStandardPackages
# package.sh: true
__yumStandardPackages() {
  printf "%s\n" which toilet jq shellcheck pcre2-tools diffutils
  export BUILD_TEXT_BINARY
  [ -n "${BUILD_TEXT_BINARY-}" ] || BUILD_TEXT_BINARY="$(__bigTextBinary)"
}

# See: brew.sh apk.sh yum.sh macports.sh
# See: https://packages.ubuntu.com/search?mode=filename&section=all&arch=any&searchon=contents&keywords=sha1sum
__yumPackageMapping() {
  case "$1" in
  "pcregrep")
    printf "%s\n" "pcre2-utils" # TODO
    ;;
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
