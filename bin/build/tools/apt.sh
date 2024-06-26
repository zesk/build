#!/usr/bin/env bash
#
# apt functions
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh pipeline.sh
#
# Docs: o ./docs/_templates/tools/apt.md
# Test: o ./test/tools/apt-tests.sh

#
# Run apt-get update once and only once in the pipeline, at least
# once an hour as well (when testing)
#
# Summary: Do `apt-get update` once
# Usage: aptUpdateOnce
# Environment: Stores state files in `./.build/` directory which is created if it does not exist.
# Artifact: `{fn}.log` is left in the `buildCacheDirectory`
#
aptUpdateOnce() {
  local name quietLog start cacheFile=.apt-update lastModified

  quietLog=$(buildQuietLog aptUpdateOnce)
  name=$(buildCacheDirectory "$cacheFile")
  __environment requireFileDirectory "$name" || return $?
  if [ -f "$name" ]; then
    lastModified="$(modificationSeconds "$name")"
    # once an hour, technically
    if [ "$lastModified" -lt 3600 ]; then
      return 0
    fi
  fi
  which apt-get >/dev/null || _environment "No apt-get available" || return $?
  start=$(beginTiming)
  consoleInfo -n "apt-get update ... "
  if ! DEBIAN_FRONTEND=noninteractive apt-get update -y >"$quietLog" 2>&1; then
    buildFailed "$quietLog" 1>&2 || :
    _environment "apt-get update failed" || return $?
  fi
  reportTiming "$start" OK 1>&2 || :
  date >"$name" || :
}

#
# Install packages using `apt-get`. If `apt-get` is not available, this succeeds
# and assumes packages will be available.
#
# Usage: aptInstall [ package ... ]
# Example:     aptInstall shellcheck
# Exit Code: 0 - If `apt-get` is not installed, returns 0.
# Exit Code: 1 - If `apt-get` fails to install the packages
# Summary: Install packages using `apt-get`
# Argument: package - One or more packages to install
# Artifact: `{fn}.log` is left in the `buildCacheDirectory`
# Default: apt-utils figlet jq pcregrep
#
# shellcheck disable=SC2120
aptInstall() {
  local installedLog quietLog
  local actualPackages package packages
  local apt start
  local usage

  usage="_${FUNCNAME[0]}"

  actualPackages=()
  packages=(apt-utils figlet toilet toilet-fonts jq pcregrep "$@")
  start=$(beginTiming)
  quietLog=$(buildQuietLog "${FUNCNAME[0]}")
  installedLog="$(buildCacheDirectory apt.packages)"
  apt=$(which apt-get || :)
  if [ -z "$apt" ]; then
    statusMessage consoleWarning "No apt, continuing anyway ..."
    return 0
  fi

  __usageEnvironmentQuiet "$usage" "$quietLog" aptUpdateOnce || return $?
  __environment requireFileDirectory "$installedLog" || return $?
  __environment touch "$installedLog" || return $?

  for package in "${packages[@]}"; do
    if ! grep -q -e "^$package$" "$installedLog"; then
      actualPackages+=("$package")
      __environment printf "%s\n" "$package" >>"$installedLog" || return $?
    fi
  done

  if [ "${#actualPackages[@]}" -eq 0 ]; then
    if [ -n "$*" ]; then
      consoleSuccess "Already installed: $*"
    fi
    return 0
  fi
  consoleInfo -n "Installing ${actualPackages[*]} ... "
  DEBIAN_FRONTEND=noninteractive __usageEnvironmentQuiet "$usage" "$quietLog" "$apt" install -y "${actualPackages[@]}" || return $?
  reportTiming "$start" OK
}
_aptInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Installs an apt package if a binary does not exist in the which path.
# The assumption here is that `aptInstallPackage` will install the desired `binary`.
#
# Confirms that `binary` is installed after installation succeeds.
#
# Summary: Install tools using `apt-get` if they are not found
# Usage: {fn} binary aptInstallPackage ...
# Example:     whichApt shellcheck shellcheck
# Example:     whichApt mariadb mariadb-client
# Argument: binary - The binary to look for
# Argument: aptInstallPackage - The package name to install if the binary is not found in the `$PATH`.
# Environment: Technically this will install the binary and any related files as a package.
#
whichApt() {
  local binary=$1
  shift || _argument "Missing aptInstallPackage" || return $?
  if which "$binary" >/dev/null; then
    return 0
  fi
  __environment aptInstall "$@" || return $?
  if which "$binary" >/dev/null; then
    return 0
  fi
  _environment "Apt packages \"$*\" did not add $binary to the PATH: ${PATH-}" || return $?
}

#
# Usage: {fn}
# OS upgrade and potential restart
# Progress is written to stderr
# Result is `uptodate` or `restart` written to stdout
#
# Exit code: 0 - Success
# Exit code: 1 - Failed due to issues with environment
# Artifact: `{fn}.log` is left in the `buildCacheDirectory`
# Artifact: `aptUpdateOnce.log` is left in the `buildCacheDirectory`
# Artifact: `aptInstall.log` is left in the `buildCacheDirectory`
aptUpToDate() {
  local quietLog upgradeLog restartFlag result

  if ! quietLog=$(buildQuietLog "${FUNCNAME[0]}") ||
    ! restartFlag=$(buildCacheDirectory ".needRestart") ||
    ! upgradeLog=$(buildQuietLog "STATE_${FUNCNAME[0]}"); then
    _environment "Unable to create log files" || return $?
  fi
  if [ -f "$restartFlag" ]; then
    consoleWarning -i "Restart flag already set. " 1>&2
  fi
  consoleInfo -n "Update ... " 1>&2
  if ! aptUpdateOnce >>"$quietLog" 2>&1 ||
    ! aptInstall >>"$quietLog" 2>&1 ||
    ! DEBIAN_FRONTEND=noninteractive NEEDRESTART_MODE=l apt-get -y dist-upgrade | tee -a "$upgradeLog" >>"$quietLog" 2>&1; then
    printf "\n" 1>&2
    buildFailed "$quietLog" 1>&2
    _environment "dist-upgrade failed" || return $?
  fi
  if [ ! -f "$restartFlag" ]; then
    if grep -q " restart " "$upgradeLog" || grep -qi needrestart "$upgradeLog"; then
      date +%s >"$restartFlag"
    fi
    result=restart
  else
    result=uptodate
  fi
  printf "%s\n" "$result"
}
