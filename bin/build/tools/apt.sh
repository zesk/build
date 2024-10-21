#!/usr/bin/env bash
#
# apt functions
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/tools/apt.md
# Test: o ./test/tools/apt-tests.sh

# Get key ring directory path
aptKeyRingDirectory() {
  printf "%s\n" "/etc/apt/keyrings"
}

# Get APT source list path
aptSourcesDirectory() {
  printf "%s\n" "/etc/apt/sources.list.d"
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
      # IDENTICAL --help 4
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
  __usageEnvironmentQuiet "$usage" "$quietLog" aptNonInteractive update -y || return $?
  statusMessage reportTiming "$start" "System sources updated in"
  date +%s >"$name" || :
  clearLine || :
}
_aptUpdateOnce() {
  # IDENTICAL usageDocument 1
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
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Install packages using `apt-get`. If `apt-get` is not available, this succeeds
# and assumes packages will be available.
#
# Main reason to use this instead of `apt-get` raw is it's quieter.
#
# Also does a simple lookup in the list of installed packages to avoid double-installation.
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
  local actualPackages package installed standardPackages
  local start forceFlag=false packages=()

  nArguments=$#
  forceFlag=false
  read -r -a standardPackages < <(_aptStandardPackages)
  while [ $# -gt 0 ]; do
    argument="$(usageArgumentString "$usage" "argument #$((nArguments - $# + 1))" "${1-}")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
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

  if ! aptIsInstalled; then
    statusMessage consoleWarning "No apt-get – blundering ahead ..."
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
    if [ "${#packages[@]}" -gt 0 ]; then
      consoleSuccess "Already installed: ${packages[*]}"
    fi
    return 0
  fi
  statusMessage consoleInfo "Installing ${packages[*]+"${packages[*]}"} ... "
  __usageEnvironmentQuiet "$usage" "$quietLog" aptNonInteractive install -y "${actualPackages[@]}" || return $?
  reportTiming "$start" OK
}
_aptInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Is apt-get installed?
#
aptIsInstalled() {
  whichExists apt-get
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
# Argument: binary - Required. String. The binary to look for
# Argument: aptInstallPackage - Required. String. The package name to install if the binary is not found in the `$PATH`.
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

# Installs an apt package if a binary does not exist in the `which` path (e.g. `$PATH`)
# The assumption here is that `aptUninstall` will install the desired `binary`.
#
# Confirms that `binary` is installed after installation succeeds.
#
# Summary: Install tools using `apt-get` if they are not found
# Usage: {fn} binary aptInstallPackage ...
# Example:     whichAptUninstall shellcheck shellcheck
# Example:     whichAptUninstall mariadb mariadb-client
# Argument: binary - Required. String. The binary to look for.
# Argument: aptInstallPackage - Required. String. The package name to uninstall if the binary is found in the `$PATH`.
# Environment: Technically this will uninstall the binary and any related files as a package.
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
  __usageEnvironment "$usage" aptUninstall "$@" || return $?
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
  local argument argumentIndex nArguments saved
  local names=() title="" remoteUrls=() skipUpdate=false listName="" releaseName="" repoUrl=""
  local name url host index IFS file listTarget
  local start ring sourcesPath keyFile skipUpdate signFiles signFileText sourceType sourceTypes=(deb)

  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  sourcesPath="$(_usageAptSourcesPath "$usage")" || return $?
  ring=$(_usageAptKeyRings "$usage") || return $?

  # apt-key is deprecated for good reasons
  # https://stackoverflow.com/questions/68992799/warning-apt-key-is-deprecated-manage-keyring-files-in-trusted-gpg-d-instead

  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --name)
        shift
        names+=("$(usageArgumentString "$usage" "$argument" "${1-}")") || return $?
        ;;
      --skip)
        skipUpdate=true
        ;;
      --title)
        shift
        title="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      --source)
        shift
        sourceTypes+=("$(usageArgumentString "$usage" "$argument" "${1-}")") || return $?
        ;;
      --repository-url)
        shift
        repoUrl="$(usageArgumentURL "$usage" "$argument" "${1-}")" || return $?
        ;;
      --list)
        shift
        listName="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      --release)
        shift
        releaseName="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      --url)
        shift
        remoteUrls+=("$(usageArgumentURL "$usage" "$argument" "${1-}")") || return $?
        ;;
      *)
        # IDENTICAL argumentUnknown 1
        __failArgument "$usage" "unknown argument #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done

  [ "${#names[@]}" -gt 0 ] || __failArgument "$usage" "Need at least one --name" || return $?
  [ "${#remoteUrls[@]}" -gt 0 ] || __failArgument "$usage" "Need at least one --url" || return $?
  [ "${#names[@]}" -eq "${#remoteUrls[@]}" ] || __failArgument "$usage" "Mismatched --name and --url pairs: ${#names[@]} != ${#remoteUrls[@]}" || return $?

  [ -n "$releaseName" ] || releaseName="$(__usageEnvironment "$usage" lsb_release -cs)" || return $?

  _usageAptPermissions "$usage" "$sourcesPath" || return $?

  index=0
  for name in "${names[@]}"; do
    url="${remoteUrls[index]}"
    host=$(urlParseItem host "$url") || __failArgument "$usage" "Unable to get host from $url" || return $?
    title="${title:-"$name"}"

    statusMessage consoleInfo "Fetching $title key ... "
    keyFile="$ring/$name.gpg"
    __usageEnvironment "$usage" curl -fsSL "$url" | gpg --no-tty --batch --dearmor | tee "$keyFile" >/dev/null || return $?
    __usageEnvironment "$usage" chmod a+r "$keyFile" || return $?
    signFiles+=("$keyFile")
    index=$((index + 1))
  done

  [ -n "$repoUrl" ] || repoUrl="https://$host/"

  signFileText="$(joinArguments "," "${signFiles[@]}")"
  statusMessage consoleInfo "Adding repository and updating sources ... "

  [ -n "$listName" ] || listName="${names[0]}"
  sourcesPath=$(_usageAptSourcesPath "$usage") || return $?
  listTarget="$sourcesPath/$listName.list"
  printf -- "%s\n" "# Generated by ${FUNCNAME[0]} on $(date "+%F %T")" >"$listTarget"
  for sourceType in "${sourceTypes[@]}"; do
    __usageEnvironment "$usage" printf -- "%s [signed-by=%s] %s %s %s\n" "$sourceType" "$signFileText" "$repoUrl" "$releaseName" "main" >>"$listTarget" || return $?
  done
  __usageEnvironment "$usage" chmod a+r "$listTarget" || return $?
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
  # IDENTICAL usageDocument 1
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
  local ring
  local argument nArguments file
  local name start
  local sourcesPath
  local names skipUpdate

  ring=$(__usageEnvironment "$usage" aptKeyRingDirectory) || return $?
  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  sourcesPath="$(_usageAptSourcesPath "$usage")" || return $?
  ring=$(_usageAptKeyRings "$usage") || return $?

  names=()
  skipUpdate=false
  nArguments=$#
  while [ $# -gt 0 ]; do
    argument="$(usageArgumentString "$usage" "argument #$((nArguments - $# + 1))" "${1-}")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
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

  [ -d "$ring" ] || __failEnvironment "$usage" "Unable to remove key as $ring is not a directory" || return $?
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
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# sources constant with checking
# Usage: {fn} usageFunction
_usageAptSourcesPath() {
  local usage="$1" sourcesPath
  sourcesPath=$(__usageEnvironment "$usage" aptSourcesDirectory) || return $?
  [ -d "$sourcesPath" ] || __failEnvironment "$usage" "No $sourcesPath exists - not an apt system" || return $?
  printf "%s\n" "$sourcesPath"
}

# key rings directory constant with creation
_usageAptKeyRings() {
  local usage="$1" ring
  # In case this changes later and may fail
  ring=$(__usageEnvironment "$usage" aptKeyRingDirectory) || return $?
  if ! [ -d "$ring" ]; then
    __usageEnvironment "$usage" mkdir -p "$ring" || return $?
    __usageEnvironment "$usage" chmod 0755 "$ring" || return $?
  fi
  printf "%s\n" "$ring"
}

# permissions check for sourcesPath modifications
_usageAptPermissions() {
  local usage="$1" sourcesPath="$2"
  touch "$sourcesPath/$$.test" 2>/dev/null || __failEnvironment "$usage" "No permission to modify $sourcesPath, failing" || return $?
  rm -f "$sourcesPath/$$.test" 2>/dev/null || __failEnvironment "$usage" "No permission to delete in $sourcesPath, failing" || return $?
}

aptNonInteractive() {
  DEBIAN_FRONTEND=noninteractive NEEDRESTART_MODE=l apt-get "$@"
}
