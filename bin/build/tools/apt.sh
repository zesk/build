#!/usr/bin/env bash
#
# apt functions
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/apt.md
# Test: o ./test/tools/apt-tests.sh

#
# Is apt-get installed?
#
aptIsInstalled() {
  whichExists apt apt-get dpkg && [ -f /etc/debian_version ]
}

# Run apt non-interactively
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

  local names=() title="" remoteUrls=() skipUpdate=false listName="" releaseName="" repoUrl=""
  local name url host index IFS file listTarget
  local start ring sourcesPath keyFile skipUpdate signFiles signFileText sourceType sourceTypes=(deb)

  start=$(timingStart) || return $?
  sourcesPath="$(_usageAptSourcesPath "$usage")" || return $?
  ring=$(_usageAptKeyRings "$usage") || return $?

  # apt-key is deprecated for good reasons
  # https://stackoverflow.com/questions/68992799/warning-apt-key-is-deprecated-manage-keyring-files-in-trusted-gpg-d-instead

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
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
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ "${#names[@]}" -gt 0 ] || __throwArgument "$usage" "Need at least one --name" || return $?
  [ "${#remoteUrls[@]}" -gt 0 ] || __throwArgument "$usage" "Need at least one --url" || return $?
  [ "${#names[@]}" -eq "${#remoteUrls[@]}" ] || __throwArgument "$usage" "Mismatched --name and --url pairs: ${#names[@]} != ${#remoteUrls[@]}" || return $?

  [ -n "$releaseName" ] || releaseName="$(__catchEnvironment "$usage" lsb_release -cs)" || return $?

  _usageAptPermissions "$usage" "$sourcesPath" || return $?

  index=0
  for name in "${names[@]}"; do
    url="${remoteUrls[index]}"
    host=$(urlParseItem host "$url") || __throwArgument "$usage" "Unable to get host from $url" || return $?
    title="${title:-"$name"}"

    statusMessage decorate info "Fetching $title key ... "
    keyFile="$ring/$name.gpg"
    __catchEnvironment "$usage" curl -fsSL "$url" | gpg --no-tty --batch --dearmor | tee "$keyFile" >/dev/null || return $?
    __catchEnvironment "$usage" chmod a+r "$keyFile" || return $?
    signFiles+=("$keyFile")
    index=$((index + 1))
  done

  [ -n "$repoUrl" ] || repoUrl="https://$host/"

  signFileText="$(listJoin "," "${signFiles[@]}")"
  statusMessage decorate info "Configuring repository ... "

  [ -n "$listName" ] || listName="${names[0]}"
  sourcesPath=$(_usageAptSourcesPath "$usage") || return $?
  listTarget="$sourcesPath/$listName.list"
  printf -- "%s\n" "# Generated by ${FUNCNAME[0]} on $(date "+%F %T")" >"$listTarget"
  for sourceType in "${sourceTypes[@]}"; do
    __catchEnvironment "$usage" printf -- "%s [signed-by=%s] %s %s %s\n" "$sourceType" "$signFileText" "$repoUrl" "$releaseName" "main" >>"$listTarget" || return $?
  done
  __catchEnvironment "$usage" chmod a+r "$listTarget" || return $?
  if ! $skipUpdate; then
    statusMessage --first decorate success "updating ... "
    __catchEnvironment "$usage" packageUpdate --force || return $?
  else
    statusMessage --first decorate success "skipped ... "
  fi
  statusMessage --last timingReport "$start" "Added $title to sources in"
}
_aptKeyAdd() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Remove apt keys
#
# Usage: {fn} keyName [ ... ]
# Argument: keyName - Required. String. One or more key names to remove.
# Argument: --skip - Flag. Optional.a Do not do `apt-get update` afterwards to update the database.
# Exit Code: 1 - if environment is awry
# Exit Code: 0 - Apt key is installed AOK
#
aptKeyRemove() {
  local usage="_${FUNCNAME[0]}"

  local names=() skipUpdate=false verboseFlag=false

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --verbose)
        verboseFlag=true
        ;;
      --skip)
        skipUpdate=true
        ;;
      *)
        names+=("$argument")
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ "${#names[@]}" -gt 0 ] || __throwArgument "$usage" "No keyNames supplied" || return $?

  local start ring sourcesPath

  start=$(timingStart) || return $?

  ring=$(_usageAptKeyRings "$usage") || return $?
  sourcesPath="$(_usageAptSourcesPath "$usage")" || return $?

  [ -d "$ring" ] || __throwEnvironment "$usage" "Unable to remove key as $ring is not a directory" || return $?

  _usageAptPermissions "$usage" "$sourcesPath" || return $?

  for name in "${names[@]}"; do
    for file in "$ring/$name.gpg" "$sourcesPath/$name.list"; do
      if [ -f "$file" ]; then
        ! $verboseFlag || statusMessage decorate warning "Removing $(decorate code "$file") ... "
        __catchEnvironment "$usage" rm -f "$file" || return $?
      else
        ! $verboseFlag || statusMessage decorate success "Already deleted $(decorate code "$file") ... "
      fi
    done
  done
  if ! $skipUpdate; then
    ! $verboseFlag || statusMessage decorate success "Updating apt sources ... "
    __catchEnvironment "$usage" packageUpdate --force || return $?
  else
    ! $verboseFlag || statusMessage decorate success "Skipped update ... "
  fi
  ! $verboseFlag || statusMessage timingReport "$start" "Removed ${names[*]} from sources in "
}
_aptKeyRemove() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# sources constant with checking
# Usage: {fn} usageFunction
_usageAptSourcesPath() {
  local usage="$1" sourcesPath
  sourcesPath=$(__catchEnvironment "$usage" aptSourcesDirectory) || return $?
  [ -d "$sourcesPath" ] || __throwEnvironment "$usage" "No $sourcesPath exists - not an apt system" || return $?
  printf "%s\n" "$sourcesPath"
}

