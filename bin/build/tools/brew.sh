#!/usr/bin/env bash
#
# Homebrew
#
# Copyright &copy; 2025 Market Acumen, Inc.
# Docs: ./documentation/source/tools/apk.md
# Test: ./test/tools/apk-tests.sh
#

#
__brewWrapper() {
  HOMEBREW_VERBOSE="" brew "$@"
}

# Install Homebrew
brewInstall() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

################################################################################################################################
#
#             ▌                ▌
#    ▛▀▖▝▀▖▞▀▖▌▗▘▝▀▖▞▀▌▞▀▖  ▞▀▘▛▀▖
#    ▙▄▘▞▀▌▌ ▖▛▚ ▞▀▌▚▄▌▛▀ ▗▖▝▀▖▌ ▌
#    ▌  ▝▀▘▝▀ ▘ ▘▝▀▘▗▄▘▝▀▘▝▘▀▀ ▘ ▘
#

# Install brew packages
__brewInstall() {
  __brewWrapper install "$@"
}

__brewDefault() {
  while [ $# -gt 0 ]; do
    case "$1" in
    mysqldump) printf -- "%s\n" "mariadb-dump" ;;
    mysql) printf -- "%s\n" "mariadb" ;;
    *) printf -- "%s\n" "$1" ;;
    esac
    shift
  done
}

# Uninstall brew packages
__brewUninstall() {
  __brewWrapper uninstall "$@"
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
__brewUpgrade() {
  local usage="_${FUNCNAME[0]}"
  local quietLog upgradeLog result clean=()

  quietLog=$(__catchEnvironment "$usage" buildQuietLog "$usage") || return $?
  upgradeLog=$(__catchEnvironment "$usage" buildQuietLog "upgrade_${usage#_}") || return $?
  clean+=("$quietLog" "$upgradeLog")
  __catchEnvironmentQuiet "$quietLog" packageUpdate || return $?
  __catchEnvironmentQuiet "$quietLog" packageInstall || return $?
  __catchEnvironment "$usage" __brewWrapper upgrade --overwrite --greedy | tee -a "$upgradeLog" >>"$quietLog" || _undo $? dumpPipe "apk upgrade failed" <"$quietLog" || _clean $? "${clean[@]}" || return $?
  if ! muzzle packageNeedRestartFlag; then
    if grep -q " restart " "$upgradeLog" || grep -qi needrestart "$upgradeLog" || grep -qi need-restart "$upgradeLog"; then
      __catchEnvironment "$usage" pacakgeNeedRestartFlag "true" || _clean $? "${clean[@]}" || return $?
    fi
    result=restart
  else
    __catchEnvironment "$usage" pacakgeNeedRestartFlag "" || _clean $? "${clean[@]}" || return $?
    result=ok
  fi
  __catchEnvironment "$usage" rm -rf "${clean[@]}" || return $?
  printf "%s\n" "$result"
}
___brewUpgrade() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Update the global database
# See: packageUpdate
# package.sh: true
__brewUpdate() {
  local usage="_return" temp returnCode
  temp=$(fileTemporaryName "$usage") || return $?
  if __brewWrapper update 2>"$temp"; then
    rm -rf "$temp" || :
    return 0
  fi
  returnCode=$?
  cat "$temp" 1>&2
  rm -rf "$temp" || :
  return $returnCode
}

# Usage: {fn}
# List installed packages
# package.sh: true
__brewInstalledList() {
  local usage="_${FUNCNAME[0]}"
  whichExists brew || __throwEnvironment "$usage" "brew not installed - can not list" || return $?
  [ $# -eq 0 ] || __throwArgument "$usage" "Unknown argument $*" || return $?
  __brewWrapper list -1 | grep -v '^[^A-Za-z]'
}
___brewInstalledList() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# List available bottles
# package.sh: true
__brewAvailableList() {
  local usage="_${FUNCNAME[0]}"
  whichExists brew || __throwEnvironment "$usage" "brew not installed - can not list" || return $?
  __brewWrapper search --formula '/.*/'
}
___brewAvailableList() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# Output list of apt standard packages (constant)
# See: _packageStandardPackages
# package.sh: true
__brewStandardPackages() {
  printf "%s\n" toilet curl pcre2 pcre psutils readline unzip
  export BUILD_TEXT_BINARY
  [ -n "${BUILD_TEXT_BINARY-}" ] || BUILD_TEXT_BINARY="toilet"
}
