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
set -eou pipefail || exit 99 # problems

# Modify this line locally, it will be preserved on update
# Points to the project root
relTop=../..

# -- DO NOT EDIT ANYTHING BELOW THIS LINE IT WILL BE OVERWRITTEN --

# Usage: install-bin-build.sh [ --mock mockBuildRoot ] [ --url url ]
# fn: install-bin-build.sh
# Installs the build system in `./bin/build` if not installed. Also
# will overwrite this binary with the latest version after installation.
# Determines the most recent version using GitHub API unless --url or --mock is specified.
#
# Argument: --mock mockBuildRoot - Optional. Directory. Diretory of an existing bin/build installation to mock behavior for testing
# Argument: --url url - Optional. URL of a tar.gz. file. Download source code from here.
# Environment: Needs internet access and creates a directory `./bin/build`
# Exit Code: 1 - Environment error
installBinBuild() {
  local this arg start ignoreFile tarArgs showDiffFlag diffLines binName replace
  local forceFlag mockFlag mockPath
  local myBinary myPath osName url
  local errorEnvironment=1
  local errorArgument=2

  local toolsBin=./bin/build/tools.sh

  if test "${BUILD_DEBUG-}"; then
    consoleOrange "BUILD_DEBUG on"
    set -x # Debugging
  fi


  this="$(basename "${BASH_SOURCE[0]}")"

  usage="_${FUNCNAME[0]}"
  url=
  showDiffFlag=false
  mockFlag=false
  mockPath=
  forceFlag=false
  while [ $# -gt 0 ]; do
    arg="$1"
    if [ -z "$arg" ]; then
      "$usage" "$errorArgument" "blank argument" || return $?
    fi
    case "$arg" in
      --debug)
        consoleOrange "Debug on"
        set -x # Debugging
        ;;
      --diff)
        showDiffFlag=true
        ;;
      --force)
        forceFlag=true
        ;;
      --mock)
        if [ -n "$mockPath" ]; then
          "$usage" "$errorArgument" "--mock argument twice" || return $?
        fi
        mockFlag=true
        shift || "$usage" "$errorArgument" "$arg missing value" || return $?
        mockPath="${1%%/}/"
        if [ ! -f "$mockPath/tools.sh" ]; then
          "$usage" "$errorArgument" "--mock argument must be path to bin/build containing tools.sh" || return $?
        fi
        ;;
      --url)
        if [ -n "$url" ]; then
          "$usage" "$errorArgument" "--url argument twice" || return $?
        fi
        shift || "$usage" "$errorArgument" "$arg missing value" || return $?
        url="$1"
        if [ -z "$url" ]; then
          "$usage" "$errorArgument" "blank url" || return $?
        fi
        ;;
    esac
    shift || "$usage" "$errorArgument" "shift after $arg failed" || return $?
  done

  if [ -z "$url" ]; then
    if ! latestVersion=$(mktemp); then
      "$usage" "$errorEnvironment" "Unable to create temporary file:" || return $?
    fi
    if ! curl -s "https://api.github.com/repos/zesk/build/releases/latest" >"$latestVersion"; then
      "$usage" "$errorEnvironment" "Unable to fetch latest JSON:"
      cat "$latestVersion" 1>&2
      rm "$latestVersion" || :
      return "$errorEnvironment"
    fi
    if ! url=$(jq -r .tarball_url <"$latestVersion"); then
      "$usage" "$errorEnvironment" "Unable to fetch .tarball_url JSON:"
      cat "$latestVersion" 1>&2
      rm "$latestVersion" || :
      return "$errorEnvironment"
    fi
  elif $mockFlag; then
    "$usage" "$errorArgument" "--mock and --url are mutually exclusive" || return $?
  fi

  if [ "${url#https://}" == "$url" ]; then
    "$usage" "$errorArgument" "URL must begin with https://" || return $?
  fi

  #
  # Arguments are all validated by here (mostly - url syntax may be bonkers)
  #

  myBinary="${BASH_SOURCE[0]}"
  if ! myPath="$(dirname "$myBinary")"; then
    "$usage" "$errorEnvironment" "Can not get dirname of $myBinary" || return $?
  fi
  if ! cd "$myPath/$relTop"; then
    "$usage" "$errorEnvironment" "Can not cd $myPath/$relTop" || return $?
  fi
  if [ ! -d bin/build ]; then
    if $forceFlag; then
      printf "%s (%s)\n" "$(consoleOrange "Forcing installation")" "$(consoleBlue "directory does not exist")"
    fi
    forceFlag=true
  elif $forceFlag; then
    printf "%s (%s)\n" "$(consoleOrange "Forcing installation")" "$(consoleBoldBlue "directory exists")"
  fi
  if $forceFlag; then
    if ! start=$(($(date +%s) + 0)); then
      "$usage" "$errorEnvironment" "date failed" || return $?
    fi

    if $mockFlag; then
      if ! cp -r "$mockPath" ./bin/build/; then
        "$usage" "$errorEnvironment" "Unable to copy to bin/build" || return $?
      fi
    else
      if ! curl -L -s "$url" -o build.tar.gz; then
        "$usage" "$errorEnvironment" "Unable to download $url"
        cat "$latestVersion" 1<&2
        rm "$latestVersion" || :
        return "$errorEnvironment"
      fi
      if ! osName="$(uname)" || [ "$osName" != "Darwin" ]; then
        tarArgs=(--wildcards '*/bin/build/*')
      else
        tarArgs=(--include='*/bin/build/*')
      fi
      if ! tar xf build.tar.gz --strip-components=1 "${tarArgs[@]}"; then
        "$usage" "$errorEnvironment" "Failed to download from $url:"
        return "$errorEnvironment"
      fi
      rm "build.tar.gz" || :
    fi
    if [ ! -d "./bin/build" ]; then
      "$usage" "$errorEnvironment" "Unable to download and install zesk/build" || return $?
    fi
    # shellcheck source=/dev/null
    if ! . "$toolsBin"; then
      "$usage" "$errorEnvironment" "Unable to source $toolsBin" || return $?
    fi
    reportTiming "$start" "Installed zesk/build in" || :
  else
    if [ ! -f "$toolsBin" ]; then
      exec
      echo "Incorrect build version or broken install (can't find tools.sh):"
      echo
      echo "  rm -rf bin/build"
      echo "  ${BASH_SOURCE[0]}"
      return "$errorEnvironment"
    fi
    # shellcheck source=/dev/null
    if ! . "$toolsBin"; then
      "$usage" "$errorEnvironment" "Unable to source $toolsBin" || return $?
    fi
  fi

  ignoreFile=.gitignore
  if [ -f "$ignoreFile" ] && ! grep -q "/bin/build/" "$ignoreFile"; then
    printf "%s %s %s %s:\n\n    %s\n" "$(consoleCode "$ignoreFile")" \
      "does not ignore" \
      "$(consoleCode "./bin/build")" \
      "$(consoleWarning "recommend adding it")" \
      "$(consoleCode "echo /bin/build/ >> $ignoreFile")"
  fi

  diffLines=NONE
  binName="./bin/build/install-bin-build.sh"
  if [ -x "$binName" ]; then
    if ! diffLines=$(diff "$binName" "$myBinary" | grep -v 'relTop=' | grep -c '[<>]' || :); then
      "$usage" "$errorEnvironment" "failed diffing $binName $myBinary" || return $?
    fi
    if [ "$diffLines" -eq 0 ]; then
      _binBuildMessage "$(consoleSuccess "is up to date")"
      return 0
    fi
    consoleMagenta "--- Changes: $diffLines ---"
    diff "$binName" "$myBinary" | grep -v 'relTop=' || :
    consoleMagenta "--- End of changes ---"
  fi
  if [ "$diffLines" = "NONE" ]; then
    "$usage" "$errorEnvironment" "$(consoleValue -n "$binName") $(consoleSuccess -n not found in downloaded build.)"
  fi

  replace=$(quoteSedPattern "relTop=$relTop")

  myBinary="${BASH_SOURCE[0]}.$$"
  sed -e "s/^relTop=.*/$replace/" <"$binName" >"$myBinary" || :
  chmod +x "$myBinary"
  if $showDiffFlag; then
    consoleWarning "DIFFERENCES: $diffLines"
    diff "$binName" "$myBinary" | grep -v 'relTop=' | wrapLines "$(consoleReset)$(consoleInfo CHANGES)$(consoleCode)" "$(consoleReset)" || :
    consoleMagenta "DIFFERENCES: $diffLines"
  fi
  _binBuildMessage "$(consoleWarning "was updated")"
  (nohup mv "$myBinary" "${BASH_SOURCE[0]}" 2>/dev/null 1>&2)
}
_binBuildMessage() {
  printf "%s (%s)\n" "$(consoleValue "$this") $*" "$(consoleCode "$(_binBuildVersion)")"
}

