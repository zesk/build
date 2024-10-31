#!/usr/bin/env bash
#
# apt functions
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/tools/apt.md
# Test: o ./test/tools/apt-tests.sh

#
# Is apt-get installed?
#
aptIsInstalled() {
  whichExists apt apt-get dpkg && [ -f /etc/debian_version ]
}

aptNonInteractive() {
  DEBIAN_FRONTEND=noninteractive NEEDRESTART_MODE=l apt-get "$@"
}

# Get key ring directory path
aptKeyRingDirectory() {
  printf "%s\n" "/etc/apt/keyrings"
}

# Get APT source list path
aptSourcesDirectory() {
  printf "%s\n" "/etc/apt/sources.list.d"
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

    statusMessage decorate info "Fetching $title key ... "
    keyFile="$ring/$name.gpg"
    __usageEnvironment "$usage" curl -fsSL "$url" | gpg --no-tty --batch --dearmor | tee "$keyFile" >/dev/null || return $?
    __usageEnvironment "$usage" chmod a+r "$keyFile" || return $?
    signFiles+=("$keyFile")
    index=$((index + 1))
  done

  [ -n "$repoUrl" ] || repoUrl="https://$host/"

  signFileText="$(joinArguments "," "${signFiles[@]}")"
  statusMessage decorate info "Adding repository and updating sources ... "

  [ -n "$listName" ] || listName="${names[0]}"
  sourcesPath=$(_usageAptSourcesPath "$usage") || return $?
  listTarget="$sourcesPath/$listName.list"
  printf -- "%s\n" "# Generated by ${FUNCNAME[0]} on $(date "+%F %T")" >"$listTarget"
  for sourceType in "${sourceTypes[@]}"; do
    __usageEnvironment "$usage" printf -- "%s [signed-by=%s] %s %s %s\n" "$sourceType" "$signFileText" "$repoUrl" "$releaseName" "main" >>"$listTarget" || return $?
  done
  __usageEnvironment "$usage" chmod a+r "$listTarget" || return $?
  if ! $skipUpdate; then
    statusMessage decorate success "Updating sources ... "
    __usageEnvironment "$usage" packageUpdate --force || return $?
  else
    statusMessage decorate success "Skipped update ... "
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
        statusMessage decorate warning "Removing $(decorate code "$file") ... "
        __usageEnvironment "$usage" rm -f "$file" || return $?
      else
        statusMessage decorate success "Already deleted $(decorate code "$file") ... "
      fi
    done
  done
  if ! $skipUpdate; then
    statusMessage decorate success "Updating apt sources ... "
    __usageEnvironment "$usage" packageUpdate --force || return $?
  else
    statusMessage decorate success "Skipped update ... "
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

################################################################################################################################
#
#             ▌                ▌
#    ▛▀▖▝▀▖▞▀▖▌▗▘▝▀▖▞▀▌▞▀▖  ▞▀▘▛▀▖
#    ▙▄▘▞▀▌▌ ▖▛▚ ▞▀▌▚▄▌▛▀ ▗▖▝▀▖▌ ▌
#    ▌  ▝▀▘▝▀ ▘ ▘▝▀▘▗▄▘▝▀▘▝▘▀▀ ▘ ▘
#

# Install apt packages
__aptInstall() {
  aptNonInteractive install -y "$@"
}

# Uninstall apt packages
__aptUninstall() {
  aptNonInteractive remove -y "$@"
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
__aptUpgrade() {
  aptNonInteractive dist-upgrade -y "$@"
}

# Update the global database
# See: packageUpdate
# package.sh: true
__aptUpdate() {
  aptNonInteractive update -y "$@"
}

# Usage: {fn}
# List installed packages
# package.sh: true
__aptInstalledList() {
  local usage="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __failArgument "$usage" "Unknown argument $*" || return $?
  dpkg --get-selections | grep -v deinstall | awk '{ print $1 }'
}
___aptInstalledList() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# List available packages
# package.sh: true
__aptAvailableList() {
  local usage="_${FUNCNAME[0]}"
  apt-cache pkgnames
}
___aptAvailableList() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# Output list of apt standard packages (constant)
# See: _packageStandardPackages
# package.sh: true
__aptStandardPackages() {
  printf "%s\n" apt-utils toilet toilet-fonts jq pcregrep
  export BUILD_TEXT_BINARY
  BUILD_TEXT_BINARY="toilet"
}

#
#   ____                                _           _
#  |  _ \  ___ _ __  _ __ ___  ___ __ _| |_ ___  __| |
#  | | | |/ _ \ '_ \| '__/ _ \/ __/ _` | __/ _ \/ _` |
#  | |_| |  __/ |_) | | |  __/ (_| (_| | ||  __/ (_| |
#  |____/ \___| .__/|_|  \___|\___\__,_|\__\___|\__,_|
#             |_|
#

# DEPRECATED
# See: packageUninstall
aptUninstall() {
  packageUninstall --manager apt "$@"
}

# DEPRECATED
# See: packageWhich
whichApt() {
  packageWhich --manager apt "$@"
}

# DEPRECATED
# See: packageWhichUninstall
whichAptUninstall() {
  packageWhichUninstall --manager apt "$@"
}

# DEPRECATED
# See: packageNeedRestartFlag
aptNeedRestartFlag() {
  packageNeedRestartFlag "$@"
}
