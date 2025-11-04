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
  if ! sudo -n -v 2>/dev/null; then
    printf "%s%s\n" "$(decorate code MacPorts)" "$(decorate warning ": Attempting to $* ...")"
  fi
  sudo port "$@"
}

__portDefault() {
  printf -- "%s\n" "$@"
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
# handler: {fn}
# OS upgrade and potential restart
# Progress is written to stderr
# Result is `ok` or `restart` written to stdout
#
# Return Code: 0 - Success
# Return Code: 1 - Failed due to issues with environment
# Artifact: `{fn}.log` is left in the `buildCacheDirectory`
# Artifact: `packageUpdate.log` is left in the `buildCacheDirectory`
# Artifact: `packageInstall.log` is left in the `buildCacheDirectory`
__portUpgrade() {
  local handler="_${FUNCNAME[0]}"
  local quietLog upgradeLog result clean=()

  quietLog=$(catchReturn "$handler" buildQuietLog "$handler") || return $?
  upgradeLog=$(catchReturn "$handler" buildQuietLog "upgrade_${handler#_}") || return $?
  clean+=("$quietLog" "$upgradeLog")
  catchEnvironmentQuiet "$quietLog" packageUpdate || return $?
  catchEnvironmentQuiet "$quietLog" packageInstall || return $?
  catchReturn "$handler" __sudoPortWrapper upgrade outdated | tee -a "$upgradeLog" >>"$quietLog" || returnUndo $? dumpPipe "macports upgrade failed" <"$quietLog" || returnClean $? "${clean[@]}" || return $?
  catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
  printf "%s\n" "$result"
}
___portUpgrade() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Update the global database
# See: packageUpdate
# package.sh: true
__portUpdate() {
  local handler="returnMessage" temp returnCode
  temp=$(fileTemporaryName "$handler") || return $?
  if __sudoPortWrapper sync 2>"$temp"; then
    rm -rf "$temp" || :
    return 0
  fi
  returnCode=$?
  cat "$temp" 1>&2
  rm -rf "$temp" || :
  return $returnCode
}

# handler: {fn}
# List installed packages
# package.sh: true
__portInstalledList() {
  local handler="_${FUNCNAME[0]}"
  whichExists port || throwEnvironment "$handler" "port not installed - can not list" || return $?
  [ $# -eq 0 ] || throwArgument "$handler" "Unknown argument $*" || return $?
  __portWrapper installed | grep -v 'currently installed' | awk '{ print $1 }'
}
___portInstalledList() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# handler: {fn}
# List available bottles
# package.sh: true
__portAvailableList() {
  local handler="_${FUNCNAME[0]}"
  whichExists port || throwEnvironment "$handler" "port not installed - can not list" || return $?
  __portWrapper list | awk '{ print $1 }'
}
___portAvailableList() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# handler: {fn}
# Output list of apt standard packages (constant)
# See: _packageStandardPackages
# package.sh: true
__portStandardPackages() {
  printf "%s\n" toilet curl pcre2 pcre psutils readline unzip
  export BUILD_TEXT_BINARY
  [ -n "${BUILD_TEXT_BINARY-}" ] || BUILD_TEXT_BINARY="toilet"
}

__portPackageMapping() {
  case "$1" in
  "pcregrep")
    printf "%s\n" "pcre2grep"
    ;;
  "python")
    printf "%s\n" python33 py33-pip
    ;;
  "mariadb")
    printf "%s\n" mariadb
    ;;
  "mariadb-server")
    printf "%s\n" mariadb-server
    ;;
  "mysql")
    printf "%s\n" mysql8
    ;;
  "mysql-server")
    printf "%s\n" mysql8-server
    ;;
  *)
    printf "%s\n" "$1"
    ;;
  esac
}
