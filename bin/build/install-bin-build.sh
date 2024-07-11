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
# set -x
#
# Change this line when placing in your project to point to your application root (where `bin/build` will be based)
#
#     e.g.
#     relTop=..
#     relTop=../../..
#
# or wherever you put it in your project to install it
#

# Usage: install-bin-build.sh [ --mock mockBuildRoot ] [ --url url ]
# fn: install-bin-build.sh
# Installs the build system in `./bin/build` if not installed. Also
# will overwrite this binary with the latest version after installation.
# Determines the most recent version using GitHub API unless --url or --mock is specified.
#
# Argument: --mock mockBuildRoot - Optional. Directory. Directory of an existing bin/build installation to mock behavior for testing
# Argument: --url url - Optional. URL of a tar.gz. file. Download source code from here.
# Argument: --force - Optional. Flag. Force installation even if file is up to date.
# Argument: --diff - Optional. Flag. Show differences between old and new file.
# Environment: Needs internet access and creates a directory `./bin/build`
# Exit Code: 1 - Environment error
installBinBuild() {
  local usage="_${FUNCNAME[0]}"
  local relative="${1-}"
  local errorEnvironment=1
  local errorArgument=2
  local argument start ignoreFile tarArgs
  local forceFlag installFlag mockPath message installArgs
  local myBinary myPath osName url

  shift
  if test "${BUILD_DEBUG-}"; then
    consoleOrange "BUILD_DEBUG on"
    set -x # Debugging
  fi

  installArgs=()
  url=
  mockPath=
  forceFlag=false
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || "$usage" "$errorArgument" "blank argument" || return $?
    case "$argument" in
      --debug)
        consoleOrange "Debug on"
        set -x # Debugging
        ;;
      --diff)
        installArgs+=("$argument")
        ;;
      --force)
        forceFlag=true
        ;;
      --mock)
        [ -z "$mockPath" ] || __failArgument "$usage" "$argument already" || return $?
        shift
        [ -n "${1-}" ] || __failArgument "$usage" "$argument blank argument" || return $?
        mockPath="$1"
        mockPath="${mockPath%/}"
        [ -x "$mockPath/tools.sh" ] || __failArgument "$usage" "$argument argument (\"$(consoleCode "$mockPath")\") must be path to bin/build containing tools.sh" || return $?
        ;;
      --url)
        [ -z "$url" ] || __failArgument "$usage" "$argument already" || return $?
        shift
        [ -n "${1-}" ] || __failArgument "$usage" "$argument blank argument" || return $?
        url="$1"
        ;;
    esac
    shift || "$usage" "$errorArgument" "shift after $argument failed" || return $?
  done

  if [ -z "$url" ]; then
    url=$(_installBinBuildFetch "$usage") || return $?
  elif [ -z "$mockPath" ]; then
    __failArgument "$usage" "--url is required" || return $?
  else
    __failArgument "$usage" "--mock and --url are mutually exclusive" || return $?
  fi

  # Move to starting point
  myBinary="${BASH_SOURCE[0]}"
  myPath="$(__usageEnvironment "$usage" dirname "$myBinary")" || return $?
  __usageEnvironment "$usage" cd "$myPath/$relative" || return $?

  installFlag=false
  if [ ! -d "./bin/build" ]; then
    if $forceFlag; then
      printf "%s (%s)\n" "$(consoleOrange "Forcing installation")" "$(consoleBlue "directory does not exist")"
    fi
    installFlag=true
  elif $forceFlag; then
    printf "%s (%s)\n" "$(consoleOrange "Forcing installation")" "$(consoleBoldBlue "directory exists")"
    installFlag=true
  fi

  if $installFlag; then
    start=$(($(__usageEnvironment "$usage" date +%s) + 0)) || return $?
    _installBinBuildDirectory "$usage" "$mockPath" "$url" || return $?
    messageFile=$(__usageEnvironment "$usage" mktemp) || return $?
    _installBinBuildCheck "$usage" >"$messageFile" || return $?
    message="Installed $(cat "$messageFile") in $(($(date +%s) - start)) seconds"
    rm -f "$messageFile" || :
  else
    messageFile=$(__usageEnvironment "$usage" mktemp) || return $?
    _installBinBuildCheck "$usage" >"$messageFile" || return $?
    message="$(cat "$messageFile") already installed"
    rm -f "$messageFile" || :
  fi
  _installBinBuildGitCheck
  if [ "$(type -t "installInstallBuild")" = "function" ]; then
    __usageEnvironment "$usage" installInstallBuild --local "${installArgs[@]+"${installArgs[@]}"}" "$myBinary" "$(pwd)" || return $?
  else
    export BUILD_HOME
    consoleError installInstallBuild is not published
    __usageEnvironment "$usage" cp "$BUILD_HOME/bin/build/install-bin-build.sh" "${BASH_SOURCE[0]}" || return $?
  fi
  printf "%s\n" "$message"
}
_installBinBuild() {
  local exitCode="$1"
  shift || :
  printf "%s: %s -> %s\n" "$(consoleCode "${BASH_SOURCE[0]}")" "$(consoleError "$*")" "$(consoleOrange "$exitCode")"
  return "$exitCode"
}

