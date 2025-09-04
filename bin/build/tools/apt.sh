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
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  whichExists apt apt-get dpkg && [ -f /etc/debian_version ]
}
_aptIsInstalled() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run apt-get non-interactively
# Argument: ... - Pass through arguments to `apt-get`
aptNonInteractive() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  DEBIAN_FRONTEND=noninteractive NEEDRESTART_MODE=l apt-get "$@"
}
_aptNonInteractive() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Get key ring directory path
aptKeyRingDirectory() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  printf "%s\n" "/etc/apt/keyrings"
}
_aptKeyRingDirectory() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Get APT source list path
aptSourcesDirectory() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  printf "%s\n" "/etc/apt/sources.list.d"
}
_aptSourcesDirectory() {
  # __IDENTICAL__ usageDocument 1
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
  local handler="_${FUNCNAME[0]}"

  local names=() title="" remoteUrls=() skipUpdate=false listName="" releaseName="" repoUrl=""
  local name url host index IFS file listTarget
  local start ring sourcesPath keyFile skipUpdate signFiles signFileText sourceType sourceTypes=(deb)

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --name)
      shift
      names+=("$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      ;;
    --skip)
      skipUpdate=true
      ;;
    --title)
      shift
      title="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      ;;
    --source)
      shift
      sourceTypes+=("$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      ;;
    --repository-url)
      shift
      repoUrl="$(usageArgumentURL "$handler" "$argument" "${1-}")" || return $?
      ;;
    --list)
      shift
      listName="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      ;;
    --release)
      shift
      releaseName="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      ;;
    --url)
      shift
      remoteUrls+=("$(usageArgumentURL "$handler" "$argument" "${1-}")") || return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  start=$(timingStart) || return $?
  sourcesPath="$(_usageAptSourcesPath "$handler")" || return $?
  ring=$(_usageAptKeyRings "$handler") || return $?

  # apt-key is deprecated for good reasons
  # https://stackoverflow.com/questions/68992799/warning-apt-key-is-deprecated-manage-keyring-files-in-trusted-gpg-d-instead

  [ "${#names[@]}" -gt 0 ] || __throwArgument "$handler" "Need at least one --name" || return $?
  [ "${#remoteUrls[@]}" -gt 0 ] || __throwArgument "$handler" "Need at least one --url" || return $?
  [ "${#names[@]}" -eq "${#remoteUrls[@]}" ] || __throwArgument "$handler" "Mismatched --name and --url pairs: ${#names[@]} != ${#remoteUrls[@]}" || return $?

  [ -n "$releaseName" ] || releaseName="$(__catchEnvironment "$handler" lsb_release -cs)" || return $?

  _usageAptPermissions "$handler" "$sourcesPath" || return $?

  index=0
  for name in "${names[@]}"; do
    url="${remoteUrls[index]}"
    host=$(urlParseItem host "$url") || __throwArgument "$handler" "Unable to get host from $url" || return $?
    title="${title:-"$name"}"

    statusMessage decorate info "Fetching $title key ... "
    keyFile="$ring/$name.gpg"
    __catchEnvironment "$handler" curl -fsSL "$url" | gpg --no-tty --batch --dearmor | tee "$keyFile" >/dev/null || return $?
    __catchEnvironment "$handler" chmod a+r "$keyFile" || return $?
    signFiles+=("$keyFile")
    index=$((index + 1))
  done

  [ -n "$repoUrl" ] || repoUrl="https://$host/"

  signFileText="$(listJoin "," "${signFiles[@]}")"
  statusMessage decorate info "Configuring repository ... "

  [ -n "$listName" ] || listName="${names[0]}"
  sourcesPath=$(_usageAptSourcesPath "$handler") || return $?
  listTarget="$sourcesPath/$listName.list"
  printf -- "%s\n" "# Generated by ${FUNCNAME[0]} on $(date "+%F %T")" >"$listTarget"
  for sourceType in "${sourceTypes[@]}"; do
    __catchEnvironment "$handler" printf -- "%s [signed-by=%s] %s %s %s\n" "$sourceType" "$signFileText" "$repoUrl" "$releaseName" "main" >>"$listTarget" || return $?
  done
  __catchEnvironment "$handler" chmod a+r "$listTarget" || return $?
  if ! $skipUpdate; then
    statusMessage --first decorate success "updating ... "
    __catch "$handler" packageUpdate --force || return $?
  else
    statusMessage --first decorate success "skipped ... "
  fi
  statusMessage --last timingReport "$start" "Added $title to sources in"
}
_aptKeyAdd() {
  # __IDENTICAL__ usageDocument 1
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
  local handler="_${FUNCNAME[0]}"

  local names=() skipUpdate=false verboseFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --verbose) verboseFlag=true ;;
    --skip) skipUpdate=true ;;
    *) names+=("$argument") ;;
    esac
    shift
  done

  [ "${#names[@]}" -gt 0 ] || __throwArgument "$handler" "No keyNames supplied" || return $?

  local start ring sourcesPath

  start=$(timingStart) || return $?

  ring=$(_usageAptKeyRings "$handler") || return $?
  sourcesPath="$(_usageAptSourcesPath "$handler")" || return $?

  [ -d "$ring" ] || __throwEnvironment "$handler" "Unable to remove key as $ring is not a directory" || return $?

  _usageAptPermissions "$handler" "$sourcesPath" || return $?

  for name in "${names[@]}"; do
    for file in "$ring/$name.gpg" "$sourcesPath/$name.list"; do
      if [ -f "$file" ]; then
        ! $verboseFlag || statusMessage decorate warning "Removing $(decorate code "$file") ... "
        __catchEnvironment "$handler" rm -f "$file" || return $?
      else
        ! $verboseFlag || statusMessage decorate success "Already deleted $(decorate code "$file") ... "
      fi
    done
  done
  if ! $skipUpdate; then
    ! $verboseFlag || statusMessage decorate success "Updating apt sources ... "
    __catch "$handler" packageUpdate --force || return $?
  else
    ! $verboseFlag || statusMessage decorate success "Skipped update ... "
  fi
  ! $verboseFlag || statusMessage timingReport "$start" "Removed ${names[*]} from sources in "
}
_aptKeyRemove() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# sources constant with checking
# Usage: {fn} usageFunction
_usageAptSourcesPath() {
  local handler="$1" sourcesPath
  sourcesPath=$(__catchEnvironment "$handler" aptSourcesDirectory) || return $?
  [ -d "$sourcesPath" ] || __throwEnvironment "$handler" "No $sourcesPath exists - not an apt system" || return $?
  printf "%s\n" "$sourcesPath"
}

