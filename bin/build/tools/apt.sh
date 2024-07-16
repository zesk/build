#!/usr/bin/env bash
#
# apt functions
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/tools/apt.md
# Test: o ./test/tools/apt-tests.sh

# sources constant with checking
# Usage: {fn} usageFunction
_aptSourcesPath() {
  local usage="$1" sourcesPath=/etc/apt/sources.list.d
  [ -d "$sourcesPath" ] || __failEnvironment "$usage" "No $sourcesPath exists - not an apt system" || return $?
  printf "%s\n" "$sourcesPath"
}

# key rings directory constant with creation
_aptKeyRings() {
  local usage="$1" ring=/etc/apt/keyrings
  [ -d "$ring" ] || __failEnvironment "$usage" mkdir -p "$ring" || return $?
  printf "%s\n" "$ring"
}

# permissions check for sourcesPath modifications
_usageAptPermissions() {
  local usage="$1" sourcesPath="$2"
  touch "$sourcesPath/$$.test" 2>/dev/null || __failEnvironment "$usage" "No permission to modify $sourcesPath, failing" || return $?
  rm -f "$sourcesPath/$$.test" 2>/dev/null || __failEnvironment "$usage" "No permission to delete in $sourcesPath, failing" || return $?
}

#
# Run apt-get update once and only once in the pipeline, at least
# once an hour as well (when testing)
#
# Summary: Do `apt-get update` once
# Usage: {fn} [ --force ]
# Argument: --force - Optional. Flag. Force apt-update regardless.
# Environment: Stores state files in `./.build/` directory which is created if it does not exist.
# Artifact: `{fn}.log` is left in the `buildCacheDirectory`
#
aptUpdateOnce() {
  local usage="_${FUNCNAME[0]}"
  local cacheFile=.apt-update
  local argument nArguments
  local forceFlag
  local name quietLog start lastModified

  nArguments=$#
  forceFlag=false
  while [ $# -gt 0 ]; do
    argument="$(usageArgumentString "$usage" "argument #$((nArguments - $# + 1))" "${1-}")" || return $?
    case "$argument" in
      --help)
        "$usage" 0
        return $?
        ;;
      --force)
        forceFlag=true
        ;;
      *)
        usageArgumentUnknown "$usage" "$argument" || return $?
        ;;
    esac
    shift || usageArgumentMissing "$usage" "$argument" || return $?
  done
  __usageEnvironment "$usage" whichExists apt-get || return $?
  quietLog=$(__usageEnvironment "$usage" buildQuietLog aptUpdateOnce) || return $?
  name=$(__usageEnvironment "$usage" buildCacheDirectory "$cacheFile") || return $?
  __usageEnvironment "$usage" requireFileDirectory "$name" || return $?
  if $forceFlag; then
    statusMessage consoleInfo "Forcing apt-update ..."
  elif [ -f "$name" ]; then
    lastModified="$(modificationSeconds "$name")"
    # once an hour, technically
    if [ "$lastModified" -lt 3600 ]; then
      return 0
    fi
  fi
  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  statusMessage consoleInfo "apt-get update ... " || :
  DEBIAN_FRONTEND=noninteractive __usageEnvironmentQuiet "$usage" "$quietLog" apt-get update -y || return $?
  statusMessage reportTiming "$start" "System sources updated in"
  date +%s >"$name" || :
  clearLine || :
}
_aptUpdateOnce() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# List installed packages
aptListInstalled() {
  whichExists dpkg || __failEnvironment "$usage" "Not an apt system (no dpkg)" || return $?
  [ $# -eq 0 ] || __failArgument "$usage" "Unknown argument $*" || return $?
  dpkg --get-selections | grep -v deinstall | awk '{ print $1 }'
}
_aptListInstalled() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
  local usage="_${FUNCNAME[0]}"
  local argument nArguments
  local quietLog
  local actualPackages package packages installed standardPackages
  local apt start forceFlag

  nArguments=$#
  forceFlag=false
  read -r -a standardPackages < <(_aptStandardPackages)
  while [ $# -gt 0 ]; do
    argument="$(usageArgumentString "$usage" "argument #$((nArguments - $# + 1))" "${1-}")" || return $?
    case "$argument" in
      --help)
        "$usage" 0
        return $?
        ;;
      --force)
        forceFlag=true
        ;;
      *)
        packages+=("$argument")
        ;;
    esac
    shift || usageArgumentMissing "$usage" "$argument" || return $?
  done

  apt=$(which apt-get || :)
  if [ -z "$apt" ]; then
    statusMessage consoleWarning "No apt-get, blundering ahead ..."
    return 0
  fi
  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  quietLog=$(__usageEnvironment "$usage" buildQuietLog "${FUNCNAME[0]}") || return $?
  installed="$(__usageEnvironment "$usage" mktemp)" || return $?
  __usageEnvironmentQuiet "$usage" "$quietLog" aptUpdateOnce || return $?
  __usageEnvironment "$usage" aptListInstalled >"$installed" || return $?
  actualPackages=()
  for package in "${packages[@]+"${packages[@]}"}"; do
    if ! grep -q -e "^$package" <"$installed"; then
      actualPackages+=("$package")
    elif $forceFlag; then
      actualPackages+=("$package")
    fi
  done

  if [ "${#actualPackages[@]}" -eq 0 ]; then
    if [ -n "$*" ]; then
      consoleSuccess "Already installed: ${packages[*]}"
    fi
    return 0
  fi
  statusMessage consoleInfo "Installing ${packages[*]+"${packages[*]}"} ... "
  DEBIAN_FRONTEND=noninteractive __usageEnvironmentQuiet "$usage" "$quietLog" "$apt" install -y "${actualPackages[@]}" || return $?
  reportTiming "$start" OK
}
_aptInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# Output list of apt standard packages (constant)
_aptStandardPackages() {
  printf "%s\n" apt-utils figlet toilet toilet-fonts jq pcregrep
}

