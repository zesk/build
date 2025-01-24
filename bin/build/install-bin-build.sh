#!/usr/bin/env bash
#
# Since scripts may copy this file directly, must replicate until deprecated
#
# Load build system - part of zesk/build
#
# Copy this into your project to install the build system during development and in pipelines
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# URL of latest release
__installBinBuildLatest() {
  printf -- "%s\n" "https://api.github.com/repos/zesk/build/releases/latest"
}

# Download remote JSON as a temporary file (delete it)
__installBinBuildJSON() {
  local usage="$1" jsonFile message

  whichExists jq || __failEnvironment "$usage" "Requires jq to install" || return $?
  jsonFile=$(fileTemporaryName "$usage") || return $?
  if ! curl -s "$(__installBinBuildLatest)" >"$jsonFile" 2>&1; then
    message="$(printf -- "%s\n%s\n" "Unable to fetch latest JSON:" "$(cat "$jsonFile")")"
    rm -rf "$jsonFile" || :
    __failEnvironment "$usage" "$message" || return $?
  fi
  printf "%s\n" "$jsonFile"
}

__installJSONField() {
  local usage="$1" selector="$2" jsonFile="$3" value message
  if ! value=$(jq -r "$selector" <"$jsonFile"); then
    message="$(printf -- "%s\n%s\n" "Unable to fetch selector from JSON:" "$(cat "$jsonFile")")"
    rm -f "$jsonFile" || :
    __failEnvironment "$usage" "$message" || return $?
  fi
  printf -- "%s\n" "$value"
}

__githubInstallationURL() {
  local usage="$1" jsonFile="$2"
  url=$(__installJSONField "$usage" .tarball_url "$jsonFile") || return $?
  printf -- "%s\n" "$url"
}

# Installs Zesk Build from GitHub
__installBinBuildURL() {
  local usage="$1" jsonFile

  export ___TEMP_BIN_BUILD_URL
  if [ -n "${___TEMP_BIN_BUILD_URL-}" ]; then
    printf "%s\n" "$___TEMP_BIN_BUILD_URL"
    return 0
  fi
  jsonFile=$(__installBinBuildJSON "$usage") || return $?
  url=$(__githubInstallationURL "$usage" "$jsonFile") || return $?
  rm -rf "$jsonFile" || :
  [ "${url#https://}" != "$url" ] || __failArgument "$usage" "URL must begin with https://" || return $?
  ___TEMP_BIN_BUILD_URL="$url"
  printf -- "%s\n" "$url"
}

# Checks Zesk Build version on GitHub
__installBinBuildVersion() {
  local usage="$1" installPath="$2" packagePath="$3" jsonFile version url

  export ___TEMP_BIN_BUILD_URL

  jsonFile=$(__installBinBuildJSON "$usage") || return $?

  # Version comparison
  version=$(__installJSONField "$usage" .tag_name "$jsonFile") || return $?
  [ -n "$version" ] || __failEnvironment "$usage" "Fetched version was blank" || return $?
  if [ -d "$packagePath" ] && [ -f "$packagePath/build.json" ]; then
    myVersion=$(jq .version <"$packagePath/build.json")
    if [ "$myVersion" = "$version" ]; then
      printf -- "%s 👌 " "$(decorate info "$version")"
      return 0
    fi
    printf -- "%s ☝️ %s " "$(decorate error "$myVersion")" "$(decorate success "$version")"
  fi

  # URL caching
  url=$(__githubInstallationURL "$usage" "$jsonFile") || return $?
  [ "${url#https://}" != "$url" ] || __failArgument "$usage" "URL must begin with https://" || return $?
  ___TEMP_BIN_BUILD_URL="$url"

  return 1
}

# Check the install directory after installation and output the version
__installBinBuildCheck() {
  __installCheck "zesk/build" "build.json" "$@"
}

