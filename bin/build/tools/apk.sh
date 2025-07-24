#!/usr/bin/env bash
#
# Alpine package manager `apk`
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/apk.md
# Test: ./test/tools/apk-tests.sh
#

# Is this an Alpine system and is apk installed?
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Exit Code: 0 - System is an alpine system and apk is installed
# Exit Code: 1 - System is not an alpine system or apk is not installed
apkIsInstalled() {
  local usage="_${FUNCNAME[0]}"
  __help --only "$usage" "$@" || return 0
  isAlpine && whichExists apk
}
_apkIsInstalled() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Is this an Alpine system?
# Argument: --help
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
isAlpine() {
  local usage="_${FUNCNAME[0]}"
  __help --only "$usage" "$@" || return 0
  [ -f /etc/alpine-release ]
}
_isAlpine() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  ! false || isAlpine --help
}

# Open an Alpine container shell
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --env-file envFile - Optional. File. One or more environment files which are suitable to load for docker; must be valid
# Argument: --env envVariable=envValue - Optional. File. One or more environment variables to set.
# Argument: --platform platform - Optional. String. Platform to run (arm vs intel).
# Argument: extraArgs - Optional. Mixed. The first non-file argument to `{fn}` is passed directly through to `docker run` as arguments
# Exit Code: 1 - If already inside docker, or the environment file passed is not valid
# Exit Code: 0 - Success
# Exit Code: Any - `docker run` error code is returned if non-zero
alpineContainer() {
  local usage="_${FUNCNAME[0]}"

  export LC_TERMINAL TERM
  __catch "$usage" buildEnvironmentLoad LC_TERMINAL TERM || return $?
  __catchEnvironment "$usage" dockerLocalContainer --handler "$usage" --image alpine:latest --path /root/build --env LC_TERMINAL="$LC_TERMINAL" --env TERM="$TERM" /root/build/bin/build/need-bash.sh Alpine apk add bash ncurses -- "$@" || return $?
}
_alpineContainer() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

################################################################################################################################
#
#             ▌                ▌
#    ▛▀▖▝▀▖▞▀▖▌▗▘▝▀▖▞▀▌▞▀▖  ▞▀▘▛▀▖
#    ▙▄▘▞▀▌▌ ▖▛▚ ▞▀▌▚▄▌▛▀ ▗▖▝▀▖▌ ▌
#    ▌  ▝▀▘▝▀ ▘ ▘▝▀▘▗▄▘▝▀▘▝▘▀▀ ▘ ▘
#

# Install apt packages
__apkInstall() {
  apk add "$@"
}

__apkDefault() {
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
__apkUninstall() {
  apk del "$@"
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
__apkUpgrade() {
  local usage="_${FUNCNAME[0]}"
  local quietLog upgradeLog result clean=()

  quietLog=$(__catch "$usage" buildQuietLog "$usage") || return $?
  upgradeLog=$(__catch "$usage" buildQuietLog "upgrade_${usage#_}") || return $?
  clean+=("$quietLog" "$upgradeLog")
  __catchEnvironment "$usage" apk upgrade | tee -a "$upgradeLog" >>"$quietLog" || returnUndo $? dumpPipe "apk upgrade failed" <"$quietLog" || returnClean $? "${clean[@]}" || return $?
  if ! muzzle packageNeedRestartFlag; then
    if grep -q " restart " "$upgradeLog" || grep -qi needrestart "$upgradeLog" || grep -qi need-restart "$upgradeLog"; then
      __catch "$usage" packageNeedRestartFlag "true" || return $?
    fi
    result=restart
  else
    __catch "$usage" packageNeedRestartFlag "" || return $?
    result=ok
  fi
  printf "%s\n" "$result"
}
___apkUpgrade() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Update the global database
# See: packageUpdate
# package.sh: true
__apkUpdate() {
  apk update
}

# Usage: {fn}
# List installed packages
# package.sh: true
__apkInstalledList() {
  local usage="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __throwArgument "$usage" "Unknown argument $*" || return $?
  apk list -I -q
}
___apkInstalledList() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# Output list of apt standard packages (constant)
# See: _packageStandardPackages
# package.sh: true
__apkStandardPackages() {
  # no toilet
  printf "%s\n" figlet curl pcre2 pcre psutils readline jq
  export BUILD_TEXT_BINARY
  [ -n "${BUILD_TEXT_BINARY-}" ] || BUILD_TEXT_BINARY="figlet"
}

# Usage: {fn}
# List available packages
# package.sh: true
__apkAvailableList() {
  local usage="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __throwArgument "$usage" "Unknown argument $*" || return $?
  apk list -a -q
}
___apkAvailableList() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# See: https://pkgs.alpinelinux.org/contents?file=sha1sum
#
__apkPackageMapping() {
  case "$1" in
  "python")
    printf "%s\n" python3
    ;;
  "mariadb")
    printf "%s\n" mariadb-client mariadb-common
    ;;
  "mariadb-server")
    printf "%s\n" mariadb-server mariadb-common mariadb-server-utils
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
