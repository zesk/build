#!/usr/bin/env bash
#
# Since scripts may copy this file directly, must replicate until deprecated
#
# Load build system - part of zesk/build
#
# Copy this into your project to install the build system during development and in pipelines
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# URL of latest release
__installBinBuildLatest() {
  printf "%s\n" "https://api.github.com/repos/zesk/build/releases/latest"
}

__installBinBuildURL() {
  local usage="$1" latestVersion

  latestVersion=$(__usageEnvironment "$usage" mktemp) || return $?
  if ! curl -s "$(__installBinBuildLatest)" >"$latestVersion"; then
    message="$(printf "%s\n%s\n" "Unable to fetch latest JSON:" "$(cat "$latestVersion")")"
    rm -f "$latestVersion" || :
    __failEnvironment "$usage" "$message" || return $?
  fi
  if ! url=$(jq -r .tarball_url <"$latestVersion"); then
    message="$(printf "%s\n%s\n" "Unable to fetch .tarball_url JSON:" "$(cat "$latestVersion")")"
    rm -f "$latestVersion" || :
    __failEnvironment "$usage" "$message" || return $?
  fi
  [ "${url#https://}" != "$url" ] || __failArgument "$usage" "URL must begin with https://" || return $?
  printf "%s\n" "$url"
}

# Check the install directory after installation and output the version
__installBinBuildCheck() {
  __installCheck "zesk/build" "build.json" "$@"
}

# IDENTICAL __installCheck 12
# Check the directory after installation and output the version
# Usage: {fn} name versionFile usageFunction installPath
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

# IDENTICAL _installRemotePackage 248

# Usage: {fn} relativePath installPath url urlFunction [ --local localPackageDirectory ] [ --debug ] [ --force ] [ --diff ]
# fn: {base}
# Installs a remote package system in a local project directory if not installed. Also
# will overwrite the installation binary with the latest version after installation.
#
# URL can be determined programmatically using `urlFunction`.
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
# Argument: --local localPackageDirectory - Optional. Directory. Directory of an existing bin/infrastructure installation to mock behavior for testing
# Argument: --url url - Optional. URL. URL of a tar.gz. file. Download source code from here.
# Argument: --user headerText - Optional. String. Add `username:password` to remote request.
# Argument: --header headerText - Optional. String. Add one or more headers to the remote request.
# Argument: --url-function urlFunction - Optional. Function. Function to return the URL to download.
# Argument: --check-function checkFunction - Optional. Function. Function to check the installation and output the version number or package name.
# Argument: --debug - Optional. Flag. Debugging is on.
# Argument: --force - Optional. Flag. Force installation even if file is up to date.
# Argument: --diff - Optional. Flag. Show differences between old and new file.
# Argument: --replace - Optional. Flag. Replace an old version of this script with this one and delete this one. Internal only, do not use.
# Exit Code: 1 - Environment error
# Exit Code: 2 - Argument error
_installRemotePackage() {
  local usage="_${FUNCNAME[0]}"
  local relative="${1-}" packagePath="${2-}" packageInstallerName="${3-}"

  shift 3
  case "${BUILD_DEBUG-}" in 1 | true) __installRemotePackageDebug BUILD_DEBUG ;; esac

  local installArgs=() url="" localPath="" forceFlag=false urlFunction="" checkFunction="" headers=() nArguments=$#
  local nArguments="$#"
  while [ $# -gt 0 ]; do
    local argument="$1" argumentIndex=$((nArguments - $# + 1))
    [ -n "$argument" ] || __failArgument "$usage" "blank argument #$argumentIndex: $argument" || return $?
    case "$argument" in
      --debug)
        __installRemotePackageDebug "$argument"
        ;;
      --diff)
        installArgs+=("$argument")
        ;;
      --replace)
        newName="${BASH_SOURCE[0]%.*}"
        decorate bold-blue "Replacing $(decorate orange "${BASH_SOURCE[0]}") -> $(decorate boldOrange "$newName")"
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
        [ -n "${1-}" ] || __failArgument "$usage" "$argument blank argument #$argumentIndex" || return $?
        localPath="$(__usageArgument "$usage" realPath "${1%/}")" || return $?
        [ -x "$localPath/tools.sh" ] || __failArgument "$usage" "$argument argument (\"$(decorate code "$localPath")\") must be path to bin/build containing tools.sh" || return $?
        ;;
      --user)
        shift
        headers+=("--user" "$(usageArgumentString "$usage" "$argument" "${1-}")")
        ;;
      --header)
        shift
        headers+=("-H" "$(usageArgumentString "$usage" "$argument" "${1-}")")
        ;;
      --url)
        shift
        [ -z "$url" ] || __failArgument "$usage" "$argument already" || return $?
        [ -n "${1-}" ] || __failArgument "$usage" "$argument blank argument" || return $?
        url="$1"
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
        __failArgument "$usage" "unknown argument #$argumentIndex: $argument" || return $?
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument" || return $?
  done

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

  local installFlag=false message
  local myBinary myPath applicationHome installPath
  # Move to starting point
  myBinary=$(__usageEnvironment "$usage" realPath "${BASH_SOURCE[0]}") || return $?
  myPath="$(__usageEnvironment "$usage" dirname "$myBinary")" || return $?
  applicationHome=$(__usageEnvironment "$usage" realPath "$myPath/$relative") || return $?
  installPath="$applicationHome/$packagePath"
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
    __installRemotePackageDirectory "$usage" "$packagePath" "$applicationHome" "$url" "$localPath" "${headers[@]+"${headers[@]}"}" || return $?
    [ -d "$installPath" ] || __failEnvironment "$usage" "Unable to download and install $packagePath ($installPath not a directory, still)" || return $?
    messageFile=$(__usageEnvironment "$usage" mktemp) || return $?
    if [ -n "$checkFunction" ]; then
      "$checkFunction" "$usage" "$installPath" >"$messageFile" 2>&1 || return $?
    else
      __usageEnvironment "$usage" printf -- "%s\n" "$packagePath" >"$messageFile" || return $?
    fi
    message="Installed $(cat "$messageFile") in $(($(date +%s) - start)) seconds$binName"
    rm -f "$messageFile" || :
  else
    messageFile=$(__usageEnvironment "$usage" mktemp) || return $?
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
__installRemotePackage() {
  local exitCode="$1"
  shift || :
  printf "%s: %s -> %s\n" "$(decorate code "${BASH_SOURCE[0]}")" "$(decorate error "$*")" "$(decorate orange "$exitCode")" 1>&2
  return "$exitCode"
}

