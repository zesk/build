#!/usr/bin/env bash
#
# MacPorts
#
# https://ports.macports.org/
# https://www.macports.org/
#
# Copyright &copy; 2025 Market Acumen, Inc.
# Docs: ./documentation/source/tools/macports.md
# Test: ./test/tools/macports-tests.sh
#

#
__portWrapper() {
  port "$@"
}
__sudoPortWrapper() {
  # Detect if sudo has a cached password from prior calls (hide messages in this case)
  if ! muzzle sudo -n -v; then
    printf "%s%s\n" "$(decorate code MacPorts)" "$(decorate warning ": Attempting to $* ...")"
  fi
  sudo port "$@"
}

################################################################################################################################
#
#             ▌                ▌
#    ▛▀▖▝▀▖▞▀▖▌▗▘▝▀▖▞▀▌▞▀▖  ▞▀▘▛▀▖
#    ▙▄▘▞▀▌▌ ▖▛▚ ▞▀▌▚▄▌▛▀ ▗▖▝▀▖▌ ▌
#    ▌  ▝▀▘▝▀ ▘ ▘▝▀▘▗▄▘▝▀▘▝▘▀▀ ▘ ▘
#

# Install macports packages
__portInstall() {
  local packages=() selections=()
  IFS="" read -d $'\n' -r -a packages < <(__portPackageNames "$@")
  __sudoPortWrapper install "${packages[@]}"
  IFS="" read -d $'\n' -r -a selections < <(__portPackageSelections "$@")
  set - "${selections[@]+${selections[@]}}"
  while [ $# -gt 0 ]; do
    __sudoPortWrapper select --set "$1" "$2"
    shift 2
  done
}

# Uninstall macports packages
__portUninstall() {
  local packages=()
  IFS="" read -d $'\n' -r -a packages < <(__portPackageFilter "$@")
  __sudoPortWrapper uninstall "$@"
}

__portPackageNames() {
  while [ $# -gt 0 ]; do
    case "$1" in
    aws)
      printf "%s\n" "py313-awscli2"
      awscli py313-awscli2
      ;;
    terraform)
      printf "%s\n" "terraform-1.11"
      ;;
    *)
      printf "%s\n" "$1"
      ;;
    esac
  done
}

__portPackageSelections() {
  while [ $# -gt 0 ]; do
    case "$1" in
    aws)
      printf "%s\n" "awscli py313-awscli2"
      ;;
    terraform)
      printf "%s\n" "terraform" "terraform-1.11"
      ;;
    *) ;;
    esac
  done
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
__portUpgrade() {
  local usage="_${FUNCNAME[0]}"
  local quietLog upgradeLog result clean=()

  quietLog=$(__catchEnvironment "$usage" buildQuietLog "$usage") || return $?
  upgradeLog=$(__catchEnvironment "$usage" buildQuietLog "upgrade_${usage#_}") || return $?
  clean+=("$quietLog" "$upgradeLog")
  __catchEnvironmentQuiet "$quietLog" packageUpdate || return $?
  __catchEnvironmentQuiet "$quietLog" packageInstall || return $?
  __catchEnvironment "$usage" __sudoPortWrapper upgrade outdated | tee -a "$upgradeLog" >>"$quietLog" || _undo $? dumpPipe "macports upgrade failed" <"$quietLog" || _clean $? "${clean[@]}" || return $?
  __catchEnvironment "$usage" rm -rf "${clean[@]}" || return $?
  printf "%s\n" "$result"
}
___portUpgrade() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Update the global database
# See: packageUpdate
# package.sh: true
__portUpdate() {
  local usage="_return" temp returnCode
  temp=$(fileTemporaryName "$usage") || return $?
  if __sudoPortWrapper sync 2>"$temp"; then
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
__portInstalledList() {
  local usage="_${FUNCNAME[0]}"
  whichExists port || __throwEnvironment "$usage" "port not installed - can not list" || return $?
  [ $# -eq 0 ] || __throwArgument "$usage" "Unknown argument $*" || return $?
  __portWrapper installed | grep -v 'currently installed' | awk '{ print $1 }'
}
___portInstalledList() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# List available bottles
# package.sh: true
__portAvailableList() {
  local usage="_${FUNCNAME[0]}"
  whichExists port || __throwEnvironment "$usage" "port not installed - can not list" || return $?
  __portWrapper list | awk '{ print $1 }'
}
___portAvailableList() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# Output list of apt standard packages (constant)
# See: _packageStandardPackages
# package.sh: true
__portStandardPackages() {
  printf "%s\n" toilet curl pcre2 pcre psutils readline unzip
  export BUILD_TEXT_BINARY
  [ -n "${BUILD_TEXT_BINARY-}" ] || BUILD_TEXT_BINARY="toilet"
}
