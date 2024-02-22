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
set -eou pipefail

# Modify this line locally, it will be preserved on update
# Points to the project root
relTop=../..

hasColors() {
  local nColors
  if ! nColors="$(tput colors)"; then return 1; fi
  [ "$nColors" -ge 8 ]
}

# IDENTICAL __consoleOutput 13
__consoleOutput() {
  local prefix="${1}" start="${2-}" end="${3}" nl="\n"

  shift && shift && shift
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

# IDENTICAL consoleCode 4
# shellcheck disable=SC2120
consoleCode() {
  __consoleOutput '' '\033[1;97;44m' '\033[0m' "$@"
}

# IDENTICAL consoleError 4
# shellcheck disable=SC2120
consoleError() {
  __consoleOutput ERROR '\033[1;38;5;255;48;5;9m' '\033[0m' "$@"
}

# shellcheck disable=SC2120
consoleOrange() {
  __consoleOutput "" '\033[38;5;214m' '\033[0m' "$@"
}

# Usage: install-bin-build.sh [ --mock mockBuildRoot ]
# fn: install-bin-build.sh
# Installs the build system in `./bin/build` if not installed. Also
# will overwrite this binary with the latest version after installation.
#
# Environment: Needs internet access and creates a directory `./bin/build`
# Exit Code: 1 - Environment error
installBinBuild() {
  local start ignoreFile tarArgs diffLines binName replace mockPath tarBall
  local myBinary myPath osName
  local errorEnvironment=1
  local errorArgument=2

  local toolsBin=./bin/build/tools.sh

  if test "${BUILD_DEBUG-}"; then
    set -x # Debugging
  fi

  myBinary="${BASH_SOURCE[0]}"
  if ! myPath="$(dirname "$myBinary")"; then
    _installBinBuild "$errorEnvironment" "Can not get dirname of $myBinary" || return $?
  fi
  if ! cd "$myPath/$relTop"; then
    _installBinBuild "$errorEnvironment" "Can not cd $myPath/$relTop" || return $?
  fi
  if [ ! -d bin/build ]; then
    if ! start=$(($(date +%s) + 0)); then
      _installBinBuild "$errorEnvironment" "date failed" || return $?
    fi
    if [ "${1-}" = "--mock" ]; then
      shift || :
      mockPath="${1%%/}/"
      if [ ! -f "$mockPath/tools.sh" ]; then
        _installBinBuild "$errorArgument" "--mock argument must be bin/build path" || return $?
      fi
      if ! cp -r "${1%%/}/" ./bin/build/; then
        _installBinBuild "$errorEnvironment" "Unable to copy to bin/build" || return $?
      fi
    else
      if ! latestVersion=$(mktemp); then
        _installBinBuild "$errorEnvironment" "Unable to create temporary file:" || return $?
      fi
      if ! curl -s "https://api.github.com/repos/zesk/build/releases/latest" >"$latestVersion"; then
        _installBinBuild "$errorEnvironment" "Unable to fetch latest JSON:"
        cat "$latestVersion" 1>&2
        rm "$latestVersion" || :
        return "$errorEnvironment"
      fi
      if ! tarBall=$(jq -r .tarball_url <"$latestVersion"); then
        _installBinBuild "$errorEnvironment" "Unable to fetch .tarball_url JSON:"
        cat "$latestVersion" 1>&2
        rm "$latestVersion" || :
        return "$errorEnvironment"
      fi
      if ! curl -L -s "$tarBall" -o build.tar.gz; then
        _installBinBuild "$errorEnvironment" "Unable to unwrap $tarBall as build.tar.gz"
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
        _installBinBuild "$errorEnvironment" "Failed to download from $tarBall:"
        return "$errorEnvironment"
      fi
      rm "build.tar.gz" || :
    fi
    if [ ! -d "./bin/build" ]; then
      _installBinBuild "$errorEnvironment" "Unable to download and install zesk/build" || return $?
    fi

    # shellcheck source=/dev/null
    if ! . "$toolsBin"; then
      _installBinBuild "$errorEnvironment" "Unable to source $toolsBin" || return $?
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
      _installBinBuild "$errorEnvironment" "Unable to source $toolsBin" || return $?
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
      _installBinBuild "$errorEnvironment" "failed diffing $binName $myBinary" || return $?
    fi
    if [ "$diffLines" -eq 0 ]; then
      echo "$(consoleValue -n "$myBinary") $(consoleSuccess -n is up to date.)"
      return 0
    fi
    consoleMagenta "XDIFFERENCES: $diffLines"
    diff "$binName" "$myBinary" | grep -v 'relTop=' || :
    consoleMagenta "XDIFFERENCES: $diffLines"
  fi
  if [ "$diffLines" = "NONE" ]; then
    _installBinBuild "$errorEnvironment" "$(consoleValue -n "$binName") $(consoleSuccess -n not found in downloaded build.)"
  fi

  replace=$(quoteSedPattern "relTop=$relTop")

  myBinary="${BASH_SOURCE[0]}.$$"
  sed -e "s/^relTop=.*/$replace/" <"$binName" >"$myBinary"
  chmod +x "$myBinary"
  if test "${BUILD_DIFF-}"; then
    consoleWarning "DIFFERENCES: $diffLines"
    diff "$binName" "$myBinary" | grep -v 'relTop=' | prefixLines "$(consoleReset)$(consoleInfo CHANGES)$(consoleCode)" || :
    consoleMagenta "DIFFERENCES: $diffLines"
  fi
  echo "$(consoleValue -n "$(basename "${BASH_SOURCE[0]}")") $(consoleWarning -n was updated.)"
  (nohup mv "$myBinary" "${BASH_SOURCE[0]}" 2>/dev/null 1>&2)
}
_installBinBuild() {
  local exitCode="$1"
  shift || :
  printf "%s: %s -> %s\n" "$(consoleCode "${BASH_SOURCE[0]}")" "$(consoleError "$*")" "$(consoleOrange "$exitCode")"
  return "$exitCode"
}

installBinBuild "$@"