# Removes packages using `apt-get`. If `apt-get` is not available, this succeeds
# and assumes packages will be available. (For now)
#
# Usage: aptUninstall [ package ... ]
# Example:     aptInstall shellcheck
# Exit Code: 0 - If `apt-get` is not installed, returns 0.
# Exit Code: 1 - If `apt-get` fails to remove the packages
# Summary: Removes packages using `apt-get`
# Argument: package - One or more packages to install
# Artifact: `{fn}.log` is left in the `buildCacheDirectory`
#
aptUninstall() {
  local usage="_${FUNCNAME[0]}"
  local quietLog standardPackages
  local package
  local apt start

  read -r -a standardPackages < <(_aptStandardPackages)
  start=$(beginTiming)
  quietLog=$(buildQuietLog "${FUNCNAME[0]}")
  apt=$(which apt-get || :)
  if [ -z "$apt" ]; then
    statusMessage consoleWarning "No apt-get, blundering ahead ..."
    return 0
  fi

  __usageEnvironmentQuiet "$usage" "$quietLog" aptUpdateOnce || return $?

  for package in "$@"; do
    if inArray "$package" "${standardPackages[@]}"; then
      __failArgument "$usage" "Unable to remove standard package $(consoleCode "$package")" || return $?
    fi
  done

  statusMessage consoleInfo "Uninstalling $* ... "
  DEBIAN_FRONTEND=noninteractive __usageEnvironmentQuiet "$usage" "$quietLog" "$apt" remove -y "$@" || return $?
  statusMessage reportTiming "$start" "Uninstallation of $* completed in" || :
  clearLine
}
_aptUninstall() {
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
  local usage="_${FUNCNAME[0]}"
  local savedArguments
  local binary="${1-}"
  savedArguments=("$@")

  [ -n "$binary" ] || __failArgument "$usage" "Missing binary" || return $?
  shift
  [ $# -gt 0 ] || __failArgument "$usage" "Missing apt packages (${savedArguments[*]})" || return $?
  if whichExists "$binary"; then
    return 0
  fi
  __environment aptInstall --force "$@" || return $?
  if whichExists "$binary"; then
    return 0
  fi
  __failEnvironment "$usage" "Apt packages \"$*\" did not add $binary to the PATH: ${PATH-}" || return $?
}
_whichApt() {
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
# Argument: binary - Required. String. The binary to look for.
# Argument: aptInstallPackage - The package name to install if the binary is not found in the `$PATH`.
# Environment: Technically this will install the binary and any related files as a package.
#
whichAptUninstall() {
  local usage="_${FUNCNAME[0]}"
  local binary="${1-}" foundPath
  [ -n "$binary" ] || __failArgument "$usage" "Missing binary" || return $?
  shift
  [ $# -ne 0 ] || __failArgument "$usage" "Missing apt packages" || return $?
  if ! whichExists "$binary"; then
    return 0
  fi
  __environment aptUninstall "$@" || return $?
  foundPath="$(which "$binary" || :)"
  [ -z "$foundPath" ] || __failEnvironment "$usage" "aptUninstall \"$*\" did not remove $(consoleCode "$foundPath") FROM the PATH: $(consoleValue "${PATH-}")" || return $?
}
_whichAptUninstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} [ value ]
# INTERNAL - has `aptUpToDate` set the `restart` flag at some point?
# Argument: value - Set the restart flag to this value (blank to remove)
aptNeedRestartFlag() {
  local usage="_${FUNCNAME[0]}"
  local quietLog upgradeLog restartFlag result

  restartFlag=$(__usageEnvironment "$usage" buildCacheDirectory ".needRestart") || return $?
  if [ $# -eq 0 ]; then
    if [ -f "$restartFlag" ]; then
      __usageEnvironment "$usage" cat "$restartFlag" || return $?
    else
      return 1
    fi
  else
    if [ "$1" = "" ]; then
      rm -f "$restartFlag" || :
    else
      printf "%s\n" "$@" >"$restartFlag" || __failEnvironment "$usage" "Unable to write $restartFlag" || return $?
    fi
  fi
}
_aptNeedRestartFlag() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
aptUpToDate() {
  local usage="_${FUNCNAME[0]}"
  local quietLog upgradeLog result

  quietLog=$(__usageEnvironment "$usage" buildQuietLog "${FUNCNAME[0]}") || return $?
  upgradeLog=$(__usageEnvironment "$usage" buildQuietLog "STATE_${FUNCNAME[0]}") || return $?
  # statusMessage consoleInfo "Update ... " 1>&2
  __usageEnvironmentQuiet "$quietLog" aptUpdateOnce || return $?
  __usageEnvironmentQuiet "$quietLog" aptInstall || return $?
  DEBIAN_FRONTEND=noninteractive NEEDRESTART_MODE=l __usageEnvironment "$usage" apt-get -y dist-upgrade | tee -a "$upgradeLog" >>"$quietLog"
  if ! aptNeedRestartFlag >/dev/null; then
    if grep -q " restart " "$upgradeLog" || grep -qi needrestart "$upgradeLog"; then
      __usageEnvironment "$usage" aptNeedRestartFlag "$restartFlag" || return $?
    fi
    result=restart
  else
    aptNeedRestartFlag "" || __failEnvironment "$usage" "Unable to delete restart flag" || return $?
    result=ok
  fi
  printf "%s\n" "$result"
}
_aptUpToDate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Add keys to enable apt to download terraform directly from hashicorp.com
#
# Usage: {fn} --name keyName [ --title title ] remoteUrl
# Argument: --title title - Optional. String. Title of the key.
# Argument: --name name - Required. String. Name of the key used to generate file names.
# Argument: --url remoteUrl - Required. URL. Remote URL of gpg key.
# Exit Code: 1 - if environment is awry
# Exit Code: 0 - Apt key is installed AOK
#
aptKeyAdd() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments
  local name title remoteUrl host quietLog
  local start ring sourcesPath keyFile skipUpdate

  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  sourcesPath="$(_aptSourcesPath "$usage")" || return $?
  ring=$(_aptKeyRings "$usage") || return $?

  # apt-key is deprecated for good reasons
  # https://stackoverflow.com/questions/68992799/warning-apt-key-is-deprecated-manage-keyring-files-in-trusted-gpg-d-instead

  name=
  title=
  remoteUrl=
  skipUpdate=false
  nArguments=$#
  while [ $# -gt 0 ]; do
    argument="$(usageArgumentString "$usage" "argument #$((nArguments - $# + 1))" "${1-}")" || return $?
    case "$argument" in
      --help)
        "$usage" 0
        return $?
        ;;
      --name)
        shift
        name="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      --skip)
        skipUpdate=true
        ;;
      --title)
        shift
        title="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      --url)
        shift
        remoteUrl="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      *)
        __failArgument "$usage" "unknown argument #$((nArguments - $# + 1)): $argument" || return $?
        ;;
    esac
    shift || usageArgumentMissing "$usage" "$argument" || return $?
  done

  name="$(usageArgumentString "$usage" "--name" "$name")" || return $?
  remoteUrl="$(usageArgumentString "$usage" "--name" "$remoteUrl")" || return $?
  host=$(urlParseItem host "$remoteUrl") || __failArgument "$usage" "Unable to get host from $remoteUrl" || return $?

  _usageAptPermissions "$usage" "$sourcesPath" || return $?

  title="${title:-"$name"}"
  statusMessage consoleInfo "Fetching $title key ... "
  keyFile="$ring/$name.gpg"
  __usageEnvironment "$usage" curl -fsSL "$remoteUrl" | gpg --dearmor | tee "$keyFile" >/dev/null || return $?
  statusMessage consoleInfo "Adding repository and updating sources ... "
  __usageEnvironment "$usage" printf "deb [signed-by=%s] https://%s %s main" "$keyFile" "$host" "$(lsb_release -cs)" >"/etc/apt/sources.list.d/$name.list" || return $?
  quietLog=$(buildQuietLog "$usage") || __failEnvironment "$usage" buildQuietLog "$usage" || return $?
  if ! $skipUpdate; then
    statusMessage consoleSuccess "Updating apt sources ... "
    __usageEnvironment "$usage" aptUpdateOnce --force || return $?
  else
    statusMessage consoleSuccess "Skipped update ... "
  fi
  statusMessage reportTiming "$start" "Added $title to sources in"
  clearLine || :
}
_aptKeyAdd() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Remove apt keys
#
# Usage: {fn} keyName [ ... ]
# Argument: keyName - Required. String. One or more key names to remove.
# Exit Code: 1 - if environment is awry
# Exit Code: 0 - Apt key is installed AOK
#
aptKeyRemove() {
  local usage="_${FUNCNAME[0]}"
  local ring=/etc/apt/keyrings
  local argument nArguments
  local name start
  local sourcesPath
  local quietLog names skipUpdate

  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  sourcesPath="$(_aptSourcesPath "$usage")" || return $?
  ring=$(_aptKeyRings "$usage") || return $?

  names=()
  skipUpdate=false
  nArguments=$#
  while [ $# -gt 0 ]; do
    argument="$(usageArgumentString "$usage" "argument #$((nArguments - $# + 1))" "${1-}")" || return $?
    case "$argument" in
      --help)
        "$usage" 0
        return $?
        ;;
      --skip)
        skipUpdate=true
        ;;
      *)
        names+=("$argument")
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$((nArguments - $# + 1)): $argument" || return $?
  done

  [ "${#names[@]}" -gt 0 ] || __failArgument "$usage" "No keyNames supplied" || return $?

  _usageAptPermissions "$usage" "$sourcesPath" || return $?

  for name in "${names[@]}"; do
    for file in "$ring/$name.gpg" "$sourcesPath/$name.list"; do
      if [ -f "$file" ]; then
        statusMessage consoleWarning "Removing $(consoleCode "$file") ... "
        __usageEnvironment "$usage" rm -f "$file" || return $?
      else
        statusMessage consoleSuccess "Already deleted $(consoleCode "$file") ... "
      fi
    done
  done
  if ! $skipUpdate; then
    statusMessage consoleSuccess "Updating apt sources ... "
    __usageEnvironment "$usage" aptUpdateOnce --force || return $?
  else
    statusMessage consoleSuccess "Skipped update ... "
  fi
  statusMessage reportTiming "$start" "Removed ${names[*]} from sources in "
}
_aptKeyRemove() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
