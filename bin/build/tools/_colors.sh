#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# NO DEPENDENCIES

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