# IDENTICAL __installCheck 14
# Check the directory after installation and output the version
# Usage: {fn} name versionFile usageFunction installPath
# Requires: dirname
# Requires: decorate printf __failEnvironment read jq
__installCheck() {
  local name="$1" version="$2" usage="$3" installPath="$4"
  local versionFile="$installPath/$version"
  if [ ! -f "$versionFile" ]; then
    __failEnvironment "$usage" "$(printf "%s: %s\n\n  %s\n  %s\n" "$(decorate error "$name")" "Incorrect version or broken install (can't find $version):" "rm -rf $(dirname "$installPath/$version")" "${BASH_SOURCE[0]}")" || return $?
  fi
  read -r version id < <(jq -r '(.version + " " + .id)' <"$versionFile" || :) || :
  [ -n "$version" ] && [ -n "$id" ] || __failEnvironment "$usage" "$versionFile missing version: \"$version\" or id: \"$id\"" || return $?
  printf "%s %s (%s)\n" "$(decorate bold-blue "$name")" "$(decorate code "$version")" "$(decorate orange "$id")"
}

# Environment: Needs internet access and creates a directory `./bin/build`
# Usage: {fn} relativePath installPath url urlFunction [ --local localPackageDirectory ] [ --debug ] [ --force ] [ --diff ]
# fn: {base}
# Installs a remote package system in a local project directory if not installed. Also
# will overwrite the installation binary with the latest version after installation.
#
# Determines the most recent version using GitHub API unless --url or --local is specified
#
# Argument: --local localPackageDirectory - Optional. Directory. Directory of an existing bin/infrastructure installation to mock behavior for testing
# Argument: --url url - Optional. URL. URL of a tar.gz. file. Download source code from here.
# Argument: --debug - Optional. Flag. Debugging is on.
# Argument: --force - Optional. Flag. Force installation even if file is up to date.
# Argument: --diff - Optional. Flag. Show differences between old and new file.
# Exit Code: 1 - Environment error
# Exit Code: 2 - Argument error
__installPackageConfiguration() {
  local rel="$1"
  shift
  _installRemotePackage "$rel" "bin/build" "install-bin-build.sh" --url-function __installBinBuildURL --check-function __installBinBuildCheck "$@"
}

# IDENTICAL _installRemotePackage 287

# Installs a remote package system in a local project directory if not installed. Also
# will overwrite the installation binary with the latest version after installation.
#
# URL can be determined programmatically using `urlFunction`.
# `versionFunction` can be used to avoid upgrades when versions have not changed.
#
# Calling signature for `version-function`:
#
#    versionFunction usageFunction applicationHome installPath
#    usageFunction - Function. Required. Function to call when an error occurs.
#    applicationHome - Required. Required. Path to the application home where target will be installed, or is installed. (e.g. myApp/)
#    installPath - Required. Required. Path to the installPath home where target will be installed, or is installed. (e.g. myApp/bin/build)
#
# Calling signature for `url-function`:
#
#    urlFunction usageFunction
#    usageFunction - Function. Required. Function to call when an error occurs.
#
# Calling signature for `check-function`:
#
#    checkFunction usageFunction installPath
#
# If `checkFunction` fails, it should output any errors to `stderr` and return a non-zero exit code.
#
# Argument: --local localPackageDirectory - Optional. Directory. Directory of an existing installation to mock behavior for testing.
# Argument: --url url - Optional. URL. URL of a tar.gz. file. Download source code from here.
# Argument: --user headerText - Optional. String. Add `username:password` to remote request.
# Argument: --header headerText - Optional. String. Add one or more fetchArguments to the remote request.
# Argument: --version-function urlFunction - Optional. Function. Function to compare live version to local version. Exits 0 if they match. Output version text if you want.
# Argument: --url-function urlFunction - Optional. Function. Function to return the URL to download.
# Argument: --check-function checkFunction - Optional. Function. Function to check the installation and output the version number or package name.
# Argument: --debug - Optional. Flag. Debugging is on.
# Argument: --force - Optional. Flag. Force installation even if file is up to date.
# Argument: --diff - Optional. Flag. Show differences between old and new file.
# Argument: --replace fie - Optional. Flag. Replace the target file with this script and delete this one. Internal only, do not use.
# Exit Code: 1 - Environment error
# Exit Code: 2 - Argument error
# Requires: cp rm cat printf
# Requires: realPath whichExists _return fileTemporaryName
# Requires: __usageArgument __failArgument
# Requires: __usageEnvironment decorate
# Requires: usageArgumentString
_installRemotePackage() {
  local usage="_${FUNCNAME[0]}"

  local relative="${1-}" packagePath="${2-}" packageInstallerName="${3-}"

  shift 3

  case "${BUILD_DEBUG-}" in 1 | true) __installRemotePackageDebug BUILD_DEBUG ;; esac

  local installArgs=() url="" localPath="" forceFlag=false urlFunction="" checkFunction="" fetchArguments=()

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __failArgument "$usage" "blank #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    case "$argument" in
      --debug)
        __installRemotePackageDebug "$argument"
        ;;
      --diff)
        installArgs+=("$argument")
        ;;
      --replace)
        shift
        newName="$1"
        decorate bold-blue "Replacing $(decorate orange "${BASH_SOURCE[0]}") -> $(decorate bold-orange "$newName")"
        __usageEnvironment "$usage" cp -f "${BASH_SOURCE[0]}" "$newName" || return $?
        __usageEnvironment "$usage" rm -rf "${BASH_SOURCE[0]}" || return $?
        return 0
        ;;
      --force)
        forceFlag=true
        ;;
      --mock | --local)
        [ -z "$localPath" ] || __failArgument "$usage" "$argument already" || return $?
        shift
        [ -n "${1-}" ] || __failArgument "$usage" "$argument blank argument #$__index" || return $?
        localPath="$(__usageArgument "$usage" realPath "${1%/}")" || return $?
        [ -x "$localPath/tools.sh" ] || __failArgument "$usage" "$argument argument (\"$(decorate code "$localPath")\") must be path to bin/build containing tools.sh" || return $?
        ;;
      --user | --header | --password)
        shift
        fetchArguments+=("$argument" "$(usageArgumentString "$usage" "$argument" "${1-}")")
        ;;
      --url)
        shift
        [ -z "$url" ] || __failArgument "$usage" "$argument already" || return $?
        [ -n "${1-}" ] || __failArgument "$usage" "$argument blank argument" || return $?
        url="$1"
        ;;
      --version-function)
        shift
        [ -z "$versionFunction" ] || __failArgument "$usage" "$argument already" || return $?
        [ -n "${1-}" ] || __failArgument "$usage" "$argument blank argument" || return $?
        versionFunction="$1"
        ;;
      --url-function)
        shift
        [ -z "$urlFunction" ] || __failArgument "$usage" "$argument already" || return $?
        [ -n "${1-}" ] || __failArgument "$usage" "$argument blank argument" || return $?
        urlFunction="$1"
        ;;
      --check-function)
        shift
        [ -z "$checkFunction" ] || __failArgument "$usage" "$argument already" || return $?
        [ -n "${1-}" ] || __failArgument "$usage" "$argument blank argument" || return $?
        checkFunction="$1"
        ;;
      *)
        __failArgument "$usage" "unknown argument #$__index: $argument" || return $?
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$__index: $argument" || return $?
  done

  local installFlag=false message
  local myBinary myPath applicationHome installPath
  # Move to starting point
  myBinary=$(__usageEnvironment "$usage" realPath "${BASH_SOURCE[0]}") || return $?
  myPath="$(__usageEnvironment "$usage" dirname "$myBinary")" || return $?
  applicationHome=$(__usageEnvironment "$usage" realPath "$myPath/$relative") || return $?
  installPath="$applicationHome/$packagePath"

  if ! $forceFlag && [ -n "$versionFunction" ]; then
    if "$versionFunction" "$usage" "$applicationHome" "$installPath"; then
      decorate info "Versions match, no upgrade required."
      return 0
    fi
  fi

  if [ -z "$url" ]; then
    if [ -n "$urlFunction" ]; then
      url=$(__usageEnvironment "$usage" "$urlFunction" "$usage") || return $?
      if [ -z "$url" ]; then
        __failArgument "$usage" "$urlFunction failed" || return $?
      fi
    fi
  fi
  if [ -z "$url" ] && [ -z "$localPath" ]; then
    __failArgument "$usage" "--local or --url|--url-function is required" || return $?
  fi

  if [ ! -d "$installPath" ]; then
    if $forceFlag; then
      printf "%s (%s)\n" "$(decorate orange "Forcing installation")" "$(decorate blue "directory does not exist")"
    fi
    installFlag=true
  elif $forceFlag; then
    printf "%s (%s)\n" "$(decorate orange "Forcing installation")" "$(decorate bold-blue "directory exists")"
    installFlag=true
  fi
  binName=" ($(decorate bold-blue "$(basename "$myBinary")"))"
  if $installFlag; then
    local start
    start=$(($(__usageEnvironment "$usage" date +%s) + 0)) || return $?
    __installRemotePackageDirectory "$usage" "$packagePath" "$applicationHome" "$url" "$localPath" "${fetchArguments[@]+"${fetchArguments[@]}"}" || return $?
    [ -d "$installPath" ] || __failEnvironment "$usage" "Unable to download and install $packagePath ($installPath not a directory, still)" || return $?
    messageFile=$(fileTemporaryName "$usage") || return $?
    if [ -n "$checkFunction" ]; then
      "$checkFunction" "$usage" "$installPath" >"$messageFile" 2>&1 || return $?
    else
      __usageEnvironment "$usage" printf -- "%s\n" "$packagePath" >"$messageFile" || return $?
    fi
    message="Installed $(cat "$messageFile") in $(($(date +%s) - start)) seconds$binName"
    __usageEnvironment "$usage" rm -f "$messageFile" || return $?
  else
    messageFile=$(fileTemporaryName "$usage") || return $?
    if [ -n "$checkFunction" ]; then
      "$checkFunction" "$usage" "$installPath" >"$messageFile" 2>&1 || return $?
    else
      __usageEnvironment "$usage" printf -- "%s\n" "$packagePath" >"$messageFile" || return $?
    fi
    message="$(cat "$messageFile") already installed"
    rm -f "$messageFile" || :
  fi
  __installRemotePackageGitCheck "$applicationHome" "$packagePath" || :
  message="$message (local)$binName"
  printf -- "%s\n" "$message"
  __installRemotePackageLocal "$installPath/$packageInstallerName" "$myBinary" "$relative"
}

