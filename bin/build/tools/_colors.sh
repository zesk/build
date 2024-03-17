#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# NO DEPENDENCIES

# IDENTICAL _colors 83

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
        BUILD_COLORS=1
      else
        BUILD_COLORS=
      fi
    else
      termColors="$(tput colors 2>/dev/null)"
      if [ "${termColors-:2}" -ge 8 ]; then
        BUILD_COLORS=1
      else
        BUILD_COLORS=
      fi
    fi
  elif [ -n "$BUILD_COLORS" ] && [ "$BUILD_COLORS" != "1" ]; then
    # Values allowed for this global are 1 and blank only
    BUILD_COLORS=
  fi
  test "$BUILD_COLORS"
}

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

#
# code or variables in output
#
# shellcheck disable=SC2120
consoleCode() {
  __consoleOutput '' '\033[1;97;44m' '\033[0m' "$@"
}

#
# errors
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
