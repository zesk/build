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

# IDENTICAL __installCheck 1
# Check the directory after installation and output the version

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

# IDENTICAL _installRemotePackage 246

# Usage: {fn} relativePath installPath url urlFunction [ --local localPackageDirectory ] [ --debug ] [ --force ] [ --diff ]
# fn: {base}
# Installs a remote package system in a local project directory if not installed. Also
# will overwrite the installation binary with the latest version after installation.
#
# URL can be determined programmatically using `urlFunction`.
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
  local argument nArguments argumentIndex
  local relative="${1-}" packagePath="${2-}" packageInstallerName="${3-}"
  local argument start ignoreFile tarArgs
  local forceFlag installFlag localPath message installArgs
  local myBinary myPath osName url urlFunction checkFunction applicationHome installPath headers

  shift 3
  case "${BUILD_DEBUG-}" in 1 | true) __installRemotePackageDebug BUILD_DEBUG ;; esac

  installArgs=()
  url=
  localPath=
  forceFlag=false
  urlFunction=
  checkFunction=
  headers=()
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$1"
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
        consoleBoldBlue "Replacing $(consoleOrange "${BASH_SOURCE[0]}") -> $(consoleBoldOrange "$newName")"
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
        [ -x "$localPath/tools.sh" ] || __failArgument "$usage" "$argument argument (\"$(consoleCode "$localPath")\") must be path to bin/build containing tools.sh" || return $?
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
      url=$(__usageEnvironment "$usage" "$urlFunction" "$usage" "$installPath") || return $?
      if [ -z "$url" ]; then
        __failArgument "$usage" "$urlFunction failed" || return $?
      fi
    fi
  fi
  if [ -z "$url" ] && [ -z "$localPath" ]; then
    __failArgument "$usage" "--local or --url|--url-function is required" || return $?
  fi

  # Move to starting point
  myBinary=$(__usageEnvironment "$usage" realPath "${BASH_SOURCE[0]}") || return $?
  myPath="$(__usageEnvironment "$usage" dirname "$myBinary")" || return $?
  applicationHome=$(__usageEnvironment "$usage" realPath "$myPath/$relative") || return $?
  installPath="$applicationHome/$packagePath"
  installFlag=false
  if [ ! -d "$installPath" ]; then
    if $forceFlag; then
      printf "%s (%s)\n" "$(consoleOrange "Forcing installation")" "$(consoleBlue "directory does not exist")"
    fi
    installFlag=true
  elif $forceFlag; then
    printf "%s (%s)\n" "$(consoleOrange "Forcing installation")" "$(consoleBoldBlue "directory exists")"
    installFlag=true
  fi
  binName=" ($(consoleBoldBlue "$(basename "$myBinary")"))"
  if $installFlag; then
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
  printf "%s: %s -> %s\n" "$(consoleCode "${BASH_SOURCE[0]}")" "$(consoleError "$*")" "$(consoleOrange "$exitCode")"
  return "$exitCode"
}

# Debug is enabled, show why
__installRemotePackageDebug() {
  consoleOrange "${1-} enabled" && set -x
}

# Install the package directory
__installRemotePackageDirectory() {
  local usage="$1" packagePath="$2" applicationHome="$3" url="$4" localPath="$5"
  local start tarArgs
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
    printf "%s %s %s %s:\n\n    %s\n" "$(consoleCode "$ignoreFile")" \
      "does not ignore" \
      "$(consoleCode "$pattern")" \
      "$(consoleError "recommend adding it")" \
      "$(consoleCode "echo $pattern/ >> $ignoreFile")"
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
  pid=$!
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

# IDENTICAL _colors 82

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
      [ "${termColors-:2}" -lt 8 ] || BUILD_COLORS=true
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
# Utility to output wrapped text
__consoleOutput() {
  local prefix="${1}" start="${2-}" end="${3-}"
  shift && shift && shift
  if hasColors; then
    if [ $# -eq 0 ]; then printf -- "%s$start" ""; else printf -- "$start%s$end\n" "$*"; fi
  elif [ $# -gt 0 ]; then
    if [ -n "$prefix" ]; then printf -- "%s: %s\n" "$prefix" "$*"; else printf -- "%s\n" "$*"; fi
  fi
}

#
# Code or variables in output
#
# shellcheck disable=SC2120
consoleCode() {
  __consoleOutput '' '\033[1;97;44m' '\033[0m' "$@"
}

#
# Errors
#
# shellcheck disable=SC2120
consoleError() {
  __consoleOutput ERROR '\033[1;91m' '\033[0m' "$@"
}

#
# Orange
#
# shellcheck disable=SC2120
consoleOrange() {
  __consoleOutput "" '\033[33m' '\033[0m' "$@"
}

# shellcheck disable=SC2120
consoleBoldOrange() {
  __consoleOutput "" '\033[33;1m' '\033[0m' "$@"
}

#
# Blue
#
# shellcheck disable=SC2120
consoleBlue() {
  __consoleOutput "" '\033[94m' '\033[0m' "$@"
}

# shellcheck disable=SC2120
consoleBoldBlue() {
  __consoleOutput "" '\033[1;94m' '\033[0m' "$@"
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

# IDENTICAL _tinySugar 48
# Error codes
_code() {
  case "${1-}" in *nvironment) printf 1 ;; *rgument) printf 2 ;; *) printf 126 ;; esac
}

# Usage: {fn} usage message
__failArgument() {
  local usage="${1-}"
  shift && "$usage" "$(_code argument)" "$@" || return $?
}

# Usage: {fn} usage message
__failEnvironment() {
  local usage="${1-}"
  shift && "$usage" "$(_code environment)" "$@" || return $?
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
  _return "$(_code "${FUNCNAME[0]#_}")" "$@" || return $?
}

# Usage: {fn} message ..`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 1
_environment() {
  _return "$(_code "${FUNCNAME[0]#_}")" "$@" || return $?
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