# Error handler for _installRemotePackage
# Usage: {fn} exitCode [ message ... ]
# Requires: printf decorate
__installRemotePackage() {
  local exitCode="$1"
  shift || :
  printf "%s: %s -> %s\n" "$(decorate code "${BASH_SOURCE[0]}")" "$(decorate error "$*")" "$(decorate orange "$exitCode")" 1>&2
  return "$exitCode"
}

# Debug is enabled, show why
# Requires: decorate
# Debugging: OK
__installRemotePackageDebug() {
  decorate orange "${1-} enabled" && set -x
}

# Install the package directory
# Requires: uname pushd popd rm tar
# Requires: __usageEnvironment __failEnvironment
__installRemotePackageDirectory() {
  local usage="$1" packagePath="$2" applicationHome="$3" url="$4" localPath="$5"
  local start tarArgs osName
  local target="$applicationHome/.$$.package.tar.gz"

  shift 5
  if [ -n "$localPath" ]; then
    __installRemotePackageDirectoryLocal "$usage" "$packagePath" "$applicationHome" "$localPath"
    return $?
  fi
  __usageEnvironment "$usage" __fetch "$usage" "$url" "$target" || return $?
  [ -f "$target" ] || __failEnvironment "$usage" "$target does not exist after download from $url" || return $?
  packagePath=${packagePath%/}
  packagePath=${packagePath#/}
  if ! osName="$(uname)" || [ "$osName" != "Darwin" ]; then
    tarArgs=(--wildcards "*/$packagePath/*")
  else
    tarArgs=(--include="*$packagePath/*")
  fi
  __usageEnvironment "$usage" pushd "$(dirname "$target")" >/dev/null || return $?
  __usageEnvironment "$usage" rm -rf "$packagePath" || return $?
  __usageEnvironment "$usage" tar xf "$target" --strip-components=1 "${tarArgs[@]}" || return $?
  __usageEnvironment "$usage" popd >/dev/null || return $?
  rm -f "$target" || :
}

# Install the build directory from a copy
# Requires: rm mv cp mkdir
# Requires: _undo __usageEnvironment __failEnvironment
__installRemotePackageDirectoryLocal() {
  local usage="$1" packagePath="$2" applicationHome="$3" localPath="$4" installPath tempPath

  installPath="${applicationHome%/}/${packagePath#/}"
  # Clean target regardless
  if [ -d "$installPath" ]; then
    tempPath="$installPath.aboutToDelete.$$"
    __usageEnvironment "$usage" rm -rf "$tempPath" || return $?
    __usageEnvironment "$usage" mv -f "$installPath" "$tempPath" || return $?
    __usageEnvironment "$usage" cp -r "$localPath" "$installPath" || _undo $? rf -f "$installPath" || _undo $? mv -f "$tempPath" "$installPath" || return $?
    __usageEnvironment "$usage" rm -rf "$tempPath" || :
  else
    tempPath=$(__usageEnvironment "$usage" dirname "$installPath") || return $?
    [ -d "$tempPath" ] || __usageEnvironment "$usage" mkdir -p "$tempPath" || return $?
    __usageEnvironment "$usage" cp -r "$localPath" "$installPath" || return $?
  fi
}

# Check .gitignore is correct
# Requires: grep printf
# Requires: decorate
__installRemotePackageGitCheck() {
  local applicationHome="$1" pattern="${2%/}"
  pattern="/${pattern#/}/"
  local ignoreFile="$1/.gitignore"
  if [ -f "$ignoreFile" ] && ! grep -q -e "^$pattern" "$ignoreFile"; then
    printf -- "%s %s %s %s:\n\n    %s\n" "$(decorate code "$ignoreFile")" \
      "does not ignore" \
      "$(decorate code "$pattern")" \
      "$(decorate error "recommend adding it")" \
      "$(decorate code "echo $pattern/ >> $ignoreFile")"
  fi
}

# Usage: {fn} _installRemotePackageSource targetBinary relativePath
# Requires: grep printf chmod wait
# Requires: _environment isUnsignedInteger dumpPipe _clean
__installRemotePackageLocal() {
  local source="$1" myBinary="$2" relTop="$3"
  local log="$myBinary.$$.log"
  {
    grep -v -e '^__installPackageConfiguration ' <"$source"
    printf "%s %s \"%s\"\n" "__installPackageConfiguration" "$relTop" '$@'
  } >"$myBinary.$$"
  chmod +x "$myBinary.$$" || _environment "chmod +x failed" || return $?
  "$myBinary.$$" --replace "$myBinary" >"$log" 2>&1 &
  local pid=$!
  if ! isUnsignedInteger "$pid"; then
    _environment "Unable to run $myBinary.$$" || return $?
  fi
  wait "$pid" || _environment "$(dumpPipe "install log failed: $pid" <"$log")" || _clean $? "$log" || return $?
  _clean 0 "$log" || return $?
}

# IDENTICAL _realPath 11
# Usage: realPath argument
# Argument: file ... - Required. File. One or more files to `realpath`.
# Requires: whichExists realpath
realPath() {
  # realpath is not present always
  if whichExists realpath; then
    realpath "$@"
  else
    readlink -f -n "$@"
  fi
}

# IDENTICAL fileTemporaryName 18
# Generate a temporary file name using mktemp, and fail using a function
# Argument: usage - Function. Required. Function to call if mktemp fails
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: ... - Optional. Arguments. Any additional arguments are passed through to mktemp.
# Requires: __help __usageEnvironment mktemp usageDocument
fileTemporaryName() {
  local usage="_${FUNCNAME[0]}"
  __help "$usage" "$@" || return 0
  usage="$1" && shift
  __usageEnvironment "$usage" mktemp "$@" || return $?
}
_fileTemporaryName() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# <-- END of IDENTICAL fileTemporaryName

# IDENTICAL whichExists 11
# Usage: {fn} binary ...
# Argument: binary - Required. String. Binary to find in the system `PATH`.
# Exit code: 0 - If all values are found
whichExists() {
  local __count=$# && [ $# -gt 0 ] || _argument "no arguments" || return $?
  while [ $# -gt 0 ]; do
    [ -n "${1-}" ] || _argument "blank argument #$((__count - $# + 1))" || return $?
    which "$1" >/dev/null || return 1
    shift
  done
}

# IDENTICAL _type 41

#
# Test if an argument is a positive integer (non-zero)
#
# Usage: {fn} argument ...
# Exit Code: 0 - if it is a positive integer
# Exit Code: 1 - if it is not a positive integer
# Requires: __usageArgument isUnsignedInteger usageDocument
isPositiveInteger() {
  # _IDENTICAL_ functionSignatureSingleArgument 2
  local usage="_${FUNCNAME[0]}"
  [ $# -eq 1 ] || __usageArgument "$usage" "Single argument only: $*" || return $?
  isUnsignedInteger "$1" || [ "$1" != "--help" ] || ! "$usage" 0 || return 0
  # Find pesky "0" or "+0"
  [ "$1" -gt 0 ] || return 1
}
_isPositiveInteger() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Test if argument are bash functions
# Usage: {fn} string0
# Argument: string - Required. String to test if it is a bash function. Builtins are supported. `.` is explicitly not supported to disambiguate it from the current directory `.`.
# If no arguments are passed, returns exit code 1.
# Exit code: 0 - argument is bash function
# Exit code: 1 - argument is not a bash function
# Requires: __usageArgument isUnsignedInteger usageDocument type
isFunction() {
  # _IDENTICAL_ functionSignatureSingleArgument 2
  local usage="_${FUNCNAME[0]}"
  [ $# -eq 1 ] || __usageArgument "$usage" "Single argument only: $*" || return $?
  # Skip illegal options "--" and "-foo"
  [ "$1" = "${1#-}" ] || return 1
  case "$(type -t "$1")" in function | builtin) [ "$1" != "." ] || return 1 ;; *) return 1 ;; esac
}
_isFunction() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL decorate 150

# Sets the environment variable `BUILD_COLORS` if not set, uses `TERM` to calculate
#
# Usage: hasColors
# Exit Code: 0 - Console or output supports colors
# Exit Code; 1 - Colors are likely not supported by console
# Environment: BUILD_COLORS - Optional. Boolean. Whether the build system will output ANSI colors.
# Requires: isPositiveInteger tput
hasColors() {
  local usage="_${FUNCNAME[0]}"
  local termColors
  export BUILD_COLORS TERM

  [ "${1-}" != "--help" ] || ! "$usage" 0 || return 0
  # Values allowed for this global are true and false
  # Important - must not use buildEnvironmentLoad BUILD_COLORS TERM; then
  BUILD_COLORS="${BUILD_COLORS-}"
  if [ -z "$BUILD_COLORS" ]; then
    BUILD_COLORS=false
    case "${TERM-}" in "" | "dumb" | "unknown") BUILD_COLORS=true ;; *)
      termColors="$(tput colors 2>/dev/null)"
      isPositiveInteger "$termColors" || termColors=2
      [ "$termColors" -lt 8 ] || BUILD_COLORS=true
      ;;
    esac
  elif [ "$BUILD_COLORS" = "1" ]; then
    # Backwards
    BUILD_COLORS=true
  elif [ -n "$BUILD_COLORS" ] && [ "$BUILD_COLORS" != "true" ]; then
    BUILD_COLORS=false
  fi
  [ "${BUILD_COLORS-}" = "true" ]
}
_hasColors() {
  ! false || hasColors --help
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Semantics-based
#
# Usage: {fn} label lightStartCode darkStartCode endCode [ -n ] [ message ]
# Requires: hasColors printf
__decorate() {
  local prefix="$1" start="$2" dp="$3" end="$4" && shift 4
  export BUILD_COLORS_MODE BUILD_COLORS
  if [ -n "${BUILD_COLORS-}" ] && [ "${BUILD_COLORS-}" = "true" ] || [ -z "${BUILD_COLORS-}" ] && hasColors; then
    if [ "${BUILD_COLORS_MODE-}" = "dark" ]; then
      start="$dp"
    fi
    if [ $# -eq 0 ]; then printf -- "%s$start" ""; else printf -- "$start%s$end\n" "$*"; fi
    return 0
  fi
  [ $# -gt 0 ] || return 0
  if [ -n "$prefix" ]; then printf -- "%s: %s\n" "$prefix" "$*"; else printf -- "%s\n" "$*"; fi
}

# Singular decoration function
# Usage: decorate style [ text ... ]
# Argument: style - String. Required. One of: reset underline no-underline bold no-bold black black-contrast blue cyan green magenta orange red white yellow bold-black bold-black-contrast bold-blue bold-cyan bold-green bold-magenta bold-orange bold-red bold-white bold-yellow code info notice success warning error subtle label value decoration
# Argument: text - Text to output. If not supplied, outputs a code to change the style to the new style.
# stdout: Decorated text
# Depends: isFunction _argument awk __usageEnvironment usageDocument
decorate() {
  local usage="_${FUNCNAME[0]}" text="" what="${1-}" && shift
  local lp dp style
  if ! style=$(_caseStyles "$what"); then
    local extend
    extend="__decorateExtension$(printf "%s" "${what:0:1}" | awk '{print toupper($0)}')${what:1}"
    # When this next line calls `__usageArgument` it results in an infinite loop
    isFunction "$extend" || _argument "Unknown decoration name: $what ($extend)" || return $?
    __usageEnvironment "$usage" "$extend" "$@" || return $?
    return $?
  fi
  read -r lp dp text <<<"$style" || :
  local p='\033['
  __decorate "$text" "${p}${lp}m" "${p}${dp:-$lp}m" "${p}0m" "$@"
}
_decorate() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Enables timing
# Usage: {fn} style
# Exit Code: 1 - not found
# Exit Code: 0 - found
# stdout: 1, 2, or 3 tokens + newline: lightColor darkColor text
# Requires: printf
_caseStyles() {
  case "$1" in
    reset) lp='0' ;;
      # styles
    underline) lp='4' ;;
    no-underline) lp='24' ;;
    bold) lp='1' ;;
    no-bold) lp='21' ;;
      # colors
    black) lp='109;7' ;;
    black-contrast) lp='107;30' ;;
    blue) lp='94' ;;
    cyan) lp='36' ;;
    green) lp='92' ;;
    magenta) lp='35' ;;
    orange) lp='33' ;;
    red) lp='31' ;;
    white) lp='48;5;0;37' ;;
    yellow) lp='48;5;16;38;5;11' ;;
      # bold-colors
    bold-black) lp='1;109;7' ;;
    bold-black-contrast) lp='1;107;30' ;;
    bold-blue) lp='1;94' ;;
    bold-cyan) lp='1;36' ;;
    bold-green) lp='92' ;;
    bold-magenta) lp='1;35' ;;
    bold-orange) lp='1;33' ;;
    bold-red) lp='1;31' ;;
    bold-white) lp='1;48;5;0;37' ;;
    bold-yellow) lp='1;48;5;16;38;5;11' ;;
      # semantic-colors
    code) lp='1;97;44' ;;
    info) lp='38;5;20' && dp='1;33' && text="Info" ;;
    success) lp='42;30' && dp='0;32' && text="SUCCESS" ;;
    warning) lp='1;93;41' && text="Warning" ;;
    error) lp='1;91' && text="ERROR" ;;
    subtle) lp='1;38;5;252' && dp='1;38;5;240' ;;
    label) lp='34;103' && dp='1;96' ;;
    value) lp='1;40;97' && dp='1;97' ;;
    decoration) lp='45;97' && dp='45;30' ;;
    *)
      return 1
      ;;
  esac
  printf "%s %s %s\n" "$lp" "${dp:-$lp}" "$text"
}