# Fetch from GitHub
_installBinBuildFetch() {
  local usage="$1" latestVersion

  if ! latestVersion=$(mktemp); then
    "$usage" "$errorEnvironment" "Unable to create temporary file:" || return $?
  fi
  if ! curl -s "https://api.github.com/repos/zesk/build/releases/latest" >"$latestVersion"; then
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

# Install the build directory
_installBinBuildDirectory() {
  local usage="$1" mockPath="$2" url="$3"
  local start tarArgs
  local target=build.tar.gz
  local path="./bin/build"

  if [ -n "$mockPath" ]; then
    __usageEnvironment "$usage" rm -rf "$path" || return $?
    __usageEnvironment "$usage" cp -r "$mockPath" "$path" || return $?
  else
    __usageEnvironment "$usage" curl -L -s "$url" -o "$target" || return $?
    [ -f "build.tar.gz" ] || __failEnvironment "$usage" "$target does not exist after download from $url" || return $?
    if ! osName="$(uname)" || [ "$osName" != "Darwin" ]; then
      tarArgs=(--wildcards '*/bin/build/*')
    else
      tarArgs=(--include='*/bin/build/*')
    fi
    __usageEnvironment "$usage" tar xf build.tar.gz --strip-components=1 "${tarArgs[@]}" || return $?
    rm -f "build.tar.gz" || :
  fi
  [ -d "$path" ] || __failEnvironment "$usage" "Unable to download and install zesk/build ($path not a directory, still)" || return $?
}

# Check the build directory after installation
_installBinBuildCheck() {
  local usage="$1"
  local path="./bin/build"
  local toolsBin="$path/tools.sh"
  if [ ! -f "$toolsBin" ]; then
    exec
    echo "Incorrect build version or broken install (can't find tools.sh):"
    echo
    echo "  rm -rf bin/build"
    echo "  ${BASH_SOURCE[0]}"
    return "$errorEnvironment"
  fi
  # shellcheck source=/dev/null
  source "$toolsBin" || __failEnvironment "$usage" source "$toolsBin" || return $?
  read -r version id < <(jq -r '(.version + " " + .id)' <"$path/build.json") || :
  printf "%s %s (%s)\n" "$(consoleBoldBlue "zesk/build")" "$(consoleCode "$version")" "$(consoleValue "$id")"
}

# Check .gitignore is correct
_installBinBuildGitCheck() {
  local ignoreFile=.gitignore
  if [ -f "$ignoreFile" ] && ! grep -q -e "^/bin/build/" "$ignoreFile"; then
    printf "%s %s %s %s:\n\n    %s\n" "$(consoleCode "$ignoreFile")" \
      "does not ignore" \
      "$(consoleCode "./bin/build")" \
      "$(consoleError "recommend adding it")" \
      "$(consoleCode "echo /bin/build/ >> $ignoreFile")"
  fi
}

# IDENTICAL _colors 87

# This tests whether `TERM` is set, and if not, uses the `DISPLAY` variable to set `BUILD_COLORS` IFF `DISPLAY` is non-empty.
# If `TERM` is set then uses the `tput colors` call to determine the console support for colors.
#
# Usage: hasColors
# Exit Code: 0 - Console or output supports colors
# Exit Code; 1 - No colors
# Local Cache: this value is cached in BUILD_COLORS if it is not set.
# Environment: BUILD_COLORS - Override value for this
hasColors() {
  local termColors
  export BUILD_COLORS TERM DISPLAY
  # Important - must not use buildEnvironmentLoad BUILD_COLORS TERM DISPLAY; then
  BUILD_COLORS="${BUILD_COLORS-z}"
  if [ "z" = "$BUILD_COLORS" ]; then
    if [ -z "${TERM-}" ] || [ "${TERM-}" = "dumb" ]; then
      if [ -n "${DISPLAY-}" ]; then
        BUILD_COLORS=1
      fi
    else
      termColors="$(tput colors 2>/dev/null)"
      if [ "${termColors-:2}" -ge 8 ]; then
        BUILD_COLORS=1
      fi
    fi
  elif [ -n "$BUILD_COLORS" ] && [ "$BUILD_COLORS" != "1" ]; then
    # Values allowed for this global are 1 and blank only
    BUILD_COLORS=
  fi
  test "$BUILD_COLORS"
}

__consoleOutput() {
  local prefix="${1}" start="${2-}" end="${3}" newline="\n"
  shift 3 || :
  if [ "${1-}" = "-n" ]; then
    shift || :
    newline=
  fi
  if hasColors; then
    if [ $# -eq 0 ]; then printf "%s$start" ""; else printf "$start%s$end$newline" "$*"; fi
  elif [ $# -eq 0 ]; then
    if [ -n "$prefix" ]; then printf "%s: %s$newline" "$prefix" "$*"; else printf "%s$newline" "$*"; fi
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
  __consoleOutput ERROR '\033[1;38;5;255;48;5;9m' '\033[0m' "$@"
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

# Error codes
_code() {
  case "${1-}" in environment) printf 1 ;; argument) printf 2 ;; *) printf 126 ;; esac
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

# Return `$errorArgument` always. Outputs `message ...` to `stderr`.
# Usage: {fn} message ..`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 2
_argument() {
  _return "$(_code "${FUNCNAME[0]#_}")" "$@" || return $?
}

_environment() {
  _return "$(_code "${FUNCNAME[0]#_}")" "$@" || return $?
}

# IDENTICAL _return 6
# Usage: {fn} _return [ exitCode [ message ... ] ]
# Exit Code: exitCode or 1 if nothing passed
_return() {
  local code="${1-1}" # make this a two-liner ;)
  shift || : && printf "[%d] ❌ %s\n" "$code" "${*-§}" 1>&2 || : && return "$code"
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
installBinBuild ../.. "$@"