_binBuildVersion() {
  jq -r .version <"./bin/build/build.json"
}
_installBinBuild() {
  local exitCode="$1"
  shift || :
  printf "%s: %s -> %s\n" "$(consoleCode "${BASH_SOURCE[0]}")" "$(consoleError "$*")" "$(consoleOrange "$exitCode")"
  return "$exitCode"
}

# IDENTICAL _colors 86

# This tests whether `TERM` is set, and if not, uses the `DISPLAY` variable to set `BUILD_COLORS` IFF `DISPLAY` is non-empty.
# If `TERM1` is set then uses the `tput colors` call to determine the console support for colors.
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
        BUILD_COLORS=true
      fi
    else
      termColors="$(tput colors 2>/dev/null)"
      if [ "${termColors-:2}" -ge 8 ]; then
        BUILD_COLORS=true
      fi
    fi
  fi
  if [ "$BUILD_COLORS" != "true" ]; then
    # Values allowed for this global are true and false only
    BUILD_COLORS=false
  fi
  "$BUILD_COLORS"
}

__consoleOutput() {
  local prefix="${1}" start="${2-}" end="${3}" nl="\n"
  shift 3 || :
  if [ "${1-}" = "-n" ]; then
    shift
    nl=
  fi
  if hasColors; then
    if [ $# -eq 0 ]; then printf "%s$start" ""; else printf "$start%s$end$nl" "$*"; fi
  elif [ $# -eq 0 ]; then
    if [ -n "$prefix" ]; then printf "%s: %s$nl" "$prefix" "$*"; else printf "%s$nl" "$*"; fi
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

installBinBuild "$@"
