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
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Platform: Darwin
brewInstall() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  isDarwin || returnThrowEnvironment "$handler" "Only on Darwin (Mac OS X)" || return $?
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}
_brewInstall() {
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
__brewUpgrade() {
  local handler="_${FUNCNAME[0]}"
  local quietLog upgradeLog result clean=()

  quietLog=$(returnCatch "$handler" buildQuietLog "$handler") || return $?
  upgradeLog=$(returnCatch "$handler" buildQuietLog "upgrade_${handler#_}") || return $?
  clean+=("$quietLog" "$upgradeLog")
  catchEnvironmentQuiet "$quietLog" packageUpdate || return $?
  catchEnvironmentQuiet "$quietLog" packageInstall || return $?
  returnCatch "$handler" __brewWrapper upgrade --overwrite --greedy | tee -a "$upgradeLog" >>"$quietLog" || returnUndo $? dumpPipe "apk upgrade failed" <"$quietLog" || returnClean $? "${clean[@]}" || return $?
  if ! muzzle packageNeedRestartFlag; then
    if grep -q " restart " "$upgradeLog" || grep -qi needrestart "$upgradeLog" || grep -qi need-restart "$upgradeLog"; then
      returnCatch "$handler" packageNeedRestartFlag "true" || returnClean $? "${clean[@]}" || return $?
    fi
    result=restart
  else
    returnCatch "$handler" packageNeedRestartFlag "" || returnClean $? "${clean[@]}" || return $?
    result=ok
  fi
  catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
  printf "%s\n" "$result"
}
___brewUpgrade() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Update the global database
# See: packageUpdate
# package.sh: true
__brewUpdate() {
  local handler="returnMessage" temp returnCode
  temp=$(fileTemporaryName "$handler") || return $?
  if __brewWrapper update 2>"$temp"; then
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
__brewInstalledList() {
  local handler="_${FUNCNAME[0]}"
  whichExists brew || returnThrowEnvironment "$handler" "brew not installed - can not list" || return $?
  [ $# -eq 0 ] || returnThrowArgument "$handler" "Unknown argument $*" || return $?
  __brewWrapper list -1 | grep -v '^[^A-Za-z]'
}
___brewInstalledList() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# handler: {fn}
# List available bottles
# package.sh: true
__brewAvailableList() {
  local handler="_${FUNCNAME[0]}"
  whichExists brew || returnThrowEnvironment "$handler" "brew not installed - can not list" || return $?
  __brewWrapper search --formula '/.*/'
}
___brewAvailableList() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# handler: {fn}
# Output list of apt standard packages (constant)
# See: _packageStandardPackages
# package.sh: true
__brewStandardPackages() {
  printf "%s\n" toilet curl pcre2 pcre psutils readline unzip
  export BUILD_TEXT_BINARY
  [ -n "${BUILD_TEXT_BINARY-}" ] || BUILD_TEXT_BINARY="toilet"
}

__brewPackageMapping() {
  case "$1" in
  "python")
    printf "%s\n" python3
    ;;
  "mariadb")
    printf "%s\n" mariadb
    ;;
  "mariadb-server")
    printf "%s\n" mariadb-server
    ;;
  "mysql")
    printf "%s\n" mysql
    ;;
  "mysql-server")
    printf "%s\n" mysql-server
    ;;
  *)
    printf "%s\n" "$1"
    ;;
  esac
}