# key rings directory constant with creation
_usageAptKeyRings() {
  local usage="$1" ring
  # In case this changes later and may fail
  ring=$(__catchEnvironment "$usage" aptKeyRingDirectory) || return $?
  if ! [ -d "$ring" ]; then
    __catchEnvironment "$usage" mkdir -p "$ring" || return $?
    __catchEnvironment "$usage" chmod 0755 "$ring" || return $?
  fi
  printf "%s\n" "$ring"
}

# permissions check for sourcesPath modifications
_usageAptPermissions() {
  local usage="$1" sourcesPath="$2"
  touch "$sourcesPath/$$.test" 2>/dev/null || __throwEnvironment "$usage" "No permission to modify $sourcesPath, failing" || return $?
  rm -f "$sourcesPath/$$.test" 2>/dev/null || __throwEnvironment "$usage" "No permission to delete in $sourcesPath, failing" || return $?
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
  # No way to hide the message
  #
  #     debconf: delaying package configuration, since apt-utils is not installed
  #
  # so just hide it always
  aptNonInteractive install -y "$@" 2> >(grep -v 'apt-utils is not installed' 1>&2) || return $?
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
  aptNonInteractive update -y "$@" || return $?
}

# Usage: {fn}
# List installed packages
# package.sh: true
__aptInstalledList() {
  local usage="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __throwArgument "$usage" "Unknown argument $*" || return $?
  dpkg --get-selections | grep -v deinstall | awk '{ print $1 }'
}
___aptInstalledList() {
  # _IDENTICAL_ usageDocument 1
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
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# Output list of apt standard packages (constant)
# See: _packageStandardPackages
# package.sh: true
__aptStandardPackages() {
  printf "%s\n" apt-utils toilet toilet-fonts jq pcregrep
  export BUILD_TEXT_BINARY
  [ -n "${BUILD_TEXT_BINARY-}" ] || BUILD_TEXT_BINARY="toilet"
}