# Usage: decorate each decoration argument1 argument2 ...
# Runs the following command on each subsequent argument to allow for formatting with spaces
# Requires: decorate printf
__decorateExtensionEach() {
  local code="$1" formatted=()

  shift || return 0
  while [ $# -gt 0 ]; do
    formatted+=("$(decorate "$code" "$1")")
    shift
  done
  IFS=" " printf -- "%s\n" "${formatted[*]-}"
}

# IDENTICAL _return 25
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
# Requires: isUnsignedInteger printf
_return() {
  local r="${1-:1}" && shift
  isUnsignedInteger "$r" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf -- "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
}

# Test if an argument is an unsigned integer
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Original: is_uint
# Usage: {fn} argument ...
# Exit Code: 0 - if it is an unsigned integer
# Exit Code: 1 - if it is not an unsigned integer
# Requires: _return
isUnsignedInteger() {
  [ $# -eq 1 ] || _return 2 "Single argument only: $*" || return $?
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

# IDENTICAL _tinySugar 61

# Run `usage` with an argument error
# Usage: {fn} usage ...
__failArgument() {
  local usage="${1-}"
  shift && "$usage" 2 "$@" || return $?
}

# Run `usage` with an environment error
# Usage: {fn} usage ...
__failEnvironment() {
  local usage="${1-}"
  shift && "$usage" 1 "$@" || return $?
}

# Run `command`, upon failure run `usage` with an argument error
# Usage: {fn} usage command ...
# Argument: usage - Required. String. Failure command
# Argument: command - Required. Command to run.
# Requires: __failArgument
__usageArgument() {
  local usage="${1-}"
  shift && "$@" || __failArgument "$usage" "$@" || return $?
}

# Run `command`, upon failure run `usage` with an environment error
# Usage: {fn} usage command ...
# Argument: usage - Required. String. Failure command
# Argument: command - Required. Command to run.
# Requires: __failEnvironment
__usageEnvironment() {
  local usage="${1-}"
  shift && "$@" || __failEnvironment "$usage" "$@" || return $?
}

# Return `argument` error code always. Outputs `message ...` to `stderr`.
# Usage: {fn} message ..`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 2
# Requires: _return
_argument() {
  _return 2 "$@" || return $?
}

# Return `environment` error code always. Outputs `message ...` to `stderr`.
# Usage: {fn} message ...
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 1
# Requires: _return
_environment() {
  _return 1 "$@" || return $?
}

# Usage: {fn} exitCode item ...
# Argument: exitCode - Required. Integer. Exit code to return.
# Argument: item - Optional. One or more files or folders to delete, failures are logged to stderr.
# Requires: rm
_clean() {
  local r="${1-}" && shift && rm -rf "$@"
  return "$r"
}

# Final line will be rewritten on update
#
# Points to the project root relative to this file's location
#
# So:
#
# - "bin/install-bin-build.sh" -> ".."
# - "bin/pipeline/install-bin-build.sh" -> "../.."
# - "bin/app/vendorApp/install-bin-build.sh" -> "../../.."
#
# -- DO NOT EDIT ANYTHING ABOVE THIS LINE IT WILL BE OVERWRITTEN --
__installPackageConfiguration ../.. "$@"