# Debug is enabled, show why
__installRemotePackageDebug() {
  decorate orange "${1-} enabled" && set -x
}

# Install the package directory
__installRemotePackageDirectory() {
  local usage="$1" packagePath="$2" applicationHome="$3" url="$4" localPath="$5"
  local start tarArgs osName
  local target="$applicationHome/.$$.package.tar.gz"

  shift 5
  if [ -n "$localPath" ]; then
    __installRemotePackageDirectoryLocal "$usage" "$packagePath" "$applicationHome" "$localPath"
    return $?
  fi
  __usageEnvironment "$usage" curl -L -s "$url" -o "$target" "$@" || return $?
  [ -f "$target" ] || __failEnvironment "$usage" "$target does not exist after download from $url" || return $?
  packagePath=${packagePath%/}
  packagePath=${packagePath#/}
  if ! osName="$(uname)" || [ "$osName" != "Darwin" ]; then
    tarArgs=(--wildcards "*/$packagePath/*")
  else
    tarArgs=(--include="*$packagePath/*")
  fi
  __usageEnvironment "$usage" pushd "$(dirname "$target")" >/dev/null || return $?
  __usageEnvironment "$usage" tar xf "$target" --strip-components=1 "${tarArgs[@]}" || return $?
  __usageEnvironment "$usage" popd >/dev/null || return $?
  rm -f "$target" || :
}

# Install the build directory from a copy
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
__installRemotePackageGitCheck() {
  local applicationHome="$1" pattern="${2%/}"
  pattern="/${pattern#/}/"
  local ignoreFile="$1/.gitignore"
  if [ -f "$ignoreFile" ] && ! grep -q -e "^$pattern" "$ignoreFile"; then
    printf "%s %s %s %s:\n\n    %s\n" "$(decorate code "$ignoreFile")" \
      "does not ignore" \
      "$(decorate code "$pattern")" \
      "$(decorate error "recommend adding it")" \
      "$(decorate code "echo $pattern/ >> $ignoreFile")"
  fi
}

# Usage: {fn} _installRemotePackageSource targetBinary relativePath
__installRemotePackageLocal() {
  local source="$1" myBinary="$2" relTop="$3"
  local log="$myBinary.$$.log"
  {
    grep -v -e '^__installPackageConfiguration ' <"$source"
    printf "%s %s \"%s\"\n" "__installPackageConfiguration" "$relTop" '$@'
  } >"$myBinary.$$"
  chmod +x "$myBinary.$$" || _environment "chmod +x failed" || return $?
  "$myBinary.$$" --replace >"$log" 2>&1 &
  local pid=$!
  if ! _integer "$pid"; then
    _environment "Unable to run $myBinary.$$" || return $?
  fi
  wait "$pid" || _environment "$(dumpPipe "install log failed: $pid" <"$log")" || _clean $? "$log" || return $?
  _clean 0 "$log" || return $?
}

# IDENTICAL _realPath 10
# Usage: realPath argument
# Argument: file ... - Required. File. One or more files to `realpath`.
realPath() {
  # realpath is not present always
  if whichExists realpath; then
    realpath "$@"
  else
    readlink -f -n "$@"
  fi
}

# IDENTICAL whichExists 11
# Usage: {fn} binary ...
# Argument: binary - Required. String. Binary to find in the system `PATH`.
# Exit code: 0 - If all values are found
whichExists() {
  local nArguments=$# && [ $# -gt 0 ] || _argument "no arguments" || return $?
  while [ $# -gt 0 ]; do
    [ -n "${1-}" ] || _argument "blank argument #$((nArguments - $# + 1))" || return $?
    which "$1" >/dev/null || return 1
    shift
  done
}

# IDENTICAL _colors 105

# Sets the environment variable `BUILD_COLORS` if not set, uses `TERM` to calculate
#
# Usage: hasColors
# Exit Code: 0 - Console or output supports colors
# Exit Code; 1 - Colors are likely not supported by console
# Environment: BUILD_COLORS - Optional. Boolean. Whether the build system will output ANSI colors.
hasColors() {
  local termColors
  export BUILD_COLORS TERM
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

#
# Semantics-based
#
# Usage: {fn} label lightStartCode darkStartCode endCode [ -n ] [ message ]
#
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
# Argument: style - String. Required. One of: reset underline no-underline bold no-bold black black-contrast blue cyan green magenta orange red white yellow bold-black bold-black-contrast bold-blue bold-cyan bold-green bold-magenta bold-orange bold-red bold-white bold-yellow code info success warning error subtle label value decoration
# Argument: text - Text to output. If not supplied, outputs a code to change the style to the new style.
# stdout: Decorated text
decorate() {
  local text="" what="${1-}" && shift
  local lp dp
  case "$what" in
    reset) lp='' ;;
      # styles
    underline) lp='\033[4m' ;;
    no-underline) lp='\033[24m' ;;
    bold) lp='\033[1m' ;;
    no-bold) lp='\033[21m' ;;
      # colors
    black) lp='\033[109;7m' ;;
    black-contrast) lp='\033[107;30m' ;;
    blue) lp='\033[94m' ;;
    cyan) lp='\033[36m' ;;
    green) lp='\033[92m' ;;
    magenta) lp='\033[35m' ;;
    orange) lp='\033[33m' ;;
    red) lp='\033[31m' ;;
    white) lp='\033[48;5;0;37m' ;;
    yellow) lp='\033[48;5;16;38;5;11m' ;;
      # bold-colors
    bold-black) lp='\033[1;109;7m' ;;
    bold-black-contrast) lp='\033[1;107;30m' ;;
    bold-blue) lp='\033[1;94m' ;;
    bold-cyan) lp='\033[1;36m' ;;
    bold-green) lp='\033[92m' ;;
    bold-magenta) lp='\033[1;35m' ;;
    bold-orange) lp='\033[1;33m' ;;
    bold-red) lp='\033[1;31m' ;;
    bold-white) lp='\033[1;48;5;0;37m' ;;
    bold-yellow) lp='\033[1;48;5;16;38;5;11m' ;;
      # semantic-colors
    code) lp='\033[1;97;44m' ;;
    info) lp='\033[38;5;20m' && dp='\033[1;33m' && text="Info" ;;
    success) lp='\033[42;30m' && dp='\033[0;32m' && text="SUCCESS" ;;
    warning) lp='\033[1;93;41m' && text="Warning" ;;
    error) lp='\033[1;91m' && text="ERROR" ;;
    subtle) lp='\033[1;38;5;252m' && dp='\033[1;38;5;240m' ;;
    label) lp='\033[34;103m' && dp='\033[1;96m' ;;
    value) lp='\033[1;40;97m' && dp='\033[1;97m' ;;
    decoration) lp='\033[45;97m' && dp='\033[45;30m' ;;
    *)
      __usageArgument "_${FUNCNAME[0]}" "Unknown decoration name: $what" || return $?
      ;;
  esac
  __decorate "$text" "$lp" "${dp-$lp}" "\033[0m" "$@"
}
_decorate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL _return 19
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
_return() {
  local r="${1-:1}" && shift
  _integer "$r" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
}

# Is this an unsigned integer?
# Usage: {fn} value
# Exit Code: 0 - if value is an unsigned integer
# Exit Code: 1 - if value is not an unsigned integer
_integer() {
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

# IDENTICAL _tinySugar 43
# Usage: {fn} usage message
__failArgument() {
  local usage="${1-}"
  shift && "$usage" 2 "$@" || return $?
}

# Usage: {fn} usage message
__failEnvironment() {
  local usage="${1-}"
  shift && "$usage" 1 "$@" || return $?
}

# Usage: {fn} usage command
__usageArgument() {
  local usage="${1-}"
  shift && "$@" || __failArgument "$usage" "$@" || return $?
}

# Usage: {fn} usage command
__usageEnvironment() {
  local usage="${1-}"
  shift && "$@" || __failEnvironment "$usage" "$@" || return $?
}

# Usage: {fn} message ..`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 2
_argument() {
  _return 2 "$@" || return $?
}

# Usage: {fn} message ..`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 1
_environment() {
  _return 1 "$@" || return $?
}

# Usage: {fn} exitCode itemToDelete ...
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