# key rings directory constant with creation
_usageAptKeyRings() {
  local handler="$1" ring
  # In case this changes later and may fail
  ring=$(__catch "$handler" aptKeyRingDirectory) || return $?
  if ! [ -d "$ring" ]; then
    __catchEnvironment "$handler" mkdir -p "$ring" || return $?
    __catchEnvironment "$handler" chmod 0755 "$ring" || return $?
  fi
  printf "%s\n" "$ring"
}

# permissions check for sourcesPath modifications
_usageAptPermissions() {
  local handler="$1" sourcesPath="$2"
  touch "$sourcesPath/$$.test" 2>/dev/null || __throwEnvironment "$handler" "No permission to modify $sourcesPath, failing" || return $?
  rm -f "$sourcesPath/$$.test" 2>/dev/null || __throwEnvironment "$handler" "No permission to delete in $sourcesPath, failing" || return $?
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

__aptDefault() {
  while [ $# -gt 0 ]; do
    case "$1" in
    mysqldump) printf -- "%s\n" "mariadb-dump" ;;
    mysql) printf -- "%s\n" "mariadb" ;;
    *) printf -- "%s\n" "$1" ;;
    esac
    shift
  done
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
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __throwArgument "$handler" "Unknown argument $*" || return $?
  dpkg --get-selections | grep -v deinstall | awk '{ print $1 }'
}
___aptInstalledList() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# List available packages
# package.sh: true
__aptAvailableList() {
  local handler="_${FUNCNAME[0]}"
  apt-cache pkgnames
}
___aptAvailableList() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# Output list of apt standard packages (constant)
# See: _packageStandardPackages
# package.sh: true
__aptStandardPackages() {
  printf "%s\n" apt-utils toilet toilet-fonts jq
  export BUILD_TEXT_BINARY
  [ -n "${BUILD_TEXT_BINARY-}" ] || BUILD_TEXT_BINARY="$(__bigTextBinary)"
}

# See: brew.sh apk.sh apt.sh macports.sh
# See: https://packages.ubuntu.com/search?mode=filename&section=all&arch=any&searchon=contents&keywords=sha1sum
__aptPackageMapping() {
  case "$1" in
  "python")
    printf "%s\n" python-is-python3 python3 python3-pip
    ;;
  "mariadb")
    printf "%s\n" mariadb-common mariadb-client
    ;;
  "mariadb-server")
    printf "%s\n" mariadb-common mariadb-server
    ;;
  "mysql")
    printf "%s\n" mysql-client
    ;;
  "mysql-server")
    printf "%s\n" mysql-server
    ;;
  "sha1sum")
    printf "%s\n" "coreutils"
    ;;
  *)
    printf "%s\n" "$1"
    ;;
  esac
}
