#!/usr/bin/env bash
#
# Alpine package manager `apk`
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/apk.md
# Test: ./test/tools/apk-tests.sh
#

# Is this an Alpine system and is apk installed?
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Return Code: 0 - System is an alpine system and apk is installed
# Return Code: 1 - System is not an alpine system or apk is not installed
apkIsInstalled() {
  local handler="_${FUNCNAME[0]}"
  __help --only "$handler" "$@" || return 0
  isAlpine && whichExists apk
}
_apkIsInstalled() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Is this an Alpine system?
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
isAlpine() {
  local handler="_${FUNCNAME[0]}"
  __help --only "$handler" "$@" || return 0
  [ -f /etc/alpine-release ]
}
_isAlpine() {
  ! false || isAlpine --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Open an Alpine container shell
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --env-file envFile - Optional. File. One or more environment files which are suitable to load for docker; must be valid
# Argument: --env envVariable=envValue - Optional. File. One or more environment variables to set.
# Argument: --platform platform - Optional. String. Platform to run (arm vs intel).
# Argument: extraArgs - Optional. Mixed. The first non-file argument to `{fn}` is passed directly through to `docker run` as arguments
# Return Code: 1 - If already inside docker, or the environment file passed is not valid
# Return Code: 0 - Success
# Return Code: Any - `docker run` error code is returned if non-zero
alpineContainer() {
  local handler="_${FUNCNAME[0]}"

  [ "$1" != "--help" ] || __help "$handler" "$@" || return 0
  export LC_TERMINAL TERM
  catchReturn "$handler" buildEnvironmentLoad LC_TERMINAL TERM || return $?
  catchEnvironment "$handler" dockerLocalContainer --handler "$handler" --image alpine:latest --path /root/build --env LC_TERMINAL="$LC_TERMINAL" --env TERM="$TERM" /root/build/bin/build/need-bash.sh Alpine apk add bash ncurses -- "$@" || return $?
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
# OS upgrade and potential restart
# Progress is written to stderr
# Result is `ok` or `restart` written to stdout
#
# Return Code: 0 - Success
# Return Code: 1 - Failed due to issues with environment
# Artifact: `{fn}.log` is left in the `buildCacheDirectory`
# Artifact: `packageUpdate.log` is left in the `buildCacheDirectory`
# Artifact: `packageInstall.log` is left in the `buildCacheDirectory`
__apkUpgrade() {
  local handler="_${FUNCNAME[0]}"
  local quietLog upgradeLog result clean=()

  quietLog=$(catchReturn "$handler" buildQuietLog "$handler") || return $?
  upgradeLog=$(catchReturn "$handler" buildQuietLog "upgrade_${handler#_}") || return $?
  clean+=("$quietLog" "$upgradeLog")
  catchEnvironment "$handler" apk upgrade | tee -a "$upgradeLog" >>"$quietLog" || returnUndo $? dumpPipe "apk upgrade failed" <"$quietLog" || returnClean $? "${clean[@]}" || return $?
  if ! muzzle packageNeedRestartFlag; then
    if grep -q " restart " "$upgradeLog" || grep -qi needrestart "$upgradeLog" || grep -qi need-restart "$upgradeLog"; then
      catchReturn "$handler" packageNeedRestartFlag "true" || return $?
    fi
    result=restart
  else
    catchReturn "$handler" packageNeedRestartFlag "" || return $?
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

# List installed packages
# package.sh: true
__apkInstalledList() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || throwArgument "$handler" "Unknown argument $*" || return $?
  apk list -I -q
}
___apkInstalledList() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Output list of apt standard packages (constant)
# See: _packageStandardPackages
# package.sh: true
__apkStandardPackages() {
  # no toilet
  printf "%s\n" figlet curl pcre2 pcre psutils readline jq
  export BUILD_TEXT_BINARY
  [ -n "${BUILD_TEXT_BINARY-}" ] || BUILD_TEXT_BINARY="figlet"
}

# List available packages
# package.sh: true
__apkAvailableList() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || throwArgument "$handler" "Unknown argument $*" || return $?
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
  "pcregrep")
    printf "%s\n" pcre2-tools
    ;;
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
    printf "%s\n" coreutils
    ;;
  *)
    printf "%s\n" "$1"
    ;;
  esac
}
