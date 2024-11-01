#!/usr/bin/env bash
#
# Homebrew
#
# Copyright &copy; 2024 Market Acumen, Inc.
# Docs: ./docs/_templates/tools/apk.md
# Test: ./test/tools/apk-tests.sh
#

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

# Install apt packages
__brewInstall() {
  brew install "$@"
}

# Uninstall apt packages
__brewUninstall() {
  brew uninstall "$@"
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
  local quietLog upgradeLog result

  quietLog=$(__usageEnvironment "$usage" buildQuietLog "${usage#_}") || return $?
  upgradeLog=$(__usageEnvironment "$usage" buildQuietLog "upgrade_${usage#_}") || return $?
  __usageEnvironmentQuiet "$quietLog" packageUpdate || return $?
  __usageEnvironmentQuiet "$quietLog" packageInstall || return $?
  __usageEnvironment "$usage" brew upgrade --overwrite --greedy | tee -a "$upgradeLog" >>"$quietLog"
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
___brewUpgrade() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Update the global database
# See: packageUpdate
# package.sh: true
__brewUpdate() {
  brew update
}

# Usage: {fn}
# List installed packages
# package.sh: true
__brewInstalledList() {
  local usage="_${FUNCNAME[0]}"
  whichExists brew || __failEnvironment "$usage" "brew not installed - can not list" || return $?
  [ $# -eq 0 ] || __failArgument "$usage" "Unknown argument $*" || return $?
  brew list -1 | grep -v '^[^A-Za-z]'
}
___brewInstalledList() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# List available bottles
# package.sh: true
__brewAvailableList() {
  local usage="_${FUNCNAME[0]}"
  whichExists brew || __failEnvironment "$usage" "brew not installed - can not list" || return $?
  brew search --formula '/.*/'
}
___brewAvailableList() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# Output list of apt standard packages (constant)
# See: _packageStandardPackages
# package.sh: true
__brewStandardPackages() {
  printf "%s\n" toilet figlet curl pcre2 pcre psutils readline unzip
}
