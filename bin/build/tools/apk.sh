#!/usr/bin/env bash
#
# Alpine package manager `apk`
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: ./docs/_templates/tools/apk.md
# Test: ./test/tools/apk-tests.sh
#

# Is this an Alpine system?
apkIsInstalled() {
  [ -f /etc/alpine-release ] && whichExists apk
}

# Open an Alpine container shell
alpineContainer() {
  dockerLocalContainer --image alpine:latest --path /root/build /root/build/bin/build/need-bash.sh apk add bash ncurses -- "$@"
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
# Artifact: `aptUpdateOnce.log` is left in the `buildCacheDirectory`
# Artifact: `aptInstall.log` is left in the `buildCacheDirectory`
__apkUpgrade() {
  local usage="_${FUNCNAME[0]}"
  local quietLog upgradeLog result

  quietLog=$(__usageEnvironment "$usage" buildQuietLog "${usage#_}") || return $?
  upgradeLog=$(__usageEnvironment "$usage" buildQuietLog "upgrade_${usage#_}") || return $?
  __usageEnvironment "$usage" apk upgrade | tee -a "$upgradeLog" >>"$quietLog"
  if ! muzzle packageNeedRestartFlag; then
    if grep -q " restart " "$upgradeLog" || grep -qi needrestart "$upgradeLog" || grep -qi need-restart "$upgradeLog"; then
      __usageEnvironment "$usage" pacakgeNeedRestartFlag "true" || return $?
    fi
    result=restart
  else
    __usageEnvironment "$usage" pacakgeNeedRestartFlag "" || return $?
    result=ok
  fi
  printf "%s\n" "$result"
}
___apkUpgrade() {
  # IDENTICAL usageDocument 1
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
  whichExists apk || __failEnvironment "$usage" "apk not installed - can not list" || return $?
  [ $# -eq 0 ] || __failArgument "$usage" "Unknown argument $*" || return $?
  apk list -I -q
}
___apkInstalledList() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# Output list of apt standard packages (constant)
# See: _packageStandardPackages
# package.sh: true
__apkStandardPackages() {
  printf "%s\n" figlet curl pcre2 pcre psutils readline
}
