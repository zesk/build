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
  # _IDENTICAL_ usageDocument 1
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
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  ! false || isAlpine --help
}

# Open an Alpine container shell
alpineContainer() {
  local usage="_${FUNCNAME[0]}"

  export LC_TERMINAL TERM
  __catchEnvironment "$usage" buildEnvironmentLoad LC_TERMINAL TERM || return $?
  __catchEnvironment "$usage" dockerLocalContainer --image alpine:latest --path /root/build --env LC_TERMINAL="$LC_TERMINAL" --env TERM="$TERM" /root/build/bin/build/need-bash.sh Alpine apk add bash ncurses -- "$@" || return $?
}
_alpineContainer() {
  # _IDENTICAL_ usageDocument 1
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

  quietLog=$(__catchEnvironment "$usage" buildQuietLog "$usage") || return $?
  upgradeLog=$(__catchEnvironment "$usage" buildQuietLog "upgrade_${usage#_}") || return $?
  clean+=("$quietLog" "$upgradeLog")
  __catchEnvironment "$usage" apk upgrade | tee -a "$upgradeLog" >>"$quietLog" || _undo $? dumpPipe "apk upgrade failed" <"$quietLog" || _clean $? "${clean[@]}" || return $?
  if ! muzzle packageNeedRestartFlag; then
    if grep -q " restart " "$upgradeLog" || grep -qi needrestart "$upgradeLog" || grep -qi need-restart "$upgradeLog"; then
      __catchEnvironment "$usage" pacakgeNeedRestartFlag "true" || return $?
    fi
    result=restart
  else
    __catchEnvironment "$usage" pacakgeNeedRestartFlag "" || return $?
    result=ok
  fi
  printf "%s\n" "$result"
}
___apkUpgrade() {
  # _IDENTICAL_ usageDocument 1
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
  # _IDENTICAL_ usageDocument 1
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
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
